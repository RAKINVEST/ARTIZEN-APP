# Phrase — normes & réglementation vidéosurveillance

> **Brouillon (v0) — proposé par IA, en attente de validation métier** (Loi 7/18). Modèle : [../../cards/CARD_TEMPLATE.md](../../cards/CARD_TEMPLATE.md).
> Niveaux de confiance : A normes/fabricant · B technique · C terrain validé · D hypothèse.

## Métadonnées
| Champ | Valeur |
|---|---|
| Identifiant | `normes-reglementation-videosurveillance` |
| Titre | Phrase — normes & réglementation vidéosurveillance |
| Profession | `metier:videosurveillance` |
| Famille | `famille:electricite` |
| Sous-famille | `sous-famille:videosurveillance` |
| Version | v0.1 |
| Auteur | IA (proposition) |
| Validateur | ⟦à valider métier⟧ |
| Statut | Brouillon |
| Indice de confiance | **C** |

## Formulation (clusters « Normes » / « Réglementation »)
> « Nos installations de vidéosurveillance respectent les règles de l'art : alimentation/PoE (**NF C 15-100**), consignation à l'intervention (**NF C 18-510**), systèmes vidéo (**EN 62676**), et la réglementation **RGPD / CNIL** (information, durée, registre) ; la vidéoprotection de la **voie publique** relève du **Code de la sécurité intérieure** (autorisation préfectorale). » `[C]` ⟦versions/démarches exactes à valider par un expert⟧

> **Cybersécurité** : durcissement des caméras IP selon **ANSSI** ; **protection des enregistrements** (données personnelles). `[C]`

> **Frontières** : ce Livre couvre la **vidéosurveillance** ; l'**alarme intrusion** (levée de doute), le **contrôle d'accès** et l'**interphonie** sont des **activités distinctes** ; alimentation → **Électricité générale**, réseau/PoE → **Réseaux VDI**, intégration → **Domotique**. `[C]`

## Cadre
- **Normes** : alimentation électrique / **PoE** **NF C 15-100** ; consignation à l'intervention **NF C 18-510** ; systèmes de vidéosurveillance **EN 62676**, protection des données (**RGPD**, **CNIL**), cadre voie publique (**Code de la sécurité intérieure**) et cybersécurité (**ANSSI**) ⟦en prose, à confirmer⟧ `[B]` ⟦référence exacte à confirmer⟧. `respecte-norme`
- **Relations** : `cite-carte` → [cabler-rj45-reseau](../../professions/reseaux-vdi/cards/cabler-rj45-reseau.md).
- **Tags** : `metier:videosurveillance famille:electricite type:phrase usage:normes cluster:normes cluster:reglementation relation:electricite-generale relation:reseaux-vdi relation:domotique relation:alarme-intrusion relation:controle-acces relation:interphonie`

## Historique
| Version | Date | Auteur | Validateur | Motif |
|---|---|---|---|---|
| v0.1 | 2026-08-05 | IA | ⟦—⟧ | proposition initiale (Brouillon) |
