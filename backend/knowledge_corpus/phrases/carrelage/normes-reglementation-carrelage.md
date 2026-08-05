# Phrase — normes & réglementation carrelage

> **Brouillon (v0) — proposé par IA, en attente de validation métier** (Loi 7/18). Modèle : [../../cards/CARD_TEMPLATE.md](../../cards/CARD_TEMPLATE.md).
> Niveaux de confiance : A normes/fabricant · B technique · C terrain validé · D hypothèse.

## Métadonnées
| Champ | Valeur |
|---|---|
| Identifiant | `normes-reglementation-carrelage` |
| Titre | Phrase — normes & réglementation carrelage |
| Profession | `metier:carrelage` |
| Famille | `famille:finition` |
| Sous-famille | `sous-famille:carrelage` |
| Version | v0.1 |
| Auteur | IA (proposition) |
| Validateur | ⟦à valider métier⟧ |
| Statut | Brouillon |
| Indice de confiance | **C** |

## Formulation (clusters « Normes » / « Réglementation »)
> « Nos ouvrages de carrelage respectent les règles de l'art : pose collée des céramiques et pierres naturelles (**DTU 52.2**), pose scellée (**DTU 52.1**), les **CPT** du CSTB (grands formats, étanchéité sous carrelage), un classement **UPEC** adapté au local, et des réservations électriques conformes (**NF C 15-100**, plancher chauffant). » `[C]` ⟦versions/classements exacts à valider par un expert⟧

> **Rénovation / amiante** : d'anciennes **colles/ragréages** peuvent contenir de l'amiante → **diagnostic avant travaux** ; tout retrait relève d'une **entreprise certifiée** (**Désamiantage**) — le carrelage ne fait que le **diagnostic/interface**. `[C]`

> **Frontières** : le carrelage voisine les **Revêtements de sol**, le **Parquet**, la **Menuiserie intérieure** et l'**Agencement** (activités distinctes, futurs Livres) ; le support mural relève de la **Plâtrerie**, le **plancher chauffant** du **Chauffage**, les réservations de l'**Électricité** (Livres existants). `[C]`

## Cadre
- **Normes** : pose collée des revêtements céramiques et pierres naturelles **DTU 52.2** ; pose scellée **DTU 52.1** ; électricité (plancher chauffant / zones équipées) **NF C 15-100** ; **CPT** CSTB (grands formats, SEL sous carrelage), classement **UPEC** et diagnostic **amiante** (colles anciennes) ⟦en prose, à confirmer⟧ `[B]` ⟦référence exacte à confirmer⟧. `respecte-norme`
- **Relations** : `cite-carte` → [monter-cloison-seche](../../professions/platrerie/cards/monter-cloison-seche.md).
- **Tags** : `metier:carrelage famille:finition type:phrase usage:normes cluster:normes cluster:reglementation relation:platrerie relation:chauffage relation:electricite-generale relation:revetements-sol relation:parquet relation:desamiantage`

## Historique
| Version | Date | Auteur | Validateur | Motif |
|---|---|---|---|---|
| v0.1 | 2026-08-05 | IA | ⟦—⟧ | proposition initiale (Brouillon) |
