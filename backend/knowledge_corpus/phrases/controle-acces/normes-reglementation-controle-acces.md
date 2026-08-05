# Phrase — normes & réglementation contrôle d'accès

> **Brouillon (v0) — proposé par IA, en attente de validation métier** (Loi 7/18). Modèle : [../../cards/CARD_TEMPLATE.md](../../cards/CARD_TEMPLATE.md).
> Niveaux de confiance : A normes/fabricant · B technique · C terrain validé · D hypothèse.

## Métadonnées
| Champ | Valeur |
|---|---|
| Identifiant | `normes-reglementation-controle-acces` |
| Titre | Phrase — normes & réglementation contrôle d'accès |
| Profession | `metier:controle-acces` |
| Famille | `famille:electricite` |
| Sous-famille | `sous-famille:controle-acces` |
| Version | v0.1 |
| Auteur | IA (proposition) |
| Validateur | ⟦à valider métier⟧ |
| Statut | Brouillon |
| Indice de confiance | **C** |

## Formulation (clusters « Normes » / « Réglementation »)
> « Nos installations de contrôle d'accès respectent les règles de l'art : alimentation (**NF C 15-100**), consignation à l'intervention (**NF C 18-510**), systèmes de contrôle d'accès électroniques (**EN 60839**), et surtout la **sécurité incendie / issues de secours** (réglementation **ERP** / **Code du travail** : déverrouillage de sécurité). » `[C]` ⟦versions/exigences exactes à valider par un expert⟧

> **Données & biométrie** : le **journal des accès** et surtout la **biométrie** (données **sensibles**) relèvent du **RGPD/CNIL** (règlement type, **AIPD**) ; cybersécurité selon **ANSSI**. `[C]`

> **Frontières** : ce Livre couvre le **contrôle d'accès** ; l'**alarme intrusion** (couplage armement), la **vidéosurveillance** (vérification) et l'**interphonie** sont des **activités distinctes** ; alimentation → **Électricité générale**, réseau IP → **Réseaux VDI**, intégration → **Domotique**. `[C]`

## Cadre
- **Normes** : alimentation des organes (serrures/lecteurs) **NF C 15-100** ; consignation à l'intervention **NF C 18-510** ; systèmes de contrôle d'accès électroniques **EN 60839**, sécurité incendie / issues de secours (réglementation ERP / **Code du travail**), données et **biométrie** (**RGPD**, **CNIL** — règlement type / **AIPD**), cybersécurité (**ANSSI**) ⟦en prose, à confirmer⟧ `[B]` ⟦référence exacte à confirmer⟧. `respecte-norme`
- **Relations** : `cite-carte` → [controler-tableau-electrique](../../professions/electricite-generale/cards/controler-tableau-electrique.md).
- **Tags** : `metier:controle-acces famille:electricite type:phrase usage:normes cluster:normes cluster:reglementation relation:electricite-generale relation:reseaux-vdi relation:domotique relation:alarme-intrusion relation:videosurveillance relation:interphonie`

## Historique
| Version | Date | Auteur | Validateur | Motif |
|---|---|---|---|---|
| v0.1 | 2026-08-05 | IA | ⟦—⟧ | proposition initiale (Brouillon) |
