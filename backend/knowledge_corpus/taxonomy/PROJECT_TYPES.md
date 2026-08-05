# Project Types — Types de projet

> **Version** 1.0 — **Status** Validated (éditorial) — **Owner** Éditorial / Contenu métier — **Last Update** 2026-08-02
> **Depends On:** [TAXONOMY.md](TAXONOMY.md) — **Used By:** cards, recherche, stats

## Objective
Classer le **type de projet** dans lequel s'inscrit une carte. Axe `projet:`. Éditorial, contrôlé, extensible.

## Vocabulaire officiel (`projet:`)
| Slug | Sens |
|---|---|
| `neuf` | construction neuve |
| `renovation` | rénovation / réhabilitation |
| `extension` | agrandissement |
| `entretien` | maintenance récurrente |
| `depannage` | intervention curative ponctuelle |
| `mise-aux-normes` | mise en conformité |
| `renovation-energetique` | performance énergétique (aides) |
| `amenagement` | aménagement / agencement |

## Règles
- `projet:` qualifie l'**échelle/nature** de l'opération, pas le **geste** ([INTERVENTION_TYPES.md](INTERVENTION_TYPES.md)).
- `renovation-energetique` relie souvent une **certification d'entreprise** (RGE…) — mention, pas classement métier.
- Extensible ; synonymes → [ALIASES.md](ALIASES.md).

## Décompte
**8 types de projet** (extensible).

## Changelog
- 1.0 (2026-08-02) — Classification initiale.
