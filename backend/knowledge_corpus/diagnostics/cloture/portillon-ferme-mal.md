# Portillon qui ferme mal

> **Brouillon (v0) — proposé par IA, en attente de validation métier** (Loi 7/18). Modèle : [../../cards/CARD_TEMPLATE.md](../../cards/CARD_TEMPLATE.md).
> Niveaux de confiance : A normes/fabricant · B technique · C terrain validé · D hypothèse.

## Métadonnées
| Champ | Valeur |
|---|---|
| Identifiant | `portillon-ferme-mal` |
| Titre | Portillon qui ferme mal |
| Profession | `metier:cloture` |
| Famille | `famille:specialises` |
| Sous-famille | `sous-famille:cloture` |
| Version | v0.1 |
| Auteur | IA (proposition) |
| Validateur | ⟦à valider métier⟧ |
| Statut | Brouillon |
| Indice de confiance | **C** |

## Symptôme
- Portillon qui **frotte**, ne ferme plus, **penche**, loquet désaxé. `[C]`

## Causes probables
1. **Poteau** de portillon descellé/penché. `[C]` → [poteau-descelle-penche](poteau-descelle-penche.md)
2. **Gonds** usés / déréglés. `[C]` → [poser-portillon-non-motorise](../../professions/cloture/cards/poser-portillon-non-motorise.md)
3. Vantail déformé (choc/corrosion). `[C]`

## Résolution
- Reprendre le scellement du poteau, régler/remplacer les gonds, réaligner le loquet ; si **motorisé**, l'automatisme relève d'un métier distinct (Automatismes). `[C]`

## Cadre
- **Normes** : béton de scellement des poteaux (**interface**) **DTU 21** ; ouvrages métalliques / portillons (**interface** métallerie) **DTU 37.1** ; grillages **NF EN 10223**, protection anticorrosion **NF EN ISO 1461 / NF EN ISO 12944**, règles d'**urbanisme** (PLU : hauteur/aspect), **bornage** (Code civil, géomètre) et **DT-DICT** (réseaux) ⟦en prose, à confirmer⟧ `[B]` ⟦référence exacte à confirmer⟧. `respecte-norme`
- **Relations** : `traite-diagnostic` → [poser-portillon-non-motorise](../../professions/cloture/cards/poser-portillon-non-motorise.md).
- **Tags** : `metier:cloture famille:specialises sous-famille:cloture probleme:portillon cluster:portillon cluster:diagnostic type:diagnostic securite:manutention relation:automatismes-portails`

## Historique
| Version | Date | Auteur | Validateur | Motif |
|---|---|---|---|---|
| v0.1 | 2026-08-05 | IA | ⟦—⟧ | proposition initiale (Brouillon) |
