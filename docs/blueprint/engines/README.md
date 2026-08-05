# Engines

> **Version** 2.0 — **Status** Frozen — **Owner** Architecture — **Last Update** 2026-08-02
> **Depends On:** [../domain/README.md](../domain/README.md) — **Used By:** contracts, events, implementation — **Niveau:** 2 · Architecture

## Objective
Spécifier **tous** les moteurs d'Artizen : responsabilité unique, frontières, dépendances, interfaces, événements, règles de collaboration. Référence officielle de l'architecture backend (Step 3). Aucun code ici.

## Contains
| Document | Rôle |
|---|---|
| [ENGINE_MAP.md](ENGINE_MAP.md) | paysage + classification des 40 moteurs + landscape/ownership (Mermaid) |
| [ENGINE_DEPENDENCIES.md](ENGINE_DEPENDENCIES.md) | matrice de dépendances + niveaux + graphe (Mermaid) |
| [ENGINE_INTERACTIONS.md](ENGINE_INTERACTIONS.md) | règles de communication + graphe d'interaction (Mermaid) |
| [ENGINE_EVENTS.md](ENGINE_EVENTS.md) | flux d'événements + event graph (Mermaid) |
| [ENGINE_BOUNDARIES.md](ENGINE_BOUNDARIES.md) | frontières + matrice des responsabilités |
| [ENGINE_LIFECYCLE.md](ENGINE_LIFECYCLE.md) | cycle de vie d'un moteur + règles d'évolution |
| [ENGINE_GUIDELINES.md](ENGINE_GUIDELINES.md) | qualité (cohésion forte, couplage faible, observabilité) |
| [ENGINE_ANTI_PATTERNS.md](ENGINE_ANTI_PATTERNS.md) | anti-patterns + recouvrements à consolider |
| [engines/](engines/) | une fiche indépendante par moteur |

## Navigation
**Pourquoi :** « ils dialoguent, ne se mélangent jamais » (Loi 16). **Public :** architectes, dev backend. **Avant :** [../domain/README.md](../domain/README.md). **Après :** [../events/README.md](../events/README.md). **Dépendants :** contracts, implementation.

## Rules
Un moteur = une responsabilité (une seule question). Un moteur ne naît qu'avec un consommateur réel (Loi 17). Aucun accès sauvage aux données d'un autre moteur : événements ou contrats uniquement.

## Forbidden
Engine God · moteur fourre-tout · dépendance circulaire · accès direct aux données d'un autre moteur · responsabilités multiples · services cachés.

## Acceptance Criteria
Tous les moteurs documentés · responsabilités uniques · dépendances connues · événements définis · frontières explicites · diagrammes présents · anti-patterns définis.

## Related Documents
[../architecture/README.md](../architecture/README.md) · [../contracts/README.md](../contracts/README.md)

## Next Reading
[ENGINE_MAP.md](ENGINE_MAP.md)

## Changelog
- 2.0 (2026-08-02) — Engine Specifications figées (Step 3) : 8 documents + fiches moteurs.
- 1.0 (2026-08-02) — Section créée (Step 1).
