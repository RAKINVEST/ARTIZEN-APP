# Entretenir une VMC simple flux

> **Brouillon (v0) — proposé par IA, en attente de validation métier** (Loi 7/18). Modèle : [../../../cards/CARD_TEMPLATE.md](../../../cards/CARD_TEMPLATE.md).
> Niveaux de confiance : A normes/fabricant · B technique · C terrain validé · D hypothèse. Rien n'est publié comme certitude.

## Métadonnées
| Champ | Valeur |
|---|---|
| Identifiant | `entretenir-vmc-simple-flux` |
| Titre | Entretenir une VMC simple flux |
| Profession | `metier:ventilation` |
| Famille | `famille:fluides` |
| Sous-famille | `sous-famille:ventilation` |
| Version | v0.1 |
| Auteur | IA (proposition) |
| Validateur | ⟦à valider métier⟧ |
| Statut | Brouillon |
| Indice de confiance | **C** |

## Cadrage
- **Objectif** : entretenir une VMC simple flux (bouches d'extraction, entrées d'air, caisson) pour maintenir les débits et la qualité de l'air. `[C]`
- **Résumé** : nettoyer/dépoussiérer les bouches d'extraction et les entrées d'air, contrôler le caisson et le rejet, vérifier les débits. `[C]`

## Réalisation
- **Étapes** :
  1. Couper l'alimentation du **caisson**. `[A]`
  2. Déposer et nettoyer les **bouches d'extraction** (cuisine, SdB, WC). `[C]` → [remplacer-nettoyer-bouches](remplacer-nettoyer-bouches.md)
  3. Nettoyer les **entrées d'air** (menuiseries). `[C]`
  4. Contrôler le caisson (roue, moteur) et le rejet. `[C]` → [controler-caisson-vmc](controler-caisson-vmc.md)
  5. Vérifier les **débits** (extraction). `[C]` → [controle-debits-ventilation](../../../procedures/ventilation/controle-debits-ventilation.md)
- **Points critiques** : débits réglementaires ; entrées d'air non obstruées ; équilibre extraction/amenée.
- **Sécurité** : électrique (caisson) ; hauteur (caisson en combles). **Raccordement électrique du caisson : intervenant **habilité** (NF C 15-100) ; travail en **hauteur** (combles/toiture) sécurisé ; **ne jamais raccorder une VMC sur un conduit de fumée** ; hygiène (filtres/réseaux — qualité de l'air).** `[B]`

## Cadre & suites
- **Normes** : installations de ventilation mécanique **DTU 68.3** ; aération des logements (**arrêté du 24 mars 1982**) ; installation électrique **NF C 15-100** `[B]` ⟦références/versions exactes à confirmer par le validateur⟧. `respecte-norme`
- **Diagnostics liés** : `traite-diagnostic` → [debit-insuffisant-ventilation](../../../diagnostics/ventilation/debit-insuffisant-ventilation.md)

## Relations & tags
- **Tags** : `metier:ventilation equipement:vmc equipement:bouche famille:fluides sous-famille:ventilation intervention:entretenir cluster:ventilation-simple-flux cluster:vmc cluster:extraction cluster:bouches cluster:entretien complexite:simple type:entretien`

## Historique
| Version | Date | Auteur | Validateur | Motif |
|---|---|---|---|---|
| v0.1 | 2026-08-04 | IA | ⟦—⟧ | proposition initiale (Brouillon) |
