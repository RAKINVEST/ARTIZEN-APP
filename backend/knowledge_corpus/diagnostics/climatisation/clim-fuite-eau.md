# Climatiseur qui fuit (eau)

> **Brouillon (v0) — proposé par IA, en attente de validation métier** (Loi 7/18). Modèle : [../../cards/CARD_TEMPLATE.md](../../cards/CARD_TEMPLATE.md).
> Niveaux de confiance : A normes/fabricant · B technique · C terrain validé · D hypothèse.

## Métadonnées
| Champ | Valeur |
|---|---|
| Identifiant | `clim-fuite-eau` |
| Titre | Climatiseur qui fuit (eau) |
| Profession | `metier:climatisation` |
| Famille | `famille:fluides` |
| Sous-famille | `sous-famille:climatisation` |
| Version | v0.1 |
| Auteur | IA (proposition) |
| Validateur | ⟦à valider métier⟧ |
| Statut | Brouillon |
| Indice de confiance | **C** |

## Symptôme
- Écoulement d'eau depuis l'unité intérieure. `[C]`

## Causes probables
1. **Évacuation des condensats** bouchée / pente incorrecte. `[C]` → [controler-evacuation-condensats](../../professions/climatisation/cards/controler-evacuation-condensats.md)
2. Pompe de relevage HS. `[C]`
3. Bac fissuré / débordement (givrage → dégel). `[C]`

## Résolution
- Déboucher/nettoyer la ligne de condensats, contrôler pompe et siphon. `[C]`

## Cadre
- **Normes** : climatiseurs à détente directe **DTU 65.16** `[B]` ⟦référence exacte à confirmer⟧. `respecte-norme`
- **Relations** : `traite-diagnostic` → [controler-evacuation-condensats](../../professions/climatisation/cards/controler-evacuation-condensats.md).
- **Tags** : `metier:climatisation equipement:climatiseur famille:fluides sous-famille:climatisation probleme:fuite probleme:condensats cluster:diagnostic cluster:pannes type:diagnostic`

## Historique
| Version | Date | Auteur | Validateur | Motif |
|---|---|---|---|---|
| v0.1 | 2026-08-04 | IA | ⟦—⟧ | proposition initiale (Brouillon) |
