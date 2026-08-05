# INDEX — Knowledge Corpus

> **Version** 1.0 — **Status** Validated — **Owner** Éditorial / Contenu métier — **Last Update** 2026-08-02
> **Depends On:** [README.md](README.md) — **Used By:** tout contributeur

## Objective
Porte d'entrée du corpus : où trouver quoi, dans quel ordre lire.

## Ordre de lecture (contributeur)
README → **taxonomy/** → EDITORIAL_GUIDE → CARD_TEMPLATE (cards/) → TAGGING → RELATIONSHIP_RULES →
QUALITY_RULES → VALIDATION_PROCESS → LIFECYCLE → VERSIONING → CONTRIBUTING → GOVERNANCE.

## Colonne vertébrale
- **[taxonomy/](taxonomy/README.md)** — taxonomie métier unifiée (miroir des 6 familles / 62 activités
  gelées + axes éditoriaux). Aucune carte ne se crée hors de cette taxonomie.
- **[factory/](factory/README.md)** — chaîne de production : comment une carte naît, est rédigée,
  relue, validée, versionnée, archivée (workflow, checklist, score, confiance, métriques).
- **[books/](books/README.md)** — système des Livres : organisation à grande échelle (Collection =
  famille, Livre = activité), curation par références, gouvernance, versionnement, releases.

## Dossiers de contenu
| Dossier | Contenu | Objet du domaine associé |
|---|---|---|
| [professions/](professions/README.md) | arborescence par métier (miroir de la taxonomie officielle) | taxonomie `catalog/trades` |
| [cards/](cards/README.md) | Knowledge Cards + **modèle officiel** | `Knowledge` |
| [kits/](kits/README.md) | kits conseillés (contenu éditorial) | `Kit` |
| [phrases/](phrases/README.md) | textes réutilisables | `Phrase` |
| [diagnostics/](diagnostics/README.md) | diagnostics types (éditorial) | — (facette) |
| [checklists/](checklists/README.md) | listes de contrôle (éditorial) | — (facette) |
| [procedures/](procedures/README.md) | procédures/étapes (éditorial) | — (facette) |
| [materials/](materials/README.md) | matériaux (éditorial) | — (facette) |
| [tools/](tools/README.md) | outillage (éditorial) | — (facette) |
| [standards/](standards/README.md) | normes/références (éditorial) | — (facette) |
| [media/](media/README.md) | photos/vidéos (références) | `Photo` / `Media` |
| [faq/](faq/README.md) | questions fréquentes (éditorial) | — (facette) |
| [experience/](experience/README.md) | retours terrain (éditorial) | — (facette, entrée `Knowledge`) |

## Gouvernance & conventions
Voir [README.md](README.md) § Documents de fondation.

## Source de vérité
- **Structure runtime** : objet `Knowledge` (Blueprint gelé).
- **Métiers** : [../TAXONOMIE-METIERS.md](../TAXONOMIE-METIERS.md).
- **Contenu éditorial** : ce corpus.

## Changelog
- 1.0 (2026-08-02) — Index initial.
