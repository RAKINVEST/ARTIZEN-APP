# Object Lifecycle — Cycles de vie

> **Version** 1.0 — **Status** Frozen — **Owner** Architecture — **Last Update** 2026-08-02
> **Depends On:** [OBJECT_CATALOG.md](OBJECT_CATALOG.md) — **Used By:** engines, events — **Niveau:** 2 · Architecture

## Objective
Définir le cycle de vie de chaque objet : création, modification, archivage, suppression, et — pour les objets à états — la machine à états et ses transitions.

## Règles générales de cycle de vie (Loi 4 / 5)
| Phase | Règle |
|---|---|
| **Création** | tout objet naît avec un id, un propriétaire (Company/tenant), un `created` event, une entrée d'historique. |
| **Modification** | autorisée tant que les invariants le permettent ; chaque modification est historisée. |
| **Archivage** | on **archive/désactive** (soft) un objet métier plutôt que de le supprimer. |
| **Suppression** | réservée aux **brouillons transactionnels** ; interdite pour toute donnée métier capitalisée (savoir, facture, historique). |

## Machines à états (objets à cycle commercial/opérationnel)
### Mission
`Prospect → Visite → Diagnostic → Préparation → Devis → Validation → Commande → Planification → Intervention → Contrôle → Facturation → Paiement → Garantie → SAV → Terminée`
- Transitions **avant uniquement** ; une Mission `Terminée` ne revient pas en brouillon (invariant).
- Chaque transition émet un événement (`MissionStateChanged`) + entrée d'historique.

### Quote (Devis)
`Draft → Sent → Accepted | Refused` (+ `Expired`)
- `Draft` seul est supprimable. Un devis **signé/accepté** devient **immuable**.

### Invoice (Facture)
`Draft → Issued → Paid | Overdue → (Cancelled via Avoir)`
- Une facture **validée** ne peut plus être modifiée (invariant légal) ; correction = avoir.

### PurchaseOrder
`Draft → Sent → Confirmed → Received → Closed`

### InterventionInstance (dans Mission)
`Planned → InProgress → Done → Controlled`

### Maintenance
`Scheduled → Due → Done → Rescheduled`

### Warranty
`Active → ExpiringSoon → Expired | Claimed(SAV)`

### Objets sans états (référentiels)
Company, User, Customer, Article, Kit, Phrase, Supplier, Category, Document, Knowledge, Workflow, Template : cycle **Actif → Archivé** (pas de machine à états commerciale).

## Constraints
Aucune transition n'est réversible si un invariant l'interdit (voir [OBJECT_RULES.md](OBJECT_RULES.md)). Toute transition est un événement.

## Acceptance Criteria
Chaque objet a un cycle de vie ; chaque objet à états a sa machine et ses transitions.

## Related Documents
[OBJECT_RULES.md](OBJECT_RULES.md) · [OBJECT_RELATIONSHIPS.md](OBJECT_RELATIONSHIPS.md)

## Next Reading
[OBJECT_RULES.md](OBJECT_RULES.md)

## Changelog
- 1.0 (2026-08-02) — Cycles de vie initiaux.
