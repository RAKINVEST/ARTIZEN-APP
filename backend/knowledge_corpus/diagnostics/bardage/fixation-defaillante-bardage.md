# Fixation défaillante / élément qui bouge

> **Brouillon (v0) — proposé par IA, en attente de validation métier** (Loi 7/18). Modèle : [../../cards/CARD_TEMPLATE.md](../../cards/CARD_TEMPLATE.md).
> Niveaux de confiance : A normes/fabricant · B technique · C terrain validé · D hypothèse.

## Métadonnées
| Champ | Valeur |
|---|---|
| Identifiant | `fixation-defaillante-bardage` |
| Titre | Fixation défaillante / élément qui bouge |
| Profession | `metier:bardage` |
| Famille | `famille:enveloppe` |
| Sous-famille | `sous-famille:bardage` |
| Version | v0.1 |
| Auteur | IA (proposition) |
| Validateur | ⟦à valider métier⟧ |
| Statut | Brouillon |
| Indice de confiance | **C** |

## Symptôme
- Élément de bardage **desserré**, qui claque au vent, ou fixation apparente corrodée. `[C]`

> Risque de **chute d'élément** (prise au vent) → sécuriser la zone. `[B]`

## Causes probables
1. Fixation sous-dimensionnée / corrodée (non inox). `[C]` → [poser-bardage-bois](../../professions/bardage/cards/poser-bardage-bois.md)
2. **Prise au vent** (zone exposée, densité de fixation insuffisante). `[C]`
3. Ossature/support dégradé. `[C]` → [poser-ossature-lame-air](../../professions/bardage/cards/poser-ossature-lame-air.md)

## Résolution
- Reprendre/renforcer les **fixations** (inox, densité adaptée au vent), contrôler l'ossature. `[C]`

## Cadre
- **Normes** : revêtements extérieurs en bois (bardage) **DTU 41.2** ; support en maçonnerie **DTU 20.1** ; bardages composite/fibres-ciment/métallique/terre cuite sous **Avis Technique** ⟦à confirmer⟧ `[B]` ⟦référence exacte à confirmer⟧. `respecte-norme`
- **Relations** : `traite-diagnostic` → [entretenir-controler-bardage](../../professions/bardage/cards/entretenir-controler-bardage.md).
- **Tags** : `metier:bardage famille:enveloppe sous-famille:bardage probleme:fixation cluster:diagnostic cluster:fixations cluster:reparation type:diagnostic securite:hauteur`

## Historique
| Version | Date | Auteur | Validateur | Motif |
|---|---|---|---|---|
| v0.1 | 2026-08-05 | IA | ⟦—⟧ | proposition initiale (Brouillon) |
