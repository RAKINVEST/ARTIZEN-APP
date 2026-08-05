# Phrase — normes & réglementation diagnostic immobilier

> **Brouillon (v0) — proposé par IA, en attente de validation métier** (Loi 7/18). Modèle : [../../cards/CARD_TEMPLATE.md](../../cards/CARD_TEMPLATE.md).
> Niveaux de confiance : A normes/fabricant · B technique · C terrain validé · D hypothèse.

## Métadonnées
| Champ | Valeur |
|---|---|
| Identifiant | `normes-reglementation-diagnostic-immobilier` |
| Titre | Phrase — normes & réglementation diagnostic immobilier |
| Profession | `metier:diagnostic` |
| Famille | `famille:specialises` |
| Sous-famille | `sous-famille:diagnostic` |
| Version | v0.1 |
| Auteur | IA (proposition) |
| Validateur | ⟦à valider métier⟧ |
| Statut | Brouillon |
| Indice de confiance | **C** |

## Formulation (clusters « Normes » / « Réglementation »)
> « Le **dossier de diagnostic technique** réunit les constats obligatoires (DPE, amiante, plomb, gaz, électricité **NF C 16-600**, termites **NF P03-201**, ERP, mesurage **Loi Carrez**) selon le bien et la transaction (**Code de la construction**, de la **santé publique**, de l'**énergie**) ; ils sont réalisés par un **diagnostiqueur certifié**. » `[C]` ⟦liste/validité/seuils exacts à valider par un expert⟧

> **Métier réservé** : **aucune méthode, mesure, prélèvement ni procédure** de diagnostic n'est décrite ; ce Livre aide à **comprendre, organiser, lire et orienter**. `[C]`

> **Interfaces** : l'**amiante/plomb** vers le **Désamiantage** ([comprendre-reperage-diagnostics](../../professions/desamiantage/cards/comprendre-reperage-diagnostics.md)), les **termites** vers le **Traitement de charpente**, les **anomalies électriques** vers l'**Électricité**, le **gaz** vers le **Chauffagiste**, les **travaux/fin de chantier** vers le **Nettoyage** — métiers distincts, jamais absorbés. `[C]`

## Cadre
- **Normes** : diagnostic de l'installation **électrique** intérieure **NF C 16-600** ; installation électrique de référence **NF C 15-100** ; cadre des diagnostics : **Code de la construction** (dossier de diagnostic technique / DDT), **Code de la santé publique** (amiante, plomb / CREP, ERP), **Code de l'énergie** (DPE, audit), **NF X46-020** (amiante), **NF P03-201** (termites), **Loi Carrez** (mesurage) et **certification des diagnostiqueurs** ⟦en prose, à confirmer⟧ `[B]` ⟦cadre réglementaire à confirmer⟧. `respecte-norme`
- **Relations** : `cite-carte` → [principe-diagnostic-immobilier](../../professions/diagnostic/cards/principe-diagnostic-immobilier.md).
- **Tags** : `metier:diagnostic famille:specialises type:phrase usage:normes cluster:normes cluster:reglementation relation:desamiantage relation:traitement-charpente relation:electricite-generale relation:chauffage relation:nettoyage`

## Historique
| Version | Date | Auteur | Validateur | Motif |
|---|---|---|---|---|
| v0.1 | 2026-08-05 | IA | ⟦—⟧ | proposition initiale (Brouillon) |
