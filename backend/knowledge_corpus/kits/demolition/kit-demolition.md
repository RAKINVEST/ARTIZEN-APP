# Kit démolition / curage

> **Brouillon (v0) — proposé par IA, en attente de validation métier** (Loi 7/18). Modèle : [../../cards/CARD_TEMPLATE.md](../../cards/CARD_TEMPLATE.md).
> Niveaux de confiance : A normes/fabricant · B technique · C terrain validé · D hypothèse.

## Métadonnées
| Champ | Valeur |
|---|---|
| Identifiant | `kit-demolition` |
| Titre | Kit démolition / curage |
| Profession | `metier:demolition` |
| Famille | `famille:gros-oeuvre` |
| Sous-famille | `sous-famille:demolition` |
| Version | v0.1 |
| Auteur | IA (proposition) |
| Validateur | ⟦à valider métier⟧ |
| Statut | Brouillon |
| Indice de confiance | **C** |

## Composition conseillée (organisationnelle + sécurité)
- **Rapports de diagnostics** (amiante avant travaux, plomb, **PEMD**) + attestation de consignation. `[A]`
- Outils (masse, burineur, scie/carotteuse à **eau**), moyens d'étaiement. `[C]`
- Bennes de **tri** + balisage/protections périmètre. `[C]`
- **EPI** : masque **silice**, protection auditive, lunettes, antichute, gants. `[A]`

## Cadre
- **Normes** : démolition/reprise d'ouvrages en maçonnerie **DTU 20.1** et en béton **DTU 21** ; diagnostics réglementaires avant travaux (**PEMD** déchets, **amiante**, **plomb/CREP**) et **Code du travail** (étaiement/protection) ⟦en prose, à confirmer⟧ `[B]` ⟦référence exacte à confirmer⟧. `respecte-norme`
- **Relations** : `utilise-kit` → [controler-securiser-chantier-demolition](../../professions/demolition/cards/controler-securiser-chantier-demolition.md).
- **Tags** : `metier:demolition famille:gros-oeuvre sous-famille:demolition type:kit cluster:curage cluster:tri-des-dechets equipement:carotteuse`

## Historique
| Version | Date | Auteur | Validateur | Motif |
|---|---|---|---|---|
| v0.1 | 2026-08-05 | IA | ⟦—⟧ | proposition initiale (Brouillon) |
