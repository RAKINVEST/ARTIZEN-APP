# Kit d'organisation des diagnostics (lecture, pas mesure)

> **Brouillon (v0) — proposé par IA, en attente de validation métier** (Loi 7/18). Modèle : [../../cards/CARD_TEMPLATE.md](../../cards/CARD_TEMPLATE.md).
> Niveaux de confiance : A normes/fabricant · B technique · C terrain validé · D hypothèse.

## Métadonnées
| Champ | Valeur |
|---|---|
| Identifiant | `kit-organisation-diagnostics` |
| Titre | Kit d'organisation des diagnostics (lecture, pas mesure) |
| Profession | `metier:diagnostic` |
| Famille | `famille:specialises` |
| Sous-famille | `sous-famille:diagnostic` |
| Version | v0.1 |
| Auteur | IA (proposition) |
| Validateur | ⟦à valider métier⟧ |
| Statut | Brouillon |
| Indice de confiance | **C** |

## Composition conseillée (**organisation / lecture** — pas d'appareil de diagnostic)
- **Grille des diagnostics** par transaction/âge/zone, modèle de **DDT**, tableau des **durées de validité**. `[C]`
- **Annuaire** de **diagnostiqueurs certifiés** et des corps d'état (élec/gaz/désamiantage/traitement) pour orientation. `[C]`
- Fiches de **lecture de rapport** (conclusions/anomalies/validité), check-lists documentaires. `[C]`

> **Ce kit ne contient aucun appareil de mesure ni de prélèvement** : la réalisation des diagnostics relève d'un **diagnostiqueur certifié**. `[A]`

## Cadre
- **Normes** : diagnostic de l'installation **électrique** intérieure **NF C 16-600** ; installation électrique de référence **NF C 15-100** ; cadre des diagnostics : **Code de la construction** (dossier de diagnostic technique / DDT), **Code de la santé publique** (amiante, plomb / CREP, ERP), **Code de l'énergie** (DPE, audit), **NF X46-020** (amiante), **NF P03-201** (termites), **Loi Carrez** (mesurage) et **certification des diagnostiqueurs** ⟦en prose, à confirmer⟧ `[B]` ⟦cadre réglementaire à confirmer⟧. `respecte-norme`
- **Relations** : `utilise-kit` → [lire-interpreter-rapport-suites](../../professions/diagnostic/cards/lire-interpreter-rapport-suites.md).
- **Tags** : `metier:diagnostic famille:specialises sous-famille:diagnostic type:kit cluster:ddt cluster:lecture-rapport equipement:grille-diagnostics`

## Historique
| Version | Date | Auteur | Validateur | Motif |
|---|---|---|---|---|
| v0.1 | 2026-08-05 | IA | ⟦—⟧ | proposition initiale (Brouillon) |
