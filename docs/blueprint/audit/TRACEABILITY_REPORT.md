# Traceability Report — Matrice de traçabilité

> **Version** 1.0 — **Status** Frozen — **Owner** Architecture — **Last Update** 2026-08-02
> **Depends On:** tout le Blueprint — **Used By:** gouvernance, planification — **Niveau:** 2 · Architecture

## Objective
Prouver que **chaque fonctionnalité** se relie de bout en bout :
**Vision → Livre Produit → Objet métier → Moteur → Flux → Contrat → Tests futurs.**
Aucune fonctionnalité ne doit être impossible à tracer.

## Chaîne de traçabilité (fonctionnalités structurantes)
| Fonctionnalité | Vision | Objet(s) | Moteur(s) | Flux | Contrat | Tests futurs |
|---|---|---|---|---|---|---|
| **Créer un devis** | restituer l'identité dans chaque devis | Quote, Article, Customer, Company | Quote, Catalog | flows/*quote-create* | API_CONTRACTS (POST /quotes), COMMAND, DTO, ERROR | calcul `Decimal`/HALF_UP, numérotation `FOR UPDATE`, invariants d'état |
| **Importer un devis existant** | ARTIZEN retrouve votre identité | Document, Quote, Article | Quote-Extraction, Document-Analysis, OCR | flows/*import* | API (upload), VALIDATION (413/415), EVENT | garde de corps, mapping, refus explicite |
| **Restituer l'identité (branding)** | s'adapter à l'artisan | Branding, Company, Template | Branding, Template | flows/*branding* | API, DTO, SECURITY | logo/couleurs/coordonnées appliqués sur confirmation |
| **Générer un PDF de devis** | un devis qui lui ressemble | Quote, Document, Branding | PDF | flows/*pdf* | API (download: attachment+nosniff), ERROR | rendu hors event-loop, tenant-scopé |
| **Cycle de vie du devis** | brouillon ≠ devis | Quote | Quote | flows/*status* | COMMAND (PUT /status), ERROR (409) | transitions `QUOTE_TRANSITIONS`, verrou de ligne |
| **Suggestion d'articles (IA)** | l'IA n'invente rien sauf la quantité | Article, AIConversation | AI, Conversation, Catalog | flows/*assistant* | API, VALIDATION | re-validation catalogue (`match_validator`), aucun montant inventé |
| **Authentification / compte** | en ligne requis V1 | User, Company, Role | Authentication, Authorization | flows/*auth* | API (401/403), SECURITY (rate-limit) | JWT, tenant → 404, rate-limit `/auth/*` |
| **Suivi d'intervention** | savoir-faire de l'artisan | Intervention, Mission, Site, Photo | Intervention, Planning, Media | flows/*intervention* | API, EVENT, DTO | composition, journalisation |

## Couverture de traçabilité
- **Objets** reliés à au moins un flux/contrat : 39/39 (les objets « famille journal » et « contexte » inclus, voir DOMAIN_VALIDATION).
- **Moteurs** reliés à au moins un flux : 40/40.
- **Flux** reliés à au moins un contrat : 40/40 (chaque fiche flux porte un diagramme de séquence).
- **Fonctionnalités non traçables : 0.**

## Réserve honnête
La colonne « Tests futurs » décrit les tests **à écrire** (le Blueprint ne contient aucun code, STEP 7
n'en produit pas). Elle nomme l'intention de test, pas un test existant. Les tests réels de la V1/V2
vivent déjà dans le dépôt (`backend/app/tests/`, `frontend/test/`) et restent la preuve d'exécution.

## Acceptance Criteria
Chaque fonctionnalité structurante est traçable de la Vision aux tests ; aucune rupture de chaîne.

## Related Documents
[DOMAIN_VALIDATION.md](DOMAIN_VALIDATION.md) · [ENGINE_VALIDATION.md](ENGINE_VALIDATION.md) · [../flows/FLOW_INDEX.md](../flows/FLOW_INDEX.md)

## Next Reading
[DOCUMENT_COVERAGE.md](DOCUMENT_COVERAGE.md)

## Changelog
- 1.0 (2026-08-02) — Matrice initiale.
