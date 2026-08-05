# Domain Validation — Validation du modèle métier

> **Version** 1.0 — **Status** Frozen — **Owner** Architecture — **Last Update** 2026-08-02
> **Depends On:** [../domain/OBJECT_CATALOG.md](../domain/OBJECT_CATALOG.md) — **Used By:** gouvernance — **Niveau:** 2 · Architecture

## Objective
Valider les **39 objets** : responsabilité unique, absence de doublon/orphelin, cycle de vie complet, invariants présents.

## Inventaire (39, mesuré)
AIConversation, Article, Attachment, Audit, Branding, Building, Catalog, Category, Company, Contact,
Customer, Document, Event, History, Intervention, Invoice, Kit, Knowledge, Maintenance, Mission,
Notification, Performance, Photo, Phrase, PurchaseOrder, Quote, Report, Role, Schedule, Site, Stock,
Supplier, Task, Template, User, Vehicle, Warehouse, Warranty, Workflow.

## Contrôles transverses
| Contrôle | Résultat |
|---|---|
| Responsabilité unique | Oui pour 39/39 |
| Doublons | Aucun doublon strict ; familles adjacentes signalées ci-dessous |
| Objets orphelins (non reliés à un flux/moteur) | 0 (voir [TRACEABILITY_REPORT.md](TRACEABILITY_REPORT.md)) |
| Cycle de vie renseigné | Oui ([../domain/OBJECT_LIFECYCLE.md](../domain/OBJECT_LIFECYCLE.md)) |
| Invariants renseignés | Oui ([../domain/OBJECT_RULES.md](../domain/OBJECT_RULES.md)) |

## Points de vigilance (non bloquants)
| Objet(s) | Constat | Décision |
|---|---|---|
| `Catalog` | présent comme **objet** mais désigné **contexte** (Business Library) dans OBJECT_CATALOG | clarifier : fiche = racine d'agrégat du contexte → OD-4 |
| `Event` / `History` / `Audit` | famille « journal » (événement / journal métier / trace sécurité) | frontières à graver → OD-3 |
| `Document` / `Attachment` / `Photo` / `Invoice` / `PurchaseOrder` / `Quote` / `Report` | famille « document » | confirmer `Document` comme super-type documentaire → OD-7 |
| `Customer` / `Contact` / `Company` | client / interlocuteur / entité | **frontières confirmées** — pas d'ambiguïté résiduelle |
| `AIConversation` | nommage vs moteur `Conversation` | terme canonique fixé (GLOSSARY_VALIDATION) |

## Invariants métier confirmés cohérents
- Brouillon ≠ devis ; un `draft` seul est supprimable ; `sent/accepted/refused` figés (409).
- Ligne de devis = photographie autonome ; total = somme des lignes arrondies (`Decimal`/HALF_UP).
- `company_id` du JWT ; tenant mismatch → 404. Aucune destruction de donnée métier (Loi 5).

## Acceptance Criteria
Les 39 objets sont validés ; aucun orphelin ; les familles adjacentes ont une décision de frontière tracée.

## Related Documents
[../domain/DOMAIN_MODEL.md](../domain/DOMAIN_MODEL.md) · [OPEN_DECISIONS.md](OPEN_DECISIONS.md)

## Next Reading
[FLOW_VALIDATION.md](FLOW_VALIDATION.md)

## Changelog
- 1.0 (2026-08-02) — Validation initiale.
