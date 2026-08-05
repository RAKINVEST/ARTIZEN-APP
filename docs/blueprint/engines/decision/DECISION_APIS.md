# Decision APIs — Contrats documentaires

> **Version** 1.0 — **Status** Validated — **Owner** Decision — **Last Update** 2026-08-02
> **Depends On:** [../../contracts/API_CONTRACTS.md](../../contracts/API_CONTRACTS.md) — **Used By:** implémentation — **Niveau:** 2 · Architecture

## Objective
Décrire, **de façon documentaire**, les capacités exposées. **Ne remplace jamais** les Contracts (STEP 5).
Signatures **illustratives, non contractuelles**.

## Capacités
| Capacité | Intention | Nature | Effet |
|---|---|---|---|
| `decision.interpret` | comprendre une intention | requête | `Intent` (transitoire) |
| `decision.context` | assembler le contexte | requête | `Context` (lecture) |
| `decision.propose` | produire une proposition classée | requête | `Proposal` + `Explanation` (lecture) |
| `decision.explain` | justifier un élément de la proposition | requête | explication traçable |
| `decision.validate` | **enregistrer la validation utilisateur** | commande | **signal** `DecisionValidated` (l'écriture reste au propriétaire) |

## Règles de contrat (héritées, non redéfinies)
- Enveloppe d'erreur `{ error: { code, message } }` ; statuts 401/403/404/422.
- `company_id` **du JWT** ; mismatch tenant → **404**.
- `decision.*` **ne persiste pas** le cœur ; `decision.validate` **délègue** l'écriture au moteur propriétaire.
- Aucune capacité ne calcule un montant (ADR-023).

## Ce qui n'est jamais exposé
Création directe de `Quote`/`Invoice`/`Mission` par Decision ; écriture d'un objet non propriétaire ;
application automatique sans validation humaine.

## Conformité
Renvoie aux Contracts STEP 5 ; read-side ; validation humaine obligatoire. ✅

## Changelog
- 1.0 (2026-08-02) — Contrats documentaires initiaux.
