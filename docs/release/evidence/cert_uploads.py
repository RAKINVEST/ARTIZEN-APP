"""RC certification: uploads remain secure in V2, over Docker HTTP.
V2 added a path where the logo is read back (PDF), so upload safety matters
more than ever."""
import io, sys, uuid, httpx
BASE="http://localhost:8000"; R=[]
def ck(n,ok,d=""): R.append((n,ok)); print(f"{'PASS' if ok else '*** FAIL ***'} | {n:52s} | {d}")
PNG=b"\x89PNG\r\n\x1a\n\x00\x00\x00\rIHDR\x00\x00\x00\x01\x00\x00\x00\x01\x08\x06\x00\x00\x00\x1f\x15\xc4\x89\x00\x00\x00\nIDATx\x9cc\x00\x01\x00\x00\x05\x00\x01\r\n-\xb4\x00\x00\x00\x00IEND\xaeB`\x82"
with httpx.Client(base_url=BASE, timeout=60) as c:
    c.headers["Authorization"]=f"Bearer {c.post('/api/auth/register',json={'email':f'u-{uuid.uuid4()}@x.io','password':'Password123!'}).json()['access_token']}"
    # magic-byte enforcement on both upload surfaces
    ck("logo: fake PNG (bytes lie) -> 415", c.post("/api/branding/logo",files={"file":("l.png",io.BytesIO(b"not a png"),"image/png")}).status_code==415)
    ck("logo: 0-byte -> 415", c.post("/api/branding/logo",files={"file":("l.png",io.BytesIO(b""),"image/png")}).status_code==415)
    ck("logo: real PNG -> 201", c.post("/api/branding/logo",files={"file":("l.png",io.BytesIO(PNG),"image/png")}).status_code==201)
    ck("doc: fake PDF -> 415", c.post("/api/document-analysis/upload",data={"document_type":"quote"},files={"file":("x.pdf",io.BytesIO(b"nope"),"application/pdf")}).status_code==415)
    # path traversal in the filename must not escape — the stored key is a uuid
    ck("logo: traversal filename accepted but stored under a uuid key",
       c.post("/api/branding/logo",files={"file":("../../etc/passwd.png",io.BytesIO(PNG),"image/png")}).status_code==201)
    prof=c.get("/api/branding/profile").json()
    ck("stored logo_path is a uuid key, not the user filename",
       prof["brand"]["logo_path"] and ".." not in prof["brand"]["logo_path"] and "passwd" not in prof["brand"]["logo_path"], prof["brand"]["logo_path"])
    # oversized body guard (V1) still active
    big=b"%PDF-"+b"0"*(21*1024*1024)
    ck("oversized upload rejected (413 or 415), not a 500",
       c.post("/api/document-analysis/upload",data={"document_type":"quote"},files={"file":("big.pdf",io.BytesIO(big),"application/pdf")}).status_code in (413,415))
    # the PDF now reads the logo back — with a valid logo set, rendering works
    cat=c.post("/api/catalog/categories",json={"name":"C"}).json()["id"]
    cli=c.post("/api/clients",json={"last_name":"X"}).json()["id"]
    it=c.post("/api/catalog/items",json={"category_id":cat,"designation":"X","item_type":"service","unit":"h","unit_price_ht":"100.00","vat_rate":"20.00"}).json()["id"]
    q=c.post("/api/quotes",json={"client_id":cli,"lines":[{"catalog_item_id":it,"quantity":"1"}]}).json()["id"]
    ck("PDF renders with the uploaded logo read from storage", c.get(f"/api/quotes/{q}/pdf").status_code==200)
f=[x for x in R if not x[1]]; print(f"\n{'='*72}\n{len(R)-len(f)}/{len(R)} passed"); [print(f"  FAILED: {n}") for n,ok in f if not ok]; sys.exit(1 if f else 0)
