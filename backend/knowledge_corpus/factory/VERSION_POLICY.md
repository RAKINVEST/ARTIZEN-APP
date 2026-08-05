# Version Policy — Versionnement en production

> **Version** 1.0 — **Status** Validated — **Owner** Éditorial / Contenu métier — **Last Update** 2026-08-02
> **Depends On:** [../VERSIONING.md](../VERSIONING.md) — **Used By:** auteurs, validateurs, responsables

## Objective
Opérationnaliser le versionnement des cartes en production. **Ne redéfinit pas** [../VERSIONING.md](../VERSIONING.md) (source) : l'applique à la chaîne.

## Numérotation (rappel)
`vMAJEUR.MINEUR`. **Majeur** = méthode/étapes/sécurité/normes ; **Mineur** = précision/reformulation/média/relation.

## Règles de production
- Toute version validée porte : numéro, date, **auteur**, **validateur**, **motif**.
- Une évolution **repasse le workflow complet** ([EDITORIAL_WORKFLOW.md](EDITORIAL_WORKFLOW.md)) — pas de « patch » direct.
- Le **slug** est immuable ; une relation résout vers la **version validée courante**, l'historique reste accessible.
- Un **retour arrière** = **nouvelle version** reprenant l'ancienne (jamais un « undo » destructif).
- La **fraîcheur** (dimension de score) se met à jour à chaque version validée.

## Traçabilité
Historique **append-only** par carte (Loi 4/5) ; aucune version supprimée ([DEPRECATION_POLICY.md](DEPRECATION_POLICY.md)).

## Changelog
- 1.0 (2026-08-02) — Politique initiale.
