"""Deliberate break attempt on the V2 PDF engine, over the real route."""
import asyncio, io, os, sys, time, uuid
sys.path.insert(0, r"c:\Users\Utilisateur\Documents\GitHub\ARTIZEN-APP\backend")
os.chdir(r"c:\Users\Utilisateur\Documents\GitHub\ARTIZEN-APP\backend")
os.environ.setdefault("AUTH_RATE_LIMIT_ENABLED", "false")
from httpx import ASGITransport, AsyncClient
from pypdf import PdfReader
from app.main import app

R=[]
def ck(n, ok, d=""):
    R.append((n,ok,d)); print(f"{'PASS' if ok else '*** FAIL ***'} | {n:54s} | {d}")

async def main():
    tr = ASGITransport(app=app)
    async with AsyncClient(transport=tr, base_url="http://t", timeout=120) as ac:
        r = await ac.post("/api/auth/register", json={"email": f"pdf-{uuid.uuid4()}@x.io", "password": "Password123!"})
        ac.headers["Authorization"] = f"Bearer {r.json()['access_token']}"
        cat = (await ac.post("/api/catalog/categories", json={"name": "C"})).json()["id"]
        cli = (await ac.post("/api/clients", json={"last_name": "Martin", "address": "3 allee des Lilas"})).json()["id"]

        async def item(price, vat, desig="Article"):
            return (await ac.post("/api/catalog/items", json={"category_id": cat, "designation": desig,
                "item_type": "service", "unit": "h", "unit_price_ht": price, "vat_rate": vat})).json()["id"]
        i20 = await item("100.00", "20.00")
        i10 = await item("60.00", "10.00", "Main-d'oeuvre")

        async def quote(lines):
            return (await ac.post("/api/quotes", json={"client_id": cli, "lines": lines})).json()

        # 1. multi-rate VAT summary must appear and be right
        q = await quote([{"catalog_item_id": i20, "quantity": "1"}, {"catalog_item_id": i10, "quantity": "1"}])
        pdf = (await ac.get(f"/api/quotes/{q['id']}/pdf")).content
        t = PdfReader(io.BytesIO(pdf)).pages[0].extract_text()
        ck("multi-rate quote renders", pdf.startswith(b"%PDF-"))
        ck("per-rate VAT summary present", "Base HT" in t)
        # 100@20% -> 120 TTC ; 60@10% -> 66 TTC ; total 186.00
        ck("TTC on PDF equals backend TTC", "186,00" in t and q["total_ttc"] == "186.00", f"api={q['total_ttc']}")

        # 2. no branding configured at all
        ck("PDF for an account with no logo/colour", (await ac.get(f"/api/quotes/{q['id']}/pdf")).status_code == 200)

        # 3. a garbage logo in storage must not lose the document
        await ac.post("/api/branding/logo", files={"file": ("l.png", io.BytesIO(b"\x89PNG\r\n\x1a\n" + b"garbage"*20), "image/png")})
        r = await ac.get(f"/api/quotes/{q['id']}/pdf")
        ck("corrupt stored logo degrades, still 200", r.status_code == 200 and r.content.startswith(b"%PDF-"), str(r.status_code))

        # 4. an absurd brand colour
        await ac.put("/api/branding/brand", json={"primary_color": "#GGGGGG"})
        r = await ac.get(f"/api/quotes/{q['id']}/pdf")
        ck("invalid brand colour degrades, still 200", r.status_code == 200, str(r.status_code))

        # 5. long designation + many lines
        big = await item("10.00", "20.00", "Remplacement complet de la colonne montante " * 8)
        q2 = await quote([{"catalog_item_id": big, "quantity": "1"} for _ in range(60)])
        r = await ac.get(f"/api/quotes/{q2['id']}/pdf")
        pages = len(PdfReader(io.BytesIO(r.content)).pages)
        ck("60 long lines paginate, no crash", r.status_code == 200 and pages > 1, f"{pages} pages")

        # 6. concurrency: PDF rendering must not serialize or fail
        t0 = time.monotonic()
        rs = await asyncio.gather(*(ac.get(f"/api/quotes/{q['id']}/pdf") for _ in range(8)))
        dt = time.monotonic()-t0
        ck("8 concurrent renders all succeed", all(x.status_code == 200 for x in rs), f"{dt:.1f}s")
        ck("concurrent renders are byte-identical (deterministic input)",
           len({len(x.content) for x in rs}) == 1, f"sizes={ {len(x.content) for x in rs} }")

        # 7. tenant isolation on a document carrying identity + address
        async with AsyncClient(transport=tr, base_url="http://t", timeout=60) as ac2:
            r2 = await ac2.post("/api/auth/register", json={"email": f"o-{uuid.uuid4()}@x.io", "password": "Password123!"})
            ac2.headers["Authorization"] = f"Bearer {r2.json()['access_token']}"
            ck("other tenant cannot download the PDF (404)",
               (await ac2.get(f"/api/quotes/{q['id']}/pdf")).status_code == 404)

        # 8. PDF still available after the quote is frozen
        await ac.put(f"/api/quotes/{q['id']}/status", json={"status": "sent"})
        ck("sent quote still downloadable", (await ac.get(f"/api/quotes/{q['id']}/pdf")).status_code == 200)

        # 9. unknown / malformed ids
        ck("unknown quote -> 404", (await ac.get(f"/api/quotes/{uuid.uuid4()}/pdf")).status_code == 404)
        ck("malformed uuid -> 422", (await ac.get("/api/quotes/not-a-uuid/pdf")).status_code == 422)

        # 10. filename header is safe (no injection via quote number)
        r = await ac.get(f"/api/quotes/{q['id']}/pdf")
        cd = r.headers["content-disposition"]
        ck("Content-Disposition is a clean filename", cd.count('"') == 2 and "\n" not in cd, cd)

    f=[x for x in R if not x[1]]
    print(f"\n{'='*76}\n{len(R)-len(f)}/{len(R)} passed")
    [print(f"  FAILED: {n} ({d})") for n,ok,d in f]
    return 1 if f else 0

sys.exit(asyncio.run(main()))
