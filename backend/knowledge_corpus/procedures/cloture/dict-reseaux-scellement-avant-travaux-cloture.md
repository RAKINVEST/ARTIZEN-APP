# DICT, réseaux & scellement avant travaux de clôture

> **Brouillon (v0) — proposé par IA, en attente de validation métier** (Loi 7/18). Modèle : [../../cards/CARD_TEMPLATE.md](../../cards/CARD_TEMPLATE.md).
> Niveaux de confiance : A normes/fabricant · B technique · C terrain validé · D hypothèse.

## Métadonnées
| Champ | Valeur |
|---|---|
| Identifiant | `dict-reseaux-scellement-avant-travaux-cloture` |
| Titre | DICT, réseaux & scellement avant travaux de clôture |
| Profession | `metier:cloture` |
| Famille | `famille:specialises` |
| Sous-famille | `sous-famille:securite` |
| Version | v0.1 |
| Auteur | IA (proposition) |
| Validateur | ⟦à valider métier⟧ |
| Statut | Brouillon |
| Indice de confiance | **B** |

## But
- Sécuriser le creusement des trous de poteaux (réseaux), le scellement et l'amiante — sans retrait ni raccordement réglementé. `[A]`

## Étapes
1. **DT-DICT** : déclarer/repérer les **réseaux enterrés** avant tout creusement (nombreux trous de poteaux). `[A]` → [terrasser-reseaux-dict](../../professions/terrassement/cards/terrasser-reseaux-dict.md)
2. **Limites/PLU** : vérifier bornage et règles d'urbanisme avant implantation. `[A]` → [implanter-relever-limites](../../professions/cloture/cards/implanter-relever-limites.md)
3. **Scellement béton** : EPI (ciment), profondeur hors-gel, prise avant tension. `[A]`
4. **Découpe/manutention** : disque adapté, EPI ; **fil sous tension** (fouet). `[A]`
5. **Motorisation** éventuelle d'un portillon = **interface** (Automatismes / Électricité), jamais ici. `[A]`
6. **Rénovation** : panneaux anciens → **diagnostic amiante** ; suspect → **arrêt**, retrait = **certifié**. `[A]` `relation:desamiantage`

## Cadre
- **Normes** : béton de scellement des poteaux (**interface**) **DTU 21** ; ouvrages métalliques / portillons (**interface** métallerie) **DTU 37.1** ; grillages **NF EN 10223**, protection anticorrosion **NF EN ISO 1461 / NF EN ISO 12944**, règles d'**urbanisme** (PLU : hauteur/aspect), **bornage** (Code civil, géomètre) et **DT-DICT** (réseaux) ⟦en prose, à confirmer⟧ `[B]` ⟦référence exacte à confirmer⟧. `respecte-norme`
- **Relations** : `cite-carte` → [sceller-poteaux-ancrages](../../professions/cloture/cards/sceller-poteaux-ancrages.md).
- **Tags** : `metier:cloture famille:specialises sous-famille:securite intervention:securiser cluster:scellement cluster:reglementation type:procedure securite:reseaux securite:amiante relation:desamiantage relation:terrassement`

## Historique
| Version | Date | Auteur | Validateur | Motif |
|---|---|---|---|---|
| v0.1 | 2026-08-05 | IA | ⟦—⟧ | proposition initiale (Brouillon) |
