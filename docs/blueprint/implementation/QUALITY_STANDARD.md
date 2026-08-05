# Quality Standard — Seuils de qualité

> **Version** 1.0 — **Status** Frozen — **Owner** Architecture — **Last Update** 2026-08-02
> **Depends On:** [CODING_STANDARDS.md](CODING_STANDARDS.md) — **Used By:** revue, CI — **Niveau:** 3 · Implémentation

## Objective
Garantir cohérence, maintenabilité, lisibilité, testabilité, évolutivité, traçabilité, stabilité.

## Seuils
| Critère | Règle |
|---|---|
| **Complexité** | fonctions courtes, une intention ; complexité cyclomatique maîtrisée |
| **Taille** | pas de classe/méthode géante ; découper au-delà d'une responsabilité |
| **Duplication** | zéro copier-coller ; extraire au second consommateur |
| **Couplage** | faible ; via contrats/événements |
| **Cohésion** | forte ; tout dans un module sert sa responsabilité |
| **Lisibilité** | nommage explicite ; le *pourquoi* commenté |
| **Analyse statique** | `ruff`/`mypy` (backend), `flutter analyze` (front) **sans erreur** |
| **Formatage** | automatique, non négociable |

## Forbidden
Dette technique cachée · code mort · logs parasites · commentaire inutile.

## Acceptance Criteria
Analyse statique verte ; aucun anti-pattern de [../implementation/CHECKLISTS.md](CHECKLISTS.md).

## Related Documents
[REVIEW_PROCESS.md](REVIEW_PROCESS.md) · [CI_CD_POLICY.md](CI_CD_POLICY.md)

## Next Reading
[REVIEW_PROCESS.md](REVIEW_PROCESS.md)

## Changelog
- 1.0 (2026-08-02) — Seuils initiaux.
