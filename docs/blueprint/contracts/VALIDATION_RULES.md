# Validation Rules — Règles de validation

> **Version** 1.0 — **Status** Frozen — **Owner** Architecture — **Last Update** 2026-08-02
> **Depends On:** [DTO_CONTRACTS.md](DTO_CONTRACTS.md) — **Used By:** contracts/, commands — **Niveau:** 2 · Architecture

## Objective
Définir les couches de validation d'un échange, dans l'ordre. Un échange invalide n'est jamais accepté.

## Couches (ordre)
| # | Couche | Vérifie |
|---|---|---|
| 1 | **Syntaxe** | types, formats, présence des champs obligatoires |
| 2 | **Formats & longueurs** | e-mail, date ISO, hex couleur, min/max de longueur |
| 3 | **Métier** | invariants du Domain Model (ex. Draft seul modifiable) |
| 4 | **Permissions** | droit de l'acteur + scoping tenant |
| 5 | **Relations** | les références (ids) existent et appartiennent au tenant |
| 6 | **Unicité** | pas de doublon (numéro de devis, e-mail utilisateur…) |
| 7 | **Cohérence** | totaux cohérents, dates ordonnées, quantités positives |

## Règles
- La validation échoue **au plus tôt** et renvoie `validation_error` (422) avec la liste des champs.
- Aucune valeur n'est **inventée** pour passer une validation (la source fait foi).
- Un `company_id` fourni par le client est **ignoré** (écrasé par le contexte).

## Acceptance Criteria
Les 7 couches sont définies et ordonnées ; les messages listent les champs fautifs.

## Related Documents
[ERROR_CONTRACTS.md](ERROR_CONTRACTS.md) · [../domain/OBJECT_RULES.md](../domain/OBJECT_RULES.md)

## Next Reading
[VERSIONING_POLICY.md](VERSIONING_POLICY.md)

## Changelog
- 1.0 (2026-08-02) — Couches de validation initiales.
