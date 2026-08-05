# Phrase — normes & réglementation ascenseur

> **Brouillon (v0) — proposé par IA, en attente de validation métier** (Loi 7/18). Modèle : [../../cards/CARD_TEMPLATE.md](../../cards/CARD_TEMPLATE.md).
> Niveaux de confiance : A normes/fabricant · B technique · C terrain validé · D hypothèse.

## Métadonnées
| Champ | Valeur |
|---|---|
| Identifiant | `normes-reglementation-ascenseur` |
| Titre | Phrase — normes & réglementation ascenseur |
| Profession | `metier:ascenseur` |
| Famille | `famille:specialises` |
| Sous-famille | `sous-famille:ascenseur` |
| Version | v0.1 |
| Auteur | IA (proposition) |
| Validateur | ⟦à valider métier⟧ |
| Statut | Brouillon |
| Indice de confiance | **C** |

## Formulation (clusters « Normes » / « Réglementation »)
> « Nos ascenseurs respectent les règles de sécurité (**Directive Ascenseurs 2014/33/UE**, **NF EN 81-20 / 81-50**), l'accessibilité (**NF EN 81-70**) et, pour l'existant, l'amélioration de sécurité (**NF EN 81-80 / SNEL**) ; l'appareil est sous **contrat d'entretien** avec **contrôle technique quinquennal**, alimentation électrique conforme (**NF C 15-100**). » `[C]` ⟦versions/exigences exactes à valider par un expert⟧

> **Métier réservé** : les opérations en gaine, sur la machinerie et les dispositifs de sécurité relèvent d'**ascensoristes habilités** — **aucune n'est décrite pas à pas**. `[C]`

> **Frontières** : l'**électricien** (alimentation/armoire), le **maçon** (gaine, génie civil), le **métallier** (ouvrages métalliques) et le **diagnostiqueur** (dont **amiante** → Désamiantage) sont des **métiers distincts**, jamais absorbés. `[C]`

## Cadre
- **Normes** : gaine (génie civil béton, **interface** maçonnerie) **DTU 21** ; alimentation électrique (**interface**) **NF C 15-100** ; sécurité des ascenseurs **NF EN 81-20 / NF EN 81-50**, accessibilité **NF EN 81-70**, amélioration de l'existant **NF EN 81-80** (SNEL), **Directive Ascenseurs 2014/33/UE** et réglementation d'entretien / contrôle technique (Code de la construction) ⟦en prose, à confirmer⟧ `[B]` ⟦référence exacte à confirmer⟧. `respecte-norme`
- **Relations** : `cite-carte` → [principe-ascenseur](../../professions/ascenseur/cards/principe-ascenseur.md).
- **Tags** : `metier:ascenseur famille:specialises type:phrase usage:normes cluster:normes cluster:reglementation relation:electricite-generale relation:maconnerie relation:serrurerie-metallerie relation:diagnostic relation:desamiantage`

## Historique
| Version | Date | Auteur | Validateur | Motif |
|---|---|---|---|---|
| v0.1 | 2026-08-05 | IA | ⟦—⟧ | proposition initiale (Brouillon) |
