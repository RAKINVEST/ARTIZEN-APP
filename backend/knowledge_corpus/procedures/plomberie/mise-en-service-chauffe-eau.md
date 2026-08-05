# Mise en service d'un chauffe-eau

> **Brouillon (v0) — proposé par IA, en attente de validation métier** (Loi 7/18). Modèle : [../../cards/CARD_TEMPLATE.md](../../cards/CARD_TEMPLATE.md).
> Niveaux de confiance : A normes/fabricant · B technique · C terrain validé · D hypothèse.

## Métadonnées
| Champ | Valeur |
|---|---|
| Identifiant | `mise-en-service-chauffe-eau` |
| Titre | Mise en service d'un chauffe-eau |
| Profession | `metier:plomberie` |
| Famille | `famille:fluides` |
| Version | v0.1 |
| Auteur | IA (proposition) |
| Validateur | ⟦à valider métier⟧ |
| Statut | Brouillon |
| Indice de confiance | **C** |

## But
- Remettre un chauffe-eau en service en sécurité. `[B]`

## Étapes
1. **Remplir la cuve** et purger l'air (avant toute mise sous tension). `[A]`
2. Contrôler l'étanchéité et l'écoulement du groupe de sécurité. `[C]`
3. Remettre **sous tension** ; contrôler la chauffe. `[B]`

## Cadre
- **Normes** : installation sanitaire — **DTU 65.10** `[B]` ⟦référence exacte à confirmer par le validateur⟧. `respecte-norme`
- **Relations** : `cite-carte` → [entretenir-chauffe-eau-electrique](../../professions/plomberie/cards/entretenir-chauffe-eau-electrique.md).
- **Tags** : `metier:plomberie famille:fluides sous-famille:ecs type:procedure intervention:mettre-en-service equipement:chauffe-eau`

## Historique
| Version | Date | Auteur | Validateur | Motif |
|---|---|---|---|---|
| v0.1 | 2026-08-04 | IA | ⟦—⟧ | consolidation au standard Factory (Brouillon) |
