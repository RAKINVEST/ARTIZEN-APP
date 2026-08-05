# Object Relationships — Relations entre objets

> **Version** 1.0 — **Status** Frozen — **Owner** Architecture — **Last Update** 2026-08-02
> **Depends On:** [OBJECT_CATALOG.md](OBJECT_CATALOG.md) — **Used By:** engines, events — **Niveau:** 2 · Architecture

## Objective
Documenter toutes les relations : cardinalité, nature (composition / agrégation / référence), et **qui possède, crée, modifie, détruit** quoi.

## Conventions
- **Composition** : le tout possède la partie ; la partie ne vit pas sans le tout (suppression en cascade métier).
- **Agrégation** : lien fort mais la partie a sa propre vie.
- **Référence** : lien par id, aucune possession (Loi 1 : jamais de duplication).

## Relations principales
| De | Vers | Cardinalité | Nature | Possède | Crée | Modifie | Détruit |
|---|---|---|---|---|---|---|---|
| Company | User | 1–N | Composition | Company | Company | Company | Company (désactive) |
| User | Role | N–1 | Référence | — | Company | Company | — |
| Company | Branding | 1–1 | Composition | Company | Company | Company | — |
| Company | Template | 1–N | Composition | Company | Company/Import | Company | archive |
| Customer | Site | 1–N | Composition | Customer | Customer | Customer | archive |
| Site | Building | 1–N | Composition | Site | Customer | Customer | archive |
| Customer / Supplier | Contact | 1–N | Composition | parent | parent | parent | archive |
| Category | Article | 1–N | Agrégation | — | Company | Company | soft-delete |
| Article | Supplier | N–1 | Référence | — | — | — | — |
| Kit | Article/Phrase | N–M | Référence | — | Company | Company | — |
| Intervention | Article/Kit/Phrase | N–M | Référence | — | Company | Company | — |
| **Mission** | InterventionInstance | 1–N | Composition | Mission | Mission | Mission | avec la Mission |
| Mission | Customer / Site | N–1 | Référence | — | — | — | — |
| Mission | Task / Schedule | 1–N | Composition | Mission | Mission | Mission | avec la Mission |
| Mission | Quote / Invoice / PurchaseOrder | 1–N | **Référence** | — | Mission | doc lui-même | doc lui-même |
| Mission | Document / Photo | 1–N | Agrégation (via Attachment) | Document&Media | user | — | archive |
| Quote | Customer, Interventions | N–1 | Référence | — | Mission/Quote | Quote | brouillon seul |
| Invoice | Quote | 0/1–1 | Référence | — | Commercial | figée après validation | jamais |
| PurchaseOrder | Supplier, Article | N–1/N–M | Référence | — | Commercial | brouillon seul | — |
| Knowledge | Mission / Intervention / Photo | N–M | Référence | — | user (opt-in) | user | archive |
| Warranty / Maintenance | Mission / Article installé | N–1 | Référence | — | Field Ops | — | — |
| Document | Photo / Attachment | 1–N | Composition | Document | user | — | archive |
| Notification | User | N–1 | Référence | — | Companion | lu/masqué | expire |
| Performance / Report | Event/History | dérivé | Read-model | — | moteur | — | — |
| Tout objet | History | 1–N | Composition (journal) | l'objet | système | **append-only** | jamais (Loi 5) |

## Règle d'unicité (rappel)
Une Mission **possède** interventions, tâches, planning, historique. Il n'existe **jamais** un second objet « Mission ». Les documents commerciaux sont **référencés** (pas contenus) pour éviter l'agrégat-dieu.

## Constraints
Aucune dépendance circulaire entre agrégats. Une partie n'appartient qu'à un seul tout (Loi 1).

## Acceptance Criteria
Chaque relation a une cardinalité, une nature et un responsable de création/modification/destruction.

## Related Documents
[OBJECT_LIFECYCLE.md](OBJECT_LIFECYCLE.md) · [OBJECT_RULES.md](OBJECT_RULES.md)

## Next Reading
[OBJECT_LIFECYCLE.md](OBJECT_LIFECYCLE.md)

## Changelog
- 1.0 (2026-08-02) — Relations initiales.
