# Room Types — Pièces

> **Version** 1.0 — **Status** Validated (éditorial) — **Owner** Éditorial / Contenu métier — **Last Update** 2026-08-02
> **Depends On:** [TAXONOMY.md](TAXONOMY.md) — **Used By:** cards, recherche

## Objective
Classer la **pièce/local** d'une intervention. Axe `piece:`. Éditorial (pas d'objet `Room` — facette).
Vocabulaire contrôlé, extensible.

## Vocabulaire officiel (`piece:`)
`cuisine` · `salle-de-bain` · `wc` · `buanderie` · `garage` · `chaufferie` · `local-technique` ·
`combles` · `sous-sol` · `cave` · `sejour` · `chambre` · `couloir` · `terrasse` · `jardin` ·
`toiture` · `facade` · `exterieur`

## Règles
- `piece:` peut être **multi-valué** (ex. réseau traversant plusieurs pièces).
- `toiture`/`facade` sont des **localisations** ici (l'ouvrage), à distinguer de l'activité `facade`.
- Extensible ; synonymes (ex. « SDB » → `salle-de-bain`) → [ALIASES.md](ALIASES.md).

## Décompte
**18 pièces** (extensible).

## Changelog
- 1.0 (2026-08-02) — Classification initiale.
