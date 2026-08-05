# Phrase — normes & réglementation menuiserie intérieure

> **Brouillon (v0) — proposé par IA, en attente de validation métier** (Loi 7/18). Modèle : [../../cards/CARD_TEMPLATE.md](../../cards/CARD_TEMPLATE.md).
> Niveaux de confiance : A normes/fabricant · B technique · C terrain validé · D hypothèse.

## Métadonnées
| Champ | Valeur |
|---|---|
| Identifiant | `normes-reglementation-menuiserie-int` |
| Titre | Phrase — normes & réglementation menuiserie intérieure |
| Profession | `metier:menuiserie-interieure` |
| Famille | `famille:finition` |
| Sous-famille | `sous-famille:menuiserie-interieure` |
| Version | v0.1 |
| Auteur | IA (proposition) |
| Validateur | ⟦à valider métier⟧ |
| Statut | Brouillon |
| Indice de confiance | **C** |

## Formulation (clusters « Normes » / « Réglementation »)
> « Nos ouvrages de menuiserie intérieure respectent les règles de l'art : menuiseries intérieures en bois (**DTU 36.2**, **DTU 36.1**), les **largeurs de passage** (accessibilité) et des perçages conformes (**NF C 15-100**, repérage des réseaux). » `[C]` ⟦versions/exigences exactes à valider par un expert⟧

> **Rénovation / amiante** : sur des ouvrages/panneaux anciens, un **diagnostic amiante avant travaux** peut s'imposer ; tout retrait relève d'une **entreprise certifiée** (**Désamiantage**) — la menuiserie ne fait que le **diagnostic/interface**. `[C]`

> **Frontières** : la menuiserie intérieure fournit des ouvrages que la **Peinture** finit (boiseries) ; elle voisine le **Parquet** et les **Revêtements de sol** (seuils/plinthes), la **Cuisine** et l'**Agencement** (activités distinctes, futurs Livres) ; les perçages relèvent de l'**Électricité** (Livre existant). `[C]`

## Cadre
- **Normes** : menuiseries intérieures en bois **DTU 36.2** ; menuiserie bois **DTU 36.1** ; électricité (avant perçage, à proximité des réseaux) **NF C 15-100** ; accessibilité (largeurs de passage) et diagnostic **amiante** (ouvrages anciens) ⟦en prose, à confirmer⟧ `[B]` ⟦référence exacte à confirmer⟧. `respecte-norme`
- **Relations** : `cite-carte` → [peindre-boiseries-laques](../../professions/peinture/cards/peindre-boiseries-laques.md).
- **Tags** : `metier:menuiserie-interieure famille:finition type:phrase usage:normes cluster:normes cluster:reglementation relation:peinture relation:parquet relation:electricite-generale relation:cuisine relation:agencement relation:desamiantage`

## Historique
| Version | Date | Auteur | Validateur | Motif |
|---|---|---|---|---|
| v0.1 | 2026-08-05 | IA | ⟦—⟧ | proposition initiale (Brouillon) |
