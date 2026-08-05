# Phrase — normes & réglementation automatismes de portails

> **Brouillon (v0) — proposé par IA, en attente de validation métier** (Loi 7/18). Modèle : [../../cards/CARD_TEMPLATE.md](../../cards/CARD_TEMPLATE.md).
> Niveaux de confiance : A normes/fabricant · B technique · C terrain validé · D hypothèse.

## Métadonnées
| Champ | Valeur |
|---|---|
| Identifiant | `normes-reglementation-automatismes-portails` |
| Titre | Phrase — normes & réglementation automatismes de portails |
| Profession | `metier:automatismes-portails` |
| Famille | `famille:specialises` |
| Sous-famille | `sous-famille:automatismes` |
| Version | v0.1 |
| Auteur | IA (proposition) |
| Validateur | ⟦à valider métier⟧ |
| Statut | Brouillon |
| Indice de confiance | **C** |

## Formulation (clusters « Normes » / « Réglementation »)
> « Nos automatismes de portail sont posés dans les règles : un portail motorisé est une **machine** (Directive Machines, **marquage CE**, **NF EN 12453 / NF EN 12445 / NF EN 13241**) — cellules, bords sensibles et **limitation d'effort** installés, avec **essais et mesure d'effort** après intervention ; l'alimentation électrique est conforme **NF C 15-100**. » `[C]` ⟦versions/exigences exactes à valider par un expert⟧

> **Frontières** : la **structure** du portail relève de la **Serrurerie / Métallerie** ; le **clavier / badge** du **Contrôle d'accès** ; l'**interphone / visiophone** de l'**Interphonie** ; les **gaines** du **Terrassement** — Livres existants, jamais absorbés. `[C]`

> **Interfaces réservées** : tout **raccordement électrique** relève de l'**Électricité** ; le **retrait d'amiante** (→ Désamiantage) n'est **jamais réalisé ici**. `[C]`

## Cadre
- **Normes** : sécurité des portes/portails motorisés — **Directive Machines**, **marquage CE**, cellules / bords sensibles / limitation d'effort — **NF EN 12453 / NF EN 12445 / NF EN 13241** ; alimentation électrique (**interface**) **NF C 15-100** ; structure du portail (**interface** métallerie) **DTU 37.1** ⟦EN 12453/12445 et versions exactes en prose, à confirmer⟧ `[B]` ⟦référence exacte à confirmer⟧. `respecte-norme`
- **Relations** : `cite-carte` → [poser-portail-grille-metallique](../../professions/serrurerie-metallerie/cards/poser-portail-grille-metallique.md).
- **Tags** : `metier:automatismes-portails famille:specialises type:phrase usage:normes cluster:normes cluster:reglementation relation:serrurerie-metallerie relation:controle-acces relation:interphonie relation:terrassement relation:electricite-generale relation:desamiantage`

## Historique
| Version | Date | Auteur | Validateur | Motif |
|---|---|---|---|---|
| v0.1 | 2026-08-05 | IA | ⟦—⟧ | proposition initiale (Brouillon) |
