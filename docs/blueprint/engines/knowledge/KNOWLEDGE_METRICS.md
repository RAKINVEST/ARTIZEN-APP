# Knowledge Metrics — Métriques d'usage

> **Version** 1.0 — **Status** Validated — **Owner** Knowledge — **Last Update** 2026-08-02
> **Depends On:** [../engines/Performance.md](../engines/Performance.md) — **Used By:** Performance — **Niveau:** 2 · Architecture

## Objective
Définir **quelles** métriques le moteur expose et **comment** — sans mesure réelle (spécification).

## Principe
Le Knowledge Engine **ne calcule pas** de statistiques transverses : il **remonte des métriques
d'usage à Performance par événements** (fiche moteur). Performance reste propriétaire de l'agrégation.

## Métriques exposées (indicateurs, non mesurés ici)
| Métrique | Sens | Remontée |
|---|---|---|
| Couverture | part des opérations disposant d'au moins une Card | événement/usage |
| Fraîcheur | ancienneté de la dernière version validée | usage |
| Réutilisation | nombre de consultations/insertions d'une Card | événement de lecture |
| Taux de validation | propositions acceptées / proposées | dérivé de `BestPracticeValidated` |
| Confiance | signal qualitatif issu des retours terrain | facette/usage |

> **Aucune valeur n'est affirmée** (« performant », « rapide »…). Ce document **spécifie** des
> indicateurs ; leur mesure appartient à l'implémentation + au moteur Performance.

## Règles
- Métriques **explicables** (Loi 6) ; aucune métrique opaque.
- Pas de donnée client dans les métriques agrégées ; tenant respecté.

## Conformité (STEP 1–8)
- Remontée à Performance par événements = fiche moteur gelée. ✅
- Aucune agrégation dupliquée ; Performance reste propriétaire. ✅

## Related Documents
[../engines/Performance.md](../engines/Performance.md) · [KNOWLEDGE_TEST_STRATEGY.md](KNOWLEDGE_TEST_STRATEGY.md)

## Next Reading
[KNOWLEDGE_TEST_STRATEGY.md](KNOWLEDGE_TEST_STRATEGY.md)

## Changelog
- 1.0 (2026-08-02) — Métriques initiales.
