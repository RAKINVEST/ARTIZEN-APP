# Knowledge Test Strategy — Stratégie de test (documentaire)

> **Version** 1.0 — **Status** Validated — **Owner** Knowledge — **Last Update** 2026-08-02
> **Depends On:** [../../implementation/TEST_STRATEGY.md](../../implementation/TEST_STRATEGY.md) — **Used By:** implémentation future — **Niveau:** 3 · Implémentation

## Objective
Décrire **ce qu'il faudra tester** (aucun test écrit ici). Aligné sur [TEST_STRATEGY](../../implementation/TEST_STRATEGY.md).

## Cas de test attendus (par invariant)
| # | Invariant | Test attendu |
|---|---|---|
| T1 | Capture | `knowledge.capture` crée une Card en **Brouillon** + publie `KnowledgeCaptured` |
| T2 | Validation humaine | transition **Brouillon → Validé** exige un acteur ; publie `BestPracticeValidated` |
| T3 | Append-only (Loi 5) | une Card validée n'est **jamais** détruite ni modifiée en place ; une évolution crée une **nouvelle version** et archive l'ancienne |
| T4 | Apprentissage non silencieux | `MissionClosed` produit une **proposition** (Brouillon), **jamais** une modification directe d'une fiche validée |
| T5 | Frontière Mission | le moteur **n'écrit jamais** `Mission` (ni un objet non propriétaire) |
| T6 | Tenant | Card d'une autre `Company` → **404** ; `company_id` du JWT |
| T7 | Vues = projections | changer de vue ne modifie pas le contenu ; zéro duplication |
| T8 | Traçabilité IA | toute proposition IA référence les Cards (id + version) qui la fondent |
| T9 | Aucun montant | aucune opération du moteur ne calcule un montant (ADR-023) |

## Niveaux (Engineering Standards)
Unitaire (transitions, invariants, projections) · Intégration (événements consommés/produits, tenant) ·
Non-régression (tout bug → test qui le reproduit). DB réelle sans isolation (limite connue du projet).

## Conformité (STEP 1–8)
- S'appuie sur TEST_STRATEGY (STEP 6) ; n'invente aucune règle de test. ✅
- Couvre chaque invariant gelé du moteur/objet. ✅

## Related Documents
[../../implementation/TEST_STRATEGY.md](../../implementation/TEST_STRATEGY.md) · [KNOWLEDGE_GOVERNANCE.md](KNOWLEDGE_GOVERNANCE.md)

## Next Reading
[README.md](README.md)

## Changelog
- 1.0 (2026-08-02) — Stratégie initiale.
