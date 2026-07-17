"""The V1 hardening surface, re-checked over HTTP against Docker — proof the
old guarantees still hold on the v2 branch."""
import io, sys, uuid, httpx
BASE="http://localhost:8000"; R=[]
def ck(n,ok,d=""): R.append((n,ok)); print(f"{'PASS' if ok else '*** FAIL ***'} | {n:50s} | {d}")
with httpx.Client(base_url=BASE, timeout=60) as c:
    cid=c.post("/api/auth/register",json={"email":f"v1-{uuid.uuid4()}@x.io","password":"Password123!"}).json()
    c.headers["Authorization"]=f"Bearer {cid['access_token']}"
    cat=c.post("/api/catalog/categories",json={"name":"C"}).json()["id"]
    cli=c.post("/api/clients",json={"last_name":"X"}).json()["id"]
    it=c.post("/api/catalog/items",json={"category_id":cat,"designation":"X","item_type":"service","unit":"h","unit_price_ht":"100.00","vat_rate":"20.00"}).json()["id"]
    ck("quantity 0.333 refused (money truncation)", c.post("/api/quotes",json={"client_id":cli,"lines":[{"catalog_item_id":it,"quantity":"0.333"}]}).status_code==422)
    ck("VAT 500% refused", c.post("/api/catalog/items",json={"category_id":cat,"designation":"V","item_type":"service","unit":"h","unit_price_ht":"100.00","vat_rate":"500"}).status_code==422)
    ck("5000-char password -> 422 not 500 (enum oracle)", c.post("/api/auth/login",json={"email":"n@x.io","password":"A"*5000}).status_code==422)
    ck("garbage JWT -> 401", c.get("/api/clients",headers={"Authorization":"Bearer x"}).status_code==401)
    ck("alg=none forged JWT -> 401", c.get("/api/clients",headers={"Authorization":"Bearer eyJhbGciOiJub25lIn0.eyJzdWIiOiJ4In0."}).status_code==401)
    ck("fake PDF (declared type lies) -> 415", c.post("/api/document-analysis/upload",data={"document_type":"quote"},files={"file":("x.pdf",io.BytesIO(b"nope"),"application/pdf")}).status_code==415)
    ck("0-byte upload -> 415", c.post("/api/document-analysis/upload",data={"document_type":"quote"},files={"file":("x.pdf",io.BytesIO(b""),"application/pdf")}).status_code==415)
    ck("AI copilot works with brackets (mock)", c.post("/api/quote-assistant/suggest",json={"description":"chauffe-eau [urgent]"}).status_code==200)
    ck("empty description -> 422", c.post("/api/quote-assistant/suggest",json={"description":""}).status_code==422)
    with httpx.Client(base_url=BASE,timeout=60) as c2:
        c2.headers["Authorization"]=f"Bearer {c2.post('/api/auth/register',json={'email':f'o-{uuid.uuid4()}@x.io','password':'Password123!'}).json()['access_token']}"
        ck("cross-tenant client -> 404 not 403", c2.get(f"/api/clients/{cli}").status_code==404)
    codes=[c.post("/api/auth/login",json={"email":"a@b.io","password":"w"}).status_code for _ in range(14)]
    ck("rate limiting active (429 appears)", 429 in codes, f"{codes.count(429)}x429")
f=[x for x in R if not x[1]]; print(f"\n{len(R)-len(f)}/{len(R)} passed"); sys.exit(1 if f else 0)
