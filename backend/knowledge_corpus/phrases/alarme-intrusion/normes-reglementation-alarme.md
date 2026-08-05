# Phrase — normes & réglementation alarme intrusion

> **Brouillon (v0) — proposé par IA, en attente de validation métier** (Loi 7/18). Modèle : [../../cards/CARD_TEMPLATE.md](../../cards/CARD_TEMPLATE.md).
> Niveaux de confiance : A normes/fabricant · B technique · C terrain validé · D hypothèse.

## Métadonnées
| Champ | Valeur |
|---|---|
| Identifiant | `normes-reglementation-alarme` |
| Titre | Phrase — normes & réglementation alarme intrusion |
| Profession | `metier:alarme-intrusion` |
| Famille | `famille:electricite` |
| Sous-famille | `sous-famille:alarme-intrusion` |
| Version | v0.1 |
| Auteur | IA (proposition) |
| Validateur | ⟦à valider métier⟧ |
| Statut | Brouillon |
| Indice de confiance | **C** |

## Formulation (clusters « Normes » / « Réglementation »)
> « Nos systèmes d'alarme respectent les règles de l'art : alimentation (**NF C 15-100**), consignation à l'intervention (**NF C 18-510**), systèmes d'alarme intrusion (**EN 50131**, notion de **grade**), règles **APSAD (R81/R82)** et certification **NF&A2P** (**CNPP**). » `[C]` ⟦versions/grades exacts à valider par un expert⟧

> **Cybersécurité & données** : durcissement selon **ANSSI** (systèmes connectés) et **RGPD** (codes/badges/journaux d'événements). `[C]`

> **Frontières** : ce Livre couvre l'**alarme intrusion** ; la **vidéosurveillance**, le **contrôle d'accès** et l'**interphonie** sont des **activités distinctes** (futurs Livres, tags) ; alimentation → **Électricité générale**, transmetteur IP → **Réseaux VDI**, intégration → **Domotique**. `[C]`

## Cadre
- **Normes** : alimentation électrique de la centrale **NF C 15-100** ; consignation à l'intervention **NF C 18-510** ; systèmes d'alarme intrusion **EN 50131** (grades), règles **APSAD** (R81/R82) / certification **NF&A2P** (**CNPP**), données **RGPD** et cybersécurité (**ANSSI**) ⟦en prose, à confirmer⟧ `[B]` ⟦référence exacte à confirmer⟧. `respecte-norme`
- **Relations** : `cite-carte` → [controler-tableau-electrique](../../professions/electricite-generale/cards/controler-tableau-electrique.md).
- **Tags** : `metier:alarme-intrusion famille:electricite type:phrase usage:normes cluster:normes cluster:reglementation relation:electricite-generale relation:reseaux-vdi relation:domotique relation:videosurveillance relation:controle-acces relation:interphonie`

## Historique
| Version | Date | Auteur | Validateur | Motif |
|---|---|---|---|---|
| v0.1 | 2026-08-05 | IA | ⟦—⟧ | proposition initiale (Brouillon) |
