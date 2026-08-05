# Fuite / baisse de pression (circuit primaire)

> **Brouillon (v0) — proposé par IA, en attente de validation métier** (Loi 7/18). Modèle : [../../cards/CARD_TEMPLATE.md](../../cards/CARD_TEMPLATE.md).
> Niveaux de confiance : A normes/fabricant · B technique · C terrain validé · D hypothèse.

## Métadonnées
| Champ | Valeur |
|---|---|
| Identifiant | `fuite-baisse-pression-primaire` |
| Titre | Fuite / baisse de pression (circuit primaire) |
| Profession | `metier:solaire-thermique` |
| Famille | `famille:fluides` |
| Sous-famille | `sous-famille:solaire-thermique` |
| Version | v0.1 |
| Auteur | IA (proposition) |
| Validateur | ⟦à valider métier⟧ |
| Statut | Brouillon |
| Indice de confiance | **C** |

## Symptôme
- **Pression** du circuit primaire qui **baisse**, manque de fluide, air/bruit dans le circulateur. `[C]`

## Causes probables
1. **Fuite** (raccords, purgeurs, joints dégradés par la chaleur). `[C]` → [raccorder-circuit-primaire](../../professions/solaire-thermique/cards/raccorder-circuit-primaire.md)
2. **Vase d'expansion** dégonflé/HS. `[C]` → [controler-regonfler-vase-expansion](../../professions/chauffage/cards/controler-regonfler-vase-expansion.md)
3. Soupape qui a craché après surchauffe. `[C]` → [surchauffe-stagnation-solaire](surchauffe-stagnation-solaire.md)

## Résolution
- Localiser/réparer la fuite (à froid), contrôler le **vase**, compléter le fluide et remettre en pression. `[C]`

## Cadre
- **Normes** : installations de capteurs solaires à circulation de liquide **DTU 65.12** ; électricité de la régulation/circulateur **NF C 15-100** ; capteurs **NF EN 12975**, systèmes **NF EN 12976**, certification **Solar Keymark** / label **RGE QualiSol** ⟦en prose, à confirmer⟧ `[B]` ⟦référence exacte à confirmer⟧. `respecte-norme`
- **Relations** : `traite-diagnostic` → [entretenir-controler-solaire](../../professions/solaire-thermique/cards/entretenir-controler-solaire.md).
- **Tags** : `metier:solaire-thermique famille:fluides sous-famille:solaire-thermique probleme:pression cluster:vase-d-expansion cluster:diagnostic type:diagnostic securite:brulure relation:chauffage`

## Historique
| Version | Date | Auteur | Validateur | Motif |
|---|---|---|---|---|
| v0.1 | 2026-08-05 | IA | ⟦—⟧ | proposition initiale (Brouillon) |
