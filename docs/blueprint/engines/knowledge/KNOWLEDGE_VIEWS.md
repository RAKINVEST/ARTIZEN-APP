# Knowledge Views — Vues & projections

> **Version** 1.0 — **Status** Validated — **Owner** Knowledge — **Last Update** 2026-08-02
> **Depends On:** [KNOWLEDGE_GRAPH.md](KNOWLEDGE_GRAPH.md) — **Used By:** IA, recherche, UI — **Niveau:** 2 · Architecture

## Objective
Spécifier les **vues multiples** d'une même Card. **Le contenu reste unique** ; les vues sont des
**projections en lecture**. **Aucune duplication de données.**

## Principe
Une Card (`Knowledge`) est **stockée une fois**. Chaque vue est une **requête/projection** qui
sélectionne et ordonne des Cards selon un axe. Changer de vue ne change **jamais** le contenu.

## Les dix axes de vue (demandés)
| Axe | Projeté à partir de | Nature |
|---|---|---|
| par métier | taxonomie `Catalog/trades` (réf. par id/tag) | relation/facette |
| par famille | `Category` (réf.) ou facette | relation/facette |
| par intervention | relation R2 (`Intervention`) | relation existante |
| par problème | **facette** (tag de la Card) | métadonnée |
| par équipement | **facette** (tag) — *pas d'objet Equipment* | métadonnée |
| par pièce | **facette** (tag) — *pas d'objet Room* | métadonnée |
| par saison | **facette** (tag) | métadonnée |
| par client | via `Mission`→`Customer` (réf. indirecte, lecture) | relation indirecte |
| par diagnostic | **facette** (tag) | métadonnée |
| par recherche | index plein-texte sur la Card | projection |

## Facettes vs objets (règle de non-création)
Les axes **sans objet dédié** (problème, équipement, pièce, saison, diagnostic) sont des
**facettes/tags** portés par la Card `Knowledge` — **pas de nouvel objet métier**. Si l'implémentation
exigeait un objet persistant dédié (ex. un référentiel `Equipment`), **cela relèverait d'un ADR**
(voir OPEN POINTS). Ici : **facettes uniquement**, zéro objet nouveau.

## Garanties
- **Une seule source** (la Card) ; N vues ; **zéro copie**.
- Une vue est **read-only** ; elle n'écrit jamais la Card ni un objet lié.
- L'ordre/filtre d'une vue n'altère pas l'historique de la Card (append-only).

## Conformité (STEP 1–8)
- Vues = projections ; Domain Model non dupliqué. ✅
- Facettes = métadonnées de `Knowledge` ; aucun objet créé (sinon ADR). ✅

## Related Documents
[KNOWLEDGE_GRAPH.md](KNOWLEDGE_GRAPH.md) · [KNOWLEDGE_PERMISSIONS.md](KNOWLEDGE_PERMISSIONS.md)

## Next Reading
[KNOWLEDGE_PERMISSIONS.md](KNOWLEDGE_PERMISSIONS.md)

## Changelog
- 1.0 (2026-08-02) — Vues initiales.
