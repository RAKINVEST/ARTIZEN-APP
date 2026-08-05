# <Livre — Activité> — Modèle officiel de Livre

> **Modèle** — copier pour créer un Livre. Un Livre **référence**, ne duplique jamais.
> **Version** 1.0 — **Status** Validated (modèle) — **Owner** <responsable> — **Last Update** 2026-08-02
> **Depends On:** [BOOK_SYSTEM.md](BOOK_SYSTEM.md) — **Used By:** lecteurs, IA

## Identité (métadonnées)
| Champ | Valeur |
|---|---|
| Numéro (ordre de lecture) | `Livre N` |
| Identifiant (stable) | `book:<activite-slug>` |
| Titre | `<Libellé de l'activité>` |
| Collection (famille) | `famille:<slug>` |
| Activité (taxonomie gelée) | `activite:<slug>` |
| Propriétaire | `<équipe>` |
| Responsable éditorial | `<nom>` |
| Version | `v1.0` |
| Statut | `Brouillon` \| `Publié` \| `Déprécié` |

## Périmètre
- **Couvre** : l'activité `activite:<slug>` (et ses **sous-familles** éditoriales pertinentes).
- **Ne couvre pas** : ce qui relève d'autres activités → **relations** ([BOOK_RELATIONSHIPS.md](BOOK_RELATIONSHIPS.md)).

## Sommaire par références (aucune duplication)
> Chaque section est une **requête de sélection** par tags de taxonomie, pas une copie de contenu.
- **Familles / sous-familles** : `sous-famille:*` de l'activité.
- **Interventions** : `intervention:*` présentes.
- **Knowledge Cards** : `activite:<slug>` (objet `Knowledge`).
- **Kits** : références → objet `Kit`.
- **Phrases** : références → objet `Phrase`.
- **Diagnostics** · **Check-lists** · **Procédures** · **Normes** · **FAQ** · **Retours d'expérience** : références éditoriales.

## Navigation
Voir [BOOK_NAVIGATION.md](BOOK_NAVIGATION.md) (schéma uniforme).

## Livres liés
`book:<autre-activite>` via [BOOK_RELATIONSHIPS.md](BOOK_RELATIONSHIPS.md) (référence, jamais copie).

## Historique
| Version | Date | Responsable | Validateur | Motif |
|---|---|---|---|---|
| v1.0 | 2026-… | … | … | création |

## Changelog
- 1.0 (2026-08-02) — Modèle initial de Livre.
