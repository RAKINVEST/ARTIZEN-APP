# Poteau descellé / qui penche

> **Brouillon (v0) — proposé par IA, en attente de validation métier** (Loi 7/18). Modèle : [../../cards/CARD_TEMPLATE.md](../../cards/CARD_TEMPLATE.md).
> Niveaux de confiance : A normes/fabricant · B technique · C terrain validé · D hypothèse.

## Métadonnées
| Champ | Valeur |
|---|---|
| Identifiant | `poteau-descelle-penche` |
| Titre | Poteau descellé / qui penche |
| Profession | `metier:cloture` |
| Famille | `famille:specialises` |
| Sous-famille | `sous-famille:cloture` |
| Version | v0.1 |
| Auteur | IA (proposition) |
| Validateur | ⟦à valider métier⟧ |
| Statut | Brouillon |
| Indice de confiance | **C** |

## Symptôme
- Poteau qui **penche**, bouge, scellement fissuré, clôture qui ondule. `[C]`

## Causes probables
1. **Scellement** insuffisant (profondeur/dosage, hors-gel non respecté). `[C]` → [sceller-poteaux-ancrages](../../professions/cloture/cards/sceller-poteaux-ancrages.md)
2. **Prise au vent** (clôture pleine) trop forte pour la fixation. `[C]` → [poser-cloture-panneaux-occultante](../../professions/cloture/cards/poser-cloture-panneaux-occultante.md)
3. Sol instable / poussée (mouvement de terrain). `[C]`

## Résolution
- Reprendre le **scellement** (profondeur hors-gel, béton), renforcer la fixation, adapter la prise au vent ; réaligner. `[C]`

## Cadre
- **Normes** : béton de scellement des poteaux (**interface**) **DTU 21** ; ouvrages métalliques / portillons (**interface** métallerie) **DTU 37.1** ; grillages **NF EN 10223**, protection anticorrosion **NF EN ISO 1461 / NF EN ISO 12944**, règles d'**urbanisme** (PLU : hauteur/aspect), **bornage** (Code civil, géomètre) et **DT-DICT** (réseaux) ⟦en prose, à confirmer⟧ `[B]` ⟦référence exacte à confirmer⟧. `respecte-norme`
- **Relations** : `traite-diagnostic` → [sceller-poteaux-ancrages](../../professions/cloture/cards/sceller-poteaux-ancrages.md).
- **Tags** : `metier:cloture famille:specialises sous-famille:cloture probleme:descellement cluster:scellement cluster:diagnostic type:diagnostic securite:manutention`

## Historique
| Version | Date | Auteur | Validateur | Motif |
|---|---|---|---|---|
| v0.1 | 2026-08-05 | IA | ⟦—⟧ | proposition initiale (Brouillon) |
