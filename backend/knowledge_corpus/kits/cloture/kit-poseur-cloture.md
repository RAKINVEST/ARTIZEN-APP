# Kit poseur de clôture

> **Brouillon (v0) — proposé par IA, en attente de validation métier** (Loi 7/18). Modèle : [../../cards/CARD_TEMPLATE.md](../../cards/CARD_TEMPLATE.md).
> Niveaux de confiance : A normes/fabricant · B technique · C terrain validé · D hypothèse.

## Métadonnées
| Champ | Valeur |
|---|---|
| Identifiant | `kit-poseur-cloture` |
| Titre | Kit poseur de clôture |
| Profession | `metier:cloture` |
| Famille | `famille:specialises` |
| Sous-famille | `sous-famille:cloture` |
| Version | v0.1 |
| Auteur | IA (proposition) |
| Validateur | ⟦à valider métier⟧ |
| Statut | Brouillon |
| Indice de confiance | **C** |

## Composition conseillée
- Cordeau, niveau/laser, tarière (manuelle/motorisée), bêche, seau/bétonnière ; **détecteur de réseaux**. `[C]`
- Tendeurs, pince à agrafer/tendeur de fil, cliquet, meuleuse/scie, perçeuse, chevilles/platines. `[C]`
- Galva à froid, bouchons de poteaux, quincaillerie de portillon (gonds/loquet). `[C]`
- **EPI** : gants anti-coupure, lunettes/**écran** (fil sous tension), chaussures, EPI ciment. `[A]`

## Cadre
- **Normes** : béton de scellement des poteaux (**interface**) **DTU 21** ; ouvrages métalliques / portillons (**interface** métallerie) **DTU 37.1** ; grillages **NF EN 10223**, protection anticorrosion **NF EN ISO 1461 / NF EN ISO 12944**, règles d'**urbanisme** (PLU : hauteur/aspect), **bornage** (Code civil, géomètre) et **DT-DICT** (réseaux) ⟦en prose, à confirmer⟧ `[B]` ⟦référence exacte à confirmer⟧. `respecte-norme`
- **Relations** : `utilise-kit` → [sceller-poteaux-ancrages](../../professions/cloture/cards/sceller-poteaux-ancrages.md).
- **Tags** : `metier:cloture famille:specialises sous-famille:cloture type:kit cluster:scellement cluster:grillage-souple equipement:tariere`

## Historique
| Version | Date | Auteur | Validateur | Motif |
|---|---|---|---|---|
| v0.1 | 2026-08-05 | IA | ⟦—⟧ | proposition initiale (Brouillon) |
