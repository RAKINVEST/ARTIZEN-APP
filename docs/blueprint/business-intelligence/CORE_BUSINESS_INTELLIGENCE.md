# Core Business Intelligence — Concept & frontières

> **Version** 1.0 — **Status** Validated — **Owner** Business Intelligence — **Last Update** 2026-08-02
> **Depends On:** [README.md](README.md) — **Used By:** Decision, AI Companion — **Niveau:** 1 · Vision

## Objective
Poser ce qu'est le raisonnement métier d'Artizen et ses limites.

## Le principe
Artizen ne remplace pas le jugement de l'artisan : il **restitue** et **outille** son raisonnement.
Le CBI **modélise** ce raisonnement (observer, diagnostiquer, évaluer, décider, contrôler) pour que le
Decision Engine propose comme le ferait **un professionnel expérimenté** — et laisse **l'artisan trancher**.

## Où il agit (et où il n'agit pas)
| Couche | Rôle |
|---|---|
| **Knowledge** | *quoi* : les connaissances validées |
| **Decision** | *quoi proposer* : sélection/assemblage/explication |
| **CBI** | *comment réfléchir* : heuristiques, modèles de décision, risque, incertitude |
| **Orchestration** | *comment exécuter* : coordination après validation |
| **Artisan** | *qui décide* : validation finale (Loi 7/18) |

## Frontières
- **Ne décide pas** ; **ne persiste rien** ; **n'invente rien**.
- N'est **pas** un moteur exécutant : c'est une **référence** que Decision/AI implémentent.
- Ne se substitue **jamais** à une validation métier/humaine, ni à une norme/DTU (il **raisonne avec**, il ne remplace pas).
- Aucun montant calculé (ADR-023) ; aucune donnée client inventée.

## Étoile polaire
Chaque heuristique sert la promesse : aider l'artisan à **retrouver et restituer son identité** et son
savoir-faire — jamais à le contraindre à raisonner comme un logiciel.

## Changelog
- 1.0 (2026-08-02) — Concept initial.
