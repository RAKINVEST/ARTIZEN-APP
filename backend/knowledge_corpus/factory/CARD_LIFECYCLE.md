# Card Lifecycle — Cycle de vie en production

> **Version** 1.0 — **Status** Validated — **Owner** Éditorial / Contenu métier — **Last Update** 2026-08-02
> **Depends On:** [../LIFECYCLE.md](../LIFECYCLE.md), [EDITORIAL_WORKFLOW.md](EDITORIAL_WORKFLOW.md) — **Used By:** tous les acteurs

## Objective
Opérationnaliser le cycle de vie **gelé** ([../LIFECYCLE.md](../LIFECYCLE.md)) en **postes de production**.
Les états restent **Brouillon → Validé → Archivé** (append-only) — non redéfinis.

## États × postes
| État (gelé) | Postes de production | Sortie |
|---|---|---|
| **Brouillon** | Cadrage · Rédaction · Enrichissement · Contrôle · Relecture | prête à valider |
| **Validé** | Validation · Publication | publiée (selon `Visibility`) |
| **(évolution)** | Amélioration → nouvelle version en Brouillon | re-entre dans la chaîne |
| **Archivé** | Archivage | historisée (lecture seule) |

## Règles (héritées, append-only)
- Un **Brouillon** peut être abandonné sans impacter le contenu validé.
- Une carte **validée** évolue par **nouvelle version** ; l'ancienne est **archivée**, jamais détruite (Loi 5).
- Le **slug** est stable sur toute la vie de la carte (références/relations préservées).

## Traçabilité
Chaque changement d'état est **historisé** (date, acteur, motif) — [VERSION_POLICY.md](VERSION_POLICY.md).

## Changelog
- 1.0 (2026-08-02) — Cycle de vie en production initial.
