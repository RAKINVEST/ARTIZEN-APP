# Contrôle de réception d'un store / d'une pergola

> **Brouillon (v0) — proposé par IA, en attente de validation métier** (Loi 7/18). Modèle : [../../cards/CARD_TEMPLATE.md](../../cards/CARD_TEMPLATE.md).
> Niveaux de confiance : A normes/fabricant · B technique · C terrain validé · D hypothèse.

## Métadonnées
| Champ | Valeur |
|---|---|
| Identifiant | `controle-reception-store-pergola` |
| Titre | Contrôle de réception d'un store / d'une pergola |
| Profession | `metier:stores-pergolas` |
| Famille | `famille:enveloppe` |
| Sous-famille | `sous-famille:stores-pergolas` |
| Version | v0.1 |
| Auteur | IA (proposition) |
| Validateur | ⟦à valider métier⟧ |
| Statut | Brouillon |
| Indice de confiance | **C** |

## But
- Vérifier la conformité et la sécurité d'un store/d'une pergola posé(e). `[C]`

## Étapes
1. **Ancrage/fixations** dimensionnés au support et aux **charges** (vent/neige). `[A]` ⟦à confirmer⟧
2. **Aplomb/niveau** ; jeux ; évacuation d'eau (pergola). `[C]`
3. **Fonctionnement** manœuvre / fins de course. `[C]` → [motoriser-regler-store-pergola](../../professions/stores-pergolas/cards/motoriser-regler-store-pergola.md)
4. **Capteurs** (vent = sécurité) testés ; raccordement électrique par un pro. `[A]`

## Cadre
- **Normes** : fermetures / stores **DTU 34.1** ; fixation sur support maçonné **DTU 20.1** ; stores extérieurs **NF EN 13561** (classes de résistance au vent) et pergolas dimensionnées selon les **Eurocodes** (charges vent/neige) ⟦à confirmer⟧ `[B]` ⟦référence exacte à confirmer⟧. `respecte-norme`
- **Relations** : `cite-carte` → [installer-pergola](../../professions/stores-pergolas/cards/installer-pergola.md).
- **Tags** : `metier:stores-pergolas famille:enveloppe sous-famille:stores-pergolas intervention:controler cluster:controle cluster:motorisations cluster:capteurs-vent-pluie type:procedure securite:manutention`

## Historique
| Version | Date | Auteur | Validateur | Motif |
|---|---|---|---|---|
| v0.1 | 2026-08-05 | IA | ⟦—⟧ | proposition initiale (Brouillon) |
