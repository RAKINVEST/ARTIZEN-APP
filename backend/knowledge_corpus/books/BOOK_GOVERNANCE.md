# Book Governance — Gouvernance d'un Livre

> **Version** 1.0 — **Status** Validated — **Owner** Éditorial / Contenu métier — **Last Update** 2026-08-02
> **Depends On:** [../GOVERNANCE.md](../GOVERNANCE.md), [../factory/VALIDATION_GUIDE.md](../factory/VALIDATION_GUIDE.md) — **Used By:** responsables de Livre

## Objective
Définir qui pilote un Livre et comment il est publié. Hérite de la gouvernance du Corpus
([../GOVERNANCE.md](../GOVERNANCE.md)) — ne la redéfinit pas.

## Rôles
| Rôle | Responsabilité |
|---|---|
| **Propriétaire du Livre** | garant du périmètre (une activité) et de la cohérence |
| **Responsable éditorial** | organise sommaire, relectures, releases |
| **Relecteurs** | contrôle métier des cartes référencées (via Factory) |
| **Validateurs** (experts) | valident les cartes ; approuvent une **release** de Livre |
| **IA** | propose sommaire, détecte doublons/manques ; **ne publie jamais** |

## Version, historique, publication
- Un Livre porte une **version** et un **historique** (append-only) — [BOOK_VERSIONING.md](BOOK_VERSIONING.md).
- **Publication** = une **release** validée par un humain habilité — [BOOK_RELEASES.md](BOOK_RELEASES.md).
- La **suppression** d'un Livre est interdite (archivage) ; toute évolution structurelle = **ADR**.

## Séparation des pouvoirs
Le responsable éditorial **n'auto-valide pas** les cartes ; la validation métier reste aux validateurs.

## Changelog
- 1.0 (2026-08-02) — Gouvernance initiale.
