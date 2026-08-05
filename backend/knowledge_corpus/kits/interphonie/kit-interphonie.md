# Kit interphonie / visiophonie

> **Brouillon (v0) — proposé par IA, en attente de validation métier** (Loi 7/18). Modèle : [../../cards/CARD_TEMPLATE.md](../../cards/CARD_TEMPLATE.md).
> Niveaux de confiance : A normes/fabricant · B technique · C terrain validé · D hypothèse.

## Métadonnées
| Champ | Valeur |
|---|---|
| Identifiant | `kit-interphonie` |
| Titre | Kit interphonie / visiophonie |
| Profession | `metier:interphonie` |
| Famille | `famille:electricite` |
| Sous-famille | `sous-famille:interphonie` |
| Version | v0.1 |
| Auteur | IA (proposition) |
| Validateur | ⟦à valider métier⟧ |
| Statut | Brouillon |
| Indice de confiance | **C** |

## Composition conseillée
- Platine(s) de rue (audio/**visiophonie**), moniteurs/combinés, **alimentation** dédiée. `[C]`
- Câble **bus 2 fils** / câble réseau (IP/PoE) ; outils de raccordement. `[C]`
- Testeur (audio/vidéo), outil de programmation/adressage. `[C]`
- **EPI** électriques pour l'alimentation (réservée **habilité**). `[A]`

## Cadre
- **Normes** : alimentation des équipements **NF C 15-100** ; consignation à l'intervention **NF C 18-510** ; systèmes d'interphonie de bâtiment **EN 62820**, communication **SIP** (IP), données/images (**RGPD**, **CNIL**) et cybersécurité (**ANSSI**) ⟦en prose, à confirmer⟧ `[B]` ⟦référence exacte à confirmer⟧. `respecte-norme`
- **Relations** : `utilise-kit` → [installer-platine-rue](../../professions/interphonie/cards/installer-platine-rue.md).
- **Tags** : `metier:interphonie famille:electricite sous-famille:interphonie type:kit cluster:platines-de-rue cluster:moniteurs-interieurs equipement:platine-de-rue`

## Historique
| Version | Date | Auteur | Validateur | Motif |
|---|---|---|---|---|
| v0.1 | 2026-08-05 | IA | ⟦—⟧ | proposition initiale (Brouillon) |
