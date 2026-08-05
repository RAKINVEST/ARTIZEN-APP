# Kit automaticien portail

> **Brouillon (v0) — proposé par IA, en attente de validation métier** (Loi 7/18). Modèle : [../../cards/CARD_TEMPLATE.md](../../cards/CARD_TEMPLATE.md).
> Niveaux de confiance : A normes/fabricant · B technique · C terrain validé · D hypothèse.

## Métadonnées
| Champ | Valeur |
|---|---|
| Identifiant | `kit-automaticien-portail` |
| Titre | Kit automaticien portail |
| Profession | `metier:automatismes-portails` |
| Famille | `famille:specialises` |
| Sous-famille | `sous-famille:automatismes` |
| Version | v0.1 |
| Auteur | IA (proposition) |
| Validateur | ⟦à valider métier⟧ |
| Statut | Brouillon |
| Indice de confiance | **C** |

## Composition conseillée
- Outillage électroportatif, niveau, gabarits de pose fabricant, clés de déverrouillage. `[C]`
- **Multimètre**, **dynamomètre / instrument de mesure d'effort** (essais EN 12445), télécommande de programmation. `[A]`
- **Détecteur de réseaux**, matériel de scellement, gaines/fourreaux (pose → Terrassement). `[C]`
- **EPI** : gants, lunettes, chaussures ; moyens de **consignation** (cadenas/étiquette). `[A]`

## Cadre
- **Normes** : sécurité des portes/portails motorisés — **Directive Machines**, **marquage CE**, cellules / bords sensibles / limitation d'effort — **NF EN 12453 / NF EN 12445 / NF EN 13241** ; alimentation électrique (**interface**) **NF C 15-100** ; structure du portail (**interface** métallerie) **DTU 37.1** ⟦EN 12453/12445 et versions exactes en prose, à confirmer⟧ `[B]` ⟦référence exacte à confirmer⟧. `respecte-norme`
- **Relations** : `utilise-kit` → [regler-essayer-motorisation](../../professions/automatismes-portails/cards/regler-essayer-motorisation.md).
- **Tags** : `metier:automatismes-portails famille:specialises sous-famille:automatismes type:kit cluster:essais cluster:reglages equipement:mesure-effort`

## Historique
| Version | Date | Auteur | Validateur | Motif |
|---|---|---|---|---|
| v0.1 | 2026-08-05 | IA | ⟦—⟧ | proposition initiale (Brouillon) |
