# Phrase — normes & réglementation traitement de l'eau

> **Brouillon (v0) — proposé par IA, en attente de validation métier** (Loi 7/18). Modèle : [../../cards/CARD_TEMPLATE.md](../../cards/CARD_TEMPLATE.md).
> Niveaux de confiance : A normes/fabricant · B technique · C terrain validé · D hypothèse.

## Métadonnées
| Champ | Valeur |
|---|---|
| Identifiant | `normes-reglementation-traitement-eau` |
| Titre | Phrase — normes & réglementation traitement de l'eau |
| Profession | `metier:traitement-eau` |
| Famille | `famille:fluides` |
| Sous-famille | `sous-famille:traitement-eau` |
| Version | v0.1 |
| Auteur | IA (proposition) |
| Validateur | ⟦à valider métier⟧ |
| Statut | Brouillon |
| Indice de confiance | **C** |

## Formulation (clusters « Normes » / « Réglementation »)
> « Nos traitements d'eau sont installés selon les règles de l'art (réseau sanitaire **DTU 60.1**, électricité UV **NF C 15-100**), avec **protection contre les retours d'eau** (**NF EN 1717**), des matériaux **ACS** et dans le respect des limites de **qualité de l'eau** (**arrêté du 11 janvier 2007**, Code de la santé). » `[C]` ⟦versions/procédures exactes à valider par un expert⟧

> **Sanitaire** : un traitement mal entretenu **dégrade** l'eau — **entretien/analyses** obligatoires ; désinfection à la mise en service. `[C]`

> **Relations inter-Livres** : le traitement s'installe sur le réseau de la **Plomberie**, traite l'eau du **Forage** (puits), protège la génération du **Chauffage** (entartrage) et l'UV relève de l'**Électricité** (raccordement réservé). `[C]`

## Cadre
- **Normes** : installation sur réseau sanitaire **DTU 60.1** ; alimentation électrique des systèmes (UV) **NF C 15-100** ; protection contre les **retours d'eau** (**NF EN 1717**), qualité de l'eau (**arrêté du 11 janvier 2007**, Code de la santé), matériaux **ACS** ⟦en prose, à confirmer⟧ `[B]` ⟦référence exacte à confirmer⟧. `respecte-norme`
- **Relations** : `cite-carte` → [poser-robinet-arret](../../professions/plomberie/cards/poser-robinet-arret.md).
- **Tags** : `metier:traitement-eau famille:fluides type:phrase usage:normes cluster:normes cluster:reglementation cluster:qualite-de-l-eau relation:plomberie relation:forage relation:chauffage relation:electricite-generale`

## Historique
| Version | Date | Auteur | Validateur | Motif |
|---|---|---|---|---|
| v0.1 | 2026-08-05 | IA | ⟦—⟧ | proposition initiale (Brouillon) |
