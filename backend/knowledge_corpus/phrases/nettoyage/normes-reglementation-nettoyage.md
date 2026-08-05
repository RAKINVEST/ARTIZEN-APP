# Phrase — normes & réglementation nettoyage

> **Brouillon (v0) — proposé par IA, en attente de validation métier** (Loi 7/18). Modèle : [../../cards/CARD_TEMPLATE.md](../../cards/CARD_TEMPLATE.md).
> Niveaux de confiance : A normes/fabricant · B technique · C terrain validé · D hypothèse.

## Métadonnées
| Champ | Valeur |
|---|---|
| Identifiant | `normes-reglementation-nettoyage` |
| Titre | Phrase — normes & réglementation nettoyage |
| Profession | `metier:nettoyage` |
| Famille | `famille:specialises` |
| Sous-famille | `sous-famille:nettoyage` |
| Version | v0.1 |
| Auteur | IA (proposition) |
| Validateur | ⟦à valider métier⟧ |
| Statut | Brouillon |
| Indice de confiance | **C** |

## Formulation (clusters « Normes » / « Réglementation »)
> « Nos prestations de nettoyage respectent les règles : **déchets de chantier** triés et évacués en filière réglementée (Code de l'environnement), produits utilisés selon leurs **fiches de données de sécurité (FDS)** et l'étiquetage **CLP** (jamais mélangés), et respect des supports (vitrages **DTU 39**, sols carrelés **DTU 52.2**). » `[C]` ⟦versions/exigences exactes à valider par un expert⟧

> **Frontières** : la **pose/remise en état** des vitrages relève du **Vitrier** ([principe-vitrerie](../../professions/vitrerie/cards/principe-vitrerie.md)), des sols du **Solier/Carreleur**, des peintures du **Peintre** ; l'**amiante** du **Désamiantage** et le **diagnostic** réglementaire du **Diagnostiqueur** — métiers distincts, jamais absorbés. `[C]`

> **Présentation uniquement** : aucun **dosage**, **mélange** ni **protocole d'usage** de produits dangereux n'est fourni ; le **nettoyage de façade** est présenté comme prestation spécialisée. `[C]`

## Cadre
- **Normes** : nettoyage des **vitrages** (**interface** vitrerie) **DTU 39** ; nettoyage / protection des **sols** carrelés (**interface**) **DTU 52.2** ; gestion des **déchets de chantier** (Code de l'environnement, tri / bordereau), **fiches de données de sécurité (FDS)** et étiquetage **CLP** des produits ⟦en prose, à confirmer⟧ `[B]` ⟦référence exacte à confirmer⟧. `respecte-norme`
- **Relations** : `cite-carte` → [principe-nettoyage](../../professions/nettoyage/cards/principe-nettoyage.md).
- **Tags** : `metier:nettoyage famille:specialises type:phrase usage:normes cluster:normes cluster:reglementation relation:vitrerie relation:revetements-sol relation:carrelage relation:peinture relation:desamiantage relation:diagnostic`

## Historique
| Version | Date | Auteur | Validateur | Motif |
|---|---|---|---|---|
| v0.1 | 2026-08-05 | IA | ⟦—⟧ | proposition initiale (Brouillon) |
