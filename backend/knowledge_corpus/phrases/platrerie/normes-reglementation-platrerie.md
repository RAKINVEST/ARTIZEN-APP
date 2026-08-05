# Phrase — normes & réglementation plâtrerie

> **Brouillon (v0) — proposé par IA, en attente de validation métier** (Loi 7/18). Modèle : [../../cards/CARD_TEMPLATE.md](../../cards/CARD_TEMPLATE.md).
> Niveaux de confiance : A normes/fabricant · B technique · C terrain validé · D hypothèse.

## Métadonnées
| Champ | Valeur |
|---|---|
| Identifiant | `normes-reglementation-platrerie` |
| Titre | Phrase — normes & réglementation plâtrerie |
| Profession | `metier:platrerie` |
| Famille | `famille:finition` |
| Sous-famille | `sous-famille:platrerie` |
| Version | v0.1 |
| Auteur | IA (proposition) |
| Validateur | ⟦à valider métier⟧ |
| Statut | Brouillon |
| Indice de confiance | **C** |

## Formulation (clusters « Normes » / « Réglementation »)
> « Nos ouvrages de plâtrerie respectent les règles de l'art : plaques de plâtre (**DTU 25.41**), doublages/habillages (**DTU 25.42**), plafonds suspendus (**DTU 58.1**), avec des réservations électriques conformes (**NF C 15-100**). » `[C]` ⟦versions/exigences exactes à valider par un expert⟧

> **Rénovation / amiante** : sur un bâti ancien, le **diagnostic amiante avant travaux** est **obligatoire** ; tout retrait relève d'une **entreprise certifiée** (**Désamiantage**, activité distincte) — la plâtrerie ne fait que le **diagnostic/interface**. `[C]`

> **Frontières** : la plâtrerie précède la **Peinture** et voisine la **Menuiserie intérieure**, le **Carrelage** et l'**Agencement** (activités distinctes, futurs Livres) ; l'**Isolation** (thermique) et l'**Électricité** (réservations/raccordement) sont des Livres existants. `[C]`

## Cadre
- **Normes** : ouvrages en plaques de plâtre **DTU 25.41** ; doublages / habillages **DTU 25.42** ; plafonds suspendus **DTU 58.1** ; électricité (perc ements / boîtes) **NF C 15-100** ; en rénovation, diagnostic **amiante** avant travaux (Code de la santé) ⟦en prose, à confirmer⟧ `[B]` ⟦référence exacte à confirmer⟧. `respecte-norme`
- **Relations** : `cite-carte` → [isoler-murs-interieur](../../professions/isolation/cards/isoler-murs-interieur.md).
- **Tags** : `metier:platrerie famille:finition type:phrase usage:normes cluster:normes cluster:reglementation relation:isolation relation:electricite-generale relation:peinture relation:carrelage relation:menuiserie-interieure relation:desamiantage`

## Historique
| Version | Date | Auteur | Validateur | Motif |
|---|---|---|---|---|
| v0.1 | 2026-08-05 | IA | ⟦—⟧ | proposition initiale (Brouillon) |
