# Versioning — Versionnement & historique

> **Version** 1.0 — **Status** Validated — **Owner** Éditorial / Contenu métier — **Last Update** 2026-08-02
> **Depends On:** [LIFECYCLE.md](LIFECYCLE.md) — **Used By:** contributeurs, validateurs

## Objective
Garantir qu'aucune évolution ne détruit le savoir passé (append-only, Loi 5).

## Numérotation
- Version **majeure** : changement de méthode/étapes/sécurité/normes (impact réel sur le geste).
- Version **mineure** : précision, reformulation, ajout de photo/relation, correction de forme.
- Format : `vMAJEUR.MINEUR` dans le champ **Version** de la carte + entrée d'historique.

## Préservation de l'historique
- Chaque version validée est **conservée** ; la précédente est **archivée**, jamais écrasée.
- L'historique porte : version, date, auteur, validateur, **motif** du changement.
- Le **slug** ne change pas entre versions (stabilité des références/relations).

## Règles
- On ne modifie **jamais** en place une carte validée : on publie une **nouvelle version**.
- Une relation pointe vers la carte (slug), qui résout vers sa **version validée courante** ;
  l'historique reste accessible.
- Un retour arrière = **nouvelle version** qui reprend l'ancienne (jamais un « undo » destructif).

## Cohérence avec le Blueprint
Aligné sur l'invariant `Knowledge` (append-only) et
[../blueprint/contracts/VERSIONING_POLICY.md](../blueprint/contracts/VERSIONING_POLICY.md).

## Changelog
- 1.0 (2026-08-02) — Politique initiale.
