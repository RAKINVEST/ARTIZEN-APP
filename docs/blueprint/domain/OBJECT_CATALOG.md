# Object Catalog — Catalogue des objets métier

> **Version** 1.0 — **Status** Frozen — **Owner** Architecture — **Last Update** 2026-08-02
> **Depends On:** [DOMAIN_MODEL.md](DOMAIN_MODEL.md) — **Used By:** objects/, engines, events — **Niveau:** 2 · Architecture

## Objective
Documenter **tous** les objets métier en une table unique : type DDD, moteur propriétaire, responsabilité (une seule), et pointeur vers la fiche détaillée. C'est la colonne vertébrale de complétude du Domain Model.

## Légende
Type : **AR** Agrégat racine · **E** Entité · **VO** Value Object · **EV** Événement/Journal · **RM** Read-model.

## Catalogue (39 objets)
| Objet | Type | Moteur propriétaire | Responsabilité unique | Fiche |
|---|---|---|---|---|
| **Company** | AR | Company Identity | L'entreprise utilisatrice ; racine de tenant | [objects/Company.md](objects/Company.md) |
| **User** | E | Company Identity | Un utilisateur rattaché à une Company | [objects/User.md](objects/User.md) |
| **Role** | VO | Company Identity | Droits d'un User (jeu de permissions) | [objects/Role.md](objects/Role.md) |
| **Branding** | E | Company Identity | Identité visuelle de la Company (logo, couleurs) | [objects/Branding.md](objects/Branding.md) |
| **Template** | E | Company Identity | Modèle de document (devis/facture) de la Company | [objects/Template.md](objects/Template.md) |
| **Customer** | AR | Client & Carnet | Le client de l'entreprise ; carnet de santé | [objects/Customer.md](objects/Customer.md) |
| **Site** | E | Client & Carnet | Un lieu d'intervention d'un Customer | [objects/Site.md](objects/Site.md) |
| **Building** | E | Client & Carnet | Un bâtiment/local d'un Site | [objects/Building.md](objects/Building.md) |
| **Contact** | E | Client & Carnet | Une personne à contacter (Customer/Supplier) | [objects/Contact.md](objects/Contact.md) |
| **Supplier** | AR | Business Library | Un fournisseur référencé | [objects/Supplier.md](objects/Supplier.md) |
| **Article** | AR | Business Library | Un produit/prestation réutilisable | [objects/Article.md](objects/Article.md) |
| **Category** | E | Business Library | Regroupement d'Articles | [objects/Category.md](objects/Category.md) |
| **Kit** | AR | Business Library | Préparation : composition d'éléments réutilisable | [objects/Kit.md](objects/Kit.md) |
| **Phrase** | E | Business Library | Texte réutilisable (garantie, condition, mention…) | [objects/Phrase.md](objects/Phrase.md) |
| **Catalog** | — | Business Library | *(Contexte, pas un objet — voir anti-pattern)* | [objects/Catalog.md](objects/Catalog.md) |
| **Intervention** | AR | Intervention | Modèle réutilisable d'un travail (unité de pensée) | [objects/Intervention.md](objects/Intervention.md) |
| **Mission** | AR | Mission | Unité de travail : tout ce qui gravite autour d'un chantier | [objects/Mission.md](objects/Mission.md) |
| **Task** | E | Mission | Une tâche planifiable dans une Mission | [objects/Task.md](objects/Task.md) |
| **Schedule** | AR | Mission | Planification (créneaux, intervenants) | [objects/Schedule.md](objects/Schedule.md) |
| **Quote** | AR | Commercial Documents | Devis : projection commerciale d'interventions | [objects/Quote.md](objects/Quote.md) |
| **Invoice** | AR | Commercial Documents | Facture | [objects/Invoice.md](objects/Invoice.md) |
| **PurchaseOrder** | AR | Commercial Documents | Bon de commande fournisseur | [objects/PurchaseOrder.md](objects/PurchaseOrder.md) |
| **Document** | AR | Document & Media | Pièce jointe générique (PDF, plan, PV…) | [objects/Document.md](objects/Document.md) |
| **Photo** | E | Document & Media | Une photo (spécialisation de Document) | [objects/Photo.md](objects/Photo.md) |
| **Attachment** | E | Document & Media | Rattachement d'un Document à un objet | [objects/Attachment.md](objects/Attachment.md) |
| **Knowledge** | AR | Knowledge | Fiche d'expérience / bonne pratique / variante | [objects/Knowledge.md](objects/Knowledge.md) |
| **Workflow** | AR | Knowledge | Procédure/checklist réutilisable | [objects/Workflow.md](objects/Workflow.md) |
| **Warranty** | AR | Field Ops *(futur)* | Garantie du matériel installé | [objects/Warranty.md](objects/Warranty.md) |
| **Maintenance** | AR | Field Ops *(futur)* | Entretien planifié récurrent | [objects/Maintenance.md](objects/Maintenance.md) |
| **Stock** | AR | Field Ops *(futur)* | Niveau de stock d'un Article | [objects/Stock.md](objects/Stock.md) |
| **Warehouse** | AR | Field Ops *(futur)* | Lieu de stockage | [objects/Warehouse.md](objects/Warehouse.md) |
| **Vehicle** | AR | Field Ops *(futur)* | Véhicule de l'entreprise | [objects/Vehicle.md](objects/Vehicle.md) |
| **Notification** | AR | Companion | Un message d'attention adressé à un User | [objects/Notification.md](objects/Notification.md) |
| **Performance** | RM | Performance | Indicateurs dérivés (5 temps, écarts, rentabilité) | [objects/Performance.md](objects/Performance.md) |
| **Report** | RM | Performance | Vue/export d'indicateurs | [objects/Report.md](objects/Report.md) |
| **AIConversation** | AR | Assistant IA | Un échange IA (contexte, tours) | [objects/AIConversation.md](objects/AIConversation.md) |
| **Audit** | EV | Journal | Trace de sécurité/accès (append-only) | [objects/Audit.md](objects/Audit.md) |
| **Event** | EV | Journal | Fait de domaine immuable | [objects/Event.md](objects/Event.md) |
| **History** | EV | Journal | Journal métier d'un objet (append-only) | [objects/History.md](objects/History.md) |

## Doublons & clarifications (voir [DOMAIN_ANTI_PATTERNS.md](DOMAIN_ANTI_PATTERNS.md))
- **Catalog** n'est pas un objet : c'est le contexte *Business Library*. Ne pas créer d'agrégat « Catalog » (fourre-tout).
- **Event / History / Audit** = la même famille « journal » à trois usages (bus de domaine / journal métier / trace sécurité). Modèles distincts, jamais fusionnés ni dupliqués.
- **Photo / Attachment** sont des facettes de **Document** ; Document reste l'agrégat propriétaire des octets.
- **Branding** appartient à **Company** (pas un tenant séparé).
- **Performance / Report** sont des read-models (Loi 7) : ils **n'écrivent jamais** dans le cœur.

## Constraints
Une responsabilité = un seul objet (Loi 1). Un objet marqué *futur* est décrit mais non implémenté tant qu'aucun consommateur réel n'existe (Loi 17).

## Acceptance Criteria
Les 39 objets présents, typés, avec propriétaire unique et fiche.

## Related Documents
[OBJECT_RELATIONSHIPS.md](OBJECT_RELATIONSHIPS.md) · [OBJECT_LIFECYCLE.md](OBJECT_LIFECYCLE.md) · [OBJECT_RULES.md](OBJECT_RULES.md)

## Next Reading
[OBJECT_RELATIONSHIPS.md](OBJECT_RELATIONSHIPS.md)

## Changelog
- 1.0 (2026-08-02) — Catalogue initial des 39 objets (38 objets + « Catalog » = contexte).
