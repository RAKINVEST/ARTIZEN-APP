# Decision Engine — Spécification détaillée

> **Version** 1.0 — **Status** Validated — **Owner** Decision — **Last Update** 2026-08-02
> **Depends On:** [../knowledge/README.md](../knowledge/README.md), [../../domain/OBJECT_RULES.md](../../domain/OBJECT_RULES.md) — **Used By:** implémentation future — **Niveau:** 2 · Architecture · **Couche:** read-side

## Objective
Spécifier le **Decision Engine** — le moteur qui transforme une **intention** en **plan d'action
proposé et expliqué**, en orchestrant (en lecture) les autres moteurs. **Aucun code.** Ce dossier
**approfondit** un moteur déjà nommé dans le Domain Model gelé ; il **ne modifie** aucun document figé.

## Règle de conformité fondatrice (le cœur de tout)
Decision est un moteur **read-side** (le Domain Model gelé le cite ainsi). En conséquence, **absolu** :
- Il **lit** (Knowledge, Catalog, historique…) via événements/contrats ; il **n'écrit jamais** le cœur.
- Il **propose et explique** ; il **ne décide pas** à la place de l'artisan (Loi 7/18).
- Il **ne persiste rien** et **n'invente rien** (comme `quote_assistant` : ni modèle, ni table, ni migration).
- Les **écritures** (devis, tâches, workflows, notifications) sont des **gestes explicites de
  l'utilisateur**, exécutés par les **moteurs propriétaires** (le Quote Engine crée le `Quote`, jamais Decision).
- Aucun **montant** calculé ici (un seul lieu calcule — ADR-023).

## Documents
| Document | Rôle |
|---|---|
| [DECISION_ENGINE.md](DECISION_ENGINE.md) | responsabilité, frontières, read-side |
| [DECISION_DOMAIN.md](DECISION_DOMAIN.md) | domaine + **taxonomie des intentions** |
| [DECISION_OBJECTS.md](DECISION_OBJECTS.md) | objets lus / artefacts transitoires |
| [DECISION_GRAPH.md](DECISION_GRAPH.md) | graphe intention → moteurs → proposition |
| [DECISION_PIPELINE.md](DECISION_PIPELINE.md) | pipeline décisionnel (10 étapes) |
| [DECISION_RULES.md](DECISION_RULES.md) | règles & priorités de décision |
| [DECISION_EVENTS.md](DECISION_EVENTS.md) | événements consommés / publiés |
| [DECISION_APIS.md](DECISION_APIS.md) | contrats documentaires |
| [DECISION_CONTEXT.md](DECISION_CONTEXT.md) | modèle de contexte |
| [DECISION_SCORING.md](DECISION_SCORING.md) | classement / scoring |
| [DECISION_LEARNING.md](DECISION_LEARNING.md) | apprentissage (du classement, pas du savoir) |
| [DECISION_EXPLAINABILITY.md](DECISION_EXPLAINABILITY.md) | explicabilité |
| [DECISION_INTEGRATIONS.md](DECISION_INTEGRATIONS.md) | interactions inter-moteurs |
| [DECISION_TEST_STRATEGY.md](DECISION_TEST_STRATEGY.md) | stratégie de test |
| [CHANGELOG.md](CHANGELOG.md) | journal |

## Changelog
- 1.0 (2026-08-02) — Spécification initiale du Decision Engine.
