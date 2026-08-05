# Contrôler le caisson de VMC

> **Brouillon (v0) — proposé par IA, en attente de validation métier** (Loi 7/18). Modèle : [../../../cards/CARD_TEMPLATE.md](../../../cards/CARD_TEMPLATE.md).
> Niveaux de confiance : A normes/fabricant · B technique · C terrain validé · D hypothèse. Rien n'est publié comme certitude.

## Métadonnées
| Champ | Valeur |
|---|---|
| Identifiant | `controler-caisson-vmc` |
| Titre | Contrôler le caisson de VMC |
| Profession | `metier:ventilation` |
| Famille | `famille:fluides` |
| Sous-famille | `sous-famille:ventilation` |
| Version | v0.1 |
| Auteur | IA (proposition) |
| Validateur | ⟦à valider métier⟧ |
| Statut | Brouillon |
| Indice de confiance | **C** |

## Cadrage
- **Objectif** : contrôler l'état du caisson/moteur de VMC (roue, fixation, bruit, alimentation) hors raccordement électrique. `[C]`
- **Résumé** : vérifier la propreté de la roue, les fixations antivibratiles, le bruit et la bonne rotation, et signaler tout défaut électrique à un habilité. `[C]`

## Réalisation
- **Étapes** :
  1. Couper l'alimentation ; **VAT** avant ouverture. `[A]`
  2. Nettoyer la **roue** (turbine) sans la déséquilibrer. `[C]`
  3. Vérifier fixations **antivibratiles** et le bruit. `[C]` → [vmc-bruyante](../../../diagnostics/ventilation/vmc-bruyante.md)
  4. Signaler tout défaut électrique à un **habilité**. `[A]`
- **Points critiques** : roue équilibrée ; fixations antivibratiles ; raccordement électrique réservé.
- **Sécurité** : électrique (habilité) ; hauteur ; VAT. **Raccordement électrique du caisson : intervenant **habilité** (NF C 15-100) ; travail en **hauteur** (combles/toiture) sécurisé ; **ne jamais raccorder une VMC sur un conduit de fumée** ; hygiène (filtres/réseaux — qualité de l'air).** `[B]`

## Cadre & suites
- **Normes** : installations de ventilation mécanique **DTU 68.3** ; aération des logements (**arrêté du 24 mars 1982**) ; installation électrique **NF C 15-100** `[B]` ⟦références/versions exactes à confirmer par le validateur⟧. `respecte-norme`
- **Diagnostics liés** : `traite-diagnostic` → [vmc-bruyante](../../../diagnostics/ventilation/vmc-bruyante.md)

## Relations & tags
- **Tags** : `metier:ventilation equipement:caisson equipement:moteur famille:fluides sous-famille:ventilation intervention:controler cluster:caisson cluster:vmc cluster:controle complexite:moyenne type:controle securite:electrique`

## Historique
| Version | Date | Auteur | Validateur | Motif |
|---|---|---|---|---|
| v0.1 | 2026-08-04 | IA | ⟦—⟧ | proposition initiale (Brouillon) |
