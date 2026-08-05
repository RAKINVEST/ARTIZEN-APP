# Engine Boundaries — Frontières & matrice des responsabilités

> **Version** 1.0 — **Status** Frozen — **Owner** Architecture — **Last Update** 2026-08-02
> **Depends On:** [ENGINE_MAP.md](ENGINE_MAP.md) — **Used By:** engines/ — **Niveau:** 2 · Architecture

## Objective
Rendre explicites, pour chaque moteur : ce qui **lui appartient**, ce qui **ne lui appartient pas**, ce qu'il **peut appeler**, ce qu'il **ne doit jamais appeler**.

## Principe de frontière
Un moteur possède ses agrégats (Step 2) et **eux seuls**. Tout le reste est **référencé** (id) ou **écouté** (événement). Franchir une frontière autrement = accès sauvage (interdit).

## Matrice des responsabilités
| Engine | Possède | Utilise | Publie | Consomme | Expose (contrat/API) | **Interdit** |
|---|---|---|---|---|---|---|
| Mission | Mission, Task | Intervention, Customer, Site | Mission* | SuggestionAccepted | `mission.*` | écrire Knowledge/Performance |
| Intervention | Intervention | Catalog, Kit, Phrase | Intervention* | — | `intervention.expand` | connaître Mission |
| Catalog | Article, Category | Company, Supplier | Article* | — | `catalog.*` | connaître Mission/Quote |
| Quote | Quote | Intervention, Customer, PDF, Branding | Quote* | — | `quote.*` | écrire Catalog |
| Billing | Invoice, PurchaseOrder | Quote, Supplier, PDF | Invoice*, PO* | QuoteAccepted | `billing.*` | modifier un Quote |
| Customer | Customer, Contact | Company | Customer* | — | `customer.*` | posséder Mission |
| Knowledge | Knowledge | Media | Knowledge* | MissionClosed | `knowledge.search/capture` | écrire Mission |
| Performance | Performance (RM) | — | — | événements | `performance.metrics` | écrire tout agrégat |
| Companion | Notification (RM) | — | Notification* | tous les * | `companion.dailyBriefing` | écrire le cœur |
| Decision | RuleSet (RM) | — | — | événements | `decision.suggest` | écrire le cœur, décider |
| PDF | — | Storage, Branding | — | — | `pdf.render` | connaître un objet métier |
| Storage | — | — | — | — | `storage.*` | logique métier |
| Audit/History | Audit/History | — | — | tous | `journal.append` | modifier/supprimer une entrée |

## Ce qu'un moteur ne doit jamais faire
- Lire/écrire la persistance d'un autre moteur.
- Appeler un moteur d'une couche supérieure.
- Prendre une décision métier à la place de l'artisan (Loi 7/18).
- Détruire une donnée métier (archivage uniquement — Loi 5).

## Acceptance Criteria
Chaque moteur a une ligne complète (possède/utilise/publie/consomme/expose/interdit).

## Related Documents
[ENGINE_GUIDELINES.md](ENGINE_GUIDELINES.md) · [ENGINE_ANTI_PATTERNS.md](ENGINE_ANTI_PATTERNS.md)

## Next Reading
[ENGINE_LIFECYCLE.md](ENGINE_LIFECYCLE.md)

## Changelog
- 1.0 (2026-08-02) — Frontières et matrice initiales.
