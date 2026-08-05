# Knowledge Production Factory

> Chaîne d'outils **éditoriale** pour produire, contrôler, mesurer, importer et
> versionner le patrimoine de connaissances (`backend/knowledge_corpus/`).
> **Outils uniquement** : la Factory *lit* le corpus, elle ne modifie jamais un
> contenu existant, ne publie jamais automatiquement, et ne fait partie d'aucun
> moteur runtime. Le Knowledge Engine (`app/knowledge`) reste la source de vérité
> read-side de l'application. Package : `backend/app/knowledge_factory/`.

## CLI

```bash
python -m app.knowledge_factory.cli <commande> [options]
```

| Commande | Rôle | Écrit ? |
|---|---|---|
| `validate [--json]` | Contrôle qualité de tout le corpus (sortie 1 si bloquants) | non |
| `duplicates` | Doublons d'identifiant et de titre | non |
| `report [--json]` | Rapport qualité (texte ou JSON) | non |
| `metrics [--today AAAA-MM-JJ]` | Métriques du patrimoine (JSON) | non |
| `dashboard [--out fichier.html]` | Tableau de bord éditorial (HTML autonome) | HTML |
| `generate --slug --title --profession [--out]` | Brouillon vierge conforme au modèle | option. |
| `import --input fichier [--out dossier]` | Import massif → **brouillons** | drafts |
| `release --file --from --to --actor [--date] [--write]` | Transition de cycle de vie (append-only) | option. |

## Contrôles qualité (le *gate* de publication — Phase 3)

Une carte est **refusée** à la publication si elle est : sans source · sans
taxonomie (métier) · sans relations · sans indice de confiance · en doublon · avec
un lien cassé · avec un champ/section obligatoire manquant. Seuls les problèmes de
sévérité `error` bloquent ; `warning`/`info` sont signalés sans bloquer (un
Brouillon peut contenir des `⟦…⟧` à compléter).

## Import massif (Phase 2)

Formats natifs : Markdown, CSV, JSON, HTML, texte. Optionnels (si la librairie est
installée) : PDF (`pypdf`), DOCX (`python-docx`), Excel (`openpyxl`) — sinon un
message clair, jamais d'échec. **Toute importation reste Brouillon.**

## Métriques (Phase 5)

Couverture métier · complétude · fraîcheur/obsolescence · qualité (taux de cartes
passant le gate) · densité de relations · orphelins · répartition de validation ·
duplication. **Aucune métrique ne modifie les données** ; la fraîcheur prend une
date de référence explicite (déterminisme).

## Cycle de vie (Phase 6)

`Brouillon → Relecture → Validation → Publication → Archivage`, **forward-only** et
**append-only** (chaque transition ajoute une ligne d'historique, n'en réécrit
jamais). La publication est **gatée** : refusée tant qu'il reste un problème
bloquant. Le champ `Statut` du corpus (Brouillon/Validé/Archivé) est dérivé de
l'étape.

## Qualité de l'outil

ruff (`F,I`) + mypy (`--follow-imports=silent`) verts ; 20 tests
(`app/tests/test_knowledge_factory.py`). Intégré aux gates CI.
