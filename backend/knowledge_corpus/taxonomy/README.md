# Taxonomie métier unifiée — Colonne vertébrale du Corpus

> **Version** 1.0 — **Status** Validated — **Owner** Éditorial / Contenu métier — **Last Update** 2026-08-02
> **Depends On:** [../../TAXONOMIE-METIERS.md](../../TAXONOMIE-METIERS.md), [../README.md](../README.md) — **Used By:** Knowledge/Catalog/Search/Workflow/Quote Engines, IA, filtres, stats

## Objective
Fournir la **taxonomie de classement** de tout le Knowledge Corpus : classer chaque connaissance sans
ambiguïté. **Aucune Knowledge Card ne se crée hors de cette taxonomie.** Aucun code, aucun objet créé.

## Règle de conformité fondatrice (à ne jamais enfreindre)
L'**axe métier** (familles / activités / qualifications) **existe déjà et est gelé** :
[`catalog/trades/taxonomy.py`](../../../backend/app/catalog/trades/taxonomy.py) —
miroir humain [../../TAXONOMIE-METIERS.md](../../TAXONOMIE-METIERS.md). **Ce dossier ne le redéfinit
pas** : il le **reflète et le référence** (source unique — Loi 1, slugs gelés).
- Ce qui est **autoritatif ailleurs** (métier) : [PROFESSIONS.md](PROFESSIONS.md), [FAMILIES.md](FAMILIES.md) = **miroirs**.
- Ce qui est **défini ici** (nouveau, éditorial) : les axes interventions/problèmes/matériaux/outils/
  équipements/pièces/bâtiments/clients/projets + les sous-familles éditoriales.

## Documents
| Document | Rôle | Autorité |
|---|---|---|
| [TAXONOMY.md](TAXONOMY.md) | vue d'ensemble, axes, mapping | — |
| [PROFESSIONS.md](PROFESSIONS.md) | 62 activités par famille | **miroir** (catalog/trades) |
| [FAMILIES.md](FAMILIES.md) | 6 familles | **miroir** |
| [SUB_FAMILIES.md](SUB_FAMILIES.md) | sous-familles éditoriales | éditorial (extensible) |
| [INTERVENTION_TYPES.md](INTERVENTION_TYPES.md) | types d'intervention | éditorial |
| [PROBLEM_TYPES.md](PROBLEM_TYPES.md) | types de problème | éditorial |
| [MATERIAL_TYPES.md](MATERIAL_TYPES.md) | matériaux | éditorial |
| [TOOL_TYPES.md](TOOL_TYPES.md) | outillage | éditorial |
| [EQUIPMENT_TYPES.md](EQUIPMENT_TYPES.md) | équipements | éditorial |
| [ROOM_TYPES.md](ROOM_TYPES.md) | pièces | éditorial |
| [BUILDING_TYPES.md](BUILDING_TYPES.md) | types de bâtiment | éditorial |
| [CUSTOMER_TYPES.md](CUSTOMER_TYPES.md) | types de client | éditorial |
| [PROJECT_TYPES.md](PROJECT_TYPES.md) | types de projet | éditorial |
| [BRAND_RULES.md](BRAND_RULES.md) | règles de l'axe marque | éditorial |
| [TAG_RULES.md](TAG_RULES.md) | règles de classement | gouvernance |
| [SEARCH_INDEX.md](SEARCH_INDEX.md) | axes indexés pour la recherche | gouvernance |
| [ALIASES.md](ALIASES.md) | alias autorisés / synonymes interdits | gouvernance |
| [CHANGELOG.md](CHANGELOG.md) | journal | — |

## Changelog
- 1.0 (2026-08-02) — Taxonomie unifiée (miroir métier + axes éditoriaux).
