# Contrôler l'échangeur / l'interface hydraulique géothermie

> **Brouillon (v0) — proposé par IA, en attente de validation métier** (Loi 7/18). Modèle : [../../../cards/CARD_TEMPLATE.md](../../../cards/CARD_TEMPLATE.md).
> Niveaux de confiance : A normes/fabricant · B technique · C terrain validé · D hypothèse. Rien n'est publié comme certitude.

## Métadonnées
| Champ | Valeur |
|---|---|
| Identifiant | `controler-echangeur-geothermie` |
| Titre | Contrôler l'échangeur / l'interface hydraulique géothermie |
| Profession | `metier:geothermie` |
| Famille | `famille:fluides` |
| Sous-famille | `sous-famille:captage` |
| Version | v0.1 |
| Auteur | IA (proposition) |
| Validateur | ⟦à valider métier⟧ |
| Statut | Brouillon |
| Indice de confiance | **C** |

## Cadrage
- **Objectif** : contrôler l'interface hydraulique entre le captage et l'émission (échangeur intermédiaire, bouteille), côté eau. `[C]`
- **Résumé** : vérifier l'encrassement/entartrage de l'échangeur, les débits et écarts de température, la protection contre les boues, sans intervenir sur le circuit frigorifère. `[C]`

## Réalisation
- **Étapes** :
  1. Contrôler l'écart de température aux bornes de l'**échangeur**. `[C]`
  2. Vérifier l'encrassement/entartrage et le **filtre magnétique**. `[C]`
  3. Contrôler les débits capteur/émission. `[C]`
  4. Signaler tout défaut côté frigorifère au **frigoriste attesté**. `[A]`
- **Points critiques** : échangeur à plaques sensible aux boues ; protection obligatoire ; côté frigorifère réservé.
- **Sécurité** : eau sous pression ; PAC frigorifique réservée F-Gaz. **Le **forage/captage vertical** relève d'un **foreur qualifié** (réglementation GMI / déclaration) ; la partie **PAC** (circuit frigorifique) est réservée à un **frigoriste attesté F-Gaz** ; le **raccordement électrique** à un intervenant **habilité**.** `[A]`

## Cadre & suites
- **Normes** : installation électrique **NF C 15-100** ; réglementation **géothermie de minime importance (GMI)** ; dimensionnement **NF EN 15450** `[B]` ⟦références/versions exactes à confirmer par le validateur⟧. `respecte-norme`
- **Diagnostics liés** : `traite-diagnostic` → [geothermie-rendement-faible](../../../diagnostics/geothermie/geothermie-rendement-faible.md)

## Relations & tags
- **Tags** : `metier:geothermie equipement:echangeur famille:fluides sous-famille:captage intervention:controler cluster:echangeurs cluster:controle cluster:maintenance complexite:avancee type:controle`

## Historique
| Version | Date | Auteur | Validateur | Motif |
|---|---|---|---|---|
| v0.1 | 2026-08-04 | IA | ⟦—⟧ | proposition initiale (Brouillon) |
