# Phrase — normes & réglementation démolition

> **Brouillon (v0) — proposé par IA, en attente de validation métier** (Loi 7/18). Modèle : [../../cards/CARD_TEMPLATE.md](../../cards/CARD_TEMPLATE.md).
> Niveaux de confiance : A normes/fabricant · B technique · C terrain validé · D hypothèse.

## Métadonnées
| Champ | Valeur |
|---|---|
| Identifiant | `normes-reglementation-demolition` |
| Titre | Phrase — normes & réglementation démolition |
| Profession | `metier:demolition` |
| Famille | `famille:gros-oeuvre` |
| Sous-famille | `sous-famille:demolition` |
| Version | v0.1 |
| Auteur | IA (proposition) |
| Validateur | ⟦à valider métier⟧ |
| Statut | Brouillon |
| Indice de confiance | **C** |

## Formulation (clusters « Réglementation » / « Normes »)
> « Nos travaux de démolition/curage respectent la réglementation : **diagnostic amiante avant travaux** et **plomb**, **diagnostic PEMD** (produits-équipements-matériaux-déchets) et tri en filières agréées, **Code du travail** (étaiement/protection) ; reprises selon **DTU 20.1** (maçonnerie) et **DTU 21** (béton). » `[C]` ⟦procédures/versions exactes à valider par un expert⟧

> **Interface désamiantage** : la présence d'amiante réserve l'intervention à une **entreprise certifiée** (activité **Désamiantage**, distincte) — la démolition ne fait que le **diagnostic/la réservation**, **jamais la dépose d'amiante**. `[C]`

> **Relations inter-Livres** : la démolition partielle d'un porteur rejoint la **Maçonnerie** (étaiement/reprise), la **consignation** l'**Électricité**, l'évacuation le **Terrassement** ; désamiantage → futur Livre (`relation:desamiantage`). `[C]`

## Cadre
- **Normes** : démolition/reprise d'ouvrages en maçonnerie **DTU 20.1** et en béton **DTU 21** ; diagnostics réglementaires avant travaux (**PEMD** déchets, **amiante**, **plomb/CREP**) et **Code du travail** (étaiement/protection) ⟦en prose, à confirmer⟧ `[B]` ⟦référence exacte à confirmer⟧. `respecte-norme`
- **Relations** : `cite-carte` → [realiser-ouverture-linteau](../../professions/maconnerie/cards/realiser-ouverture-linteau.md).
- **Tags** : `metier:demolition famille:gros-oeuvre type:phrase usage:normes cluster:reglementation cluster:normes relation:maconnerie relation:electricite-generale relation:terrassement relation:desamiantage`

## Historique
| Version | Date | Auteur | Validateur | Motif |
|---|---|---|---|---|
| v0.1 | 2026-08-05 | IA | ⟦—⟧ | proposition initiale (Brouillon) |
