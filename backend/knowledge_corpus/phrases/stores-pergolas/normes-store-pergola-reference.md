# Phrase — normes & réglementation stores & pergolas

> **Brouillon (v0) — proposé par IA, en attente de validation métier** (Loi 7/18). Modèle : [../../cards/CARD_TEMPLATE.md](../../cards/CARD_TEMPLATE.md).
> Niveaux de confiance : A normes/fabricant · B technique · C terrain validé · D hypothèse.

## Métadonnées
| Champ | Valeur |
|---|---|
| Identifiant | `normes-store-pergola-reference` |
| Titre | Phrase — normes & réglementation stores & pergolas |
| Profession | `metier:stores-pergolas` |
| Famille | `famille:enveloppe` |
| Sous-famille | `sous-famille:stores-pergolas` |
| Version | v0.1 |
| Auteur | IA (proposition) |
| Validateur | ⟦à valider métier⟧ |
| Statut | Brouillon |
| Indice de confiance | **C** |

## Formulation (clusters « Normes » / « Réglementation »)
> « Nos stores et pergolas sont posés selon les règles de l'art (fermetures **DTU 34.1**, fixation sur support **DTU 20.1**), avec une **classe de résistance au vent** conforme à la **NF EN 13561** (stores) et un dimensionnement des pergolas selon les **Eurocodes** (charges vent/neige). » `[C]` ⟦classes/versions exactes à valider par un expert⟧

> **Réglementation** : une pergola/structure peut requérir une **déclaration préalable** voire un **permis** selon l'emprise/surface (contraintes **ABF**) ; motorisation = marquage **CE** / directive Machines. `[C]` ⟦à confirmer selon commune/projet⟧

> **Relations inter-Livres (frontières)** : fixation → **Façade** / **Bardage** ; store de baie/toiture → **Menuiserie Extérieure** ; motorisation/capteurs → **Électricité** ; pergola adossée / évacuation → **Étanchéité**. `[C]`

## Cadre
- **Normes** : fermetures / stores **DTU 34.1** ; fixation sur support maçonné **DTU 20.1** ; stores extérieurs **NF EN 13561** (classes de résistance au vent) et pergolas dimensionnées selon les **Eurocodes** (charges vent/neige) ⟦à confirmer⟧ `[B]` ⟦référence exacte à confirmer⟧. `respecte-norme`
- **Relations** : `cite-carte` → [poser-regler-volet](../../professions/menuiserie-exterieure/cards/poser-regler-volet.md).
- **Tags** : `metier:stores-pergolas famille:enveloppe type:phrase usage:normes cluster:normes cluster:reglementation relation:facade relation:bardage relation:menuiserie-exterieure relation:electricite-generale relation:etancheite`

## Historique
| Version | Date | Auteur | Validateur | Motif |
|---|---|---|---|---|
| v0.1 | 2026-08-05 | IA | ⟦—⟧ | proposition initiale (Brouillon) |
