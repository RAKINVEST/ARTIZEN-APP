# Explainability — Explicabilité du raisonnement

> **Version** 1.0 — **Status** Validated — **Owner** Business Intelligence — **Last Update** 2026-08-02
> **Depends On:** [../engines/decision/DECISION_EXPLAINABILITY.md](../engines/decision/DECISION_EXPLAINABILITY.md) — **Used By:** UX, confiance — **Niveau:** 2 · Architecture

## Objective
Garantir que **chaque recommandation est justifiable** — y compris les hésitations et les demandes de confirmation (Loi 6).

## Le moteur sait dire « pourquoi »
| Question | Réponse fondée sur |
|---|---|
| Pourquoi je **recommande** ? | cause diagnostiquée + connaissance validée + priorité (sécurité/conformité) |
| Pourquoi j'**écarte** une option | risque, confiance plus faible, hors qualification, non conforme |
| Pourquoi j'**hésite** | sources divergentes / confiance faible (A/B/C/D) |
| Pourquoi je **demande confirmation** | information manquante / doute de sécurité ([UNCERTAINTY.md](UNCERTAINTY.md)) |

## Exigences
- Toute réponse **cite ses appuis** (cartes + version, tags, règle, priorité) — **traçable**.
- Le **niveau de confiance** accompagne la recommandation ; le « à confirmer » (D) est explicite.
- **Aucune boîte noire** : pas de recommandation sans explication.
- Langage **artisan** (deux langues) ; on **montre le raisonnement**, on ne l'impose pas.

## Cohérence
Prolonge l'explicabilité du Decision Engine ([../engines/decision/DECISION_EXPLAINABILITY.md](../engines/decision/DECISION_EXPLAINABILITY.md)) au niveau du **raisonnement**.

## Changelog
- 1.0 (2026-08-02) — Explicabilité initiale.
