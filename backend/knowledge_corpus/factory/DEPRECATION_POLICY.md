# Deprecation Policy — Dépréciation

> **Version** 1.0 — **Status** Validated — **Owner** Éditorial / Contenu métier — **Last Update** 2026-08-02
> **Depends On:** [CHANGE_POLICY.md](CHANGE_POLICY.md), [../LIFECYCLE.md](../LIFECYCLE.md) — **Used By:** responsables, validateurs

## Objective
Retirer une carte de l'usage **sans jamais la détruire** (Loi 5).

## Quand déprécier
- Contenu **obsolète** (norme abrogée, méthode dépassée, produit disparu).
- Carte **fusionnée** dans une canonique ([CHANGE_POLICY.md](CHANGE_POLICY.md)).
- **Doublon** confirmé qui devient une **référence**.

## Comment déprécier
1. Passer la carte en **Archivé** (état gelé) + marquer **`deprecated`** avec **motif** et **date**.
2. Renseigner la **carte de remplacement** (si elle existe) : relation `remplacee-par`.
3. **Rediriger** navigation/recherche vers le remplacement ; la carte reste **lisible en historique**.

## Ce qui est interdit
- **Supprimer** une carte (métier = donnée protégée) → exigerait un **ADR**.
- Déprécier **sans motif** ni remplacement identifié quand un remplacement existe.
- Laisser des **relations cassées** : elles pointent vers le remplacement.

## Effet
Une carte dépréciée **n'apparaît plus** dans les résultats actifs (sauf demande explicite d'historique),
mais son **savoir et son historique sont conservés**.

## Changelog
- 1.0 (2026-08-02) — Politique initiale.
