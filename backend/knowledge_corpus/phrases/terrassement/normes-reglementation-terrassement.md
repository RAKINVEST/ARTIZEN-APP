# Phrase — normes & réglementation terrassement

> **Brouillon (v0) — proposé par IA, en attente de validation métier** (Loi 7/18). Modèle : [../../cards/CARD_TEMPLATE.md](../../cards/CARD_TEMPLATE.md).
> Niveaux de confiance : A normes/fabricant · B technique · C terrain validé · D hypothèse.

## Métadonnées
| Champ | Valeur |
|---|---|
| Identifiant | `normes-reglementation-terrassement` |
| Titre | Phrase — normes & réglementation terrassement |
| Profession | `metier:terrassement` |
| Famille | `famille:gros-oeuvre` |
| Sous-famille | `sous-famille:terrassement` |
| Version | v0.1 |
| Auteur | IA (proposition) |
| Validateur | ⟦à valider métier⟧ |
| Statut | Brouillon |
| Indice de confiance | **C** |

## Formulation (clusters « Normes » / « Réglementation »)
> « Nos terrassements respectent les règles de l'art (**DTU 12** terrassements, **DTU 13.11/13.12** fondations superficielles) et la réglementation **anti-endommagement des réseaux** (**DT/DICT**, guichet unique, **AIPR**), avec un dimensionnement géotechnique selon l'**Eurocode 7 (NF EN 1997)**. » `[C]` ⟦versions/procédures exactes à valider par un expert⟧

> **Sécurité réglementaire** : **blindage** des fouilles (Code du travail), autorisations (**AIPR**), étude géotechnique préalable. `[C]` ⟦à confirmer selon chantier⟧

> **Relations inter-Livres** : le terrassement prépare l'assise de la **Maçonnerie** (fondations) ; il précède/accompagne l'**Assainissement**, la **VRD** et la **Démolition** (futurs Livres Gros Œuvre). `[C]`

## Cadre
- **Normes** : terrassements pour le bâtiment **DTU 12** ; fondations superficielles **DTU 13.11 / 13.12** ; réglementation réseaux (**DICT** / guichet unique, **AIPR**) et géotechnique **Eurocode 7 (NF EN 1997)** ⟦en prose, à confirmer⟧ `[B]` ⟦référence exacte à confirmer⟧. `respecte-norme`
- **Relations** : `cite-carte` → [monter-mur-cloison](../../professions/maconnerie/cards/monter-mur-cloison.md).
- **Tags** : `metier:terrassement famille:gros-oeuvre type:phrase usage:normes cluster:normes cluster:reglementation cluster:dict relation:maconnerie relation:assainissement relation:vrd relation:demolition`

## Historique
| Version | Date | Auteur | Validateur | Motif |
|---|---|---|---|---|
| v0.1 | 2026-08-05 | IA | ⟦—⟧ | proposition initiale (Brouillon) |
