# Phrase — références normatives ventilation

> **Brouillon (v0) — proposé par IA, en attente de validation métier** (Loi 7/18). Modèle : [../../cards/CARD_TEMPLATE.md](../../cards/CARD_TEMPLATE.md).
> Niveaux de confiance : A normes/fabricant · B technique · C terrain validé · D hypothèse.

## Métadonnées
| Champ | Valeur |
|---|---|
| Identifiant | `normes-ventilation-reference` |
| Titre | Phrase — références normatives ventilation |
| Profession | `metier:ventilation` |
| Famille | `famille:fluides` |
| Sous-famille | `sous-famille:ventilation` |
| Version | v0.1 |
| Auteur | IA (proposition) |
| Validateur | ⟦à valider métier⟧ |
| Statut | Brouillon |
| Indice de confiance | **C** |

## Formulation (cluster « Normes / Réglementation »)
> « Nos installations de ventilation respectent les règles de l'art, notamment le **DTU 68.3** (installations de ventilation mécanique) et l'**arrêté du 24 mars 1982** (aération des logements) ; l'alimentation électrique suit la **NF C 15-100**. » `[C]` ⟦versions/valeurs exactes à valider par un expert⟧

> **Relations inter-Livres** : la ventilation double flux partage des enjeux d'air avec la **Climatisation** et de récupération d'énergie avec le **Chauffage** ; elle concourt à la **qualité de l'air** (⟦relation:qualite-air⟧). `[C]`

## Cadre
- **Normes** : installations de ventilation mécanique **DTU 68.3** ; aération des logements (**arrêté du 24 mars 1982**) ; installation électrique **NF C 15-100** `[B]` ⟦référence exacte à confirmer⟧. `respecte-norme`
- **Relations** : `cite-carte` → [entretenir-climatiseur](../../professions/climatisation/cards/entretenir-climatiseur.md).
- **Tags** : `metier:ventilation equipement:vmc famille:fluides type:phrase usage:normes cluster:normes cluster:reglementation relation:climatisation relation:chauffage relation:qualite-air`

## Historique
| Version | Date | Auteur | Validateur | Motif |
|---|---|---|---|---|
| v0.1 | 2026-08-04 | IA | ⟦—⟧ | proposition initiale (Brouillon) |
