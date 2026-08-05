# Quality Rules — Critères de qualité

> **Version** 1.0 — **Status** Validated — **Owner** Éditorial / Contenu métier — **Last Update** 2026-08-02
> **Depends On:** [cards/CARD_TEMPLATE.md](cards/CARD_TEMPLATE.md), [VALIDATION_PROCESS.md](VALIDATION_PROCESS.md) — **Used By:** validateurs

## Objective
Fixer les critères **non négociables** de validation d'une carte. Une carte qui échoue à un critère
**reste en Brouillon**.

## Critères de validation (tous requis)
| # | Critère | Vérification |
|---|---|---|
| Q1 | **Complète** | tous les champs obligatoires du [modèle](cards/CARD_TEMPLATE.md) sont renseignés |
| Q2 | **Cohérente** | pas de contradiction interne ; temps/difficulté/étapes concordent |
| Q3 | **Traçable** | auteur, validateur, version, sources (normes, retours) identifiables |
| Q4 | **Reliée** | au moins les relations pertinentes posées (kit, phrases, diagnostics… selon le cas) |
| Q5 | **Conforme aux conventions** | nommage, tags, structure (EDITORIAL_GUIDE, TAGGING) |
| Q6 | **Non-dupliquée** | aucune carte équivalente existante (sinon référence/variante) |
| Q7 | **Sécurité & normes** | points critiques, sécurité et normes applicables présents quand pertinents |
| Q8 | **Langage artisan** | aucun terme d'ingénierie ; test des 5 secondes |

## Champs obligatoires (minimum pour valider)
Identifiant · Titre · Profession · Objectif · Résumé · Étapes · Points critiques · Sécurité ·
Version · Auteur · Validateur · Tags · Relations. *(Les autres champs sont recommandés ; leur
absence n'empêche pas la validation mais baisse l'indice de confiance.)*

## Indice de confiance
Signal qualitatif (non mesuré ici) reflétant complétude + retours terrain + validations. Défini
comme **facette** de la carte ; sa formule appartient à l'implémentation (moteur Performance).

## Interdits
Valider une carte incomplète · valider une carte dupliquée · valider sans validateur humain ·
affirmer une norme non sourcée.

## Changelog
- 1.0 (2026-08-02) — Critères initiaux.
