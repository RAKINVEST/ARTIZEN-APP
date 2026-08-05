# Building Types — Types de bâtiment

> **Version** 1.0 — **Status** Validated (éditorial) — **Owner** Éditorial / Contenu métier — **Last Update** 2026-08-02
> **Depends On:** [TAXONOMY.md](TAXONOMY.md) — **Used By:** cards, recherche

## Objective
Classer le **type de bâtiment** d'un contexte. Axe `batiment:`. Éditorial (à ne pas confondre avec
l'objet du domaine `Building`, qui est un local d'un `Site`). Contrôlé, extensible.

## Vocabulaire officiel (`batiment:`)
| Slug | Sens |
|---|---|
| `maison-individuelle` | pavillon / maison |
| `appartement` | logement en copropriété |
| `immeuble-collectif` | immeuble d'habitation |
| `local-commercial` | commerce / boutique |
| `bureau-tertiaire` | bureaux / tertiaire |
| `industriel` | site industriel / atelier |
| `erp` | établissement recevant du public |
| `agricole` | bâtiment agricole |
| `neuf` | construction neuve (contexte) |
| `ancien` | bâti ancien / patrimonial |

## Règles
- `batiment:` décrit le **contexte**, pas la localisation fine ([ROOM_TYPES.md](ROOM_TYPES.md)) ni le projet ([PROJECT_TYPES.md](PROJECT_TYPES.md)).
- Ne remplace pas l'objet `Building` du domaine (référence structurée, non éditoriale).
- Extensible ; synonymes → [ALIASES.md](ALIASES.md).

## Décompte
**10 types de bâtiment** (extensible).

## Changelog
- 1.0 (2026-08-02) — Classification initiale.
