# Clôture corrodée / dégradée

> **Brouillon (v0) — proposé par IA, en attente de validation métier** (Loi 7/18). Modèle : [../../cards/CARD_TEMPLATE.md](../../cards/CARD_TEMPLATE.md).
> Niveaux de confiance : A normes/fabricant · B technique · C terrain validé · D hypothèse.

## Métadonnées
| Champ | Valeur |
|---|---|
| Identifiant | `cloture-corrodee-degradee` |
| Titre | Clôture corrodée / dégradée |
| Profession | `metier:cloture` |
| Famille | `famille:specialises` |
| Sous-famille | `sous-famille:cloture` |
| Version | v0.1 |
| Auteur | IA (proposition) |
| Validateur | ⟦à valider métier⟧ |
| Statut | Brouillon |
| Indice de confiance | **C** |

## Symptôme
- **Rouille**, grillage détendu, panneau cassé, bois gris/pourri, alu taché. `[C]`

## Causes probables
1. **Coupes/perçages** non protégés (amorces de corrosion). `[C]` → [proteger-anticorrosion-finir](../../professions/cloture/cards/proteger-anticorrosion-finir.md)
2. **Tension** perdue (grillage souple) / fixations desserrées. `[C]` → [poser-grillage-souple-rigide](../../professions/cloture/cards/poser-grillage-souple-rigide.md)
3. Bois non/mal traité (classe d'emploi inadaptée). `[C]`

## Résolution
- Traiter/reprendre l'anticorrosion (galva à froid), retendre le grillage, remplacer les éléments atteints, retraiter le bois. `[C]`

## Cadre
- **Normes** : béton de scellement des poteaux (**interface**) **DTU 21** ; ouvrages métalliques / portillons (**interface** métallerie) **DTU 37.1** ; grillages **NF EN 10223**, protection anticorrosion **NF EN ISO 1461 / NF EN ISO 12944**, règles d'**urbanisme** (PLU : hauteur/aspect), **bornage** (Code civil, géomètre) et **DT-DICT** (réseaux) ⟦en prose, à confirmer⟧ `[B]` ⟦référence exacte à confirmer⟧. `respecte-norme`
- **Relations** : `traite-diagnostic` → [proteger-anticorrosion-finir](../../professions/cloture/cards/proteger-anticorrosion-finir.md).
- **Tags** : `metier:cloture famille:specialises sous-famille:cloture probleme:corrosion cluster:anticorrosion cluster:diagnostic type:diagnostic securite:coupure`

## Historique
| Version | Date | Auteur | Validateur | Motif |
|---|---|---|---|---|
| v0.1 | 2026-08-05 | IA | ⟦—⟧ | proposition initiale (Brouillon) |
