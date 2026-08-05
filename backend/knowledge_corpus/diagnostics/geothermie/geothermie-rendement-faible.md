# Rendement géothermique faible

> **Brouillon (v0) — proposé par IA, en attente de validation métier** (Loi 7/18). Modèle : [../../cards/CARD_TEMPLATE.md](../../cards/CARD_TEMPLATE.md).
> Niveaux de confiance : A normes/fabricant · B technique · C terrain validé · D hypothèse.

## Métadonnées
| Champ | Valeur |
|---|---|
| Identifiant | `geothermie-rendement-faible` |
| Titre | Rendement géothermique faible |
| Profession | `metier:geothermie` |
| Famille | `famille:fluides` |
| Sous-famille | `sous-famille:captage` |
| Version | v0.1 |
| Auteur | IA (proposition) |
| Validateur | ⟦à valider métier⟧ |
| Statut | Brouillon |
| Indice de confiance | **C** |

## Symptôme
- Performances/économies **inférieures** aux attentes. `[C]`

## Causes probables
1. **Débit** de captage insuffisant / déséquilibre. `[C]` → [controler-collecteur-geothermie](../../professions/geothermie/cards/controler-collecteur-geothermie.md)
2. **Échangeur** encrassé / boues. `[C]` → [controler-echangeur-geothermie](../../professions/geothermie/cards/controler-echangeur-geothermie.md)
3. Caloporteur inadapté (taux). `[C]`
4. Défaut côté **PAC** → **frigoriste F-Gaz**. `[D]`

## Résolution
- Contrôler débit/échangeur/caloporteur ; PAC → qualifié. `[C]`

## Cadre
- **Normes** : installation électrique **NF C 15-100** ; réglementation **géothermie de minime importance (GMI)** ; dimensionnement **NF EN 15450** `[B]` ⟦référence exacte à confirmer⟧. `respecte-norme`
- **Relations** : `traite-diagnostic` → [controler-echangeur-geothermie](../../professions/geothermie/cards/controler-echangeur-geothermie.md).
- **Tags** : `metier:geothermie equipement:echangeur famille:fluides sous-famille:captage probleme:rendement cluster:diagnostic cluster:depannage cluster:echangeurs type:diagnostic`

## Historique
| Version | Date | Auteur | Validateur | Motif |
|---|---|---|---|---|
| v0.1 | 2026-08-04 | IA | ⟦—⟧ | proposition initiale (Brouillon) |
