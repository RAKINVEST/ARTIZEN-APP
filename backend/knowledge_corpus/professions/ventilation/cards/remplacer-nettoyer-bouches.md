# Nettoyer / remplacer les bouches de VMC

> **Brouillon (v0) — proposé par IA, en attente de validation métier** (Loi 7/18). Modèle : [../../../cards/CARD_TEMPLATE.md](../../../cards/CARD_TEMPLATE.md).
> Niveaux de confiance : A normes/fabricant · B technique · C terrain validé · D hypothèse. Rien n'est publié comme certitude.

## Métadonnées
| Champ | Valeur |
|---|---|
| Identifiant | `remplacer-nettoyer-bouches` |
| Titre | Nettoyer / remplacer les bouches de VMC |
| Profession | `metier:ventilation` |
| Famille | `famille:fluides` |
| Sous-famille | `sous-famille:ventilation` |
| Version | v0.1 |
| Auteur | IA (proposition) |
| Validateur | ⟦à valider métier⟧ |
| Statut | Brouillon |
| Indice de confiance | **C** |

## Cadrage
- **Objectif** : restaurer le débit d'extraction en nettoyant ou remplaçant les bouches (dont hygroréglables). `[C]`
- **Résumé** : déposer les bouches, nettoyer sans modifier leur réglage, remplacer les bouches hygroréglables défaillantes, remonter et contrôler. `[C]`

## Réalisation
- **Étapes** :
  1. Déposer les **bouches** (extraction). `[C]`
  2. Nettoyer sans **modifier le réglage/calibre**. `[C]`
  3. Remplacer les bouches **hygroréglables** défaillantes par un modèle équivalent. `[C]` ⟦calibre à confirmer⟧
  4. Remonter, contrôler l'extraction. `[C]` → [controle-debits-ventilation](../../../procedures/ventilation/controle-debits-ventilation.md)
- **Points critiques** : ne pas altérer le **calibre** ; bouche hygro = pilotage par l'humidité.
- **Sécurité** : hauteur éventuelle ; hygiène. **Raccordement électrique du caisson : intervenant **habilité** (NF C 15-100) ; travail en **hauteur** (combles/toiture) sécurisé ; **ne jamais raccorder une VMC sur un conduit de fumée** ; hygiène (filtres/réseaux — qualité de l'air).** `[B]`

## Cadre & suites
- **Normes** : installations de ventilation mécanique **DTU 68.3** ; aération des logements (**arrêté du 24 mars 1982**) ; installation électrique **NF C 15-100** `[B]` ⟦références/versions exactes à confirmer par le validateur⟧. `respecte-norme`
- **Entretien** : `cite-carte` → [entretenir-vmc-simple-flux](entretenir-vmc-simple-flux.md)

## Relations & tags
- **Tags** : `metier:ventilation equipement:bouche famille:fluides sous-famille:ventilation intervention:entretenir intervention:remplacer cluster:bouches cluster:vmc-hygroreglable cluster:extraction complexite:simple type:entretien`

## Historique
| Version | Date | Auteur | Validateur | Motif |
|---|---|---|---|---|
| v0.1 | 2026-08-04 | IA | ⟦—⟧ | proposition initiale (Brouillon) |
