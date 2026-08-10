# PAC en défaut (code / mise en sécurité)

> **Brouillon (v0) — proposé par IA, en attente de validation métier** (Loi 7/18). Modèle : [../../cards/CARD_TEMPLATE.md](../../cards/CARD_TEMPLATE.md).
> Niveaux de confiance : A normes/fabricant · B technique · C terrain validé · D hypothèse.

## Métadonnées
| Champ | Valeur |
|---|---|
| Identifiant | `pac-en-defaut` |
| Titre | PAC en défaut (code / mise en sécurité) |
| Profession | `metier:chauffage` |
| Famille | `famille:fluides` |
| Sous-famille | `sous-famille:pac` |
| Version | v0.1 |
| Auteur | IA (proposition) |
| Validateur | ⟦à valider métier⟧ |
| Statut | Brouillon |
| Indice de confiance | **C** |

## Symptôme
- La PAC affiche un **code défaut** ou se met en sécurité. `[C]`

## Causes probables
1. Pression hydraulique / débit insuffisant. `[C]`
2. Défaut sonde / électrique. `[D]` ⟦selon code fabricant à confirmer⟧
3. Défaut frigorifère → **frigoriste F-Gaz**. `[D]`

## Résolution
- Relever le **code** (doc fabricant), contrôler l'hydraulique ; frigorifère → qualifié. `[C]` → [controler-pac-geothermique](../../professions/geothermie/cards/controler-pac-geothermique.md)

## Cadre
- **Normes** : installations de PAC **DTU 65.16** `[B]` ⟦référence exacte à confirmer⟧. `respecte-norme`
- **Relations** : `traite-diagnostic` → [entretenir-pac](../../professions/chauffage/cards/entretenir-pac.md).
- **Tags** : `metier:chauffage equipement:pac famille:fluides sous-famille:pac probleme:mise-en-securite cluster:diagnostic cluster:pannes type:diagnostic`

## Historique
| Version | Date | Auteur | Validateur | Motif |
|---|---|---|---|---|
| v0.1 | 2026-08-04 | IA | ⟦—⟧ | proposition initiale (Brouillon) |
