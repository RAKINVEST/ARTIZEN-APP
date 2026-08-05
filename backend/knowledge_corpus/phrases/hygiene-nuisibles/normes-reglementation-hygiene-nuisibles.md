# Phrase — normes & réglementation hygiène / nuisibles

> **Brouillon (v0) — proposé par IA, en attente de validation métier** (Loi 7/18). Modèle : [../../cards/CARD_TEMPLATE.md](../../cards/CARD_TEMPLATE.md).
> Niveaux de confiance : A normes/fabricant · B technique · C terrain validé · D hypothèse.

## Métadonnées
| Champ | Valeur |
|---|---|
| Identifiant | `normes-reglementation-hygiene-nuisibles` |
| Titre | Phrase — normes & réglementation hygiène / nuisibles |
| Profession | `metier:hygiene-nuisibles` |
| Famille | `famille:specialises` |
| Sous-famille | `sous-famille:hygiene-nuisibles` |
| Version | v0.1 |
| Auteur | IA (proposition) |
| Validateur | ⟦à valider métier⟧ |
| Statut | Brouillon |
| Indice de confiance | **C** |

## Formulation (clusters « Normes » / « Réglementation »)
> « Nous **diagnostiquons** et **prévenons** les nuisibles par une **lutte intégrée** (hygiène, exclusion, surveillance), dans le respect du **Règlement Sanitaire Départemental**, des règles **HACCP** (locaux alimentaires) et du service de lutte antiparasitaire (**NF EN 16636**). L'application de biocides est **réglementée** (**Certibiocide**, Règlement Biocides, AMM). » `[C]` ⟦versions/exigences exactes à valider par un expert⟧

> **Frontières** : les **termites** relèvent du **Traitement de charpente** ([identifier-insectes-xylophages](../../professions/traitement-charpente/cards/identifier-insectes-xylophages.md)), l'accès par les **réseaux** de la **Plomberie**, l'**humidité** de la **Ventilation**, les **points d'entrée en toiture** du **Couvreur**, l'**amiante** du **Désamiantage**, le **diagnostic** réglementaire du **Diagnostiqueur** — métiers distincts, jamais absorbés. `[C]`

> **Présentation uniquement** : aucun **protocole de dératisation, désinsectisation ou désinfection**, aucun **dosage** ni **mode d'application** de biocides n'est fourni. `[C]`

## Cadre
- **Normes** : accès des nuisibles par les réseaux (siphons / clapets anti-rongeurs, **interface** plomberie) **DTU 60.1** ; **ventilation** contre l'humidité favorisant les nuisibles (**interface**) **DTU 68.3** ; services de lutte antiparasitaire **NF EN 16636** (certification CEPA), **Règlement Sanitaire Départemental**, **Règlement Biocides UE 528/2012 / Certibiocide** et **HACCP** (locaux alimentaires) ⟦en prose, à confirmer⟧ `[B]` ⟦référence exacte à confirmer⟧. `respecte-norme`
- **Relations** : `cite-carte` → [principe-hygiene-nuisibles](../../professions/hygiene-nuisibles/cards/principe-hygiene-nuisibles.md).
- **Tags** : `metier:hygiene-nuisibles famille:specialises type:phrase usage:normes cluster:normes cluster:reglementation relation:traitement-charpente relation:plomberie relation:ventilation relation:couverture relation:desamiantage relation:diagnostic`

## Historique
| Version | Date | Auteur | Validateur | Motif |
|---|---|---|---|---|
| v0.1 | 2026-08-05 | IA | ⟦—⟧ | proposition initiale (Brouillon) |
