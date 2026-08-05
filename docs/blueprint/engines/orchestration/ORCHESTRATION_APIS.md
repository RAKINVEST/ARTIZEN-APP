# Orchestration APIs — Contrats documentaires

> **Version** 1.0 — **Status** Validated — **Owner** Orchestration — **Last Update** 2026-08-02
> **Depends On:** [../../contracts/API_CONTRACTS.md](../../contracts/API_CONTRACTS.md) — **Used By:** implémentation — **Niveau:** 2 · Architecture

## Objective
Décrire **de façon documentaire** les capacités. **Ne remplace jamais** les Contracts (STEP 5).
Signatures **illustratives, non contractuelles**.

## Capacités
| Capacité | Intention | Nature | Effet |
|---|---|---|---|
| `orchestration.start` | démarrer depuis une décision **validée** | commande | lance une orchestration (id) |
| `orchestration.status` | consulter l'avancement | requête | état + chronologie des étapes |
| `orchestration.cancel` | annuler | commande | passe en **Annulé** + compensations |

## Règles de contrat (héritées)
- Enveloppe d'erreur `{ error: { code, message } }` ; statuts 401/403/404/409/422/429.
- `company_id` **du JWT** ; mismatch tenant → **404**.
- `orchestration.start` **exige** une décision **validée** (sinon refus) — pas d'action automatique.
- Orchestration **ne persiste pas** de modèle dédié ; elle **délègue** les écritures aux propriétaires.
- Aucune capacité ne calcule un montant (ADR-023).

## Ce qui n'est jamais exposé
Écriture directe des données d'un autre moteur ; démarrage sans décision validée ; suppression de donnée métier.

## Conformité
Read/commande de coordination ; renvoie aux Contracts STEP 5 ; validation en amont. ✅

## Changelog
- 1.0 (2026-08-02) — Contrats documentaires initiaux.
