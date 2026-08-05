# Phrase — références normatives PAC

> **Brouillon (v0) — proposé par IA, en attente de validation métier** (Loi 7/18). Modèle : [../../cards/CARD_TEMPLATE.md](../../cards/CARD_TEMPLATE.md).
> Niveaux de confiance : A normes/fabricant · B technique · C terrain validé · D hypothèse.

## Métadonnées
| Champ | Valeur |
|---|---|
| Identifiant | `normes-pac-reference` |
| Titre | Phrase — références normatives PAC |
| Profession | `metier:pac` |
| Famille | `famille:fluides` |
| Sous-famille | `sous-famille:pac` |
| Version | v0.1 |
| Auteur | IA (proposition) |
| Validateur | ⟦à valider métier⟧ |
| Statut | Brouillon |
| Indice de confiance | **C** |

## Formulation (cluster « Normes »)
> « Nos installations et interventions PAC respectent les règles de l'art, notamment le **DTU 65.16** (installations de PAC) et la réglementation **F-Gaz** pour le circuit frigorifère (intervenant attesté). » `[C]` ⟦liste et versions exactes à valider par un expert⟧

> **Relations inter-Livres** : une PAC est un **équipement transversal** (⟦equipement:pac⟧) lié aux Livres **Chauffage** (émission air/eau) et **Climatisation** (réversible air/air). Ces relations seront tracées quand le Livre Climatisation existera. `[C]`

## Cadre
- **Normes** : installations de PAC **DTU 65.16** `[B]` ⟦référence exacte à confirmer⟧. `respecte-norme`
- **Relations** : `cite-phrase` → [entretenir-pac](../../professions/pac/cards/entretenir-pac.md).
- **Tags** : `metier:pac equipement:pac famille:fluides type:phrase usage:normes cluster:normes relation:chauffage relation:climatisation`

## Historique
| Version | Date | Auteur | Validateur | Motif |
|---|---|---|---|---|
| v0.1 | 2026-08-04 | IA | ⟦—⟧ | proposition initiale (Brouillon) |
