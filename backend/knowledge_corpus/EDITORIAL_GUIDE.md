# Editorial Guide — Règles éditoriales

> **Version** 1.0 — **Status** Validated — **Owner** Éditorial / Contenu métier — **Last Update** 2026-08-02
> **Depends On:** [cards/CARD_TEMPLATE.md](cards/CARD_TEMPLATE.md), [TAGGING.md](TAGGING.md) — **Used By:** tout rédacteur

## Objective
Comment écrire, nommer et faire évoluer une Knowledge Card, de façon homogène à l'échelle industrielle.

## Comment écrire une carte
- **Une carte = UNE opération métier** (un savoir-faire), jamais un produit (le produit vit dans `Catalog`).
- Langage **artisan** (les « deux langues ») : aucun terme d'ingénierie à l'écran.
- Style : impératif, concret, vérifiable ; **montrer** (photos/étapes) plutôt qu'expliquer.
- Toujours partir du [modèle officiel](cards/CARD_TEMPLATE.md) ; ne jamais improviser la structure.

## Comment nommer une carte
- **Titre** : action + objet + contexte. Ex. « Remplacer un mitigeur thermostatique de douche ».
- **Slug/fichier** : `kebab-case`, stable, sans accent. Ex. `remplacer-mitigeur-thermostatique-douche.md`.
- **Emplacement** : `professions/<métier>/cards/` (ou `cards/` transverse), selon RELATIONSHIP_RULES.
- Le slug est **gelé** à la validation : on ne renomme pas une carte validée (on versionne).

## Comment éviter les doublons
- Avant création : **rechercher** (titre, tags, profession) — voir [SEARCH_STRATEGY.md](SEARCH_STRATEGY.md).
- Un doublon **n'est jamais supprimé** automatiquement : il devient une **référence** vers la carte
  officielle (source unique — Loi 1), ou une **variante** rattachée (voir ci-dessous).

## Comment gérer les variantes
- Une **variante** (même opération, contexte différent : marque, matériau, pièce) est une **carte
  distincte** reliée à la carte-mère par la relation `variante-de` ([RELATIONSHIP_RULES.md](RELATIONSHIP_RULES.md)).
- Ne pas gonfler une carte de tous les cas : préférer plusieurs cartes reliées et navigables.

## Comment gérer les mises à jour
- Une carte **validée** ne se modifie pas en place : toute évolution crée une **nouvelle version**
  (voir [VERSIONING.md](VERSIONING.md)) ; l'ancienne est **archivée**, jamais détruite (Loi 5).

## Comment gérer les suppressions
- **Aucune suppression** de contenu métier. On **archive** (statut Archivé). Une suppression
  réelle exigerait un **ADR** (donnée métier — Loi 5).

## Comment gérer les validations
- Une carte naît en **Brouillon** ; elle ne devient **Validée** que par un **humain habilité**
  ([VALIDATION_PROCESS.md](VALIDATION_PROCESS.md)) et si elle satisfait [QUALITY_RULES.md](QUALITY_RULES.md).

## Interdits éditoriaux
Inventer un prix/une norme non sourcée · dupliquer une carte · jargon d'ingénierie à l'écran ·
modifier une carte validée en place · supprimer du contenu métier.

## Changelog
- 1.0 (2026-08-02) — Guide initial.
