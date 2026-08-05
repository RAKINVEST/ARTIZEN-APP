# Book Versioning — Versionnement d'un Livre

> **Version** 1.0 — **Status** Validated — **Owner** Éditorial / Contenu métier — **Last Update** 2026-08-02
> **Depends On:** [../VERSIONING.md](../VERSIONING.md), [../factory/VERSION_POLICY.md](../factory/VERSION_POLICY.md) — **Used By:** responsables de Livre

## Objective
Versionner un Livre **en tant que curation**, sans jamais dupliquer ni détruire (Loi 5).

## Version d'un Livre
- Format `vMAJEUR.MINEUR`. **Majeure** = changement de périmètre/sommaire structurant ;
  **Mineure** = ajout/retrait de références, réorganisation de navigation.
- La version d'un Livre est **indépendante** de celle des cartes qu'il référence (les cartes ont
  leur propre versionnement — [../factory/VERSION_POLICY.md](../factory/VERSION_POLICY.md)).

## Publication
Une version se **publie** via une **release** validée ([BOOK_RELEASES.md](BOOK_RELEASES.md)).

## Dépréciation
Un Livre obsolète est **archivé + `deprecated`** avec motif et **Livre de remplacement** éventuel ;
jamais supprimé (analogue [../factory/DEPRECATION_POLICY.md](../factory/DEPRECATION_POLICY.md)).

## Compatibilité
- Une référence pointe vers un **slug** stable (`book:*`, carte) : elle survit aux versions.
- Retirer une référence d'un Livre **n'affecte pas** la carte (elle reste dans le Corpus).
- Une **rupture de sommaire** (activité scindée/fusionnée) = version **majeure** + **ADR**.

## Migration
- **Scission/fusion** de Livres → plan de migration des références (redirection), **ADR** obligatoire.
- La migration **préserve** l'historique et les relations (aucune perte).

## Changelog
- 1.0 (2026-08-02) — Politique initiale.
