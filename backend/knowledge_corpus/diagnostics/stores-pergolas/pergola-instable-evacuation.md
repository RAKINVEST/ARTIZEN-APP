# Pergola instable / évacuation défaillante

> **Brouillon (v0) — proposé par IA, en attente de validation métier** (Loi 7/18). Modèle : [../../cards/CARD_TEMPLATE.md](../../cards/CARD_TEMPLATE.md).
> Niveaux de confiance : A normes/fabricant · B technique · C terrain validé · D hypothèse.

## Métadonnées
| Champ | Valeur |
|---|---|
| Identifiant | `pergola-instable-evacuation` |
| Titre | Pergola instable / évacuation défaillante |
| Profession | `metier:stores-pergolas` |
| Famille | `famille:enveloppe` |
| Sous-famille | `sous-famille:stores-pergolas` |
| Version | v0.1 |
| Auteur | IA (proposition) |
| Validateur | ⟦à valider métier⟧ |
| Statut | Brouillon |
| Indice de confiance | **C** |

## Symptôme
- Pergola qui **bouge/vibre** au vent, ou évacuation d'eau qui **déborde** (lames/chenaux). `[C]`

> Une pergola instable au vent = **danger** (arrachement) → sécuriser et diagnostiquer l'ancrage. `[B]`

## Causes probables
1. **Ancrage/fixation** sous-dimensionné ou dégradé. `[C]` → [installer-pergola](../../professions/stores-pergolas/cards/installer-pergola.md)
2. **Évacuation d'eau** (chenaux/descentes) obstruée. `[C]`
3. Interface adossée défaillante (mur/toiture). `[C]` → [traiter-penetrations-points-singuliers](../../professions/etancheite/cards/traiter-penetrations-points-singuliers.md)

## Résolution
- Reprendre/renforcer l'**ancrage** (charges vent/neige), dégager l'évacuation, traiter l'interface. `[C]`

## Cadre
- **Normes** : fermetures / stores **DTU 34.1** ; fixation sur support maçonné **DTU 20.1** ; stores extérieurs **NF EN 13561** (classes de résistance au vent) et pergolas dimensionnées selon les **Eurocodes** (charges vent/neige) ⟦à confirmer⟧ `[B]` ⟦référence exacte à confirmer⟧. `respecte-norme`
- **Relations** : `traite-diagnostic` → [entretenir-controler-store-pergola](../../professions/stores-pergolas/cards/entretenir-controler-store-pergola.md).
- **Tags** : `metier:stores-pergolas equipement:pergola famille:enveloppe sous-famille:stores-pergolas probleme:instabilite cluster:pergolas-bioclimatiques cluster:diagnostic type:diagnostic securite:manutention relation:etancheite`

## Historique
| Version | Date | Auteur | Validateur | Motif |
|---|---|---|---|---|
| v0.1 | 2026-08-05 | IA | ⟦—⟧ | proposition initiale (Brouillon) |
