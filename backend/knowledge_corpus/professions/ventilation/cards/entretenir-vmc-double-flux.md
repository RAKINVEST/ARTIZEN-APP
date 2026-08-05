# Entretenir une VMC double flux

> **Brouillon (v0) — proposé par IA, en attente de validation métier** (Loi 7/18). Modèle : [../../../cards/CARD_TEMPLATE.md](../../../cards/CARD_TEMPLATE.md).
> Niveaux de confiance : A normes/fabricant · B technique · C terrain validé · D hypothèse. Rien n'est publié comme certitude.

## Métadonnées
| Champ | Valeur |
|---|---|
| Identifiant | `entretenir-vmc-double-flux` |
| Titre | Entretenir une VMC double flux |
| Profession | `metier:ventilation` |
| Famille | `famille:fluides` |
| Sous-famille | `sous-famille:ventilation` |
| Version | v0.1 |
| Auteur | IA (proposition) |
| Validateur | ⟦à valider métier⟧ |
| Statut | Brouillon |
| Indice de confiance | **C** |

## Cadrage
- **Objectif** : entretenir une VMC double flux (filtres, échangeur, condensats, réseaux) pour garantir débits, rendement et qualité de l'air. `[C]`
- **Résumé** : remplacer/nettoyer les **filtres**, contrôler l'échangeur et l'évacuation des condensats, vérifier le by-pass et les débits insufflation/extraction. `[C]`

## Réalisation
- **Étapes** :
  1. Couper l'alimentation de la centrale. `[A]`
  2. Remplacer/nettoyer les **filtres** (insufflation + extraction). `[C]` ⟦classe/périodicité selon fabricant⟧
  3. Contrôler l'**échangeur** et l'évacuation des **condensats**. `[C]`
  4. Vérifier le by-pass et les **débits** insufflation/extraction. `[C]` → [equilibrer-debits-ventilation](equilibrer-debits-ventilation.md)
- **Points critiques** : filtres adaptés (qualité d'air) ; échangeur propre (rendement) ; condensats évacués.
- **Sécurité** : électrique ; hygiène (filtres) ; hauteur. **Raccordement électrique du caisson : intervenant **habilité** (NF C 15-100) ; travail en **hauteur** (combles/toiture) sécurisé ; **ne jamais raccorder une VMC sur un conduit de fumée** ; hygiène (filtres/réseaux — qualité de l'air).** `[B]`

## Cadre & suites
- **Normes** : installations de ventilation mécanique **DTU 68.3** ; aération des logements (**arrêté du 24 mars 1982**) ; installation électrique **NF C 15-100** `[B]` ⟦références/versions exactes à confirmer par le validateur⟧. `respecte-norme`
- **Relations Chauffage** : `cite-procedure` → [mise-en-service-chauffage](../../../procedures/chauffage/mise-en-service-chauffage.md)

## Relations & tags
- **Tags** : `metier:ventilation equipement:vmc-double-flux equipement:filtre equipement:echangeur famille:fluides sous-famille:ventilation intervention:entretenir cluster:ventilation-double-flux cluster:insufflation cluster:filtres cluster:entretien complexite:moyenne type:entretien`

## Historique
| Version | Date | Auteur | Validateur | Motif |
|---|---|---|---|---|
| v0.1 | 2026-08-04 | IA | ⟦—⟧ | proposition initiale (Brouillon) |
