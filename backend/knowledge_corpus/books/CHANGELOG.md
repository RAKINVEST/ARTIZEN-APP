# CHANGELOG — Book System

> **Version** 1.0 — **Status** Living — **Owner** Éditorial / Contenu métier — **Last Update** 2026-08-02
> **Depends On:** [README.md](README.md) — **Used By:** gouvernance

## Objective
Journal des évolutions du **système des Livres** (structure/gouvernance) — pas des Livres eux-mêmes.

## Historique
### 1.0 — 2026-08-02
- Création de `docs/knowledge/books/` — 11 documents : système & invariants, modèle de Livre,
  gouvernance, index officiel (62 Livres / 6 collections, miroir taxonomie), versionnement,
  dépendances, navigation uniforme, relations (dont thème PAC), releases, changelog.
- Principe : Livre = **curation par références** (projection), aligné taxonomie gelée, **zéro
  duplication** ; toute évolution structurelle = ADR. 4 diagrammes Mermaid.

## Politique d'évolution (résumé)
- **Ajouter une profession** → via `catalog/trades` (taxonomie gelée) + ADR, **puis** un Livre.
- **Créer / fusionner / scinder / archiver un Livre** → **ADR** + plan de migration (redirection).
- Aucune suppression de Livre (archivage).

## Changelog
- 1.0 (2026-08-02) — Entrée initiale.
