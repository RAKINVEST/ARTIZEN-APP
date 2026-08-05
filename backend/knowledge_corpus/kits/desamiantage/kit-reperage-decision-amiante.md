# Kit de repérage et de décision (identification, pas retrait)

> **Brouillon (v0) — proposé par IA, en attente de validation métier** (Loi 7/18). Modèle : [../../cards/CARD_TEMPLATE.md](../../cards/CARD_TEMPLATE.md).
> Niveaux de confiance : A normes/fabricant · B technique · C terrain validé · D hypothèse.

## Métadonnées
| Champ | Valeur |
|---|---|
| Identifiant | `kit-reperage-decision-amiante` |
| Titre | Kit de repérage et de décision (identification, pas retrait) |
| Profession | `metier:desamiantage` |
| Famille | `famille:specialises` |
| Sous-famille | `sous-famille:desamiantage` |
| Version | v0.1 |
| Auteur | IA (proposition) |
| Validateur | ⟦à valider métier⟧ |
| Statut | Brouillon |
| Indice de confiance | **C** |

## Composition conseillée (identification / décision — **jamais** retrait)
- **Appareil photo / lampe** pour inspection **visuelle à distance** ; fiches de repérage MPCA ; DTA. `[C]`
- **Balisage / rubalise**, panneaux « zone à ne pas pénétrer », fiche de **signalement**. `[C]`
- **Annuaire** : diagnostiqueurs certifiés et **entreprises de désamiantage certifiées** (orientation). `[C]`
- Protection de **mise en sécurité/repli** (masque FFP3 pour évacuer, pas pour travailler). `[A]`

> **Ce kit ne contient aucun matériel de retrait / confinement / extraction** : ces équipements relèvent **exclusivement** des entreprises certifiées. `[A]`

## Cadre
- **Normes** : **cadre réglementaire amiante** : **Code du travail** (R.4412-94 et s. — **SS3/SS4**), **Code de la santé publique** (repérage / DTA), **NF X46-020** (repérage avant travaux) et arrêtés (8 avril 2013, 26 juin 2019) ⟦références non détectées — à confirmer par un expert⟧ ; côté **interfaces** où l'amiante est fréquent : conduits / fumisterie **DTU 24.1**, anciens équipements électriques **NF C 15-100** ⟦interfaces, à confirmer⟧ `[B]` ⟦cadre réglementaire à confirmer⟧. `respecte-norme`
- **Relations** : `utilise-kit` → [arreter-signaler-en-cas-de-doute](../../professions/desamiantage/cards/arreter-signaler-en-cas-de-doute.md).
- **Tags** : `metier:desamiantage famille:specialises sous-famille:desamiantage type:kit cluster:reperage cluster:orientation equipement:balisage-signalement`

## Historique
| Version | Date | Auteur | Validateur | Motif |
|---|---|---|---|---|
| v0.1 | 2026-08-05 | IA | ⟦—⟧ | proposition initiale (Brouillon) |
