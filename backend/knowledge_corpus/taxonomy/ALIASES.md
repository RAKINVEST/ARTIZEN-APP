# Aliases — Alias & synonymes

> **Version** 1.0 — **Status** Validated — **Owner** Éditorial / Contenu métier — **Last Update** 2026-08-02
> **Depends On:** [TAG_RULES.md](TAG_RULES.md) — **Used By:** recherche, saisie, IA

## Objective
Registre des **alias autorisés** (entrées équivalentes résolues vers un slug officiel) et des
**synonymes interdits** (variantes à ne jamais créer comme valeur distincte). Mécanisme anti-doublon.

## Alias d'axe
| Alias | Slug officiel | Note |
|---|---|---|
| `metier:` | `activite:` | terminologie « métier » ↔ « activité » (composition) |

## Alias de valeur (amorce, extensible)
| Alias saisi | Résout vers |
|---|---|
| `cumulus` | `equipement:chauffe-eau` |
| `sdb` | `piece:salle-de-bain` |
| `pvc-u` | `materiau:pvc` |
| `placo` | `materiau:placo` (marque générique de plaque de plâtre) |
| `chaudiere-gaz` | `equipement:chaudiere` (+ `materiau`/`energie` en facette) |

## Synonymes interdits (exemples)
- Créer `metier:plombier` **au lieu de** `activite:plomberie` → interdit (utiliser le slug gelé).
- Créer `probleme:qui-fuit` **au lieu de** `probleme:fuite` → interdit.
- Dupliquer une famille sous un autre nom → interdit (métier gelé).

## Règles
- Un alias **n'est jamais** une nouvelle valeur : il **pointe** vers le slug officiel.
- Un alias se **résout à l'indexation** ([SEARCH_INDEX.md](SEARCH_INDEX.md)).
- Ajouter un alias = relecture éditoriale ; supprimer une valeur = interdit (deprecate).

## Changelog
- 1.0 (2026-08-02) — Registre initial.
