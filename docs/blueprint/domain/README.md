# Domain

> **Version** 2.0 — **Status** Frozen — **Owner** Architecture — **Last Update** 2026-08-02
> **Depends On:** [../architecture/README.md](../architecture/README.md) — **Used By:** engines, events, contracts, implementation — **Niveau:** 2 · Architecture

## Objective
Modéliser le domaine (DDD) : objets fondamentaux, **Agrégats**, **Entités**, **Value Objects**, **Domain Services**, **Repositories**. C'est la fondation métier : après lui, la signification d'un objet ne prête plus à discussion (Step 2, Domain Model figé).

## Contains
| Document | Rôle |
|---|---|
| [DOMAIN_MODEL.md](DOMAIN_MODEL.md) | vue d'ensemble, catégories, carte propriétaire |
| [OBJECT_CATALOG.md](OBJECT_CATALOG.md) | les 39 objets classés (type, propriétaire, responsabilité) |
| [OBJECT_RELATIONSHIPS.md](OBJECT_RELATIONSHIPS.md) | relations, cardinalités, possession |
| [OBJECT_LIFECYCLE.md](OBJECT_LIFECYCLE.md) | cycles de vie et machines à états |
| [OBJECT_RULES.md](OBJECT_RULES.md) | invariants, validation, historisation, permissions |
| [DOMAIN_GLOSSARY.md](DOMAIN_GLOSSARY.md) | langage ubiquitaire (synonymes interdits) |
| [DOMAIN_PATTERNS.md](DOMAIN_PATTERNS.md) | patrons de modélisation |
| [DOMAIN_ANTI_PATTERNS.md](DOMAIN_ANTI_PATTERNS.md) | erreurs interdites + règles de modification |
| [objects/](objects/) | une fiche indépendante par objet métier |

## Navigation
**Pourquoi :** une seule source de vérité par objet (Loi 1). **Public :** architectes, dev backend. **Avant :** [../architecture/README.md](../architecture/README.md). **Après :** [../engines/README.md](../engines/README.md). **Dépendants :** events, contracts, implementation.

## Rules
Un objet = un agrégat/entité/VO propriétaire ; les autres référencent par id (Loi 1/11). Aucun montant calculé hors du service dédié (ADR-023 / ADR-V2-10). Toute évolution d'objet respecte les 4 conditions de [DOMAIN_ANTI_PATTERNS.md](DOMAIN_ANTI_PATTERNS.md) ou déclenche un ADR.

## Forbidden
Écrire du code, un DTO, un repository ou un service à cette étape : le Domain Model **décrit** le métier, il ne l'implémente pas.

## Acceptance Criteria
Tous les objets documentés · relations décrites · cycles de vie et événements présents · responsabilités uniques · vocabulaire cohérent · invariants et anti-patterns définis.

## Related Documents
[../engines/README.md](../engines/README.md) · [../events/README.md](../events/README.md) · [../glossary/GLOSSARY.md](../glossary/GLOSSARY.md)

## Next Reading
[DOMAIN_MODEL.md](DOMAIN_MODEL.md)

## Changelog
- 2.0 (2026-08-02) — Domain Model figé (Step 2) : 8 documents + fiches objets.
- 1.0 (2026-08-02) — Section créée (Step 1).
