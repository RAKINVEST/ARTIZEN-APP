# Phrase — normes & réglementation clôture

> **Brouillon (v0) — proposé par IA, en attente de validation métier** (Loi 7/18). Modèle : [../../cards/CARD_TEMPLATE.md](../../cards/CARD_TEMPLATE.md).
> Niveaux de confiance : A normes/fabricant · B technique · C terrain validé · D hypothèse.

## Métadonnées
| Champ | Valeur |
|---|---|
| Identifiant | `normes-reglementation-cloture` |
| Titre | Phrase — normes & réglementation clôture |
| Profession | `metier:cloture` |
| Famille | `famille:specialises` |
| Sous-famille | `sous-famille:cloture` |
| Version | v0.1 |
| Auteur | IA (proposition) |
| Validateur | ⟦à valider métier⟧ |
| Statut | Brouillon |
| Indice de confiance | **C** |

## Formulation (clusters « Normes » / « Réglementation »)
> « Nos clôtures sont posées dans les règles : **limites de propriété** respectées (bornage, Code civil), **règles d'urbanisme** (PLU : hauteur/aspect), scellements béton (**DTU 21**), ouvrages métalliques/portillons (**DTU 37.1**), grillages (**NF EN 10223**) et protection anticorrosion (**NF EN ISO 1461 / 12944**), après **DT-DICT** des réseaux. » `[C]` ⟦versions/exigences exactes à valider par un expert⟧

> **Frontières** : le **mur** de clôture maçonné relève de la **Maçonnerie**, la **haie** du **Paysagisme**, la **grille/portail métallique** de la **Métallerie**, la **motorisation** des **Automatismes de portails** — Livres existants, jamais absorbés. `[C]`

> **Interface** : une **terrasse bois** (activité distincte, non encore construite) et le **retrait d'amiante** (rénovation → Désamiantage) ne sont **jamais réalisés ici**. `[C]`

## Cadre
- **Normes** : béton de scellement des poteaux (**interface**) **DTU 21** ; ouvrages métalliques / portillons (**interface** métallerie) **DTU 37.1** ; grillages **NF EN 10223**, protection anticorrosion **NF EN ISO 1461 / NF EN ISO 12944**, règles d'**urbanisme** (PLU : hauteur/aspect), **bornage** (Code civil, géomètre) et **DT-DICT** (réseaux) ⟦en prose, à confirmer⟧ `[B]` ⟦référence exacte à confirmer⟧. `respecte-norme`
- **Relations** : `cite-carte` → [implanter-relever-limites](../../professions/cloture/cards/implanter-relever-limites.md).
- **Tags** : `metier:cloture famille:specialises type:phrase usage:normes cluster:normes cluster:reglementation relation:maconnerie relation:paysagisme relation:serrurerie-metallerie relation:automatismes-portails relation:terrasse-bois relation:desamiantage`

## Historique
| Version | Date | Auteur | Validateur | Motif |
|---|---|---|---|---|
| v0.1 | 2026-08-05 | IA | ⟦—⟧ | proposition initiale (Brouillon) |
