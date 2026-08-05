# Flow Permissions — Qui peut quoi

> **Version** 1.0 — **Status** Frozen — **Owner** Architecture — **Last Update** 2026-08-02
> **Depends On:** [../engines/engines/Authorization.md](../engines/engines/Authorization.md) — **Used By:** flows/ — **Niveau:** 2 · Architecture

## Objective
Définir, par famille de flux, qui peut **lancer / interrompre / reprendre / annuler / valider**. Toute décision d'accès passe par l'Authorization Engine ; `company_id` du contexte, jamais du client.

## Matrice par famille
| Famille | Lancer | Interrompre | Reprendre | Annuler | Valider |
|---|---|---|---|---|---|
| Onboarding | Admin | Admin | Admin | Admin | Admin |
| Client / Mission / Intervention | Artisan | Artisan | Artisan | Artisan (si non figé) | Artisan |
| Devis | Artisan | Artisan | Artisan | Artisan (Draft) | **Client** (signature) |
| Facturation / Achats | Artisan (droit facturation) | Artisan | Artisan | avoir uniquement | Artisan |
| Bibliothèque / Média | Artisan | Artisan | Artisan | Artisan | Artisan |
| Suivi (garantie, maintenance…) | Artisan / Système | Artisan | Artisan | Artisan | Artisan |
| Cycle de vie (archiver/restaurer) | Artisan | — | — | — | Artisan |
| **Supprimer** | Artisan | — | — | — | Artisan + **confirmation** ; brouillon uniquement |

## Règles
- Une action **irréversible** (envoi, signature, suppression) exige une **confirmation explicite**.
- Un mismatch de tenant renvoie « introuvable » (jamais « interdit »).
- La signature d'un devis est le seul flux où l'acteur validant est le **client**.

## Acceptance Criteria
Chaque famille de flux a ses cinq droits définis.

## Related Documents
[FLOW_ERRORS.md](FLOW_ERRORS.md) · [../domain/OBJECT_RULES.md](../domain/OBJECT_RULES.md)

## Next Reading
[FLOW_PATTERNS.md](FLOW_PATTERNS.md)

## Changelog
- 1.0 (2026-08-02) — Matrice de permissions initiale.
