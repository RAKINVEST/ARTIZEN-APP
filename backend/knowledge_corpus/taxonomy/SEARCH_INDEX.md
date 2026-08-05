# Search Index — Axes indexés

> **Version** 1.0 — **Status** Validated — **Owner** Éditorial / Contenu métier — **Last Update** 2026-08-02
> **Depends On:** [TAG_RULES.md](TAG_RULES.md), [../SEARCH_STRATEGY.md](../SEARCH_STRATEGY.md) — **Used By:** recherche, IA, filtres

## Objective
Déclarer **quels axes** alimentent la recherche et les filtres, pour une recherche compatible IA à
grande échelle. La **mécanique** (moteur, embeddings) relève de l'implémentation — ici, la **structure**.

## Axes indexables
| Axe | Filtre | Facette multi ? | Poids recherche (indicatif) |
|---|---|---|---|
| `famille:` | ✅ | non | élevé |
| `activite:` (`metier:`) | ✅ | non (principal) | élevé |
| `sous-famille:` | ✅ | oui | moyen |
| `intervention:` | ✅ | oui | élevé |
| `probleme:` | ✅ | oui | élevé |
| `equipement:` | ✅ | oui | élevé |
| `materiau:` | ✅ | oui | moyen |
| `piece:` | ✅ | oui | moyen |
| `batiment:` | ✅ | oui | faible |
| `client:` | ✅ | oui | faible |
| `projet:` | ✅ | oui | faible |
| `marque:` | ✅ | oui | faible |
| plein-texte (titre/objectif/résumé) | — | — | élevé |

## Principes
- La recherche est une **projection** : elle n'altère jamais une carte (source unique).
- Les **alias** ([ALIASES.md](ALIASES.md)) sont résolus **à l'indexation** (une requête `metier:` trouve `activite:`).
- Aucune donnée dupliquée : l'index dérive des champs/tags de la carte.

## Changelog
- 1.0 (2026-08-02) — Index initial.
