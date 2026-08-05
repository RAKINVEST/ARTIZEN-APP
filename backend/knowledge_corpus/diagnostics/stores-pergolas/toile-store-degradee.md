# Toile de store dégradée

> **Brouillon (v0) — proposé par IA, en attente de validation métier** (Loi 7/18). Modèle : [../../cards/CARD_TEMPLATE.md](../../cards/CARD_TEMPLATE.md).
> Niveaux de confiance : A normes/fabricant · B technique · C terrain validé · D hypothèse.

## Métadonnées
| Champ | Valeur |
|---|---|
| Identifiant | `toile-store-degradee` |
| Titre | Toile de store dégradée |
| Profession | `metier:stores-pergolas` |
| Famille | `famille:enveloppe` |
| Sous-famille | `sous-famille:stores-pergolas` |
| Version | v0.1 |
| Auteur | IA (proposition) |
| Validateur | ⟦à valider métier⟧ |
| Statut | Brouillon |
| Indice de confiance | **C** |

## Symptôme
- Toile **déchirée**, détendue, décolorée ou **moisie**. `[C]`

## Causes probables
1. Vieillissement / UV / exposition. `[C]`
2. **Rangée humide** (toile enroulée mouillée) → moisissure. `[C]`
3. Tension mal réglée / bras faussé. `[C]` → [reparer-toile-mecanisme](../../professions/stores-pergolas/cards/reparer-toile-mecanisme.md)

## Résolution
- Remplacer la toile (référence compatible), re-régler tension ; éviter de ranger la toile humide. `[C]`

## Cadre
- **Normes** : fermetures / stores **DTU 34.1** ; fixation sur support maçonné **DTU 20.1** ; stores extérieurs **NF EN 13561** (classes de résistance au vent) et pergolas dimensionnées selon les **Eurocodes** (charges vent/neige) ⟦à confirmer⟧ `[B]` ⟦référence exacte à confirmer⟧. `respecte-norme`
- **Relations** : `traite-diagnostic` → [reparer-toile-mecanisme](../../professions/stores-pergolas/cards/reparer-toile-mecanisme.md).
- **Tags** : `metier:stores-pergolas equipement:store-banne famille:enveloppe sous-famille:stores-pergolas probleme:degradation cluster:reparation cluster:diagnostic type:diagnostic securite:manutention`

## Historique
| Version | Date | Auteur | Validateur | Motif |
|---|---|---|---|---|
| v0.1 | 2026-08-05 | IA | ⟦—⟧ | proposition initiale (Brouillon) |
