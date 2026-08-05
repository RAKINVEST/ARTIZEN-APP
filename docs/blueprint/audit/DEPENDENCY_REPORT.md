# Dependency Report — Rapport de dépendances

> **Version** 1.0 — **Status** Frozen — **Owner** Architecture — **Last Update** 2026-08-02
> **Depends On:** [../engines/ENGINE_DEPENDENCIES.md](../engines/ENGINE_DEPENDENCIES.md), [../implementation/DEPENDENCY_RULES.md](../implementation/DEPENDENCY_RULES.md) — **Used By:** gouvernance — **Niveau:** 2 · Architecture

## Objective
Cartographier les dépendances (documentaires et de code), repérer cycles, dépendances inutiles et points critiques.

## Matrice — dépendances de code réelles (source : CLAUDE.md, vérifiées)
| Élément | Dépend de | Utilisé par | Impact | Criticité | Risque |
|---|---|---|---|---|---|
| `quotes` | `catalog`, `clients` | `quote_assistant`, PDF | central | **Haute** | faible (sens unique justifié) |
| `catalog` | — | `quotes`, `quote_assistant`, `interventions` | fondation | Haute | faible |
| `clients` | — | `quotes` | fondation | Moyenne | faible |
| `document_detection` | `document_analysis` | `template_import` | pipeline | Moyenne | faible |
| `template_import` | `branding`, `document_analysis`, `document_detection` | — (orchestrateur) | périphérique | Basse | faible |
| `quote_assistant` | `catalog`, `quotes`, `branding` (lecture) | — | périphérique | Moyenne | faible (ne persiste rien) |
| tous les modules | `users.deps.CurrentUserDep` | — | infrastructure auth | Haute | faible (dépendance d'infra assumée) |
| `models/__init__.py` | tous les modules | Alembic | build | Haute | faible |
| `app/pdf/` | `app.pdf.*` **seulement** | `quotes` (via mapper) | isolé | Moyenne | faible (contrainte tenue) |

## Cycles
| Cycle | Réalité | Statut |
|---|---|---|
| `users ↔ branding` | **réel** : `users` importe `branding.CompanyRepository` (l'inscription crée une `Company`) ; `branding/router` importe `users.deps` | ⏳ **connu et borné** — pas de cycle à l'import (l'app démarre, la suite pytest le prouve). Cause : `Company` appartient à `branding`. Résolution = déplacement en V2. Voir [OPEN_DECISIONS](OPEN_DECISIONS.md) OD-6, [TECHNICAL_DEBT](TECHNICAL_DEBT.md) D2 |

Aucun **autre** cycle détecté. La règle « dépendances à sens unique et justifiées » est respectée partout ailleurs.

## Dépendances documentaires (Blueprint)
- Sens général : Implémentation → Contrats → Flux → Moteurs → Domain → Vision. **Acyclique** (0 lien cassé, aucune boucle documentaire détectée).
- `models/` (doc & code) dépend des modules, jamais l'inverse — confirmé.

## Dépendances inutiles
Aucune dépendance de code inutile détectée. Point de vigilance : `quote_assistant` lit `branding`
seulement pour le nom d'entreprise — dépendance **mince mais justifiée** (lecture seule).

## Points critiques (à surveiller)
1. `catalog` et `quotes` = cœur ; toute évolution de leur contrat a un fort rayon d'impact → passer par [../contracts/](../contracts/) + ADR.
2. `CurrentUserDep` = point de couplage universel (8 modules) — assumé comme infrastructure.
3. Cycle `users ↔ branding` = seule entorse ; à ne pas aggraver avant le refactor V2.

## Acceptance Criteria
Toutes les dépendances sont documentées ; tout cycle est identifié et tracé ; aucun cycle **non** documenté.

## Related Documents
[../implementation/DEPENDENCY_RULES.md](../implementation/DEPENDENCY_RULES.md) · [TRACEABILITY_REPORT.md](TRACEABILITY_REPORT.md)

## Next Reading
[TRACEABILITY_REPORT.md](TRACEABILITY_REPORT.md)

## Changelog
- 1.0 (2026-08-02) — Matrice initiale.
