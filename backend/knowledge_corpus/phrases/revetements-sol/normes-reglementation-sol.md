# Phrase — normes & réglementation revêtements de sol

> **Brouillon (v0) — proposé par IA, en attente de validation métier** (Loi 7/18). Modèle : [../../cards/CARD_TEMPLATE.md](../../cards/CARD_TEMPLATE.md).
> Niveaux de confiance : A normes/fabricant · B technique · C terrain validé · D hypothèse.

## Métadonnées
| Champ | Valeur |
|---|---|
| Identifiant | `normes-reglementation-sol` |
| Titre | Phrase — normes & réglementation revêtements de sol |
| Profession | `metier:revetements-sol` |
| Famille | `famille:finition` |
| Sous-famille | `sous-famille:revetements-sol` |
| Version | v0.1 |
| Auteur | IA (proposition) |
| Validateur | ⟦à valider métier⟧ |
| Statut | Brouillon |
| Indice de confiance | **C** |

## Formulation (clusters « Normes » / « Réglementation »)
> « Nos revêtements de sol respectent les règles de l'art : PVC collés (**DTU 53.2**), textiles/moquettes (**DTU 53.1**), pose flottante des stratifiés (**DTU 51.11**), un classement **UPEC** adapté au local et des produits à **faible COV** ; réservations électriques conformes (**NF C 15-100**, sols techniques). » `[C]` ⟦versions/classements exacts à valider par un expert⟧

> **Rénovation / amiante** : anciennes **dalles vinyle-amiante** / **colles** → **diagnostic avant travaux** ; tout retrait relève d'une **entreprise certifiée** (**Désamiantage**) — la pose de sol ne fait que le **diagnostic/interface**. `[C]`

> **Frontières** : hors **Parquet** massif (métier distinct) ; voisine le **Carrelage** (préparation/ragréage), la **Menuiserie intérieure** et l'**Agencement** (futurs Livres) ; sols techniques → **Électricité** (Livre existant). `[C]`

## Cadre
- **Normes** : revêtements de sol PVC collés **DTU 53.2** ; revêtements textiles / moquettes **DTU 53.1** ; pose flottante des sols stratifiés **DTU 51.11** (interface) ; électricité (avant découpe/percement, sols techniques) **NF C 15-100** ; classement **UPEC**, étiquetage **COV** et diagnostic **amiante** (anciennes dalles/colles) ⟦en prose, à confirmer⟧ `[B]` ⟦référence exacte à confirmer⟧. `respecte-norme`
- **Relations** : `cite-carte` → [preparer-support-ragreage](../../professions/carrelage/cards/preparer-support-ragreage.md).
- **Tags** : `metier:revetements-sol famille:finition type:phrase usage:normes cluster:normes cluster:reglementation relation:carrelage relation:electricite-generale relation:parquet relation:menuiserie-interieure relation:desamiantage`

## Historique
| Version | Date | Auteur | Validateur | Motif |
|---|---|---|---|---|
| v0.1 | 2026-08-05 | IA | ⟦—⟧ | proposition initiale (Brouillon) |
