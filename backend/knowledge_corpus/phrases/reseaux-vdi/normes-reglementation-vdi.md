# Phrase — normes & réglementation VDI (courants faibles)

> **Brouillon (v0) — proposé par IA, en attente de validation métier** (Loi 7/18). Modèle : [../../cards/CARD_TEMPLATE.md](../../cards/CARD_TEMPLATE.md).
> Niveaux de confiance : A normes/fabricant · B technique · C terrain validé · D hypothèse.

## Métadonnées
| Champ | Valeur |
|---|---|
| Identifiant | `normes-reglementation-vdi` |
| Titre | Phrase — normes & réglementation VDI (courants faibles) |
| Profession | `metier:reseaux-vdi` |
| Famille | `famille:electricite` |
| Sous-famille | `sous-famille:reseaux-vdi` |
| Version | v0.1 |
| Auteur | IA (proposition) |
| Validateur | ⟦à valider métier⟧ |
| Statut | Brouillon |
| Indice de confiance | **C** |

## Formulation (clusters « Normes » / « Réglementation »)
> « Nos réseaux VDI respectent les règles de l'art : coffret de communication et grade résidentiel (**NF C 15-100**), consignation à proximité des courants forts (**NF C 18-510**), câblage résidentiel (**UTE C 90-483**) et systèmes de câblage (**NF EN 50173** / **ISO-IEC 11801**), avec **certification** de recette. » `[C]` ⟦versions/paramètres exacts à valider par un expert⟧

> **Gouvernance (taxonomie)** : ce Livre couvre l'activité **`reseaux-vdi`** ; l'**interphonie/visiophonie**, le **contrôle d'accès**, l'**alarme intrusion**, la **vidéosurveillance** et la **domotique** sont des **activités distinctes** (futurs Livres) — ici, seule l'**interface câblage** est traitée. `[C]`

> **Relations inter-Livres** : le VDI côtoie l'**Électricité générale** (coffret/tableau, séparation/consignation, mise à la terre — réservé habilité). `[C]`

## Cadre
- **Normes** : installation électrique et **coffret de communication** résidentiel **NF C 15-100** ; opérations / consignation à proximité des courants forts **NF C 18-510** ; câblage résidentiel VDI (**UTE C 90-483**), systèmes de câblage (**NF EN 50173** / **ISO-IEC 11801**), sécurité laser fibre (**NF EN 60825**) ⟦en prose, à confirmer⟧ `[B]` ⟦référence exacte à confirmer⟧. `respecte-norme`
- **Relations** : `cite-carte` → [controler-tableau-electrique](../../professions/electricite-generale/cards/controler-tableau-electrique.md).
- **Tags** : `metier:reseaux-vdi famille:electricite type:phrase usage:normes cluster:normes cluster:reglementation relation:electricite-generale relation:interphonie relation:controle-acces relation:domotique`

## Historique
| Version | Date | Auteur | Validateur | Motif |
|---|---|---|---|---|
| v0.1 | 2026-08-05 | IA | ⟦—⟧ | proposition initiale (Brouillon) |
