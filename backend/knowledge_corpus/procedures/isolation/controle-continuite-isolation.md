# Contrôle de la continuité de l'isolation

> **Brouillon (v0) — proposé par IA, en attente de validation métier** (Loi 7/18). Modèle : [../../cards/CARD_TEMPLATE.md](../../cards/CARD_TEMPLATE.md).
> Niveaux de confiance : A normes/fabricant · B technique · C terrain validé · D hypothèse.

## Métadonnées
| Champ | Valeur |
|---|---|
| Identifiant | `controle-continuite-isolation` |
| Titre | Contrôle de la continuité de l'isolation |
| Profession | `metier:isolation` |
| Famille | `famille:enveloppe` |
| Sous-famille | `sous-famille:isolation` |
| Version | v0.1 |
| Auteur | IA (proposition) |
| Validateur | ⟦à valider métier⟧ |
| Statut | Brouillon |
| Indice de confiance | **C** |

## But
- Vérifier la continuité de l'isolant et de l'étanchéité à l'air (limiter ponts thermiques et fuites). `[C]`

## Étapes
1. Vérifier l'**absence de discontinuité** de l'isolant (jonctions, liaisons). `[C]`
2. Contrôler la **continuité du pare/frein-vapeur** (lés, adhésifs, passages). `[C]` → [poser-pare-vapeur](../../professions/isolation/cards/poser-pare-vapeur.md)
3. Repérer les **ponts thermiques** résiduels. `[C]` → [traiter-ponts-thermiques](../../professions/isolation/cards/traiter-ponts-thermiques.md)
4. Vérifier la cohérence avec la **ventilation**. `[C]` ⟦test d'infiltrométrie à confirmer⟧

## Cadre
- **Normes** : isolation des combles par soufflage **DTU 45.10** ; isolation thermique de combles **DTU 45.11** ; doublage / plaques de plâtre (isolation intérieure) **DTU 25.41** `[B]` ⟦référence exacte à confirmer⟧. `respecte-norme`
- **Relations** : `cite-carte` → [diagnostiquer-isolation](../../professions/isolation/cards/diagnostiquer-isolation.md).
- **Tags** : `metier:isolation famille:enveloppe sous-famille:isolation intervention:controler cluster:continuite-de-l-isolation cluster:controle cluster:ponts-thermiques type:procedure securite:respiratoire relation:ventilation`

## Historique
| Version | Date | Auteur | Validateur | Motif |
|---|---|---|---|---|
| v0.1 | 2026-08-04 | IA | ⟦—⟧ | proposition initiale (Brouillon) |
