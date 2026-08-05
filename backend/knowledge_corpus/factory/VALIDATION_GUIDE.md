# Validation Guide — Guide du validateur

> **Version** 1.0 — **Status** Validated — **Owner** Éditorial / Contenu métier — **Last Update** 2026-08-02
> **Depends On:** [../VALIDATION_PROCESS.md](../VALIDATION_PROCESS.md), [QUALITY_CHECKLIST.md](QUALITY_CHECKLIST.md) — **Used By:** validateurs (experts métier)

## Objective
Cadrer l'acte de **validation** : le seul moment où une carte devient publiable. Opérationnalise
[../VALIDATION_PROCESS.md](../VALIDATION_PROCESS.md) (gelé) — ne le redéfinit pas.

## Qui valide
Un **validateur humain habilité** du métier concerné (jamais l'auteur seul, jamais l'IA — Loi 7/18).

## Condition de validation
La carte passe **intégralement** [QUALITY_CHECKLIST.md](QUALITY_CHECKLIST.md) **et** atteint le seuil de
[KNOWLEDGE_SCORE.md](KNOWLEDGE_SCORE.md) **et** son niveau de confiance est défini
([CONFIDENCE_MODEL.md](CONFIDENCE_MODEL.md)).

## Décisions
| Décision | Effet |
|---|---|
| **Valider** | Brouillon → **Validé** ; publication selon `Visibility` ; événement `BestPracticeValidated` (runtime) |
| **Rejeter** | rejet **motivé** (conservé) ; retour Brouillon |
| **Ajourner** | manque une source/relecture ; reste Brouillon avec action claire |

## Règles
- La validation **engage** : l'expert répond de l'exactitude métier.
- Une carte validée **ne se modifie pas** en place : évolution = nouvelle version ([VERSION_POLICY.md](VERSION_POLICY.md)).
- Aucune validation « en lot » à l'aveugle : chaque carte est validée individuellement (même en production de masse).

## Changelog
- 1.0 (2026-08-02) — Guide initial.
