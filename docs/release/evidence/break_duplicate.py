"""Deliberate break attempt on quote duplication, over Docker HTTP."""
import asyncio, sys, uuid, httpx
BASE = "http://localhost:8000"
R=[]
def ck(n, ok, d=""):
    R.append((n,ok,d)); print(f"{'PASS' if ok else '*** FAIL ***'} | {n:56s} | {d}")

async def main():
    async with httpx.AsyncClient(base_url=BASE, timeout=90) as ac:
        r = await ac.post("/api/auth/register", json={"email": f"dup-{uuid.uuid4()}@x.io", "password": "Password123!"})
        ac.headers["Authorization"] = f"Bearer {r.json()['access_token']}"
        cat = (await ac.post("/api/catalog/categories", json={"name":"C"})).json()["id"]
        cli = (await ac.post("/api/clients", json={"last_name":"Martin"})).json()["id"]
        async def item(price, vat, d="X"):
            return (await ac.post("/api/catalog/items", json={"category_id":cat,"designation":d,
                "item_type":"service","unit":"h","unit_price_ht":price,"vat_rate":vat})).json()["id"]
        i20 = await item("100.00","20.00","Article A")
        i10 = await item("60.00","10.00","Main d'oeuvre")
        q = (await ac.post("/api/quotes", json={"client_id":cli,"lines":[
            {"catalog_item_id":i20,"quantity":"2"},{"catalog_item_id":i10,"quantity":"1.5"}]})).json()

        # 1. exact copy of lines and totals
        d = (await ac.post(f"/api/quotes/{q['id']}/duplicate")).json()
        ck("copy has the same TTC to the cent", d["total_ttc"] == q["total_ttc"], f"{q['total_ttc']} -> {d['total_ttc']}")
        ck("copy has the same number of lines", len(d["lines"]) == len(q["lines"]))
        ck("copy line amounts match line by line",
           [(l["designation"],l["total_ttc"]) for l in d["lines"]] == [(l["designation"],l["total_ttc"]) for l in q["lines"]])
        ck("copy is a draft", d["status"] == "draft")
        ck("copy has a different id", d["id"] != q["id"])
        ck("copy has a different, later number", d["quote_number"] != q["quote_number"] and d["quote_number"].endswith("0002"), d["quote_number"])

        # 2. original untouched
        orig = (await ac.get(f"/api/quotes/{q['id']}")).json()
        ck("original unchanged by duplication", orig["quote_number"] == q["quote_number"] and orig["status"] == "draft")

        # 3. concurrent duplications -> distinct numbers, no collision
        rs = await asyncio.gather(*(ac.post(f"/api/quotes/{q['id']}/duplicate") for _ in range(10)))
        ck("10 concurrent duplications all 201", all(x.status_code==201 for x in rs), str([x.status_code for x in rs][:3]))
        nums = [x.json()["quote_number"] for x in rs]
        ck("10 concurrent copies get 10 distinct numbers", len(set(nums))==10, f"{len(set(nums))} distinct")

        # 4. robustness: duplicate after the catalog item is deactivated
        await ac.delete(f"/api/catalog/items/{i20}")
        dd = await ac.post(f"/api/quotes/{q['id']}/duplicate")
        ck("duplicate still works with an inactive catalog item", dd.status_code == 201, str(dd.status_code))
        ck("inactive item's line is preserved in the copy",
           any(l["designation"]=="Article A" for l in dd.json()["lines"]))

        # 5. duplicate a sent/accepted quote
        await ac.put(f"/api/quotes/{q['id']}/status", json={"status":"sent"})
        await ac.put(f"/api/quotes/{q['id']}/status", json={"status":"accepted"})
        ds = await ac.post(f"/api/quotes/{q['id']}/duplicate")
        ck("duplicate of an accepted quote is a new draft", ds.status_code==201 and ds.json()["status"]=="draft")
        ck("the accepted original stays accepted", (await ac.get(f"/api/quotes/{q['id']}")).json()["status"]=="accepted")
        # and the copy is editable where the original was not
        ck("the copy can be deleted (editable)", (await ac.delete(f"/api/quotes/{ds.json()['id']}")).status_code==204)

        # 6. errors
        ck("duplicate unknown quote -> 404", (await ac.post(f"/api/quotes/{uuid.uuid4()}/duplicate")).status_code==404)
        ck("duplicate malformed id -> 422", (await ac.post("/api/quotes/not-a-uuid/duplicate")).status_code==422)

        # 7. tenant isolation
        async with httpx.AsyncClient(base_url=BASE, timeout=60) as ac2:
            r2 = await ac2.post("/api/auth/register", json={"email": f"o-{uuid.uuid4()}@x.io","password":"Password123!"})
            ac2.headers["Authorization"] = f"Bearer {r2.json()['access_token']}"
            ck("other tenant cannot duplicate the quote -> 404", (await ac2.post(f"/api/quotes/{q['id']}/duplicate")).status_code==404)
            # and no phantom copy landed in the attacker's list
            ck("no copy leaked into the other tenant", (await ac2.get("/api/quotes")).json()==[])

        # 8. a copy of a copy keeps the lines
        base = (await ac.post("/api/quotes", json={"client_id":cli,"lines":[{"catalog_item_id":i10,"quantity":"3"}]})).json()
        c1 = (await ac.post(f"/api/quotes/{base['id']}/duplicate")).json()
        c2 = (await ac.post(f"/api/quotes/{c1['id']}/duplicate")).json()
        ck("copy-of-a-copy keeps the line and TTC", c2["total_ttc"]==base["total_ttc"] and len(c2["lines"])==1)

    f=[x for x in R if not x[1]]
    print(f"\n{'='*80}\n{len(R)-len(f)}/{len(R)} passed")
    [print(f"  FAILED: {n} ({d})") for n,ok,d in f]
    return 1 if f else 0

sys.exit(asyncio.run(main()))
