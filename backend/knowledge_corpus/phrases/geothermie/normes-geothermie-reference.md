# Phrase — références normatives géothermie

> **Brouillon (v0) — proposé par IA, en attente de validation métier** (Loi 7/18). Modèle : [../../cards/CARD_TEMPLATE.md](../../cards/CARD_TEMPLATE.md).
> Niveaux de confiance : A normes/fabricant · B technique · C terrain validé · D hypothèse.

## Métadonnées
| Champ | Valeur |
|---|---|
| Identifiant | `normes-geothermie-reference` |
| Titre | Phrase — références normatives géothermie |
| Profession | `metier:geothermie` |
| Famille | `famille:fluides` |
| Sous-famille | `sous-famille:captage` |
| Version | v0.1 |
| Auteur | IA (proposition) |
| Validateur | ⟦à valider métier⟧ |
| Statut | Brouillon |
| Indice de confiance | **C** |

## Formulation (cluster « Normes / Réglementation »)
> « Nos installations géothermiques respectent les règles de l'art et la réglementation **géothermie de minime importance (GMI)** ; le dimensionnement suit la **NF EN 15450** et l'installation électrique la **NF C 15-100**. Forage et circuit frigorifère sont réalisés par des intervenants **qualifiés**. » `[C]` ⟦versions/cadre exacts à valider par un expert⟧

> **Relations inter-Livres** : la **PAC** géothermique est un équipement (⟦equipement:pac⟧, ADR-0024) ; l'émission relève du **Chauffage** ; l'alimentation du **Livre Électricité**. `[C]`

## Cadre
- **Normes** : installation électrique **NF C 15-100** ; réglementation **géothermie de minime importance (GMI)** ; dimensionnement **NF EN 15450** `[B]` ⟦référence exacte à confirmer⟧. `respecte-norme`
- **Relations** : `cite-carte` → [controler-pac-geothermique](../../professions/pac/cards/controler-pac-geothermique.md).
- **Tags** : `metier:geothermie equipement:pac famille:fluides type:phrase usage:normes cluster:normes cluster:reglementation relation:pac relation:chauffage relation:electricite`

## Historique
| Version | Date | Auteur | Validateur | Motif |
|---|---|---|---|---|
| v0.1 | 2026-08-04 | IA | ⟦—⟧ | proposition initiale (Brouillon) |
