# Lame d'air obstruée / ventilation défaillante

> **Brouillon (v0) — proposé par IA, en attente de validation métier** (Loi 7/18). Modèle : [../../cards/CARD_TEMPLATE.md](../../cards/CARD_TEMPLATE.md).
> Niveaux de confiance : A normes/fabricant · B technique · C terrain validé · D hypothèse.

## Métadonnées
| Champ | Valeur |
|---|---|
| Identifiant | `lame-air-obstruee-ventilation` |
| Titre | Lame d'air obstruée / ventilation défaillante |
| Profession | `metier:bardage` |
| Famille | `famille:enveloppe` |
| Sous-famille | `sous-famille:bardage` |
| Version | v0.1 |
| Auteur | IA (proposition) |
| Validateur | ⟦à valider métier⟧ |
| Statut | Brouillon |
| Indice de confiance | **C** |

## Symptôme
- Condensation/humidité derrière le bardage, grilles bouchées, matériau qui se dégrade par l'arrière. `[C]`

> Une **lame d'air non ventilée** = humidité piégée → dégradation accélérée du bardage et du support. `[B]`

## Causes probables
1. **Grilles** d'entrée/sortie obstruées (débris, nids). `[C]`
2. Lame d'air discontinue / écrangée à la pose. `[C]` → [poser-ossature-lame-air](../../professions/bardage/cards/poser-ossature-lame-air.md)
3. Soubassement/couronnement mal ventilé. `[C]`

## Résolution
- **Dégager la ventilation** (grilles), rétablir la continuité de la lame d'air. `[C]`

## Cadre
- **Normes** : revêtements extérieurs en bois (bardage) **DTU 41.2** ; support en maçonnerie **DTU 20.1** ; bardages composite/fibres-ciment/métallique/terre cuite sous **Avis Technique** ⟦à confirmer⟧ `[B]` ⟦référence exacte à confirmer⟧. `respecte-norme`
- **Relations** : `traite-diagnostic` → [entretenir-controler-bardage](../../professions/bardage/cards/entretenir-controler-bardage.md).
- **Tags** : `metier:bardage famille:enveloppe sous-famille:bardage probleme:ventilation probleme:humidite cluster:diagnostic cluster:lame-air-ventilee type:diagnostic securite:hauteur`

## Historique
| Version | Date | Auteur | Validateur | Motif |
|---|---|---|---|---|
| v0.1 | 2026-08-05 | IA | ⟦—⟧ | proposition initiale (Brouillon) |
