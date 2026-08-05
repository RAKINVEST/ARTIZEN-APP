# Équilibrer les débits d'une ventilation

> **Brouillon (v0) — proposé par IA, en attente de validation métier** (Loi 7/18). Modèle : [../../../cards/CARD_TEMPLATE.md](../../../cards/CARD_TEMPLATE.md).
> Niveaux de confiance : A normes/fabricant · B technique · C terrain validé · D hypothèse. Rien n'est publié comme certitude.

## Métadonnées
| Champ | Valeur |
|---|---|
| Identifiant | `equilibrer-debits-ventilation` |
| Titre | Équilibrer les débits d'une ventilation |
| Profession | `metier:ventilation` |
| Famille | `famille:fluides` |
| Sous-famille | `sous-famille:ventilation` |
| Version | v0.1 |
| Auteur | IA (proposition) |
| Validateur | ⟦à valider métier⟧ |
| Statut | Brouillon |
| Indice de confiance | **C** |

## Cadrage
- **Objectif** : répartir les débits d'air entre les pièces selon les valeurs réglementaires (extraction/insufflation). `[C]`
- **Résumé** : mesurer les débits aux bouches, comparer aux valeurs réglementaires, ajuster (bouches/registres) itérativement jusqu'à conformité. `[C]` ⟦valeurs réglementaires à confirmer⟧

## Réalisation
- **Étapes** :
  1. Mesurer les **débits** aux bouches (anémomètre/débitmètre). `[C]`
  2. Comparer aux **valeurs réglementaires** (arrêté 1982). `[B]` ⟦à confirmer⟧
  3. Ajuster (bouches/registres) itérativement. `[C]`
  4. Consigner les débits obtenus. `[C]` → [controle-debits-ventilation](../../../procedures/ventilation/controle-debits-ventilation.md)
- **Points critiques** : respect des débits réglementaires ; équilibre global du réseau.
- **Sécurité** : hauteur ; électrique (caisson). **Raccordement électrique du caisson : intervenant **habilité** (NF C 15-100) ; travail en **hauteur** (combles/toiture) sécurisé ; **ne jamais raccorder une VMC sur un conduit de fumée** ; hygiène (filtres/réseaux — qualité de l'air).** `[B]`

## Cadre & suites
- **Normes** : installations de ventilation mécanique **DTU 68.3** ; aération des logements (**arrêté du 24 mars 1982**) ; installation électrique **NF C 15-100** `[B]` ⟦références/versions exactes à confirmer par le validateur⟧. `respecte-norme`
- **Contrôle** : `cite-procedure` → [controle-debits-ventilation](../../../procedures/ventilation/controle-debits-ventilation.md)

## Relations & tags
- **Tags** : `metier:ventilation famille:fluides sous-famille:ventilation intervention:regler intervention:equilibrer cluster:equilibrage cluster:controle cluster:reseaux-aerauliques complexite:avancee type:reglage`

## Historique
| Version | Date | Auteur | Validateur | Motif |
|---|---|---|---|---|
| v0.1 | 2026-08-04 | IA | ⟦—⟧ | proposition initiale (Brouillon) |
