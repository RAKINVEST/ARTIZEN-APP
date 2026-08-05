# Phrase — normes & réglementation domotique

> **Brouillon (v0) — proposé par IA, en attente de validation métier** (Loi 7/18). Modèle : [../../cards/CARD_TEMPLATE.md](../../cards/CARD_TEMPLATE.md).
> Niveaux de confiance : A normes/fabricant · B technique · C terrain validé · D hypothèse.

## Métadonnées
| Champ | Valeur |
|---|---|
| Identifiant | `normes-reglementation-domotique` |
| Titre | Phrase — normes & réglementation domotique |
| Profession | `metier:domotique` |
| Famille | `famille:electricite` |
| Sous-famille | `sous-famille:domotique` |
| Version | v0.1 |
| Auteur | IA (proposition) |
| Validateur | ⟦à valider métier⟧ |
| Statut | Brouillon |
| Indice de confiance | **C** |

## Formulation (clusters « Normes » / « Réglementation »)
> « Nos installations domotiques respectent les règles de l'art : circuits/actionneurs (**NF C 15-100**), consignation à proximité des courants forts (**NF C 18-510**), systèmes **KNX (ISO/IEC 14543-3)** et protocoles interopérables (**Matter**), performance de l'automatisation (**NF EN ISO 52120**). » `[C]` ⟦versions/protocoles exacts à valider par un expert⟧

> **Cybersécurité & données** : durcissement selon les recommandations **ANSSI** (objets connectés) et respect du **RGPD** (données personnelles). `[C]`

> **Gouvernance / relations** : la domotique **pilote** sans absorber les métiers voisins — courant fort → **Électricité générale**, infrastructure → **Réseaux VDI**, pilotage du **Chauffage** ; l'**alarme**, la **vidéosurveillance**, le **contrôle d'accès**, l'**interphonie** et le **photovoltaïque** sont des **activités distinctes** (futurs Livres, tags). `[C]`

## Cadre
- **Normes** : circuits / **actionneurs** pilotés **NF C 15-100** ; consignation à proximité des courants forts **NF C 18-510** ; systèmes domotiques **KNX (ISO/IEC 14543-3)**, protocoles (Zigbee/Z-Wave/**Matter**/Thread), performance de l'automatisation **NF EN ISO 52120**, cybersécurité (**ANSSI**) et données (**RGPD**) ⟦en prose, à confirmer⟧ `[B]` ⟦référence exacte à confirmer⟧. `respecte-norme`
- **Relations** : `cite-carte` → [cabler-rj45-reseau](../../professions/reseaux-vdi/cards/cabler-rj45-reseau.md).
- **Tags** : `metier:domotique famille:electricite type:phrase usage:normes cluster:normes cluster:reglementation relation:electricite-generale relation:reseaux-vdi relation:chauffage relation:alarme-intrusion relation:videosurveillance relation:controle-acces relation:interphonie relation:photovoltaique`

## Historique
| Version | Date | Auteur | Validateur | Motif |
|---|---|---|---|---|
| v0.1 | 2026-08-05 | IA | ⟦—⟧ | proposition initiale (Brouillon) |
