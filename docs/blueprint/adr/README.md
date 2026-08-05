# ADR — Architecture Decision Records

> **Version** 1.0 — **Status** Frozen — **Owner** Architecture — **Last Update** 2026-08-02
> **Depends On:** [../architecture/](../architecture/README.md) — **Used By:** architecture, domain, engines — **Niveau:** 2 · Architecture

## Objective
Organiser les **décisions d'architecture** : chaque choix structurant est un ADR numéroté, immuable une fois `Frozen`, remplacé (jamais effacé — Loi 5) par un ADR ultérieur.

## Contains
- [ADR-0000-adopter-les-adr.md](ADR-0000-adopter-les-adr.md) — décision d'adopter le système.
- [ADR-0001-standard-de-rapport-execution.md](ADR-0001-standard-de-rapport-execution.md) — standard de rapport d'exécution V2.2 (figé).
- Modèle : [../templates/ADR_TEMPLATE.md](../templates/ADR_TEMPLATE.md).

## Index des ADR
| N° | Titre | Statut |
|---|---|---|
| 0000 | Adopter les ADR | Frozen |
| 0001 | Standard de rapport d'exécution (V3.0) | Accepted |
| 0002+ | *(à créer — voir les 11 ADR proposés dans la revue d'architecture V2)* | — |

## Navigation
**Pourquoi :** tracer le « pourquoi » des choix. **Public :** architectes, dev. **Avant :** [architecture/](../architecture/README.md). **Après :** —. **Dépendants :** domain, engines, contracts.

## Rules
Numérotation croissante, jamais réutilisée. Un ADR `Frozen` ne se modifie pas : on le remplace par un nouvel ADR qui référence l'ancien.

## Acceptance Criteria
Chaque décision structurante a un ADR ; l'index est à jour.

## Changelog
- 1.0 (2026-08-02) — Système ADR initialisé (README + ADR-0000).
