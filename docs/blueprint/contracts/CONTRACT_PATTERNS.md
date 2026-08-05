# Contract Patterns — Patrons de contrat

> **Version** 1.0 — **Status** Frozen — **Owner** Architecture — **Last Update** 2026-08-02
> **Depends On:** [CONTRACT_INDEX.md](CONTRACT_INDEX.md) — **Used By:** contracts/ — **Niveau:** 2 · Architecture

## Objective
Les formes récurrentes de contrat, à réutiliser plutôt qu'à réinventer.

## Patrons
| Patron | Forme | Exemple |
|---|---|---|
| **Enveloppe unique** | réponse/erreur toujours structurée pareil | `{error:{code,message}}` |
| **Événement versionné** | `schema_version` + upcasting | `QuoteAccepted v1` |
| **Command/Query separation** | écriture ≠ lecture | `CreateQuote` vs `GET /quotes` |
| **DTO par intention** | un DTO lecture, un DTO écriture | `QuoteReadDTO` / `QuoteCreateDTO` |
| **Pagination bornée** | `offset/limit` plafonnés | `limit ≤ 200` |
| **Confiance + justification** | toute sortie décisionnelle | `Suggestion{confidence, justification}` |
| **Montant fidèle** | décimal en chaîne | `total_ht: "1200.00"` |
| **Idempotence** | rejouer = même effet | `PUT`, événement idempotent |

## Rules
Tout contrat cite le(s) patron(s) qu'il applique. Un montant reste une chaîne décimale ; une sortie IA/décision porte confiance + justification.

## Acceptance Criteria
Chaque patron a une forme et un exemple.

## Related Documents
[CONTRACT_ANTI_PATTERNS.md](CONTRACT_ANTI_PATTERNS.md)

## Next Reading
[CONTRACT_ANTI_PATTERNS.md](CONTRACT_ANTI_PATTERNS.md)

## Changelog
- 1.0 (2026-08-02) — Patrons initiaux.
