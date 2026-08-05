# Knowledge Corpus — Patrimoine métier d'Artizen

> **Version** 1.0 — **Status** Validated — **Owner** Éditorial / Contenu métier — **Last Update** 2026-08-02
> **Depends On:** [../blueprint/engines/knowledge/README.md](../blueprint/engines/knowledge/README.md) — **Used By:** contributeurs métier, IA (lecture)

## Objective
Fonder le **Knowledge Corpus** : la bibliothèque éditoriale du savoir métier d'Artizen, conçue pour
accueillir **plusieurs dizaines de milliers** de connaissances sans perdre sa cohérence. Cette
fondation construit **le contenant avant le contenu** : structure, conventions, gouvernance,
relations et mécanismes d'évolution. **Aucune connaissance n'est encore rédigée massivement.**

## Ce que le Corpus EST / N'EST PAS
- **EST** : une bibliothèque documentaire (Markdown) éditoriale, versionnée, gouvernée.
- **N'EST PAS** : du code, une base de données, une nouvelle architecture, un nouveau moteur.
- Le Corpus **alimente** l'objet `Knowledge` à l'exécution ; il n'en est pas une redéfinition.

## Conformité au Blueprint (gelé)
Le Corpus respecte la spécification gelée du **Knowledge Engine**
([../blueprint/engines/knowledge/](../blueprint/engines/knowledge/README.md)) :
- La **Knowledge Card = l'objet `Knowledge` existant** — **aucun nouvel objet métier**.
- Cycle **Brouillon → Validé → Archivé** ; **append-only** (Loi 5) ; **validation humaine** (Loi 7/18).
- Les concepts **sans objet du domaine** (diagnostic, checklist, procédure, matériau, outil, norme,
  faq, expérience) sont du **contenu éditorial / des facettes**, pas des objets persistés. En créer
  un exigerait un **ADR** (voir [RELATIONSHIP_RULES.md](RELATIONSHIP_RULES.md)).
- Les **métiers** référencent la taxonomie officielle gelée (`catalog/trades/taxonomy.py` /
  [../TAXONOMIE-METIERS.md](../TAXONOMIE-METIERS.md)) — **pas de taxonomie concurrente**.

## Documents de fondation
| Document | Rôle |
|---|---|
| [INDEX.md](INDEX.md) | carte du corpus (dossiers + gouvernance) |
| [EDITORIAL_GUIDE.md](EDITORIAL_GUIDE.md) | comment écrire, nommer, éviter les doublons |
| [GOVERNANCE.md](GOVERNANCE.md) | rôles : créer/modifier/valider/archiver/publier |
| [QUALITY_RULES.md](QUALITY_RULES.md) | critères de validation d'une carte |
| [LIFECYCLE.md](LIFECYCLE.md) | cycle de vie d'une carte |
| [VERSIONING.md](VERSIONING.md) | versionnement + préservation de l'historique |
| [CONTRIBUTING.md](CONTRIBUTING.md) | flux de contribution |
| [SEARCH_STRATEGY.md](SEARCH_STRATEGY.md) | recherche & projections |
| [TAGGING.md](TAGGING.md) | taxonomie de tags |
| [RELATIONSHIP_RULES.md](RELATIONSHIP_RULES.md) | relations entre objets |
| [VALIDATION_PROCESS.md](VALIDATION_PROCESS.md) | processus de validation humaine |
| [CHANGELOG.md](CHANGELOG.md) | journal du corpus |

## Taxonomie (colonne vertébrale)
[taxonomy/](taxonomy/README.md) — taxonomie métier unifiée : **miroir** des 6 familles / 62 activités
gelées (`catalog/trades`) + axes éditoriaux (interventions, problèmes, matériaux, outils, équipements,
pièces, bâtiments, clients, projets, marque). **Aucune carte ne se crée hors de cette taxonomie.**

## Dossiers de contenu
`professions/` · `cards/` · `kits/` · `phrases/` · `diagnostics/` · `checklists/` · `procedures/` ·
`materials/` · `tools/` · `standards/` · `media/` · `faq/` · `experience/` (chacun avec son README).

## Changelog
- 1.0 (2026-08-02) — Fondation du Knowledge Corpus (structure, sans contenu massif).
