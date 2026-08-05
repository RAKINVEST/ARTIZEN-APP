# Mettre en service une VMC

> **Brouillon (v0) — proposé par IA, en attente de validation métier** (Loi 7/18). Modèle : [../../../cards/CARD_TEMPLATE.md](../../../cards/CARD_TEMPLATE.md).
> Niveaux de confiance : A normes/fabricant · B technique · C terrain validé · D hypothèse. Rien n'est publié comme certitude.

## Métadonnées
| Champ | Valeur |
|---|---|
| Identifiant | `mettre-en-service-vmc` |
| Titre | Mettre en service une VMC |
| Profession | `metier:ventilation` |
| Famille | `famille:fluides` |
| Sous-famille | `sous-famille:ventilation` |
| Version | v0.1 |
| Auteur | IA (proposition) |
| Validateur | ⟦à valider métier⟧ |
| Statut | Brouillon |
| Indice de confiance | **C** |

## Cadrage
- **Objectif** : mettre en service une VMC : contrôles préalables, démarrage, équilibrage et vérification des débits. `[C]`
- **Résumé** : vérifier le montage (caisson, réseau, bouches, rejet), démarrer (raccordement électrique par un habilité), équilibrer et contrôler les débits réglementaires. `[C]`

## Réalisation
- **Étapes** :
  1. Vérifier le montage : caisson, réseau, bouches, **rejet en toiture**. `[C]`
  2. Raccordement électrique et démarrage (intervenant **habilité**). `[A]`
  3. Équilibrer les débits. `[C]` → [equilibrer-debits-ventilation](equilibrer-debits-ventilation.md)
  4. Contrôler les **débits réglementaires** et l'acoustique. `[C]` → [controle-debits-ventilation](../../../procedures/ventilation/controle-debits-ventilation.md)
- **Points critiques** : débits réglementaires ; rejet correct (toiture) ; acoustique.
- **Sécurité** : électrique (habilité) ; hauteur ; conduit de fumée proscrit. **Raccordement électrique du caisson : intervenant **habilité** (NF C 15-100) ; travail en **hauteur** (combles/toiture) sécurisé ; **ne jamais raccorder une VMC sur un conduit de fumée** ; hygiène (filtres/réseaux — qualité de l'air).** `[B]`

## Cadre & suites
- **Normes** : installations de ventilation mécanique **DTU 68.3** ; aération des logements (**arrêté du 24 mars 1982**) ; installation électrique **NF C 15-100** `[B]` ⟦références/versions exactes à confirmer par le validateur⟧. `respecte-norme`
- **Contrôle** : `a-checklist` → [controle-maintenance-ventilation](../../../checklists/ventilation/controle-maintenance-ventilation.md)

## Relations & tags
- **Tags** : `metier:ventilation equipement:vmc famille:fluides sous-famille:ventilation intervention:mettre-en-service cluster:mise-en-service cluster:equilibrage complexite:moyenne type:mise-en-service`

## Historique
| Version | Date | Auteur | Validateur | Motif |
|---|---|---|---|---|
| v0.1 | 2026-08-04 | IA | ⟦—⟧ | proposition initiale (Brouillon) |
