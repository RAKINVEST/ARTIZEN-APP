# Phrase — normes & réglementation peinture

> **Brouillon (v0) — proposé par IA, en attente de validation métier** (Loi 7/18). Modèle : [../../cards/CARD_TEMPLATE.md](../../cards/CARD_TEMPLATE.md).
> Niveaux de confiance : A normes/fabricant · B technique · C terrain validé · D hypothèse.

## Métadonnées
| Champ | Valeur |
|---|---|
| Identifiant | `normes-reglementation-peinture` |
| Titre | Phrase — normes & réglementation peinture |
| Profession | `metier:peinture` |
| Famille | `famille:finition` |
| Sous-famille | `sous-famille:peinture` |
| Version | v0.1 |
| Auteur | IA (proposition) |
| Validateur | ⟦à valider métier⟧ |
| Statut | Brouillon |
| Indice de confiance | **C** |

## Formulation (clusters « Normes » / « Réglementation »)
> « Nos travaux de peinture respectent les règles de l'art : travaux de peinture des bâtiments (**DTU 59.1**), avec dépose/protection des appareillages électriques (**NF C 15-100**) et des produits à **faible teneur en COV** (**directive 2004/42/CE**, étiquetage émissions). » `[C]` ⟦versions/exigences exactes à valider par un expert⟧

> **Rénovation / plomb** : sur un bâti ancien, le **diagnostic plomb (CREP) avant travaux** s'impose ; en présence de plomb, **pas de ponçage à sec** et **arrêt** — le traitement relève d'une **activité spécialisée** (jamais réalisé en peinture). `[C]`

> **Frontières** : la peinture suit la **Plâtrerie** (support) et voisine les **Revêtements de sol**, le **Carrelage**, la **Menuiserie intérieure** et l'**Agencement** (activités distinctes, futurs Livres) ; l'**Électricité** (appareillages) est un Livre existant. `[C]`

## Cadre
- **Normes** : travaux de peinture des bâtiments **DTU 59.1** ; électricité (dépose/protection des appareillages) **NF C 15-100** ; teneur en **COV** (**directive 2004/42/CE**, étiquetage émissions A+/A/B/C), diagnostic **plomb (CREP)** avant travaux (Code de la santé) et prévention (**INRS**) ⟦en prose, à confirmer⟧ `[B]` ⟦référence exacte à confirmer⟧. `respecte-norme`
- **Relations** : `cite-carte` → [realiser-bandes-jointoiement](../../professions/platrerie/cards/realiser-bandes-jointoiement.md).
- **Tags** : `metier:peinture famille:finition type:phrase usage:normes cluster:normes cluster:reglementation relation:platrerie relation:electricite-generale relation:revetements-sol relation:carrelage relation:menuiserie-interieure`

## Historique
| Version | Date | Auteur | Validateur | Motif |
|---|---|---|---|---|
| v0.1 | 2026-08-05 | IA | ⟦—⟧ | proposition initiale (Brouillon) |
