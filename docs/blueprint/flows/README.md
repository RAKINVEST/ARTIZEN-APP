# Flows — Business Flows

> **Version** 1.0 — **Status** Frozen — **Owner** Architecture — **Last Update** 2026-08-02
> **Depends On:** [../domain/README.md](../domain/README.md), [../engines/README.md](../engines/README.md) — **Used By:** implementation, ui — **Niveau:** 2 · Architecture

## Objective
Cartographier **tous** les processus métier : comment objets (Step 2), moteurs (Step 3) et événements collaborent, du premier clic à l'archivage. Chaque flux répond à « **Comment Artizen réalise cette opération ?** ». Aucun code ici.

## Contains
| Document | Rôle |
|---|---|
| [FLOW_CATALOG.md](FLOW_CATALOG.md) | les 40 flux classés (acteur, objets, moteurs) |
| [FLOW_INDEX.md](FLOW_INDEX.md) | ordre de lecture + accès rapide |
| [FLOW_PRINCIPLES.md](FLOW_PRINCIPLES.md) | règles communes à tout flux |
| [FLOW_STATES.md](FLOW_STATES.md) | machines à états canoniques (Mermaid) |
| [FLOW_EVENTS.md](FLOW_EVENTS.md) | flux → événements par transition |
| [FLOW_ERRORS.md](FLOW_ERRORS.md) | gestion d'erreurs, rollback, reprise |
| [FLOW_PERMISSIONS.md](FLOW_PERMISSIONS.md) | qui lance / interrompt / reprend / annule / valide |
| [FLOW_PATTERNS.md](FLOW_PATTERNS.md) | patrons de flux |
| [FLOW_ANTI_PATTERNS.md](FLOW_ANTI_PATTERNS.md) | erreurs de flux interdites |
| [flows/](flows/) | un document par Business Flow |

## Navigation
**Pourquoi :** aucun flux ne dépend d'une interprétation. **Public :** produit, dev, QA. **Avant :** [../engines/README.md](../engines/README.md). **Après :** [../implementation/README.md](../implementation/README.md). **Dépendants :** implementation, ui.

## Rules
Un flux a un **début** et une **fin**, est **traçable**, **publie ses événements**, **historise** ses actions, respecte le Domain Model et les Engine Specifications.

## Forbidden
Sauts d'étapes · validation implicite · action irréversible sans confirmation · double création · événement silencieux · état impossible · transition cachée.

## Acceptance Criteria
Tous les flux documentés · branches, transitions, événements, permissions, états et diagrammes présents.

## Related Documents
[../domain/OBJECT_LIFECYCLE.md](../domain/OBJECT_LIFECYCLE.md) · [../engines/ENGINE_EVENTS.md](../engines/ENGINE_EVENTS.md)

## Next Reading
[FLOW_CATALOG.md](FLOW_CATALOG.md)

## Changelog
- 1.0 (2026-08-02) — Section Flows créée (Step 4).
