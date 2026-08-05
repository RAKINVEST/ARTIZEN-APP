# CHANGELOG — Decision Engine

> **Version** 1.0 — **Status** Living — **Owner** Decision — **Last Update** 2026-08-02
> **Depends On:** [README.md](README.md) — **Used By:** gouvernance — **Niveau:** 2 · Architecture

## Objective
Journal des évolutions de la **spécification** du Decision Engine.

## Historique
### 1.0 — 2026-08-02
- Création de `docs/blueprint/engines/decision/` — 16 documents : moteur & frontières, domaine +
  taxonomie des intentions, objets (read-side, artefacts transitoires), graphe, pipeline (10 étapes),
  règles & priorités, événements, contrats documentaires, contexte, scoring, apprentissage,
  explicabilité, intégrations, stratégie de test.
- **Approfondissement** d'un moteur **read-side déjà nommé** dans le Domain Model gelé (Decision).
  Aucun document figé modifié ; aucun objet/moteur créé ; aucun code. 4 diagrammes Mermaid.
- Invariant central : **propose, explique, attend la validation ; n'écrit/ne persiste/n'invente rien** ;
  l'écriture reste un geste explicite exécuté par le moteur propriétaire (Loi 7/18, invariant IA, ADR-023).

## Changelog
- 1.0 (2026-08-02) — Entrée initiale.
