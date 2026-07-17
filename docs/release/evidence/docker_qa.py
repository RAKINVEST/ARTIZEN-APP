"""Full functional QA over real HTTP against the Docker stack."""
import io, sys, uuid, httpx
from pypdf import PdfWriter

BASE = "http://localhost:8000"
R = []
def check(name, ok, d=""):
    R.append((name, ok, d)); print(f"{'PASS' if ok else '*** FAIL ***'} | {name:54s} | {d}")

def pdf(pages=1):
    w = PdfWriter()
    for _ in range(pages): w.add_blank_page(width=595, height=842)
    b = io.BytesIO(); w.write(b); return b.getvalue()

def register(c):
    r = c.post(f"{BASE}/api/auth/register", json={"email": f"dk-{uuid.uuid4()}@x.io", "password": "Password123!"})
    c.headers["Authorization"] = f"Bearer {r.json()['access_token']}"
    return r.json()["user"]["company_id"]

with httpx.Client(timeout=90) as c:
    # --- health / api surface ---
    r = c.get(f"{BASE}/health"); check("health reports db ok", r.json()["database"] == "ok", r.json()["status"])
    check("openapi served", c.get(f"{BASE}/docs").status_code == 200)

    # --- AUTH ---
    cid = register(c)
    check("register creates company + JWT", bool(cid), cid[:8])
    r = c.post(f"{BASE}/api/auth/login", json={"email": "nope@x.io", "password": "x"})
    check("login rejects unknown user (401)", r.status_code == 401, str(r.status_code))
    r = c.get(f"{BASE}/api/clients", headers={"Authorization": "Bearer garbage"})
    check("garbage JWT -> 401", r.status_code == 401, str(r.status_code))
    r = c.get(f"{BASE}/api/auth/me"); check("GET /auth/me works", r.status_code == 200, str(r.status_code))

    # --- BRANDING ---
    r = c.get(f"{BASE}/api/branding/profile"); check("branding profile", r.status_code == 200, str(r.status_code))
    png = b"\x89PNG\r\n\x1a\n" + b"0"*256
    r = c.post(f"{BASE}/api/branding/logo", files={"file": ("logo.png", io.BytesIO(png), "image/png")})
    check("LOGO UPLOAD -> storage volume (non-root write)", r.status_code == 201, str(r.status_code))
    r = c.put(f"{BASE}/api/branding/company", json={"legal_name": "SARL Docker", "siret": "35600000000048"})
    check("company profile update", r.status_code == 200, str(r.status_code))

    # --- CATALOG / CLIENTS ---
    cat = c.post(f"{BASE}/api/catalog/categories", json={"name": "Plomberie"}).json()["id"]
    item = c.post(f"{BASE}/api/catalog/items", json={"category_id": cat, "designation": "Chauffe-eau Atlantic 200L",
          "item_type": "product", "unit": "u", "unit_price_ht": "450.00", "vat_rate": "20.00"}).json()["id"]
    check("catalog category + item created", bool(item), item[:8])
    cli = c.post(f"{BASE}/api/clients", json={"last_name": "Dupont", "email": "d@x.io"}).json()["id"]
    check("client created", bool(cli), cli[:8])
    # M1: clearing a field must stick
    c.put(f"{BASE}/api/clients/{cli}", json={"last_name": "Dupont", "email": None})
    check("M1: cleared email stays cleared", c.get(f"{BASE}/api/clients/{cli}").json()["email"] is None)
    # M2: reactivate
    c.delete(f"{BASE}/api/catalog/items/{item}")
    check("item deactivated", c.get(f"{BASE}/api/catalog/items/{item}").json()["active"] is False)
    r = c.put(f"{BASE}/api/catalog/items/{item}", json={"active": True})
    check("M2: item reactivated (was a one-way door)", r.status_code == 200 and r.json()["active"] is True, str(r.status_code))

    # --- QUOTES (money) ---
    q = c.post(f"{BASE}/api/quotes", json={"client_id": cli, "lines": [{"catalog_item_id": item, "quantity": "2"}]})
    b = q.json()
    check("QUOTE created", q.status_code == 201, str(q.status_code))
    check("HT/VAT/TTC exact (2 x 450.00 @20%)",
          (b["total_ht"], b["total_vat"], b["total_ttc"]) == ("900.00", "180.00", "1080.00"),
          f'{b["total_ht"]}/{b["total_vat"]}/{b["total_ttc"]}')
    check("amounts are strings (Decimal preserved)", isinstance(b["total_ht"], str))
    r = c.post(f"{BASE}/api/quotes", json={"client_id": cli, "lines": [{"catalog_item_id": item, "quantity": "0.333"}]})
    check("quantity 0.333 refused (no silent corruption)", r.status_code == 422, str(r.status_code))
    check("quote deletable", c.delete(f"{BASE}/api/quotes/{b['id']}").status_code == 204)

    # --- AI COPILOT ---
    r = c.post(f"{BASE}/api/quote-assistant/suggest", json={"description": "Remplacement chauffe-eau Atlantic 200 litres"})
    check("AI copilot suggests (mock provider, no key)", r.status_code == 200, f'conf={r.json().get("confidence")}')
    r = c.post(f"{BASE}/api/quote-assistant/suggest", json={"description": "chauffe-eau [urgent]"})
    check("AI: brackets in description no longer break it", r.status_code == 200, str(r.status_code))

    # --- DOCUMENT PIPELINE / UPLOADS ---
    up = c.post(f"{BASE}/api/document-analysis/upload", data={"document_type": "quote"},
                files={"file": ("devis.pdf", io.BytesIO(pdf(2)), "application/pdf")})
    check("PDF UPLOAD -> volume", up.status_code == 201, str(up.status_code))
    aid = up.json()["id"]
    pr = c.post(f"{BASE}/api/document-analysis/{aid}/process")
    check("PDF processed (page count)", pr.status_code == 200 and pr.json()["page_count"] == 2, str(pr.json().get("page_count")))
    det = c.get(f"{BASE}/api/document-analysis/{aid}/detection")
    check("detection runs", det.status_code == 200, str(det.status_code))
    r = c.post(f"{BASE}/api/document-analysis/upload", data={"document_type": "quote"},
               files={"file": ("fake.pdf", io.BytesIO(b"not a pdf at all"), "application/pdf")})
    check("fake PDF rejected by magic bytes (415)", r.status_code == 415, str(r.status_code))

    # --- TEMPLATE IMPORT ---
    prev = c.get(f"{BASE}/api/template-import/{aid}/preview")
    check("template-import preview", prev.status_code == 200, str(prev.status_code))
    val = c.post(f"{BASE}/api/template-import/{aid}/validate", json={"apply_company": False, "apply_brand": False})
    check("template-import validate (explicit confirmation)", val.status_code == 200, str(val.status_code))

    # --- MULTI-TENANT ---
    with httpx.Client(timeout=90) as c2:
        register(c2)
        check("other tenant: client -> 404", c2.get(f"{BASE}/api/clients/{cli}").status_code == 404)
        check("other tenant: item -> 404", c2.get(f"{BASE}/api/catalog/items/{item}").status_code == 404)
        check("other tenant: analysis -> 404", c2.get(f"{BASE}/api/document-analysis/{aid}").status_code == 404)
        check("other tenant sees empty client list", c2.get(f"{BASE}/api/clients").json() == [])

    # --- RATE LIMITING (enabled in docker: .env has no override) ---
    codes = [c.post(f"{BASE}/api/auth/login", json={"email": "x@y.io", "password": "w"}).status_code for _ in range(14)]
    check("rate limiting active in Docker (429 appears)", 429 in codes, f"{codes.count(401)}x401 then {codes.count(429)}x429")

f = [x for x in R if not x[1]]
print(f"\n{'='*76}\n{len(R)-len(f)}/{len(R)} passed")
[print(f"  FAILED: {n} ({d})") for n, ok, d in f]
sys.exit(1 if f else 0)
