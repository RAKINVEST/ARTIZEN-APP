"""RC certification: security of the V2 endpoints, over HTTP against Docker.
Proves each new route (duplicate, pdf, status) enforces the same rules as
the rest: JWT required, tenant isolation (404 not 403), no leak."""
import io, sys, uuid, httpx
BASE="http://localhost:8000"; R=[]
def ck(n,ok,d=""): R.append((n,ok)); print(f"{'PASS' if ok else '*** FAIL ***'} | {n:56s} | {d}")

with httpx.Client(base_url=BASE, timeout=60) as c:
    c.headers["Authorization"]=f"Bearer {c.post('/api/auth/register',json={'email':f'a-{uuid.uuid4()}@x.io','password':'Password123!'}).json()['access_token']}"
    cat=c.post("/api/catalog/categories",json={"name":"C"}).json()["id"]
    cli=c.post("/api/clients",json={"last_name":"X"}).json()["id"]
    it=c.post("/api/catalog/items",json={"category_id":cat,"designation":"X","item_type":"service","unit":"h","unit_price_ht":"100.00","vat_rate":"20.00"}).json()["id"]
    q=c.post("/api/quotes",json={"client_id":cli,"lines":[{"catalog_item_id":it,"quantity":"1"}]}).json()["id"]

    # --- 1. every V2 route requires a JWT ---
    anon = httpx.Client(base_url=BASE, timeout=60)  # no Authorization header
    ck("GET  /quotes/{id}/pdf without JWT -> 401/403", anon.get(f"/api/quotes/{q}/pdf").status_code in (401,403))
    ck("POST /quotes/{id}/duplicate without JWT -> 401/403", anon.post(f"/api/quotes/{q}/duplicate").status_code in (401,403))
    ck("PUT  /quotes/{id}/status without JWT -> 401/403", anon.put(f"/api/quotes/{q}/status",json={"status":"sent"}).status_code in (401,403))
    # garbage / forged tokens
    for tok,label in [("garbage","garbage"),("eyJhbGciOiJub25lIn0.eyJzdWIiOiJ4In0.","alg=none forged")]:
        anon.headers["Authorization"]=f"Bearer {tok}"
        ck(f"PDF with {label} token -> 401", anon.get(f"/api/quotes/{q}/pdf").status_code==401)
    anon.close()

    # --- 2. tenant isolation: another company sees 404, never 403, on all V2 routes ---
    with httpx.Client(base_url=BASE, timeout=60) as c2:
        c2.headers["Authorization"]=f"Bearer {c2.post('/api/auth/register',json={'email':f'b-{uuid.uuid4()}@x.io','password':'Password123!'}).json()['access_token']}"
        ck("other tenant PDF -> 404 (not 403, no existence leak)", c2.get(f"/api/quotes/{q}/pdf").status_code==404)
        ck("other tenant duplicate -> 404", c2.post(f"/api/quotes/{q}/duplicate").status_code==404)
        ck("other tenant status change -> 404", c2.put(f"/api/quotes/{q}/status",json={"status":"sent"}).status_code==404)
        # and none of the attempts had a side effect on the victim
        ck("victim quote untouched (still draft)", c.get(f"/api/quotes/{q}").json()["status"]=="draft")
        ck("no phantom copy in attacker's list", c2.get("/api/quotes").json()==[])

    # --- 3. the PDF (which carries identity + client address) does not leak via the number either ---
    #     a valid tenant downloads their own; content-disposition uses the number, not raw input
    r = c.get(f"/api/quotes/{q}/pdf")
    ck("own PDF downloadable (200, application/pdf)", r.status_code==200 and r.headers["content-type"]=="application/pdf")
    ck("filename header is clean (no header injection)", '"' in r.headers["content-disposition"] and "\r" not in r.headers["content-disposition"] and "\n" not in r.headers["content-disposition"])

    # --- 4. duplicate cannot be used to inject a chosen number/status (client input ignored) ---
    d = c.post(f"/api/quotes/{q}/duplicate", json={"quote_number":"HACK","status":"accepted"}).json()
    ck("duplicate ignores client-supplied number", d["quote_number"]!="HACK", d["quote_number"])
    ck("duplicate ignores client-supplied status (always draft)", d["status"]=="draft")

f=[x for x in R if not x[1]]; print(f"\n{'='*80}\n{len(R)-len(f)}/{len(R)} passed"); [print(f"  FAILED: {n}") for n,ok in f if not ok]; sys.exit(1 if f else 0)
