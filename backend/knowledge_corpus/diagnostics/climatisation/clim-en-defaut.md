# Climatiseur en défaut (code)

> **Brouillon (v0) — proposé par IA, en attente de validation métier** (Loi 7/18). Modèle : [../../cards/CARD_TEMPLATE.md](../../cards/CARD_TEMPLATE.md).
> Niveaux de confiance : A normes/fabricant · B technique · C terrain validé · D hypothèse.

## Métadonnées
| Champ | Valeur |
|---|---|
| Identifiant | `clim-en-defaut` |
| Titre | Climatiseur en défaut (code) |
| Profession | `metier:climatisation` |
| Famille | `famille:fluides` |
| Sous-famille | `sous-famille:climatisation` |
| Version | v0.1 |
| Auteur | IA (proposition) |
| Validateur | ⟦à valider métier⟧ |
| Statut | Brouillon |
| Indice de confiance | **C** |

## Symptôme
- Le climatiseur affiche un **code défaut** / clignotements. `[C]`

## Causes probables
1. Défaut communication unité int./ext. `[D]` ⟦selon code fabricant à confirmer⟧
2. Défaut sonde / électrique. `[D]`
3. Protection frigorifère → **frigoriste F-Gaz**. `[D]`

## Résolution
- Relever le **code** (doc fabricant), contrôler unité ext./électrique ; frigorifère → qualifié. `[C]` → [controler-unite-exterieure-clim](../../professions/climatisation/cards/controler-unite-exterieure-clim.md)

## Cadre
- **Normes** : climatiseurs à détente directe **DTU 65.16** `[B]` ⟦référence exacte à confirmer⟧. `respecte-norme`
- **Relations** : `traite-diagnostic` → [controler-unite-exterieure-clim](../../professions/climatisation/cards/controler-unite-exterieure-clim.md).
- **Tags** : `metier:climatisation equipement:climatiseur famille:fluides sous-famille:climatisation probleme:code-defaut cluster:diagnostic cluster:pannes type:diagnostic`

## Historique
| Version | Date | Auteur | Validateur | Motif |
|---|---|---|---|---|
| v0.1 | 2026-08-04 | IA | ⟦—⟧ | proposition initiale (Brouillon) |
