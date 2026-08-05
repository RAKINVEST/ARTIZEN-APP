# Phrase — normes & réglementation traitement de charpente

> **Brouillon (v0) — proposé par IA, en attente de validation métier** (Loi 7/18). Modèle : [../../cards/CARD_TEMPLATE.md](../../cards/CARD_TEMPLATE.md).
> Niveaux de confiance : A normes/fabricant · B technique · C terrain validé · D hypothèse.

## Métadonnées
| Champ | Valeur |
|---|---|
| Identifiant | `normes-reglementation-traitement-charpente` |
| Titre | Phrase — normes & réglementation traitement de charpente |
| Profession | `metier:traitement-charpente` |
| Famille | `famille:specialises` |
| Sous-famille | `sous-famille:traitement-charpente` |
| Version | v0.1 |
| Auteur | IA (proposition) |
| Validateur | ⟦à valider métier⟧ |
| Statut | Brouillon |
| Indice de confiance | **C** |

## Formulation (clusters « Normes » / « Réglementation »)
> « Nous **diagnostiquons** et **prévenons** les attaques du bois (insectes xylophages, champignons, termites) : maîtrise de l'**humidité**, bois à la bonne **classe d'emploi** (**NF EN 335 / NF EN 350**), produits de préservation efficaces (**NF EN 599**) et respect des obligations **termites** (Code de la construction, déclaration en mairie) et **mérule** (information). L'application de biocides est **réglementée** (**Certibiocide**, Règlement Biocides). » `[C]` ⟦versions/exigences exactes à valider par un expert⟧

> **Frontières** : la **structure** (renfort/remplacement) relève du **Charpentier**, l'**humidité** du **Couvreur/Maçon**, les **abords/drainage** du **Paysagiste**, le **diagnostic** réglementaire du **Diagnostiqueur**, l'**amiante** du **Désamiantage** ([arreter-signaler-en-cas-de-doute](../../professions/desamiantage/cards/arreter-signaler-en-cas-de-doute.md)) — métiers distincts, jamais absorbés. `[C]`

> **Présentation uniquement** : aucun **protocole d'application de biocides** ni procédure permettant une intervention professionnelle n'est fourni. `[C]`

## Cadre
- **Normes** : charpente / structure bois traitée (**interface** charpente) **DTU 31.1** ; humidité / remédiation du bâti (**interface** maçonnerie) **DTU 20.1** ; classes d'emploi / risque biologique **NF EN 335**, durabilité **NF EN 350**, efficacité des produits de préservation **NF EN 599**, diagnostic **termites** (Code de la construction, déclaration en mairie), **mérule** (obligation d'information) et **Règlement Biocides UE 528/2012 / Certibiocide** ⟦en prose, à confirmer⟧ `[B]` ⟦référence exacte à confirmer⟧. `respecte-norme`
- **Relations** : `cite-carte` → [principe-traitement-charpente](../../professions/traitement-charpente/cards/principe-traitement-charpente.md).
- **Tags** : `metier:traitement-charpente famille:specialises type:phrase usage:normes cluster:normes cluster:reglementation relation:charpente relation:couverture relation:maconnerie relation:paysagisme relation:desamiantage relation:diagnostic`

## Historique
| Version | Date | Auteur | Validateur | Motif |
|---|---|---|---|---|
| v0.1 | 2026-08-05 | IA | ⟦—⟧ | proposition initiale (Brouillon) |
