# Change Policy — Corriger, faire évoluer, fusionner

> **Version** 1.0 — **Status** Validated — **Owner** Éditorial / Contenu métier — **Last Update** 2026-08-02
> **Depends On:** [VERSION_POLICY.md](VERSION_POLICY.md), [../VERSIONING.md](../VERSIONING.md) — **Used By:** auteurs, responsables

## Objective
Encadrer l'**évolution** d'une carte validée, dans le respect de l'append-only (Loi 5).

## Corriger une carte
- Une carte validée **ne se modifie pas en place** : on crée une **nouvelle version** (Brouillon) qui
  repasse le workflow, puis remplace l'ancienne (archivée). Voir [VERSION_POLICY.md](VERSION_POLICY.md).

## Créer une nouvelle version
- **Majeure** (méthode/étapes/sécurité/normes) vs **mineure** (précision/forme) — [../VERSIONING.md](../VERSIONING.md).
- Motif obligatoire ; historique conservé (auteur, date, validateur).

## Conserver l'historique
- Toutes les versions validées sont **conservées** ; l'ancienne devient **Archivé**, jamais supprimée.
- Le **slug** ne change pas : les relations pointant vers la carte restent valides.

## Fusionner deux cartes (doublon détecté)
1. Choisir la **carte canonique** (la plus complète/sourcée).
2. **Reporter** le contenu utile de la seconde dans une **nouvelle version** de la canonique.
3. **Déprécier** la seconde et la faire **pointer** vers la canonique ([DEPRECATION_POLICY.md](DEPRECATION_POLICY.md)).
4. **Rediriger** les relations entrantes vers la canonique.
> Aucune suppression : la carte fusionnée est **dépréciée + redirigée**, jamais effacée (Loi 5).

## Interdits
Modifier une carte validée en place · supprimer une version · fusionner en supprimant · casser des relations sans redirection.

## Changelog
- 1.0 (2026-08-02) — Politique initiale.
