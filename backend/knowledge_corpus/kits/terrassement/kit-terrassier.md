# Kit terrassier / préparation de chantier

> **Brouillon (v0) — proposé par IA, en attente de validation métier** (Loi 7/18). Modèle : [../../cards/CARD_TEMPLATE.md](../../cards/CARD_TEMPLATE.md).
> Niveaux de confiance : A normes/fabricant · B technique · C terrain validé · D hypothèse.

## Métadonnées
| Champ | Valeur |
|---|---|
| Identifiant | `kit-terrassier` |
| Titre | Kit terrassier / préparation de chantier |
| Profession | `metier:terrassement` |
| Famille | `famille:gros-oeuvre` |
| Sous-famille | `sous-famille:terrassement` |
| Version | v0.1 |
| Auteur | IA (proposition) |
| Validateur | ⟦à valider métier⟧ |
| Statut | Brouillon |
| Indice de confiance | **C** |

## Composition conseillée (organisationnelle + sécurité)
- **Récépissés DICT** + plans réseaux + **AIPR** de l'opérateur. `[A]`
- **Blindage** (caisson/panneaux) ou moyens de talutage. `[A]`
- Niveau laser/topo (altimétrie), jalons, balisage/barrières. `[C]`
- **EPI** (casque, gilet HV, chaussures S3), moyens de **pompage**. `[A]`

## Cadre
- **Normes** : terrassements pour le bâtiment **DTU 12** ; fondations superficielles **DTU 13.11 / 13.12** ; réglementation réseaux (**DICT** / guichet unique, **AIPR**) et géotechnique **Eurocode 7 (NF EN 1997)** ⟦en prose, à confirmer⟧ `[B]` ⟦référence exacte à confirmer⟧. `respecte-norme`
- **Relations** : `utilise-kit` → [realiser-fouille-tranchee](../../professions/terrassement/cards/realiser-fouille-tranchee.md).
- **Tags** : `metier:terrassement famille:gros-oeuvre sous-famille:terrassement type:kit cluster:blindage cluster:dict equipement:blindage`

## Historique
| Version | Date | Auteur | Validateur | Motif |
|---|---|---|---|---|
| v0.1 | 2026-08-05 | IA | ⟦—⟧ | proposition initiale (Brouillon) |
