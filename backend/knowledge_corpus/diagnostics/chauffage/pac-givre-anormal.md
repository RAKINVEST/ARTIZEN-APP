# Givrage anormal de l'unité extérieure

> **Brouillon (v0) — proposé par IA, en attente de validation métier** (Loi 7/18). Modèle : [../../cards/CARD_TEMPLATE.md](../../cards/CARD_TEMPLATE.md).
> Niveaux de confiance : A normes/fabricant · B technique · C terrain validé · D hypothèse.

## Métadonnées
| Champ | Valeur |
|---|---|
| Identifiant | `pac-givre-anormal` |
| Titre | Givrage anormal de l'unité extérieure |
| Profession | `metier:chauffage` |
| Famille | `famille:fluides` |
| Sous-famille | `sous-famille:pac` |
| Version | v0.1 |
| Auteur | IA (proposition) |
| Validateur | ⟦à valider métier⟧ |
| Statut | Brouillon |
| Indice de confiance | **C** |

## Symptôme
- Givre **persistant/excessif** sur l'unité extérieure. `[C]`

## Causes probables
1. Évacuation des **condensats** bouchée / gel. `[C]`
2. Cycle de **dégivrage** défaillant. `[C]`
3. Échangeur encrassé / débit d'air réduit. `[C]` → [controler-unite-exterieure-pac](../../professions/chauffage/cards/controler-unite-exterieure-pac.md)
4. Défaut frigorifère → **frigoriste F-Gaz**. `[D]`

## Résolution
- Dégager les condensats, nettoyer l'échangeur, contrôler le dégivrage. `[C]`

## Cadre
- **Normes** : installations de PAC **DTU 65.16** `[B]` ⟦référence exacte à confirmer⟧. `respecte-norme`
- **Relations** : `traite-diagnostic` → [controler-unite-exterieure-pac](../../professions/chauffage/cards/controler-unite-exterieure-pac.md).
- **Tags** : `metier:chauffage equipement:pac famille:fluides sous-famille:pac probleme:givrage cluster:diagnostic cluster:pannes equipement:unite-exterieure type:diagnostic`

## Historique
| Version | Date | Auteur | Validateur | Motif |
|---|---|---|---|---|
| v0.1 | 2026-08-04 | IA | ⟦—⟧ | proposition initiale (Brouillon) |
