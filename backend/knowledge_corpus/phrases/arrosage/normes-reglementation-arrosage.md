# Phrase — normes & réglementation arrosage

> **Brouillon (v0) — proposé par IA, en attente de validation métier** (Loi 7/18). Modèle : [../../cards/CARD_TEMPLATE.md](../../cards/CARD_TEMPLATE.md).
> Niveaux de confiance : A normes/fabricant · B technique · C terrain validé · D hypothèse.

## Métadonnées
| Champ | Valeur |
|---|---|
| Identifiant | `normes-reglementation-arrosage` |
| Titre | Phrase — normes & réglementation arrosage |
| Profession | `metier:arrosage` |
| Famille | `famille:specialises` |
| Sous-famille | `sous-famille:arrosage` |
| Version | v0.1 |
| Auteur | IA (proposition) |
| Validateur | ⟦à valider métier⟧ |
| Statut | Brouillon |
| Indice de confiance | **C** |

## Formulation (clusters « Normes » / « Réglementation »)
> « Nos installations d'arrosage automatique respectent les règles : **protection sanitaire de l'eau potable** par **disconnecteur / clapet anti-retour** (**NF EN 1717**), raccordement conforme (**DTU 60.1**), tubes **PE** (**NF EN 12201**), commande électrique conforme (**NF C 15-100**) et **DT-DICT** des réseaux avant terrassement ; programmation économe (restrictions d'eau). » `[C]` ⟦versions/exigences exactes à valider par un expert⟧

> **Frontières** : le **choix des végétaux** et du sol relève du **Paysagisme**, l'**alimentation en eau potable** de la **Plomberie**, le **raccordement électrique** de l'**Électricité**, la **tranchée technique** générale du **VRD / Terrassement** — Livres existants, jamais absorbés. `[C]`

> **Interface** : le **retrait d'amiante** (rénovation → Désamiantage) et tout **raccordement électrique/plomberie** détaillé ne sont **jamais réalisés ici**. `[C]`

## Cadre
- **Normes** : raccordement à l'eau potable + **protection anti-retour** (**interface** plomberie) **DTU 60.1** ; alimentation du programmateur / électrovannes (**interface** électricité) **NF C 15-100** ; **protection contre les retours d'eau** (disconnecteur) **NF EN 1717**, tube **PE** **NF EN 12201**, réglementation **DT-DICT** (réseaux) et règlement du service des eaux ⟦en prose, à confirmer⟧ `[B]` ⟦référence exacte à confirmer⟧. `respecte-norme`
- **Relations** : `cite-carte` → [essayer-regler-mettre-en-service](../../professions/arrosage/cards/essayer-regler-mettre-en-service.md).
- **Tags** : `metier:arrosage famille:specialises type:phrase usage:normes cluster:normes cluster:reglementation relation:paysagisme relation:plomberie relation:electricite-generale relation:vrd relation:terrassement relation:desamiantage`

## Historique
| Version | Date | Auteur | Validateur | Motif |
|---|---|---|---|---|
| v0.1 | 2026-08-05 | IA | ⟦—⟧ | proposition initiale (Brouillon) |
