# Kit traitement de l'eau

> **Brouillon (v0) — proposé par IA, en attente de validation métier** (Loi 7/18). Modèle : [../../cards/CARD_TEMPLATE.md](../../cards/CARD_TEMPLATE.md).
> Niveaux de confiance : A normes/fabricant · B technique · C terrain validé · D hypothèse.

## Métadonnées
| Champ | Valeur |
|---|---|
| Identifiant | `kit-traitement-eau` |
| Titre | Kit traitement de l'eau |
| Profession | `metier:traitement-eau` |
| Famille | `famille:fluides` |
| Sous-famille | `sous-famille:traitement-eau` |
| Version | v0.1 |
| Auteur | IA (proposition) |
| Validateur | ⟦à valider métier⟧ |
| Statut | Brouillon |
| Indice de confiance | **C** |

## Composition conseillée
- **Testeur de dureté (TH)**, kit d'**analyse** (bandelettes/flacons labo), manomètre. `[C]`
- Cartouches (sédiments/charbon), sel, **produit de désinfection** ; clé de filtre. `[C]`
- **Clapet anti-retour/disconnecteur** ; réducteur de pression. `[C]`
- **EPI** (gants/lunettes pour produits) ; matériaux **ACS**. `[A]`

## Cadre
- **Normes** : installation sur réseau sanitaire **DTU 60.1** ; alimentation électrique des systèmes (UV) **NF C 15-100** ; protection contre les **retours d'eau** (**NF EN 1717**), qualité de l'eau (**arrêté du 11 janvier 2007**, Code de la santé), matériaux **ACS** ⟦en prose, à confirmer⟧ `[B]` ⟦référence exacte à confirmer⟧. `respecte-norme`
- **Relations** : `utilise-kit` → [entretenir-controler-traitement-eau](../../professions/traitement-eau/cards/entretenir-controler-traitement-eau.md).
- **Tags** : `metier:traitement-eau famille:fluides sous-famille:traitement-eau type:kit cluster:analyses cluster:filtres equipement:testeur-th`

## Historique
| Version | Date | Auteur | Validateur | Motif |
|---|---|---|---|---|
| v0.1 | 2026-08-05 | IA | ⟦—⟧ | proposition initiale (Brouillon) |
