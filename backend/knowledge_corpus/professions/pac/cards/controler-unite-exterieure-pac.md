# Contrôler l'unité extérieure d'une PAC

> **Brouillon (v0) — proposé par IA, en attente de validation métier** (Loi 7/18). Modèle : [../../../cards/CARD_TEMPLATE.md](../../../cards/CARD_TEMPLATE.md).
> Niveaux de confiance : A normes/fabricant · B technique · C terrain validé · D hypothèse. Rien n'est publié comme certitude.

## Métadonnées
| Champ | Valeur |
|---|---|
| Identifiant | `controler-unite-exterieure-pac` |
| Titre | Contrôler l'unité extérieure d'une PAC |
| Profession | `metier:pac` |
| Famille | `famille:fluides` |
| Sous-famille | `sous-famille:pac` |
| Version | v0.1 |
| Auteur | IA (proposition) |
| Validateur | ⟦à valider métier⟧ |
| Statut | Brouillon |
| Indice de confiance | **C** |

## Cadrage
- **Objectif** : contrôler et entretenir l'unité extérieure (échangeur, ventilateur, évacuation des condensats/dégivrage). `[C]`
- **Résumé** : nettoyer l'échangeur extérieur, vérifier le ventilateur, dégager l'implantation, contrôler l'évacuation des condensats et le dégivrage. `[C]`

## Réalisation
- **Étapes** :
  1. Couper l'alimentation électrique de l'unité. `[A]`
  2. Nettoyer l'**échangeur** extérieur (ailettes) sans les déformer. `[C]`
  3. Vérifier le **ventilateur** et l'absence d'obstacle (implantation). `[C]`
  4. Contrôler l'évacuation des **condensats** et le cycle de **dégivrage**. `[C]` → [pac-givre-anormal](../../../diagnostics/pac/pac-givre-anormal.md)
- **Points critiques** : ailettes fragiles ; évacuation des condensats libre (gel) ; ne pas ouvrir le circuit frigorifère. `[B]`
- **Sécurité** : électricité (consignation) ; ne pas intervenir sur le frigorifère. **Le circuit frigorifère est sous pression et contient un fluide réglementé : toute manipulation (charge, récupération, brasage) exige une **attestation de capacité F-Gaz** et l'outillage adapté — hors périmètre sans qualification.** `[A]`

## Cadre & suites
- **Normes** : installations de PAC **DTU 65.16** `[B]` ⟦références/versions exactes à confirmer par le validateur⟧. `respecte-norme`
- **Diagnostics liés** : `traite-diagnostic` → [pac-givre-anormal](../../../diagnostics/pac/pac-givre-anormal.md)

## Relations & tags
- **Tags** : `metier:pac equipement:pac famille:fluides sous-famille:pac intervention:controler intervention:entretenir cluster:unite-exterieure cluster:controle equipement:unite-exterieure complexite:moyenne type:entretien`

## Historique
| Version | Date | Auteur | Validateur | Motif |
|---|---|---|---|---|
| v0.1 | 2026-08-04 | IA | ⟦—⟧ | proposition initiale (Brouillon) |
