# Knowledge APIs — Contrats documentaires exposés

> **Version** 1.0 — **Status** Validated — **Owner** Knowledge — **Last Update** 2026-08-02
> **Depends On:** [../../contracts/API_CONTRACTS.md](../../contracts/API_CONTRACTS.md) — **Used By:** implémentation future — **Niveau:** 2 · Architecture

## Objective
Décrire, **de façon documentaire**, les capacités exposées. **Ces descriptions ne remplacent jamais
les Contracts du STEP 5** : elles illustrent les interactions du moteur. Toute API réelle sera
définie via [../../contracts/](../../contracts/) au moment de l'implémentation.

> **Aucune API réelle n'est créée ici.** Signatures illustratives, non contractuelles.

## Capacités (dérivées des services gelés `knowledge.search/capture`)
| Capacité | Intention | Nature | Effet |
|---|---|---|---|
| `knowledge.capture` | proposer un savoir | commande | crée un `Knowledge` **Brouillon** |
| `knowledge.propose` | proposer un enrichissement d'une fiche existante | commande | crée une **proposition** (Brouillon de nouvelle version) |
| `knowledge.validate` | valider une proposition (humain) | commande | transition **Brouillon → Validé** + version + archivage de l'ancienne |
| `knowledge.search` | rechercher / naviguer | requête | lecture (projections/vues) |
| `knowledge.get` | lire une Card + son historique | requête | lecture |

## Règles de contrat (héritées, non redéfinies)
- Enveloppe d'erreur `{ error: { code, message } }` ; statuts standard (401/403/404/409/422).
- `company_id` **du JWT**, jamais du client ; mismatch tenant → **404** (jamais 403).
- Écritures **append-only** ; aucune route ne détruit une donnée métier (Loi 5).
- Aucune capacité ne calcule un montant (ADR-023).

## Ce que ces contrats N'EXPOSENT PAS
- Aucun accès aux tables d'un autre moteur ; aucune écriture de `Mission`/`Intervention`.
- Aucune application automatique : `knowledge.validate` exige un **acteur humain** (Loi 7/18).

## Conformité (STEP 1–8)
- Renvoie explicitement aux Contracts STEP 5 ; ne les redéfinit pas. ✅
- Règles tenant/erreur/append-only alignées sur STEP 5/6. ✅

## Related Documents
[../../contracts/API_CONTRACTS.md](../../contracts/API_CONTRACTS.md) · [KNOWLEDGE_PERMISSIONS.md](KNOWLEDGE_PERMISSIONS.md)

## Next Reading
[KNOWLEDGE_VIEWS.md](KNOWLEDGE_VIEWS.md)

## Changelog
- 1.0 (2026-08-02) — Contrats documentaires initiaux.
