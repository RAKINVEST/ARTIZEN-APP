# Core Business Intelligence — Le raisonnement métier

> **Version** 1.0 — **Status** Validated — **Owner** Business Intelligence — **Last Update** 2026-08-02
> **Depends On:** [../engines/decision/README.md](../engines/decision/README.md), [../engines/knowledge/README.md](../engines/knowledge/README.md) — **Used By:** Decision Engine, AI Companion — **Niveau:** 1 · Vision

## Objective
Formaliser **comment raisonne un artisan expérimenté** : le modèle officiel du raisonnement métier
d'Artizen. Le patrimoine contient les **connaissances** ; le Decision Engine sait **sélectionner** ; le
Core Business Intelligence (CBI) explique **comment réfléchir**. **Aucun code.**

## Ce que le CBI EST / N'EST PAS
- **EST** : une **référence de raisonnement** (heuristiques, modèles de décision, gestion du risque et
  de l'incertitude) que le **Decision Engine** et l'**AI Companion** appliquent.
- **N'EST PAS** : un moteur qui agit, un objet du domaine, une base de données, du code.
- Il **ne décide jamais** à la place de l'artisan (Loi 7/18) et **n'invente jamais** (incertitude → demander/proposer/attendre/suspendre).

## Conformité
Section **nouvelle**, **documentaire** ; **ne modifie aucun document gelé**, ne crée aucun objet/moteur,
aucune Knowledge Card. S'aligne sur l'invariant IA (« ne persiste/n'invente rien »), le CONFIDENCE_MODEL
(A/B/C/D), la validation humaine et l'explicabilité (Loi 6/7/18).

## Documents
| Document | Rôle |
|---|---|
| [CORE_BUSINESS_INTELLIGENCE.md](CORE_BUSINESS_INTELLIGENCE.md) | concept & frontières |
| [REASONING_MODEL.md](REASONING_MODEL.md) | le raisonnement en 10 temps |
| [DECISION_PATTERNS.md](DECISION_PATTERNS.md) | modèles de décision (9) |
| [PROBLEM_SOLVING.md](PROBLEM_SOLVING.md) | méthode de résolution |
| [DIAGNOSTIC_REASONING.md](DIAGNOSTIC_REASONING.md) | raisonnement diagnostique |
| [INTERVENTION_REASONING.md](INTERVENTION_REASONING.md) | choix & adaptation de l'intervention |
| [RISK_ANALYSIS.md](RISK_ANALYSIS.md) | analyse des risques |
| [PRIORITIZATION.md](PRIORITIZATION.md) | priorisation |
| [UNCERTAINTY.md](UNCERTAINTY.md) | gestion de l'incertitude |
| [EXCEPTION_HANDLING.md](EXCEPTION_HANDLING.md) | cas particuliers / exceptions |
| [HUMAN_VALIDATION.md](HUMAN_VALIDATION.md) | l'humain décide |
| [LEARNING_MODEL.md](LEARNING_MODEL.md) | apprentissage (du classement) |
| [EXPLAINABILITY.md](EXPLAINABILITY.md) | explicabilité |
| [CHANGELOG.md](CHANGELOG.md) | journal |

## Changelog
- 1.0 (2026-08-02) — Modèle de raisonnement initial.
