"""Deliberate break attempt against the real app + real PostgreSQL.
Every case asserts the app degrades cleanly (4xx) rather than 500/hang."""
import asyncio, io, os, sys, uuid
sys.path.insert(0, r"c:\Users\Utilisateur\Documents\GitHub\ARTIZEN-APP\backend")
os.chdir(r"c:\Users\Utilisateur\Documents\GitHub\ARTIZEN-APP\backend")
os.environ.setdefault("AUTH_RATE_LIMIT_ENABLED", "false")
from httpx import ASGITransport, AsyncClient
from app.main import app

results = []
def check(name, ok, detail=""):
    results.append((name, ok, detail))
    print(f"{'PASS' if ok else '*** FAIL ***'} | {name:52s} | {detail}")

async def auth(ac):
    r = await ac.post("/api/auth/register", json={"email": f"brk-{uuid.uuid4()}@x.io", "password": "Password123!"})
    ac.headers["Authorization"] = f"Bearer {r.json()['access_token']}"
    return r.json()["user"]["company_id"]

async def main():
    tr = ASGITransport(app=app)
    async with AsyncClient(transport=tr, base_url="http://t", timeout=60) as ac:
        cid = await auth(ac)
        cat = (await ac.post("/api/catalog/categories", json={"name": "Brk"})).json()["id"]
        cli = (await ac.post("/api/clients", json={"last_name": "Brk"})).json()["id"]
        item = (await ac.post("/api/catalog/items", json={"category_id": cat, "designation": "X",
                "item_type": "service", "unit": "h", "unit_price_ht": "100.00", "vat_rate": "20.00"})).json()["id"]

        # --- money precision / truncation ---
        r = await ac.post("/api/quotes", json={"client_id": cli, "lines": [{"catalog_item_id": item, "quantity": "0.333"}]})
        check("quantity 0.333 refused (was silent corruption)", r.status_code == 422, f"{r.status_code}")
        r = await ac.post("/api/quotes", json={"client_id": cli, "lines": [{"catalog_item_id": item, "quantity": "0.004"}]})
        check("quantity 0.004 refused (was 0.00 billed 0.40EUR)", r.status_code == 422, f"{r.status_code}")
        r = await ac.post("/api/quotes", json={"client_id": cli, "lines": [{"catalog_item_id": item, "quantity": "999999999"}]})
        check("quantity overflow refused, not a 500", r.status_code == 422, f"{r.status_code}")
        r = await ac.post("/api/quotes", json={"client_id": cli, "lines": [{"catalog_item_id": item, "quantity": "-5"}]})
        check("negative quantity refused", r.status_code == 422, f"{r.status_code}")
        r = await ac.post("/api/quotes", json={"client_id": cli, "lines": []})
        check("quote with zero lines refused", r.status_code == 422, f"{r.status_code}")

        # --- VAT ---
        r = await ac.post("/api/catalog/items", json={"category_id": cat, "designation": "V", "item_type": "service",
              "unit": "h", "unit_price_ht": "100.00", "vat_rate": "500"})
        check("VAT 500% refused (was sent to the customer)", r.status_code == 422, f"{r.status_code}")
        r = await ac.post("/api/catalog/items", json={"category_id": cat, "designation": "V", "item_type": "service",
              "unit": "h", "unit_price_ht": "100.00", "vat_rate": "1000"})
        check("VAT 1000% refused, not a numeric overflow 500", r.status_code == 422, f"{r.status_code}")

        # --- auth / enumeration oracle ---
        r = await ac.post("/api/auth/login", json={"email": "nobody@x.io", "password": "A"*5000})
        check("5000-char password -> 422, never a 500 oracle", r.status_code == 422, f"{r.status_code}")
        r = await ac.post("/api/auth/login", json={"email": "nobody@x.io", "password": "wrong"})
        check("unknown email -> uniform 401", r.status_code == 401, f"{r.status_code}")

        # --- JWT ---
        bad = AsyncClient(transport=tr, base_url="http://t")
        for tok, label in [("not.a.jwt", "malformed JWT"), ("", "empty JWT"),
                           ("eyJhbGciOiJub25lIn0.eyJzdWIiOiJ4In0.", "alg=none forged JWT")]:
            bad.headers["Authorization"] = f"Bearer {tok}"
            r = await bad.get("/api/clients")
            check(f"{label} -> 401/403, never 500", r.status_code in (401, 403), f"{r.status_code}")
        await bad.aclose()

        # --- uploads ---
        r = await ac.post("/api/document-analysis/upload", data={"document_type": "quote"},
                          files={"file": ("x.pdf", io.BytesIO(b"totally not a pdf"), "application/pdf")})
        check("fake PDF (declared type lies) -> 415", r.status_code == 415, f"{r.status_code}")
        r = await ac.post("/api/document-analysis/upload", data={"document_type": "quote"},
                          files={"file": ("x.pdf", io.BytesIO(b""), "application/pdf")})
        check("0-byte upload -> 415", r.status_code == 415, f"{r.status_code}")
        r = await ac.post("/api/document-analysis/upload", data={"document_type": "quote"},
                          files={"file": ("x.svg", io.BytesIO(b"<svg onload=alert(1)>"), "image/svg+xml")})
        check("SVG rejected on the PDF endpoint -> 415", r.status_code == 415, f"{r.status_code}")

        # --- tenant isolation (cross-company) ---
        async with AsyncClient(transport=tr, base_url="http://t", timeout=60) as ac2:
            await auth(ac2)
            for path, label in [(f"/api/clients/{cli}", "client"), (f"/api/catalog/items/{item}", "item")]:
                r = await ac2.get(path)
                check(f"other company's {label} -> 404 (never 403)", r.status_code == 404, f"{r.status_code}")
            r = await ac2.post("/api/catalog/items", json={"category_id": cat, "designation": "steal",
                  "item_type": "service", "unit": "h", "unit_price_ht": "1.00", "vat_rate": "20.00"})
            check("grafting an item onto another company's category -> 404", r.status_code == 404, f"{r.status_code}")

        # --- quote delete (the undo path) ---
        q = (await ac.post("/api/quotes", json={"client_id": cli, "lines": [{"catalog_item_id": item, "quantity": "1"}]})).json()["id"]
        r = await ac.delete(f"/api/quotes/{q}")
        check("quote deletable (a typo is no longer permanent)", r.status_code == 204, f"{r.status_code}")
        r = await ac.get(f"/api/quotes/{q}")
        check("deleted quote is really gone -> 404", r.status_code == 404, f"{r.status_code}")

        # --- client delete guarded by quotes ---
        q2 = (await ac.post("/api/quotes", json={"client_id": cli, "lines": [{"catalog_item_id": item, "quantity": "1"}]})).json()["id"]
        r = await ac.delete(f"/api/clients/{cli}")
        check("deleting a client with quotes -> 409, not a raw 500", r.status_code == 409, f"{r.status_code}")

        # --- AI copilot degradation ---
        r = await ac.post("/api/quote-assistant/suggest", json={"description": "chauffe-eau [urgent]"})
        check("AI description with brackets still works (mock)", r.status_code == 200, f"{r.status_code}")
        r = await ac.post("/api/quote-assistant/suggest", json={"description": "x" * 6000})
        check("6000-char description -> 422 (bounded prompt)", r.status_code == 422, f"{r.status_code}")
        r = await ac.post("/api/quote-assistant/suggest", json={"description": ""})
        check("empty description -> 422", r.status_code == 422, f"{r.status_code}")

    failed = [r for r in results if not r[1]]
    print(f"\n{'='*70}\n{len(results)-len(failed)}/{len(results)} passed")
    if failed:
        print("FAILURES:"); [print(f"  - {n} ({d})") for n, ok, d in failed]
    return 1 if failed else 0

sys.exit(asyncio.run(main()))
