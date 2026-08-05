# Goût / odeur / couleur de l'eau

> **Brouillon (v0) — proposé par IA, en attente de validation métier** (Loi 7/18). Modèle : [../../cards/CARD_TEMPLATE.md](../../cards/CARD_TEMPLATE.md).
> Niveaux de confiance : A normes/fabricant · B technique · C terrain validé · D hypothèse.

## Métadonnées
| Champ | Valeur |
|---|---|
| Identifiant | `gout-odeur-couleur-eau` |
| Titre | Goût / odeur / couleur de l'eau |
| Profession | `metier:traitement-eau` |
| Famille | `famille:fluides` |
| Sous-famille | `sous-famille:traitement-eau` |
| Version | v0.1 |
| Auteur | IA (proposition) |
| Validateur | ⟦à valider métier⟧ |
| Statut | Brouillon |
| Indice de confiance | **C** |

## Symptôme
- Eau au **goût/odeur** de chlore, **colorée** (rouille), trouble. `[C]`

## Causes probables
1. **Chlore** / goûts → affinage charbon actif. `[C]` → [installer-charbon-actif](../../professions/traitement-eau/cards/installer-charbon-actif.md)
2. **Fer/manganese** (couleur) / sédiments. `[C]` → [installer-filtration-sediments](../../professions/traitement-eau/cards/installer-filtration-sediments.md)
3. Stagnation / développement dans un filtre saturé. `[C]` → [traitement-inefficace-contamination](traitement-inefficace-contamination.md)

## Résolution
- **Analyser l'eau**, adapter le traitement (charbon/filtration), remplacer les cartouches saturées, désinfecter. `[C]`

## Cadre
- **Normes** : installation sur réseau sanitaire **DTU 60.1** ; alimentation électrique des systèmes (UV) **NF C 15-100** ; protection contre les **retours d'eau** (**NF EN 1717**), qualité de l'eau (**arrêté du 11 janvier 2007**, Code de la santé), matériaux **ACS** ⟦en prose, à confirmer⟧ `[B]` ⟦référence exacte à confirmer⟧. `respecte-norme`
- **Relations** : `traite-diagnostic` → [entretenir-controler-traitement-eau](../../professions/traitement-eau/cards/entretenir-controler-traitement-eau.md).
- **Tags** : `metier:traitement-eau famille:fluides sous-famille:traitement-eau probleme:gout cluster:charbon-actif cluster:diagnostic type:diagnostic securite:sanitaire`

## Historique
| Version | Date | Auteur | Validateur | Motif |
|---|---|---|---|---|
| v0.1 | 2026-08-05 | IA | ⟦—⟧ | proposition initiale (Brouillon) |
