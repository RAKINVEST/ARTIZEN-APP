# Phrase — normes & réglementation vitrerie

> **Brouillon (v0) — proposé par IA, en attente de validation métier** (Loi 7/18). Modèle : [../../cards/CARD_TEMPLATE.md](../../cards/CARD_TEMPLATE.md).
> Niveaux de confiance : A normes/fabricant · B technique · C terrain validé · D hypothèse.

## Métadonnées
| Champ | Valeur |
|---|---|
| Identifiant | `normes-reglementation-vitrerie` |
| Titre | Phrase — normes & réglementation vitrerie |
| Profession | `metier:vitrerie` |
| Famille | `famille:specialises` |
| Sous-famille | `sous-famille:vitrerie` |
| Version | v0.1 |
| Auteur | IA (proposition) |
| Validateur | ⟦à valider métier⟧ |
| Statut | Brouillon |
| Indice de confiance | **C** |

## Formulation (clusters « Normes » / « Réglementation »)
> « Nos travaux de vitrerie suivent les règles de l'art (**DTU 39** vitrerie-miroiterie) : verre de sécurité adapté à l'usage (trempé **NF EN 12150**, feuilleté **NF EN 14449 / ISO 12543**), vitrages isolants **NF EN 1279**, résistance au choc **NF EN 12600** et garde-corps **NF P01-012**. » `[C]` ⟦versions/exigences exactes à valider par un expert⟧

> **Frontières** : le vitrier pose et étanche le **verre** ; les **menuiseries métalliques** relèvent de la **Serrurerie / Métallerie**, les **menuiseries bois** de la **Menuiserie intérieure**, un **ouvrant automatique** vitré des **Automatismes de portails** — Livres existants, jamais absorbés. `[C]`

> **Interfaces (porte vitrée d'entrée)** : un éventuel **contrôle d'accès** ([installer-lecteurs-claviers](../../professions/controle-acces/cards/installer-lecteurs-claviers.md)) ou **interphone** ([installer-platine-rue](../../professions/interphonie/cards/installer-platine-rue.md)) relève de son métier ; le **retrait d'amiante** (mastics anciens → Désamiantage) n'est **jamais réalisé ici**. `[C]`

## Cadre
- **Normes** : travaux de **vitrerie-miroiterie** **DTU 39** ; menuiseries métalliques recevant le vitrage (**interface**) **DTU 37.1** ; verre de sécurité trempé / feuilleté (**NF EN 12150 / NF EN 14449 / ISO 12543**), vitrage isolant **NF EN 1279**, résistance au choc **NF EN 12600**, garde-corps **NF P01-012** ⟦en prose, à confirmer⟧ `[B]` ⟦référence exacte à confirmer⟧. `respecte-norme`
- **Relations** : `cite-carte` → [poser-remplacer-vitrage](../../professions/vitrerie/cards/poser-remplacer-vitrage.md).
- **Tags** : `metier:vitrerie famille:specialises type:phrase usage:normes cluster:normes cluster:reglementation relation:serrurerie-metallerie relation:menuiserie-interieure relation:automatismes-portails relation:controle-acces relation:interphonie relation:desamiantage`

## Historique
| Version | Date | Auteur | Validateur | Motif |
|---|---|---|---|---|
| v0.1 | 2026-08-05 | IA | ⟦—⟧ | proposition initiale (Brouillon) |
