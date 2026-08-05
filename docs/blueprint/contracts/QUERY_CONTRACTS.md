# Query Contracts — Lectures

> **Version** 1.0 — **Status** Frozen — **Owner** Architecture — **Last Update** 2026-08-02
> **Depends On:** [API_CONTRACTS.md](API_CONTRACTS.md) — **Used By:** contracts/queries — **Niveau:** 2 · Architecture

## Objective
Décrire toute **lecture** (aucun effet de bord). Séparation commande/requête (CQRS léger) : une requête ne modifie jamais l'état.

## Forme d'une requête
| Élément | Règle |
|---|---|
| **Entrées** | critères explicites ; `company_id` du contexte |
| **Filtres** | liste blanche de champs filtrables ; jamais de filtre libre non borné |
| **Pagination** | obligatoire au-delà d'un seuil ([contracts/pagination.md](contracts/pagination.md)) : `offset/limit` bornés (limit ≤ 200) |
| **Tri** | liste blanche de champs triables + sens |
| **Recherche** | champ `q` (ILIKE borné) ; pas de requête arbitraire |
| **Permissions** | scoping tenant strict ; aucune donnée hors Company |
| **Cache** | idempotente, cacheable ; invalidée par les événements d'écriture |

## Rules
Une requête est **idempotente** et sans effet de bord. Les résultats respectent la visibilité (Privé/Entreprise/Groupe/Public).

## Acceptance Criteria
Chaque requête a : entrées, filtres (liste blanche), pagination, tri, recherche, permissions, cache.

## Related Documents
[DTO_CONTRACTS.md](DTO_CONTRACTS.md) · [contracts/pagination.md](contracts/pagination.md)

## Next Reading
[DTO_CONTRACTS.md](DTO_CONTRACTS.md)

## Changelog
- 1.0 (2026-08-02) — Conventions requêtes initiales.
