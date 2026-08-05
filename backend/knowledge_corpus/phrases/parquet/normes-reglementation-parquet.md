# Phrase — normes & réglementation parquet

> **Brouillon (v0) — proposé par IA, en attente de validation métier** (Loi 7/18). Modèle : [../../cards/CARD_TEMPLATE.md](../../cards/CARD_TEMPLATE.md).
> Niveaux de confiance : A normes/fabricant · B technique · C terrain validé · D hypothèse.

## Métadonnées
| Champ | Valeur |
|---|---|
| Identifiant | `normes-reglementation-parquet` |
| Titre | Phrase — normes & réglementation parquet |
| Profession | `metier:parquet` |
| Famille | `famille:finition` |
| Sous-famille | `sous-famille:parquet` |
| Version | v0.1 |
| Auteur | IA (proposition) |
| Validateur | ⟦à valider métier⟧ |
| Statut | Brouillon |
| Indice de confiance | **C** |

## Formulation (clusters « Normes » / « Réglementation »)
> « Nos parquets sont posés selon les règles de l'art : parquets à clouer (**DTU 51.1**), parquets collés (**DTU 51.2**), pose flottante des contrecollés (**DTU 51.11**), avec un **contrôle d'humidité** du support et des réservations électriques conformes (**NF C 15-100**, plancher chauffant). » `[C]` ⟦versions/seuils exacts à valider par un expert⟧

> **Rénovation / amiante** : d'anciennes **colles** sous parquet peuvent contenir de l'amiante → **diagnostic avant travaux** ; tout retrait relève d'une **entreprise certifiée** (**Désamiantage**) — le parquet ne fait que le **diagnostic/interface**. `[C]`

> **Frontières** : le **stratifié** relève des **Revêtements de sol** (métier distinct) ; le parquet voisine le **Carrelage** (support/seuils), la **Menuiserie intérieure** et l'**Agencement** (futurs Livres) ; **plancher chauffant** → **Chauffage**, réservations → **Électricité** (Livres existants). `[C]`

## Cadre
- **Normes** : pose des parquets à clouer **DTU 51.1** ; parquets collés **DTU 51.2** ; pose flottante des parquets contrecollés **DTU 51.11** ; électricité (avant percement, plancher chauffant) **NF C 15-100** ; taux d'humidité du support et diagnostic **amiante** (colles anciennes) ⟦en prose, à confirmer⟧ `[B]` ⟦référence exacte à confirmer⟧. `respecte-norme`
- **Relations** : `cite-carte` → [poser-sol-flottant-clipsable](../../professions/revetements-sol/cards/poser-sol-flottant-clipsable.md).
- **Tags** : `metier:parquet famille:finition type:phrase usage:normes cluster:normes cluster:reglementation relation:revetements-sol relation:carrelage relation:chauffage relation:electricite-generale relation:desamiantage`

## Historique
| Version | Date | Auteur | Validateur | Motif |
|---|---|---|---|---|
| v0.1 | 2026-08-05 | IA | ⟦—⟧ | proposition initiale (Brouillon) |
