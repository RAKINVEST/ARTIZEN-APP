# Givrage excessif de l'évaporateur

> **Brouillon (v0) — proposé par IA, en attente de validation métier** (Loi 7/18). Modèle : [../../cards/CARD_TEMPLATE.md](../../cards/CARD_TEMPLATE.md).
> Niveaux de confiance : A normes/fabricant · B technique · C terrain validé · D hypothèse.

## Métadonnées
| Champ | Valeur |
|---|---|
| Identifiant | `givrage-excessif-evaporateur` |
| Titre | Givrage excessif de l'évaporateur |
| Profession | `metier:froid` |
| Famille | `famille:fluides` |
| Sous-famille | `sous-famille:froid-commercial` |
| Version | v0.1 |
| Auteur | IA (proposition) |
| Validateur | ⟦à valider métier⟧ |
| Statut | Brouillon |
| Indice de confiance | **C** |

## Symptôme
- Évaporateur **pris en glace** ; performance en baisse. `[C]`

## Causes probables
1. **Dégivrage** insuffisant (paramètres, résistances, sonde de fin). `[C]` → [controler-chambre-froide-negative-degivrage](../../professions/froid/cards/controler-chambre-froide-negative-degivrage.md)
2. Infiltrations d'air humide (joint de porte). `[C]`
3. Défaut **frigorifique** → **frigoriste F-Gaz**. `[D]`

## Résolution
- Contrôler le dégivrage et l'étanchéité ; frigorifique → qualifié. `[C]`

## Cadre
- **Normes** : sécurité des systèmes frigorifiques **NF EN 378** ; installation électrique **NF C 15-100** ; réglementation **F-Gaz** (UE 517/2014) `[B]` ⟦référence exacte à confirmer⟧. `respecte-norme`
- **Relations** : `traite-diagnostic` → [controler-chambre-froide-negative-degivrage](../../professions/froid/cards/controler-chambre-froide-negative-degivrage.md).
- **Tags** : `metier:froid equipement:evaporateur famille:fluides sous-famille:froid-commercial probleme:givrage cluster:diagnostic cluster:degivrage cluster:evaporateurs type:diagnostic securite:frigorifique`

## Historique
| Version | Date | Auteur | Validateur | Motif |
|---|---|---|---|---|
| v0.1 | 2026-08-04 | IA | ⟦—⟧ | proposition initiale (Brouillon) |
