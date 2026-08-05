# Phrase — références normatives couverture

> **Brouillon (v0) — proposé par IA, en attente de validation métier** (Loi 7/18). Modèle : [../../cards/CARD_TEMPLATE.md](../../cards/CARD_TEMPLATE.md).
> Niveaux de confiance : A normes/fabricant · B technique · C terrain validé · D hypothèse.

## Métadonnées
| Champ | Valeur |
|---|---|
| Identifiant | `normes-couverture-reference` |
| Titre | Phrase — références normatives couverture |
| Profession | `metier:couverture` |
| Famille | `famille:enveloppe` |
| Sous-famille | `sous-famille:couverture` |
| Version | v0.1 |
| Auteur | IA (proposition) |
| Validateur | ⟦à valider métier⟧ |
| Statut | Brouillon |
| Indice de confiance | **C** |

## Formulation (clusters « Normes » / « Réglementation »)
> « Nos travaux de couverture respectent les règles de l'art, notamment le **DTU 40.21** (tuiles terre cuite), le **DTU 40.11** (ardoises) et le **DTU 40.35** (bac acier). » `[C]` ⟦versions exactes à valider par un expert⟧

> **Réglementation** : une réfection modifiant l'aspect peut requérir une **déclaration préalable** (urbanisme), avec contraintes en secteur **ABF** (Architecte des Bâtiments de France). `[C]` ⟦à confirmer selon commune/projet⟧

> **Relations inter-Livres** : la couverture repose sur la **Charpente** (support), s'articule avec la **Zinguerie** (noues, solins, évacuation EP), l'**Étanchéité** (toitures-terrasses), la **Façade** (jonctions) et la **Ventilation** (sous-toiture). `[C]`

## Cadre
- **Normes** : couverture en tuiles de terre cuite **DTU 40.21** ; couverture en ardoises **DTU 40.11** ; couverture en plaques nervurées / bac acier **DTU 40.35** `[B]` ⟦référence exacte à confirmer⟧. `respecte-norme`
- **Relations** : `cite-carte` → [controler-liteaux-voliges](../../professions/charpente/cards/controler-liteaux-voliges.md).
- **Tags** : `metier:couverture famille:enveloppe type:phrase usage:normes cluster:normes cluster:reglementation relation:charpente relation:zinguerie relation:etancheite relation:facade relation:ventilation`

## Historique
| Version | Date | Auteur | Validateur | Motif |
|---|---|---|---|---|
| v0.1 | 2026-08-04 | IA | ⟦—⟧ | proposition initiale (Brouillon) |
