# Chambre froide qui ne tient pas la température

> **Brouillon (v0) — proposé par IA, en attente de validation métier** (Loi 7/18). Modèle : [../../cards/CARD_TEMPLATE.md](../../cards/CARD_TEMPLATE.md).
> Niveaux de confiance : A normes/fabricant · B technique · C terrain validé · D hypothèse.

## Métadonnées
| Champ | Valeur |
|---|---|
| Identifiant | `chambre-froide-ne-tient-pas-temperature` |
| Titre | Chambre froide qui ne tient pas la température |
| Profession | `metier:froid` |
| Famille | `famille:fluides` |
| Sous-famille | `sous-famille:froid-commercial` |
| Version | v0.1 |
| Auteur | IA (proposition) |
| Validateur | ⟦à valider métier⟧ |
| Statut | Brouillon |
| Indice de confiance | **C** |

## Symptôme
- La température dépasse la consigne. `[C]`

## Causes probables
1. **Condenseur** encrassé / ventilation réduite. `[C]` → [nettoyer-condenseur](../../professions/froid/cards/nettoyer-condenseur.md)
2. **Givrage** de l'évaporateur / dégivrage défaillant. `[C]` → [givrage-excessif-evaporateur](givrage-excessif-evaporateur.md)
3. Joint de porte / surcharge / ouvertures. `[C]` → [controler-joint-porte-chambre-froide](../../professions/froid/cards/controler-joint-porte-chambre-froide.md)
4. Défaut **frigorifique** (charge, compresseur) → **frigoriste F-Gaz**. `[D]`

## Résolution
- Contrôler condenseur/dégivrage/porte ; frigorifique → qualifié. `[C]`

## Cadre
- **Normes** : sécurité des systèmes frigorifiques **NF EN 378** ; installation électrique **NF C 15-100** ; réglementation **F-Gaz** (UE 517/2014) `[B]` ⟦référence exacte à confirmer⟧. `respecte-norme`
- **Relations** : `traite-diagnostic` → [controler-chambre-froide-positive](../../professions/froid/cards/controler-chambre-froide-positive.md).
- **Tags** : `metier:froid equipement:chambre-froide famille:fluides sous-famille:froid-commercial probleme:temperature-haute cluster:diagnostic cluster:depannage type:diagnostic securite:frigorifique`

## Historique
| Version | Date | Auteur | Validateur | Motif |
|---|---|---|---|---|
| v0.1 | 2026-08-04 | IA | ⟦—⟧ | proposition initiale (Brouillon) |
