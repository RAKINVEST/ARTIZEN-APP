# Eau dure / entartrage

> **Brouillon (v0) — proposé par IA, en attente de validation métier** (Loi 7/18). Modèle : [../../cards/CARD_TEMPLATE.md](../../cards/CARD_TEMPLATE.md).
> Niveaux de confiance : A normes/fabricant · B technique · C terrain validé · D hypothèse.

## Métadonnées
| Champ | Valeur |
|---|---|
| Identifiant | `eau-dure-tartre` |
| Titre | Eau dure / entartrage |
| Profession | `metier:traitement-eau` |
| Famille | `famille:fluides` |
| Sous-famille | `sous-famille:traitement-eau` |
| Version | v0.1 |
| Auteur | IA (proposition) |
| Validateur | ⟦à valider métier⟧ |
| Statut | Brouillon |
| Indice de confiance | **C** |

## Symptôme
- **Tartre** (résistances, robinetterie), dépôts blancs, baisse de rendement chauffe-eau. `[C]`

## Causes probables
1. **TH élevé** (eau dure) non traité. `[C]` → [installer-adoucisseur](../../professions/traitement-eau/cards/installer-adoucisseur.md)
2. Adoucisseur déréglé / en panne (sel, régénération). `[C]` → [entretenir-controler-traitement-eau](../../professions/traitement-eau/cards/entretenir-controler-traitement-eau.md)
3. By-pass ouvert / anti-tartre inefficace. `[C]` → [installer-anti-tartre](../../professions/traitement-eau/cards/installer-anti-tartre.md)

## Résolution
- Mesurer le **TH**, régler/réparer l'adoucisseur ou proposer une solution adaptée ; détartrer la génération. `[C]`

## Cadre
- **Normes** : installation sur réseau sanitaire **DTU 60.1** ; alimentation électrique des systèmes (UV) **NF C 15-100** ; protection contre les **retours d'eau** (**NF EN 1717**), qualité de l'eau (**arrêté du 11 janvier 2007**, Code de la santé), matériaux **ACS** ⟦en prose, à confirmer⟧ `[B]` ⟦référence exacte à confirmer⟧. `respecte-norme`
- **Relations** : `traite-diagnostic` → [installer-adoucisseur](../../professions/traitement-eau/cards/installer-adoucisseur.md).
- **Tags** : `metier:traitement-eau famille:fluides sous-famille:traitement-eau probleme:tartre cluster:adoucisseurs cluster:diagnostic type:diagnostic securite:sanitaire relation:chauffage`

## Historique
| Version | Date | Auteur | Validateur | Motif |
|---|---|---|---|---|
| v0.1 | 2026-08-05 | IA | ⟦—⟧ | proposition initiale (Brouillon) |
