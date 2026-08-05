# Contract Anti-Patterns — Erreurs de contrat interdites

> **Version** 1.0 — **Status** Frozen — **Owner** Architecture — **Last Update** 2026-08-02
> **Depends On:** [CONTRACT_PATTERNS.md](CONTRACT_PATTERNS.md) — **Used By:** revue de tout contrat — **Niveau:** 2 · Architecture

## Objective
Interdire les formes de contrat qui créent de l'ambiguïté ou cassent les consommateurs.

## Anti-patterns interdits
| Anti-pattern | Pourquoi | À faire |
|---|---|---|
| **DTO God** | objet fourre-tout | un DTO par intention |
| **Payload ambigu** | interprétation nécessaire | champs explicites, typés |
| **Champ sans propriétaire** | source floue | chaque champ appartient à un objet/moteur |
| **Erreur générique** | non actionnable | code + enveloppe normalisée |
| **Version implicite** | incompatibilités | version explicite partout |
| **Breaking change silencieux** | casse les consommateurs | version majeure + ADR + migration |
| **Réponse incohérente** | formes multiples pour un même sens | enveloppe unique |
| **Null inexpliqué** | ambiguïté | nullable documenté, sens précis |
| **Formats multiples** | date/montant variables | un seul format (ISO, décimal chaîne) |

## Règle
Un contrat présentant un de ces anti-patterns est refusé en revue. Toute exception exige un ADR.

## Acceptance Criteria
Les anti-patterns majeurs sont listés avec leur correction.

## Related Documents
[CONTRACT_PATTERNS.md](CONTRACT_PATTERNS.md) · [VERSIONING_POLICY.md](VERSIONING_POLICY.md)

## Next Reading
[contracts/](contracts/)

## Changelog
- 1.0 (2026-08-02) — Anti-patterns initiaux.
