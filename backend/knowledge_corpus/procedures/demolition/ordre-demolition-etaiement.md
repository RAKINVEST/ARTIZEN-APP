# Ordre de démolition & étaiement (séquence sécurisée)

> **Brouillon (v0) — proposé par IA, en attente de validation métier** (Loi 7/18). Modèle : [../../cards/CARD_TEMPLATE.md](../../cards/CARD_TEMPLATE.md).
> Niveaux de confiance : A normes/fabricant · B technique · C terrain validé · D hypothèse.

## Métadonnées
| Champ | Valeur |
|---|---|
| Identifiant | `ordre-demolition-etaiement` |
| Titre | Ordre de démolition & étaiement (séquence sécurisée) |
| Profession | `metier:demolition` |
| Famille | `famille:gros-oeuvre` |
| Sous-famille | `sous-famille:securite` |
| Version | v0.1 |
| Auteur | IA (proposition) |
| Validateur | ⟦à valider métier⟧ |
| Statut | Brouillon |
| Indice de confiance | **B** |

## But
- Démolir dans un ordre sûr, sans provoquer d'effondrement. `[B]`

## Étapes (compétences requises)
1. **Diagnostics** (amiante/plomb/PEMD/structure) + **consignation réseaux**. `[A]` → [realiser-diagnostic-prealable](../../professions/demolition/cards/realiser-diagnostic-prealable.md)
2. **Étaiement** des porteurs concernés (étude). `[A]`
3. Démolir **du haut vers le bas**, du **non-porteur vers le porteur**. `[B]`
4. Poser les **reprises** avant retrait progressif de l'étaiement. `[B]`

> Un mauvais ordre ou un étaiement absent = **effondrement**. Opération réservée à des compétences adaptées. `[A]`

## Cadre
- **Normes** : démolition/reprise d'ouvrages en maçonnerie **DTU 20.1** et en béton **DTU 21** ; diagnostics réglementaires avant travaux (**PEMD** déchets, **amiante**, **plomb/CREP**) et **Code du travail** (étaiement/protection) ⟦en prose, à confirmer⟧ `[B]` ⟦référence exacte à confirmer⟧. `respecte-norme`
- **Relations** : `cite-carte` → [demolir-partiel-porteur-etaiement](../../professions/demolition/cards/demolir-partiel-porteur-etaiement.md).
- **Tags** : `metier:demolition famille:gros-oeuvre sous-famille:securite intervention:etayer cluster:demolition-partielle cluster:securite type:procedure securite:effondrement relation:maconnerie`

## Historique
| Version | Date | Auteur | Validateur | Motif |
|---|---|---|---|---|
| v0.1 | 2026-08-05 | IA | ⟦—⟧ | proposition initiale (Brouillon) |
