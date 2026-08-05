# Phrase — normes & réglementation terrasse bois

> **Brouillon (v0) — proposé par IA, en attente de validation métier** (Loi 7/18). Modèle : [../../cards/CARD_TEMPLATE.md](../../cards/CARD_TEMPLATE.md).
> Niveaux de confiance : A normes/fabricant · B technique · C terrain validé · D hypothèse.

## Métadonnées
| Champ | Valeur |
|---|---|
| Identifiant | `normes-reglementation-terrasse-bois` |
| Titre | Phrase — normes & réglementation terrasse bois |
| Profession | `metier:terrasse-bois` |
| Famille | `famille:specialises` |
| Sous-famille | `sous-famille:terrasse-bois` |
| Version | v0.1 |
| Auteur | IA (proposition) |
| Validateur | ⟦à valider métier⟧ |
| Statut | Brouillon |
| Indice de confiance | **C** |

## Formulation (clusters « Normes » / « Réglementation »)
> « Nos terrasses bois suivent les règles de l'art (**DTU 51.4** — platelages extérieurs en bois) : structure ventilée sur plots/lambourdes, pente et drainage, essences à la bonne **classe d'emploi** (**NF EN 335 / NF EN 350**) ou **bois composite** (**NF EN 15534**), fixations inox et jeux de dilatation ; support béton conforme (**DTU 21**). » `[C]` ⟦versions/exigences exactes à valider par un expert⟧

> **Frontières** : la **charpente** (structure bois lourde), la **menuiserie extérieure** (ouvrages/seuils), le **paysagisme** (abords), la **maçonnerie** (dalle) et le **terrassement** sont des **métiers distincts** (Livres existants), jamais absorbés. `[C]`

> **Interfaces réservées** : un éventuel **éclairage intégré** ([remplacer-prise-courant](../../professions/electricite-generale/cards/remplacer-prise-courant.md)) relève de l'**Électricité** ; le **retrait d'amiante** (rénovation → Désamiantage) n'est **jamais réalisé ici**. `[C]`

## Cadre
- **Normes** : platelages extérieurs en bois **DTU 51.4** ; dalle / support béton (**interface** maçonnerie) **DTU 21** ; classes d'emploi du bois **NF EN 335**, durabilité **NF EN 350**, bois composite **NF EN 15534**, éclairage intégré (**interface** électricité) **NF C 15-100** et **DT-DICT** (réseaux) ⟦en prose, à confirmer⟧ `[B]` ⟦référence exacte à confirmer⟧. `respecte-norme`
- **Relations** : `cite-carte` → [poser-plots-lambourdes-solives](../../professions/terrasse-bois/cards/poser-plots-lambourdes-solives.md).
- **Tags** : `metier:terrasse-bois famille:specialises type:phrase usage:normes cluster:normes cluster:reglementation relation:charpente relation:menuiserie-exterieure relation:paysagisme relation:maconnerie relation:terrassement relation:electricite-generale relation:desamiantage`

## Historique
| Version | Date | Auteur | Validateur | Motif |
|---|---|---|---|---|
| v0.1 | 2026-08-05 | IA | ⟦—⟧ | proposition initiale (Brouillon) |
