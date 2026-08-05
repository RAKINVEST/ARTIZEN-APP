# Kit maintenance froid (parties accessibles)

> **Brouillon (v0) — proposé par IA, en attente de validation métier** (Loi 7/18). Modèle : [../../cards/CARD_TEMPLATE.md](../../cards/CARD_TEMPLATE.md).
> Niveaux de confiance : A normes/fabricant · B technique · C terrain validé · D hypothèse.

## Métadonnées
| Champ | Valeur |
|---|---|
| Identifiant | `kit-maintenance-froid` |
| Titre | Kit maintenance froid (parties accessibles) |
| Profession | `metier:froid` |
| Famille | `famille:fluides` |
| Sous-famille | `sous-famille:froid-commercial` |
| Version | v0.1 |
| Auteur | IA (proposition) |
| Validateur | ⟦à valider métier⟧ |
| Statut | Brouillon |
| Indice de confiance | **C** |

## Composition conseillée
- Produits de nettoyage échangeurs/condenseur ; désinfectant enceinte. `[C]`
- Joints de porte de rechange selon modèle. `[C]` ⟦selon matériel⟧
- Thermomètre étalonné ; nettoyeur de ligne de condensats. `[B]`
- EPI (froid, hygiène). `[B]`

> Le kit **ne couvre pas** l'intervention frigorifique (outillage + qualification F-Gaz dédiés).

## Cadre
- **Normes** : sécurité des systèmes frigorifiques **NF EN 378** ; installation électrique **NF C 15-100** ; réglementation **F-Gaz** (UE 517/2014) `[B]` ⟦référence exacte à confirmer⟧. `respecte-norme`
- **Relations** : `utilise-kit` → [nettoyer-condenseur](../../professions/froid/cards/nettoyer-condenseur.md).
- **Tags** : `metier:froid famille:fluides sous-famille:froid-commercial type:kit cluster:maintenance cluster:entretien equipement:condenseur`

## Historique
| Version | Date | Auteur | Validateur | Motif |
|---|---|---|---|---|
| v0.1 | 2026-08-04 | IA | ⟦—⟧ | proposition initiale (Brouillon) |
