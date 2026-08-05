# Families — Les 6 familles (miroir gelé)

> **Version** 1.0 — **Status** Validated (miroir) — **Owner** Catalog/Taxonomie — **Last Update** 2026-08-02
> **Depends On:** [../../TAXONOMIE-METIERS.md](../../TAXONOMIE-METIERS.md) — **Used By:** PROFESSIONS, filtres, moteurs

## Objective
Refléter les **6 familles gelées**. **Source de vérité :** `catalog/trades/taxonomy.py`. Ce document
ne fait pas autorité (miroir) ; toute divergence se résout vers le code.

## Les 6 familles
| Slug (`famille:`) | Libellé |
|---|---|
| `fluides` | Fluides & génie climatique |
| `electricite` | Électricité & courants faibles |
| `finition` | Finition intérieure (second œuvre) |
| `enveloppe` | Enveloppe du bâtiment |
| `gros-oeuvre` | Gros œuvre & travaux publics |
| `specialises` | Métiers spécialisés & services techniques |

## Règles (héritées de la taxonomie gelée)
- **Slugs gelés** : jamais renommés (Loi de gel de la taxonomie).
- Une famille regroupe des **activités** ([PROFESSIONS.md](PROFESSIONS.md)) et des **qualifications d'exercice**.
- Les **énergies renouvelables ne sont pas une famille** (le PV *est* de l'électricité ; solaire
  thermique/géothermie *sont* des fluides) — c'est une **qualification/certification**.
- Ajouter/renommer une famille = **hors de ce dossier** : cela passe par la taxonomie gelée (et un ADR).

## Changelog
- 1.0 (2026-08-02) — Miroir initial des 6 familles.
