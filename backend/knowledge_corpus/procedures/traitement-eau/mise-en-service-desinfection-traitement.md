# Mise en service & désinfection d'un traitement

> **Brouillon (v0) — proposé par IA, en attente de validation métier** (Loi 7/18). Modèle : [../../cards/CARD_TEMPLATE.md](../../cards/CARD_TEMPLATE.md).
> Niveaux de confiance : A normes/fabricant · B technique · C terrain validé · D hypothèse.

## Métadonnées
| Champ | Valeur |
|---|---|
| Identifiant | `mise-en-service-desinfection-traitement` |
| Titre | Mise en service & désinfection d'un traitement |
| Profession | `metier:traitement-eau` |
| Famille | `famille:fluides` |
| Sous-famille | `sous-famille:traitement-eau` |
| Version | v0.1 |
| Auteur | IA (proposition) |
| Validateur | ⟦à valider métier⟧ |
| Statut | Brouillon |
| Indice de confiance | **C** |

## But
- Mettre en service un équipement de traitement **sans dégrader** l'eau (désinfection). `[C]`

## Étapes
1. Vérifier le montage : sens, **by-pass**, **protection retours d'eau**. `[A]`
2. Rincer abondamment (évacuer fines/conservateurs des cartouches). `[C]`
3. **Désinfecter** l'équipement selon la notice ; rincer. `[C]` ⟦produit/dose à confirmer⟧
4. Contrôler (TH/pression) et faire **analyser l'eau**. `[A]` → [entretenir-controler-traitement-eau](../../professions/traitement-eau/cards/entretenir-controler-traitement-eau.md)

> Un rinçage/désinfection insuffisant = **risque sanitaire** à la mise en service. `[A]`

## Cadre
- **Normes** : installation sur réseau sanitaire **DTU 60.1** ; alimentation électrique des systèmes (UV) **NF C 15-100** ; protection contre les **retours d'eau** (**NF EN 1717**), qualité de l'eau (**arrêté du 11 janvier 2007**, Code de la santé), matériaux **ACS** ⟦en prose, à confirmer⟧ `[B]` ⟦référence exacte à confirmer⟧. `respecte-norme`
- **Relations** : `cite-carte` → [installer-adoucisseur](../../professions/traitement-eau/cards/installer-adoucisseur.md).
- **Tags** : `metier:traitement-eau famille:fluides sous-famille:traitement-eau intervention:controler cluster:desinfection cluster:controle type:procedure securite:sanitaire`

## Historique
| Version | Date | Auteur | Validateur | Motif |
|---|---|---|---|---|
| v0.1 | 2026-08-05 | IA | ⟦—⟧ | proposition initiale (Brouillon) |
