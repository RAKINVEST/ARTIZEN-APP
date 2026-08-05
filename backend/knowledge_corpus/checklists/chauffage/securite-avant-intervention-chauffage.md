# Sécurité avant intervention chauffage

> **Brouillon (v0) — proposé par IA, en attente de validation métier** (Loi 7/18). Modèle : [../../cards/CARD_TEMPLATE.md](../../cards/CARD_TEMPLATE.md).
> Niveaux de confiance : A normes/fabricant · B technique · C terrain validé · D hypothèse.

## Métadonnées
| Champ | Valeur |
|---|---|
| Identifiant | `securite-avant-intervention-chauffage` |
| Titre | Sécurité avant intervention chauffage |
| Profession | `metier:chauffage` |
| Famille | `famille:fluides` |
| Sous-famille | `sous-famille:generation` |
| Version | v0.1 |
| Auteur | IA (proposition) |
| Validateur | ⟦à valider métier⟧ |
| Statut | Brouillon |
| Indice de confiance | **B** |

## Points à vérifier
- [ ] Combustible **coupé** (gaz/fioul) si intervention générateur. `[A]`
- [ ] Électricité **consignée**. `[A]`
- [ ] Circuit **dépressurisé** / refroidi avant ouverture. `[B]`
- [ ] Ventilation du local et détection **CO** le cas échéant. `[B]`
- [ ] EPI adaptés ; zone protégée. `[B]`

## Cadre
- **Normes** : sécurité chauffage central **DTU 65.11** `[B]` ⟦référence exacte à confirmer⟧. `respecte-norme`
- **Relations** : `cite-carte` → [entretenir-chaudiere](../../professions/chauffage/cards/entretenir-chaudiere.md).
- **Tags** : `metier:chauffage famille:fluides sous-famille:generation type:checklist cluster:securite controle:consignation securite:combustion`

## Historique
| Version | Date | Auteur | Validateur | Motif |
|---|---|---|---|---|
| v0.1 | 2026-08-04 | IA | ⟦—⟧ | proposition initiale (Brouillon) |
