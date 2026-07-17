"""V2 functional QA over real HTTP against the Docker stack.
The artisan's whole journey: compose -> number -> PDF -> send -> answer."""
import io, sys, time, uuid, httpx
from pypdf import PdfReader

BASE = "http://localhost:8000"
R = []
def ck(n, ok, d=""):
    R.append((n, ok, d)); print(f"{'PASS' if ok else '*** FAIL ***'} | {n:56s} | {d}")

with httpx.Client(timeout=120) as c:
    r = c.post(f"{BASE}/api/auth/register", json={"email": f"v2-{uuid.uuid4()}@x.io", "password": "Password123!"})
    c.headers["Authorization"] = f"Bearer {r.json()['access_token']}"

    # the artisan sets up their identity
    c.put(f"{BASE}/api/branding/company", json={"legal_name": "SARL Plomberie Dupont",
          "siret": "35600000000048", "vat_number": "FR12345678901",
          "address_line": "12 rue des Artisans", "postal_code": "75011", "city": "Paris"})
    png = b"\x89PNG\r\n\x1a\n\x00\x00\x00\rIHDR\x00\x00\x00\x01\x00\x00\x00\x01\x08\x06\x00\x00\x00\x1f\x15\xc4\x89\x00\x00\x00\nIDATx\x9cc\x00\x01\x00\x00\x05\x00\x01\r\n-\xb4\x00\x00\x00\x00IEND\xaeB`\x82"
    lr = c.post(f"{BASE}/api/branding/logo", files={"file": ("logo.png", io.BytesIO(png), "image/png")})
    ck("logo uploaded to the volume (non-root write)", lr.status_code == 201, str(lr.status_code))

    cat = c.post(f"{BASE}/api/catalog/categories", json={"name": "Plomberie"}).json()["id"]
    cli = c.post(f"{BASE}/api/clients", json={"last_name": "Martin", "first_name": "Claire",
                 "address": "3 allee des Lilas, 75012 Paris"}).json()["id"]
    i20 = c.post(f"{BASE}/api/catalog/items", json={"category_id": cat, "designation": "Chauffe-eau Atlantic 200L",
          "item_type": "product", "unit": "u", "unit_price_ht": "450.00", "vat_rate": "20.00"}).json()["id"]
    i10 = c.post(f"{BASE}/api/catalog/items", json={"category_id": cat, "designation": "Main-d'oeuvre",
          "item_type": "service", "unit": "h", "unit_price_ht": "60.00", "vat_rate": "10.00"}).json()["id"]

    # --- the journey ---
    q = c.post(f"{BASE}/api/quotes", json={"client_id": cli, "lines": [
        {"catalog_item_id": i20, "quantity": "1"}, {"catalog_item_id": i10, "quantity": "2.5"}]}).json()
    ck("quote created as a numbered draft", q["status"] == "draft" and q["quote_number"].startswith("DEV-"), q["quote_number"])
    # 450@20% -> 540 ; 150@10% -> 165 ; total 705.00
    ck("totals computed by the backend", q["total_ttc"] == "705.00", f"TTC={q['total_ttc']}")

    pdf = c.get(f"{BASE}/api/quotes/{q['id']}/pdf")
    ck("PDF downloadable from the container", pdf.status_code == 200 and pdf.content.startswith(b"%PDF-"), f"{len(pdf.content)}B")
    ck("PDF filename is the quote number", f'"{q["quote_number"]}.pdf"' in pdf.headers["content-disposition"])
    t = PdfReader(io.BytesIO(pdf.content)).pages[0].extract_text()
    ck("PDF carries the quote number", q["quote_number"] in t)
    ck("PDF carries the artisan's legal name", "SARL Plomberie Dupont" in t)
    ck("PDF carries the customer", "Martin" in t)
    ck("PDF TTC matches the API, to the cent", "705,00" in t)
    ck("PDF has the per-rate VAT summary (2 rates)", "Base HT" in t)

    # send -> frozen
    s = c.put(f"{BASE}/api/quotes/{q['id']}/status", json={"status": "sent"})
    ck("draft can be sent", s.json()["status"] == "sent")
    ck("sent quote can no longer be deleted", c.delete(f"{BASE}/api/quotes/{q['id']}").status_code == 409)
    ck("sent quote cannot go back to draft", c.put(f"{BASE}/api/quotes/{q['id']}/status", json={"status": "draft"}).status_code == 409)
    ck("sent quote still downloadable as PDF", c.get(f"{BASE}/api/quotes/{q['id']}/pdf").status_code == 200)

    a = c.put(f"{BASE}/api/quotes/{q['id']}/status", json={"status": "accepted"})
    ck("customer's answer recorded", a.json()["status"] == "accepted")
    ck("accepted is terminal", c.put(f"{BASE}/api/quotes/{q['id']}/status", json={"status": "refused"}).status_code == 409)

    # numbering continues
    q2 = c.post(f"{BASE}/api/quotes", json={"client_id": cli, "lines": [{"catalog_item_id": i20, "quantity": "1"}]}).json()
    ck("next quote continues the series", q2["quote_number"].endswith("0002"), q2["quote_number"])

    # draft is deletable, and that's the correction path
    ck("draft is deletable (the correction path)", c.delete(f"{BASE}/api/quotes/{q2['id']}").status_code == 204)

    # --- performance ---
    t0 = time.monotonic()
    for _ in range(10): c.get(f"{BASE}/api/quotes/{q['id']}/pdf")
    dt = (time.monotonic()-t0)/10
    ck("PDF renders in a reasonable time", dt < 1.0, f"{dt*1000:.0f} ms avg over 10")

    # --- tenant isolation on the document ---
    with httpx.Client(timeout=60) as c2:
        r2 = c2.post(f"{BASE}/api/auth/register", json={"email": f"o-{uuid.uuid4()}@x.io", "password": "Password123!"})
        c2.headers["Authorization"] = f"Bearer {r2.json()['access_token']}"
        ck("other tenant cannot download the PDF", c2.get(f"{BASE}/api/quotes/{q['id']}/pdf").status_code == 404)
        ck("other tenant cannot change the status", c2.put(f"{BASE}/api/quotes/{q['id']}/status", json={"status": "refused"}).status_code == 404)

f = [x for x in R if not x[1]]
print(f"\n{'='*80}\n{len(R)-len(f)}/{len(R)} passed")
[print(f"  FAILED: {n} ({d})") for n, ok, d in f]
sys.exit(1 if f else 0)
