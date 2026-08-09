# Désembouer le circuit hydraulique d'une PAC air/eau

> **Brouillon (v0) — proposé par IA, en attente de validation métier** (Loi 7/18). Modèle : [../../../cards/CARD_TEMPLATE.md](../../../cards/CARD_TEMPLATE.md).
> Niveaux de confiance : A normes/fabricant · B technique · C terrain validé · D hypothèse. Rien n'est publié comme certitude.

## Métadonnées
| Champ | Valeur |
|---|---|
| Identifiant | `desembouer-circuit-pac-air-eau` |
| Titre | Désembouer le circuit hydraulique d'une PAC air/eau |
| Profession | `metier:chauffage` |
| Famille | `famille:fluides` |
| Sous-famille | `sous-famille:pac-air-eau` |
| Version | v0.1 |
| Auteur | IA (proposition) |
| Validateur | ⟦à valider métier⟧ |
| Statut | Brouillon |
| Indice de confiance | **C** |

## Cadrage
- **Objectif** : protéger l'échangeur d'une PAC air/eau en éliminant les boues du circuit hydraulique. `[C]`
- **Résumé** : isoler la PAC selon préconisation, désembouer et protéger le circuit émission par inhibiteur + filtre magnétique (protection de l'échangeur à plaques). `[C]`

## Réalisation
- **Étapes** :
  1. Isoler la PAC selon la préconisation fabricant. `[C]` ⟦à confirmer⟧
  2. Désembouer le circuit **émission** (même principe que chauffage). `[C]` → [desembouer-circuit-chauffage](../../../professions/chauffage/cards/desembouer-circuit-chauffage.md)
  3. Poser/vérifier un **filtre magnétique** protégeant l'échangeur. `[B]`
  4. Rincer, protéger par inhibiteur, remettre en eau et purger. `[C]`
- **Points critiques** : l'échangeur à plaques est sensible aux boues ; protection obligatoire. `[B]`
- **Sécurité** : hydraulique sous pression ; côté frigorifère non concerné par ce geste. `[B]`

## Cadre & suites
- **Normes** : installations de PAC **DTU 65.16** `[B]` ⟦références/versions exactes à confirmer par le validateur⟧. `respecte-norme`
- **Relations Chauffage** : `cite-carte` → [desembouer-circuit-chauffage](../../../professions/chauffage/cards/desembouer-circuit-chauffage.md)

## Relations & tags
- **Tags** : `metier:chauffage equipement:pac famille:fluides sous-famille:pac-air-eau intervention:entretenir cluster:hydraulique cluster:reparation probleme:boue complexite:moyenne type:entretien`

## Historique
| Version | Date | Auteur | Validateur | Motif |
|---|---|---|---|---|
| v0.1 | 2026-08-04 | IA | ⟦—⟧ | proposition initiale (Brouillon) |
