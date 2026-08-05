# Phrase — normes & réglementation VRD

> **Brouillon (v0) — proposé par IA, en attente de validation métier** (Loi 7/18). Modèle : [../../cards/CARD_TEMPLATE.md](../../cards/CARD_TEMPLATE.md).
> Niveaux de confiance : A normes/fabricant · B technique · C terrain validé · D hypothèse.

## Métadonnées
| Champ | Valeur |
|---|---|
| Identifiant | `normes-reglementation-vrd` |
| Titre | Phrase — normes & réglementation VRD |
| Profession | `metier:vrd` |
| Famille | `famille:gros-oeuvre` |
| Sous-famille | `sous-famille:vrd` |
| Version | v0.1 |
| Auteur | IA (proposition) |
| Validateur | ⟦à valider métier⟧ |
| Statut | Brouillon |
| Indice de confiance | **C** |

## Formulation (clusters « Normes » / « Réglementation »)
> « Nos travaux VRD respectent les règles de l'art : terrassement des tranchées (**DTU 12**), ouverture/réfection (**NF P 98-331**), réseaux électriques (**NF C 15-100**), assainissement (**NF EN 1610**), ainsi que la réglementation **anti-endommagement des réseaux** (**DT/DICT**, **AIPR**) et la **signalisation temporaire** de chantier. » `[C]` ⟦versions/procédures exactes à valider par un expert⟧

> **Frontières (Gros Œuvre)** : le **terrassement** des tranchées est partagé avec le Livre **Terrassement** (lien) ; les spécificités **EU/EP et traitement** relèvent de l'**Assainissement**, et les revêtements des **Enrobés** (futurs Livres, tags). `[C]`

> **Relations inter-Livres** : réseaux secs électriques → **Électricité** (branchement, réservé). `[C]`

## Cadre
- **Normes** : terrassement des tranchées **DTU 12** ; branchements/réseaux électriques **NF C 15-100** ; ouverture/réfection de tranchées **NF P 98-331**, assainissement **NF EN 1610**, réglementation réseaux (**DICT/AIPR**) et signalisation temporaire ⟦en prose, à confirmer⟧ `[B]` ⟦référence exacte à confirmer⟧. `respecte-norme`
- **Relations** : `cite-carte` → [terrasser-reseaux-dict](../../professions/terrassement/cards/terrasser-reseaux-dict.md).
- **Tags** : `metier:vrd famille:gros-oeuvre type:phrase usage:normes cluster:normes cluster:reglementation relation:terrassement relation:assainissement relation:enrobes relation:electricite-generale`

## Historique
| Version | Date | Auteur | Validateur | Motif |
|---|---|---|---|---|
| v0.1 | 2026-08-05 | IA | ⟦—⟧ | proposition initiale (Brouillon) |
