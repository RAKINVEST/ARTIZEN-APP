# Flow Catalog — Catalogue des Business Flows

> **Version** 1.0 — **Status** Frozen — **Owner** Architecture — **Last Update** 2026-08-02
> **Depends On:** [README.md](README.md) — **Used By:** flows/, implementation — **Niveau:** 2 · Architecture

## Objective
Documenter **tous** les flux en une table unique : catégorie, acteur principal, objets et moteurs concernés, fiche détaillée. Colonne vertébrale de complétude (Step 4).

## Catalogue (40 flux)
| # | Flux | Catégorie | Acteur | Objets | Moteurs | Fiche |
|---|---|---|---|---|---|---|
| 1 | Créer une entreprise | Onboarding | Fondateur | Company | Company, Auth | [flows/creer-une-entreprise.md](flows/creer-une-entreprise.md) |
| 2 | Créer un utilisateur | Onboarding | Admin | User | User | [flows/creer-un-utilisateur.md](flows/creer-un-utilisateur.md) |
| 3 | Inviter un collaborateur | Onboarding | Admin | User | User, Notification | [flows/inviter-un-collaborateur.md](flows/inviter-un-collaborateur.md) |
| 4 | Créer un client | Client | Artisan | Customer | Customer | [flows/creer-un-client.md](flows/creer-un-client.md) |
| 5 | Créer un chantier | Client | Artisan | Site, Building | Site | [flows/creer-un-chantier.md](flows/creer-un-chantier.md) |
| 6 | Créer une mission | Mission | Artisan | Mission | Mission | [flows/creer-une-mission.md](flows/creer-une-mission.md) |
| 7 | Créer une intervention | Mission | Artisan | Intervention | Intervention | [flows/creer-une-intervention.md](flows/creer-une-intervention.md) |
| 8 | Planifier une intervention | Mission | Artisan | Schedule | Planning | [flows/planifier-une-intervention.md](flows/planifier-une-intervention.md) |
| 9 | Reporter une intervention | Mission | Artisan | Schedule | Planning | [flows/reporter-une-intervention.md](flows/reporter-une-intervention.md) |
| 10 | Clôturer une intervention | Mission | Artisan | Mission, Intervention | Mission, Performance | [flows/cloturer-une-intervention.md](flows/cloturer-une-intervention.md) |
| 11 | Créer un devis | Devis | Artisan | Quote | Quote | [flows/creer-un-devis.md](flows/creer-un-devis.md) |
| 12 | Dupliquer un devis | Devis | Artisan | Quote | Quote | [flows/dupliquer-un-devis.md](flows/dupliquer-un-devis.md) |
| 13 | Importer un devis PDF | Devis | Artisan | Document | Document Analysis | [flows/importer-un-devis-pdf.md](flows/importer-un-devis-pdf.md) |
| 14 | Extraire un devis | Devis | Système | ExtractedQuote | Quote Extraction, AI | [flows/extraire-un-devis.md](flows/extraire-un-devis.md) |
| 15 | Modifier un devis | Devis | Artisan | Quote | Quote | [flows/modifier-un-devis.md](flows/modifier-un-devis.md) |
| 16 | Envoyer un devis | Devis | Artisan | Quote | Quote, PDF | [flows/envoyer-un-devis.md](flows/envoyer-un-devis.md) |
| 17 | Signer un devis | Devis | Client | Quote | Quote | [flows/signer-un-devis.md](flows/signer-un-devis.md) |
| 18 | Transformer un devis en mission | Devis | Artisan | Quote, Mission | Mission | [flows/transformer-un-devis-en-mission.md](flows/transformer-un-devis-en-mission.md) |
| 19 | Créer une facture | Facturation | Artisan | Invoice | Billing | [flows/creer-une-facture.md](flows/creer-une-facture.md) |
| 20 | Encaisser un paiement | Facturation | Artisan | Invoice | Billing | [flows/encaisser-un-paiement.md](flows/encaisser-un-paiement.md) |
| 21 | Créer un avoir | Facturation | Artisan | Invoice | Billing | [flows/creer-un-avoir.md](flows/creer-un-avoir.md) |
| 22 | Créer un bon de commande | Achats | Artisan | PurchaseOrder | Billing, Supplier | [flows/creer-un-bon-de-commande.md](flows/creer-un-bon-de-commande.md) |
| 23 | Commander du matériel | Achats | Artisan | PurchaseOrder | Billing | [flows/commander-du-materiel.md](flows/commander-du-materiel.md) |
| 24 | Réceptionner du matériel | Achats | Artisan | PurchaseOrder, Stock | Stock | [flows/receptionner-du-materiel.md](flows/receptionner-du-materiel.md) |
| 25 | Créer un kit | Bibliothèque | Artisan | Kit | Kit | [flows/creer-un-kit.md](flows/creer-un-kit.md) |
| 26 | Utiliser un kit | Bibliothèque | Artisan | Kit, Intervention | Intervention | [flows/utiliser-un-kit.md](flows/utiliser-un-kit.md) |
| 27 | Créer une phrase | Bibliothèque | Artisan | Phrase | Phrase Library | [flows/creer-une-phrase.md](flows/creer-une-phrase.md) |
| 28 | Réutiliser une phrase | Bibliothèque | Artisan | Phrase | Phrase Library | [flows/reutiliser-une-phrase.md](flows/reutiliser-une-phrase.md) |
| 29 | Ajouter une photo | Média | Artisan | Photo | Media | [flows/ajouter-une-photo.md](flows/ajouter-une-photo.md) |
| 30 | Créer un document | Média | Artisan | Document | Media | [flows/creer-un-document.md](flows/creer-un-document.md) |
| 31 | Partager un document | Média | Artisan | Document, Resource | Import/Export | [flows/partager-un-document.md](flows/partager-un-document.md) |
| 32 | Créer une garantie | Suivi | Artisan | Warranty | Warranty | [flows/creer-une-garantie.md](flows/creer-une-garantie.md) |
| 33 | Créer une maintenance | Suivi | Artisan | Maintenance | Maintenance | [flows/creer-une-maintenance.md](flows/creer-une-maintenance.md) |
| 34 | Créer un rapport | Suivi | Artisan | Report | Reporting | [flows/creer-un-rapport.md](flows/creer-un-rapport.md) |
| 35 | Créer une notification | Suivi | Système | Notification | Notification | [flows/creer-une-notification.md](flows/creer-une-notification.md) |
| 36 | Créer un workflow | Suivi | Artisan | Workflow | Workflow | [flows/creer-un-workflow.md](flows/creer-un-workflow.md) |
| 37 | Créer un audit | Suivi | Système | Audit | Audit | [flows/creer-un-audit.md](flows/creer-un-audit.md) |
| 38 | Archiver | Cycle de vie | Artisan | tout objet | moteur propriétaire | [flows/archiver.md](flows/archiver.md) |
| 39 | Restaurer | Cycle de vie | Artisan | tout objet | moteur propriétaire | [flows/restaurer.md](flows/restaurer.md) |
| 40 | Supprimer | Cycle de vie | Artisan | brouillon | moteur propriétaire | [flows/supprimer.md](flows/supprimer.md) |

## Constraints
Chaque flux respecte le Domain Model et les Engine Specifications. Un flux de cycle de vie (38–40) applique la Loi 5 : archiver/restaurer toujours ; supprimer **uniquement** un brouillon.

## Acceptance Criteria
Les 40 flux présents, classés, avec acteur, objets, moteurs et fiche.

## Related Documents
[FLOW_STATES.md](FLOW_STATES.md) · [FLOW_EVENTS.md](FLOW_EVENTS.md) · [FLOW_PERMISSIONS.md](FLOW_PERMISSIONS.md)

## Next Reading
[FLOW_PRINCIPLES.md](FLOW_PRINCIPLES.md)

## Changelog
- 1.0 (2026-08-02) — Catalogue initial des 40 flux.
