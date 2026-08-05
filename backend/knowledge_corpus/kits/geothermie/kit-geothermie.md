# Kit maintenance géothermie (captage)

> **Brouillon (v0) — proposé par IA, en attente de validation métier** (Loi 7/18). Modèle : [../../cards/CARD_TEMPLATE.md](../../cards/CARD_TEMPLATE.md).
> Niveaux de confiance : A normes/fabricant · B technique · C terrain validé · D hypothèse.

## Métadonnées
| Champ | Valeur |
|---|---|
| Identifiant | `kit-geothermie` |
| Titre | Kit maintenance géothermie (captage) |
| Profession | `metier:geothermie` |
| Famille | `famille:fluides` |
| Sous-famille | `sous-famille:captage` |
| Version | v0.1 |
| Auteur | IA (proposition) |
| Validateur | ⟦à valider métier⟧ |
| Statut | Brouillon |
| Indice de confiance | **C** |

## Composition conseillée
- **Fluide caloporteur** (antigel) compatible + réfractomètre (mesure du taux). `[C]`
- Pompe de remplissage / purgeur. `[C]`
- Manomètre, débitmètres, filtre magnétique. `[B]`
- EPI (produit, froid). `[B]`

> Le kit **ne couvre pas** l'intervention frigorifère (PAC) ni le forage.

## Cadre
- **Normes** : installation électrique **NF C 15-100** ; réglementation **géothermie de minime importance (GMI)** ; dimensionnement **NF EN 15450** `[B]` ⟦référence exacte à confirmer⟧. `respecte-norme`
- **Relations** : `utilise-kit` → [controler-fluide-caloporteur](../../professions/geothermie/cards/controler-fluide-caloporteur.md).
- **Tags** : `metier:geothermie equipement:caloporteur famille:fluides sous-famille:captage type:kit cluster:maintenance cluster:fluide-caloporteur`

## Historique
| Version | Date | Auteur | Validateur | Motif |
|---|---|---|---|---|
| v0.1 | 2026-08-04 | IA | ⟦—⟧ | proposition initiale (Brouillon) |
