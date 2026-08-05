# Contrôler un réseau aéraulique

> **Brouillon (v0) — proposé par IA, en attente de validation métier** (Loi 7/18). Modèle : [../../../cards/CARD_TEMPLATE.md](../../../cards/CARD_TEMPLATE.md).
> Niveaux de confiance : A normes/fabricant · B technique · C terrain validé · D hypothèse. Rien n'est publié comme certitude.

## Métadonnées
| Champ | Valeur |
|---|---|
| Identifiant | `controler-reseau-aeraulique` |
| Titre | Contrôler un réseau aéraulique |
| Profession | `metier:ventilation` |
| Famille | `famille:fluides` |
| Sous-famille | `sous-famille:ventilation` |
| Version | v0.1 |
| Auteur | IA (proposition) |
| Validateur | ⟦à valider métier⟧ |
| Statut | Brouillon |
| Indice de confiance | **C** |

## Cadrage
- **Objectif** : contrôler l'état et l'étanchéité d'un réseau de conduits de ventilation (encrassement, fuites, isolation). `[C]`
- **Résumé** : vérifier l'état des conduits (souples/rigides), leur étanchéité, l'isolation en volume non chauffé et l'encrassement, sans dégrader le réseau. `[C]`

## Réalisation
- **Étapes** :
  1. Contrôler l'état des **conduits** (écrasements, déconnexions). `[C]`
  2. Vérifier l'**étanchéité** des raccords (pertes de débit). `[C]`
  3. Contrôler l'**isolation** des conduits en volume non chauffé (condensation). `[C]`
  4. Évaluer l'encrassement (empoussièrement). `[C]` → [debit-insuffisant-ventilation](../../../diagnostics/ventilation/debit-insuffisant-ventilation.md)
- **Points critiques** : étanchéité (pertes de débit) ; isolation (condensation) ; ne pas écraser les souples.
- **Sécurité** : hauteur/combles ; poussières (EPI). **Raccordement électrique du caisson : intervenant **habilité** (NF C 15-100) ; travail en **hauteur** (combles/toiture) sécurisé ; **ne jamais raccorder une VMC sur un conduit de fumée** ; hygiène (filtres/réseaux — qualité de l'air).** `[B]`

## Cadre & suites
- **Normes** : installations de ventilation mécanique **DTU 68.3** ; aération des logements (**arrêté du 24 mars 1982**) ; installation électrique **NF C 15-100** `[B]` ⟦références/versions exactes à confirmer par le validateur⟧. `respecte-norme`
- **Équilibrage** : `cite-carte` → [equilibrer-debits-ventilation](equilibrer-debits-ventilation.md)

## Relations & tags
- **Tags** : `metier:ventilation equipement:conduit famille:fluides sous-famille:ventilation intervention:controler cluster:reseaux-aerauliques cluster:controle complexite:moyenne type:controle`

## Historique
| Version | Date | Auteur | Validateur | Motif |
|---|---|---|---|---|
| v0.1 | 2026-08-04 | IA | ⟦—⟧ | proposition initiale (Brouillon) |
