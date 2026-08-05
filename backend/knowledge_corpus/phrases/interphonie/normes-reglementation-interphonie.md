# Phrase — normes & réglementation interphonie / visiophonie

> **Brouillon (v0) — proposé par IA, en attente de validation métier** (Loi 7/18). Modèle : [../../cards/CARD_TEMPLATE.md](../../cards/CARD_TEMPLATE.md).
> Niveaux de confiance : A normes/fabricant · B technique · C terrain validé · D hypothèse.

## Métadonnées
| Champ | Valeur |
|---|---|
| Identifiant | `normes-reglementation-interphonie` |
| Titre | Phrase — normes & réglementation interphonie / visiophonie |
| Profession | `metier:interphonie` |
| Famille | `famille:electricite` |
| Sous-famille | `sous-famille:interphonie` |
| Version | v0.1 |
| Auteur | IA (proposition) |
| Validateur | ⟦à valider métier⟧ |
| Statut | Brouillon |
| Indice de confiance | **C** |

## Formulation (clusters « Normes » / « Réglementation »)
> « Nos installations d'interphonie/visiophonie respectent les règles de l'art : alimentation (**NF C 15-100**), consignation à l'intervention (**NF C 18-510**), systèmes d'interphonie de bâtiment (**EN 62820**), communication **SIP** en IP. » `[C]` ⟦versions/exigences exactes à valider par un expert⟧

> **Données & vie privée** : en **visiophonie**, la caméra et tout **enregistrement d'images** relèvent du **RGPD/CNIL** (information, champ limité à l'entrée) ; cybersécurité IP/SIP selon **ANSSI**. `[C]`

> **Frontières** : ce Livre couvre l'**interphonie** ; la **gâche/le déverrouillage de sécurité** relèvent du **Contrôle d'accès** (interface uniquement), un visiophone **n'est pas** de la **Vidéosurveillance** ; alimentation → **Électricité générale**, réseau IP → **Réseaux VDI**, intégration → **Domotique**. `[C]`

## Cadre
- **Normes** : alimentation des équipements **NF C 15-100** ; consignation à l'intervention **NF C 18-510** ; systèmes d'interphonie de bâtiment **EN 62820**, communication **SIP** (IP), données/images (**RGPD**, **CNIL**) et cybersécurité (**ANSSI**) ⟦en prose, à confirmer⟧ `[B]` ⟦référence exacte à confirmer⟧. `respecte-norme`
- **Relations** : `cite-carte` → [poser-organe-verrouillage](../../professions/controle-acces/cards/poser-organe-verrouillage.md).
- **Tags** : `metier:interphonie famille:electricite type:phrase usage:normes cluster:normes cluster:reglementation relation:electricite-generale relation:reseaux-vdi relation:domotique relation:controle-acces relation:videosurveillance`

## Historique
| Version | Date | Auteur | Validateur | Motif |
|---|---|---|---|---|
| v0.1 | 2026-08-05 | IA | ⟦—⟧ | proposition initiale (Brouillon) |
