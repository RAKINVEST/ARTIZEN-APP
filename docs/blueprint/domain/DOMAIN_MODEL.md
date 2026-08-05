# Domain Model — Modèle métier canonique d'Artizen

> **Version** 1.0 — **Status** Frozen — **Owner** Architecture — **Last Update** 2026-08-02
> **Depends On:** [../architecture/README.md](../architecture/README.md), [../constitution/README.md](../constitution/README.md) — **Used By:** engines, events, contracts, implementation — **Niveau:** 2 · Architecture

## Objective
Fournir **la** représentation unique de tous les objets métier d'Artizen. Après ce document, la signification d'un objet ne prête plus à discussion. Aucun objet métier ne peut être créé sans respecter ce modèle (Loi 1 : source unique).

## Responsibilities
- Classer chaque objet (Agrégat / Entité / Value Object / Événement / Read-model).
- Fixer le **moteur propriétaire** unique de chaque objet.
- Renvoyer vers le détail : [OBJECT_CATALOG.md](OBJECT_CATALOG.md), [OBJECT_RELATIONSHIPS.md](OBJECT_RELATIONSHIPS.md), [OBJECT_LIFECYCLE.md](OBJECT_LIFECYCLE.md), [OBJECT_RULES.md](OBJECT_RULES.md), et une fiche par objet dans [objects/](objects/).

## Principes de modélisation (dérivés de la Constitution)
| Principe | Origine | Conséquence |
|---|---|---|
| Un objet = un propriétaire unique | Loi 1 | pas de second « Mission » ; pas de moteur propriétaire secondaire |
| Référence par id, jamais duplication | Loi 1/11 | les relations sont des refs, pas des copies |
| Agrégats frontières nettes | DDD + risque « agrégat-dieu » | Mission référence Devis/Documents, ne les contient pas |
| Append-only pour le savoir | Loi 4/5 | on archive / remplace, jamais on ne détruit une donnée métier |
| Événements = seul canal cœur→moteurs | Loi 7/16 | un objet publie des événements ; les moteurs les écoutent |
| Tout invariant est explicite | Loi 6 | chaque objet déclare ses invariants ([OBJECT_RULES.md](OBJECT_RULES.md)) |

## Les cinq catégories d'objets
1. **Agrégats racines** — cycle de vie propre, identité, propriétaire d'une frontière de cohérence (Company, Mission, Intervention, Customer, Article, Kit, Quote, Invoice…).
2. **Entités** — identité mais vivant **dans** un agrégat (User, Site, Building, Contact, Category, Task, Photo, InterventionInstance…).
3. **Value Objects** — égalité par valeur, immuables (Role, Address, Money, Temps, Confidence, Visibility…).
4. **Événements de domaine** — faits immuables (Event / History / Audit forment la famille « journal »).
5. **Read-models** — vues dérivées d'événements, sans écriture cœur (Performance, Report).

## Carte propriétaire (résumé)
| Contexte (moteur propriétaire) | Objets |
|---|---|
| **Company Identity** | Company · User · Role · Branding · Template |
| **Client & Carnet** | Customer · Site · Building · Contact |
| **Business Library** | Article · Category · Kit · Phrase · Supplier |
| **Intervention** | Intervention (modèle) · *InterventionInstance* (dans Mission) |
| **Mission** | Mission · Task · Schedule |
| **Commercial Documents** | Quote · Invoice · PurchaseOrder |
| **Document & Media** | Document · Photo · Attachment |
| **Knowledge** | Knowledge (fiche d'expérience) · Workflow |
| **Field Ops** *(contexte futur)* | Warranty · Maintenance · Stock · Warehouse · Vehicle |
| **Companion / Performance** *(read-side)* | Performance · Report · Notification |
| **Assistant IA** | AIConversation |
| **Journal (transverse)** | Event · History · Audit |

## Constraints
Ce document décrit **uniquement** le métier : aucun code, DTO, repository ou service (interdits à cette étape).

## Rules
Toute modification d'un objet ne peut se faire que si responsabilité, propriétaire, invariants et compatibilité d'événements sont **préservés** ; sinon un **ADR** est obligatoire ([DOMAIN_ANTI_PATTERNS.md](DOMAIN_ANTI_PATTERNS.md), section Règles de modification).

## Forbidden
Créer un doublon d'objet · un moteur propriétaire secondaire · une dépendance circulaire · fusionner deux responsabilités · ajouter un champ sans justification métier.

## Acceptance Criteria
Les 39 objets sont classés, chacun a un propriétaire unique, et un renvoi vers sa fiche.

## Related Documents
[OBJECT_CATALOG.md](OBJECT_CATALOG.md) · [DOMAIN_GLOSSARY.md](DOMAIN_GLOSSARY.md) · [DOMAIN_PATTERNS.md](DOMAIN_PATTERNS.md) · [DOMAIN_ANTI_PATTERNS.md](DOMAIN_ANTI_PATTERNS.md)

## Next Reading
[OBJECT_CATALOG.md](OBJECT_CATALOG.md)

## Changelog
- 1.0 (2026-08-02) — Modèle canonique initial (39 objets classés).
