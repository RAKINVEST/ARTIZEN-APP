# Problem Types — Types de problème

> **Version** 1.0 — **Status** Validated (éditorial) — **Owner** Éditorial / Contenu métier — **Last Update** 2026-08-02
> **Depends On:** [TAXONOMY.md](TAXONOMY.md) — **Used By:** cards, diagnostics, recherche

## Objective
Classer **le symptôme** traité par une carte. Axe `probleme:`. Vocabulaire contrôlé, extensible.

## Vocabulaire officiel (`probleme:`)
| Slug | Sens |
|---|---|
| `fuite` | perte d'eau/fluide/air |
| `bruit` | nuisance sonore anormale |
| `absence-pression` | pression insuffisante/nulle |
| `absence-alimentation` | plus d'eau/électricité/gaz |
| `absence-chauffe` | ne chauffe plus / eau froide |
| `corrosion` | dégradation par oxydation |
| `obstruction` | bouchon / engorgement |
| `usure` | vieillissement fonctionnel |
| `casse` | rupture / élément cassé |
| `gel` | dommage lié au gel |
| `surchauffe` | température excessive |
| `fuite-electrique` | défaut d'isolement / disjonction |
| `court-circuit` | contact accidentel |
| `infiltration` | entrée d'eau (toiture/façade) |
| `condensation` | humidité / point de rosée |
| `dysfonctionnement` | comportement anormal non catégorisé |
| `mauvaise-odeur` | remontée d'odeurs |
| `vibration` | vibration mécanique anormale |

## Règles
- Un `probleme:` décrit un **symptôme**, pas une cause (la cause vit dans le diagnostic).
- Une carte de type `installer`/`creer` peut n'avoir **aucun** `probleme:`.
- Extensible ; synonymes → [ALIASES.md](ALIASES.md).

## Décompte
**18 types de problème** (extensible).

## Changelog
- 1.0 (2026-08-02) — Vocabulaire initial (18).
