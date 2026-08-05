# Learning Model — Apprentissage du raisonnement

> **Version** 1.0 — **Status** Validated — **Owner** Business Intelligence — **Last Update** 2026-08-02
> **Depends On:** [../engines/decision/DECISION_LEARNING.md](../engines/decision/DECISION_LEARNING.md), [../engines/knowledge/KNOWLEDGE_LEARNING.md](../engines/knowledge/KNOWLEDGE_LEARNING.md) — **Used By:** Decision — **Niveau:** 2 · Architecture

## Objective
Décrire comment le **raisonnement s'affine** — sans jamais modifier les connaissances validées.

## Ce qui s'améliore
| Cible | Comment |
|---|---|
| **Classement** | les propositions les plus souvent retenues remontent |
| **Recommandations** | mieux ajustées au contexte (métier, équipement, saison) |
| **Priorités** | pondérations affinées par les retours réels |

## Ce qui **ne** change **jamais** ici
- Le **contenu** d'une Knowledge Card : il n'évolue que par le cycle **Knowledge** (Observation →
  Proposition → **Validation humaine** → Nouvelle version).
- Les **règles de sécurité/conformité** : non « apprises » à la baisse — elles restent des garde-fous.

## Signaux (lecture)
Validations, modifications, refus, temps réels, devis envoyés, interventions réalisées, SAV, retours terrain — **via le Decision Engine** ([../engines/decision/DECISION_LEARNING.md](../engines/decision/DECISION_LEARNING.md)).

## Règles
- Apprentissage **borné** au classement/recommandation/priorité ; **jamais** au savoir validé.
- **Explicable** : une évolution de recommandation doit rester justifiable ([EXPLAINABILITY.md](EXPLAINABILITY.md)).
- **Aucune modification silencieuse** ; aucune baisse de garde sécurité par « apprentissage ».

## Changelog
- 1.0 (2026-08-02) — Modèle d'apprentissage initial.
