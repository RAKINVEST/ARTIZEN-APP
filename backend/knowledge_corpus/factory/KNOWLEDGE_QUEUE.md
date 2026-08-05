# Knowledge Queue — File de production

> **Version** 1.0 — **Status** Validated — **Owner** Éditorial / Contenu métier — **Last Update** 2026-08-02
> **Depends On:** [KNOWLEDGE_PIPELINE.md](KNOWLEDGE_PIPELINE.md) — **Used By:** responsables de production

## Objective
Gérer le **backlog** de cartes à produire : quoi produire, dans quel ordre, par qui.

## Éléments de file
Une entrée de file porte : sujet (activité + intervention + problème/équipement), **priorité**,
**assignation**, **état de poste**, source de la demande (couverture, terrain, demande produit).

## Priorisation (critères)
| Critère | Poussée |
|---|---|
| **Couverture** | activités/interventions sans carte → priorité haute |
| **Fréquence terrain** | opérations les plus courantes d'abord |
| **Demande** | signaux (SAV, questions, devis fréquents) |
| **Sécurité/normes** | gestes à risque prioritaires |
| **Obsolescence** | cartes vieillissantes à réviser |

## Règles de file
- **Un doublon ne rentre pas** : vérification taxonomique à l'entrée ([../taxonomy/SEARCH_INDEX.md](../taxonomy/SEARCH_INDEX.md)).
- **Limite d'en-cours (WIP)** par acteur : éviter les Brouillons dormants.
- Une entrée bloquée (manque source/expert) est **explicitement marquée**, jamais silencieuse.
- La file est **pilotée par la couverture** (voir [METRICS.md](METRICS.md)), pas par le volume brut.

## Changelog
- 1.0 (2026-08-02) — File initiale.
