# Technical Debt — Dette documentaire

> **Version** 1.0 — **Status** Frozen — **Owner** Architecture — **Last Update** 2026-08-02
> **Depends On:** [CONSISTENCY_REPORT.md](CONSISTENCY_REPORT.md) — **Used By:** planification — **Niveau:** 2 · Architecture

## Objective
Recenser la dette **documentaire** restante (aucune correction de périmètre — consolidation seulement).

## Registre de dette
| # | Dette | Nature | Gravité | Action |
|---|---|---|---|---|
| **D1** | ~~`engines/engines/` sans `_TEMPLATE.md`~~ | asymétrie de structure | Basse | ✅ **résolu** (scaffold ajouté, A1) |
| **D2** | Cycle de code `users ↔ branding` | dette d'architecture réelle (code) | Moyenne | refactor V2 (déplacer `Company`) — hors STEP 7 ; tracé OD-6 |
| **D3** | ~~Libellés de lien ≠ chemin cible~~ | cosmétique | Basse | ✅ **résolu** (libellé aligné, A2) |
| **D4** | Fiches en série synthétiques (objets/moteurs/contrats) | profondeur métier | Moyenne | enrichissement continu au fil du dev (A3) |
| **D5** | Alias de moteurs non consolidés (Analytics/OCR/Conversation/Reporting) | chevauchement | Moyenne | arbitrage V2 (OD-1/2/5) — **pas de suppression en STEP 7** |
| **D6** | Familles d'objets à frontière (journal, document) | ambiguïté de niveau | Moyenne | graver les frontières (OD-3/7) |

## Ce qui n'est PAS de la dette (confirmé sain)
- Intégrité des liens (0/1725 cassé), métadonnées (252/252), comptes conformes.
- Invariants produit cohérents entre Constitution, CLAUDE.md et Constitution technique.
- Provider-abstraction (IA/stockage/e-mail) et « Build Product, Not Infrastructure ».

## Principe
Toute cette dette est **consolidable sans rouvrir le périmètre**. Aucune ne bloque le démarrage du développement.

## Acceptance Criteria
La dette est recensée, gravée en gravité, et rattachée à une action ou une décision ouverte.

## Related Documents
[OPEN_DECISIONS.md](OPEN_DECISIONS.md) · [ACTION_PLAN.md](ACTION_PLAN.md)

## Next Reading
[OPEN_DECISIONS.md](OPEN_DECISIONS.md)

## Changelog
- 1.0 (2026-08-02) — Registre initial.
