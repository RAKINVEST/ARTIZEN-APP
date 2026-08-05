# Human Validation — L'humain décide

> **Version** 1.0 — **Status** Validated — **Owner** Business Intelligence — **Last Update** 2026-08-02
> **Depends On:** [../engines/decision/DECISION_ENGINE.md](../engines/decision/DECISION_ENGINE.md) — **Used By:** Decision, AI Companion — **Niveau:** 1 · Vision

## Objective
Graver que le raisonnement d'Artizen **prépare** la décision ; **l'artisan la prend** (Loi 7/18).

## Principe
Le CBI **raisonne pour proposer**, jamais pour **imposer**. La décision — et sa responsabilité — reste
**humaine**. Artizen restitue le savoir-faire ; il ne s'y substitue pas.

## Points de validation obligatoires
| Moment | Ce que l'humain valide |
|---|---|
| Choix de la solution | l'option retenue (réparer/remplacer…) |
| Contenu proposé | devis pré-rempli, kits, phrases, procédures |
| Sécurité / conformité | les points critiques et normes applicables |
| Exécution | le déclenchement (Orchestration ne démarre qu'après) |
| Contenu de savoir | une carte n'est **Validée** que par un humain habilité (Knowledge) |

## Règles
- **Rien d'automatique** sur une décision engageante : proposition → **validation** → exécution.
- La validation est **éclairée** : elle s'appuie sur l'**explication** ([EXPLAINABILITY.md](EXPLAINABILITY.md)) et le **niveau de confiance**.
- Un refus/une modification de l'artisan **prime** toujours sur la recommandation.

## Changelog
- 1.0 (2026-08-02) — Principe initial.
