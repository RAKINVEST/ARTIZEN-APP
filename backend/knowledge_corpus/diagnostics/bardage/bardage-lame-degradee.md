# Lame de bardage dégradée

> **Brouillon (v0) — proposé par IA, en attente de validation métier** (Loi 7/18). Modèle : [../../cards/CARD_TEMPLATE.md](../../cards/CARD_TEMPLATE.md).
> Niveaux de confiance : A normes/fabricant · B technique · C terrain validé · D hypothèse.

## Métadonnées
| Champ | Valeur |
|---|---|
| Identifiant | `bardage-lame-degradee` |
| Titre | Lame de bardage dégradée |
| Profession | `metier:bardage` |
| Famille | `famille:enveloppe` |
| Sous-famille | `sous-famille:bardage` |
| Version | v0.1 |
| Auteur | IA (proposition) |
| Validateur | ⟦à valider métier⟧ |
| Statut | Brouillon |
| Indice de confiance | **C** |

## Symptôme
- Lame/panneau **gauchi**, fendu, **pourri** (bois), corrodé (métal) ou décoloré. `[C]`

## Causes probables
1. Exposition / classe d'emploi inadaptée (bois). `[C]` → [choisir-bardage](../../professions/bardage/cards/choisir-bardage.md)
2. **Humidité piégée** (lame d'air/ventilation défaillante). `[C]` → [lame-air-obstruee-ventilation](lame-air-obstruee-ventilation.md)
3. Fixation ou jeu inadapté (bridage du bois). `[C]`

## Résolution
- Traiter la cause (ventilation), **remplacer** l'élément par un identique. `[C]` → [remplacer-element-bardage](../../professions/bardage/cards/remplacer-element-bardage.md)

## Cadre
- **Normes** : revêtements extérieurs en bois (bardage) **DTU 41.2** ; support en maçonnerie **DTU 20.1** ; bardages composite/fibres-ciment/métallique/terre cuite sous **Avis Technique** ⟦à confirmer⟧ `[B]` ⟦référence exacte à confirmer⟧. `respecte-norme`
- **Relations** : `traite-diagnostic` → [remplacer-element-bardage](../../professions/bardage/cards/remplacer-element-bardage.md).
- **Tags** : `metier:bardage famille:enveloppe sous-famille:bardage probleme:degradation cluster:diagnostic cluster:bardage-bois cluster:remplacement type:diagnostic securite:hauteur`

## Historique
| Version | Date | Auteur | Validateur | Motif |
|---|---|---|---|---|
| v0.1 | 2026-08-05 | IA | ⟦—⟧ | proposition initiale (Brouillon) |
