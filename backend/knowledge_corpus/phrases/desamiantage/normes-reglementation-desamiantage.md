# Phrase — cadre réglementaire & interfaces désamiantage

> **Brouillon (v0) — proposé par IA, en attente de validation métier** (Loi 7/18). Modèle : [../../cards/CARD_TEMPLATE.md](../../cards/CARD_TEMPLATE.md).
> Niveaux de confiance : A normes/fabricant · B technique · C terrain validé · D hypothèse.

## Métadonnées
| Champ | Valeur |
|---|---|
| Identifiant | `normes-reglementation-desamiantage` |
| Titre | Phrase — cadre réglementaire & interfaces désamiantage |
| Profession | `metier:desamiantage` |
| Famille | `famille:specialises` |
| Sous-famille | `sous-famille:desamiantage` |
| Version | v0.1 |
| Auteur | IA (proposition) |
| Validateur | ⟦à valider métier⟧ |
| Statut | Brouillon |
| Indice de confiance | **C** |

## Formulation (clusters « Normes » / « Réglementation »)
> « Face à l'amiante, nous appliquons la règle : **reconnaître, arrêter, signaler, orienter**. Le **retrait / l'encapsulage** relèvent d'**entreprises certifiées** (**Code du travail**, R.4412-94 et s. — **SS3/SS4**), après **repérage** par un diagnostiqueur (**NF X46-020**, DTA) ; nous ne réalisons **aucun** désamiantage. » `[C]` ⟦cadre réglementaire (Code du travail / santé publique / arrêtés) à valider par un expert⟧

> **Métier d'interface** : l'amiante concerne des ouvrages du **couvreur**, du **chauffagiste**, du **vitrier**, du **ramoneur**, de l'**ascensoriste**, du **maçon**, de l'**électricien**, du **menuisier**… ([remplacer-menuiserie](../../professions/menuiserie-exterieure/cards/remplacer-menuiserie.md)) : chacun **arrête et oriente**, jamais n'absorbe le désamiantage. `[C]`

> **Interdits** : aucun **mode opératoire de retrait**, de **confinement** ou de **démontage** n'est produit ; les **déchets** amiantés suivent une filière réglementée (présentation uniquement). `[C]`

## Cadre
- **Normes** : **cadre réglementaire amiante** : **Code du travail** (R.4412-94 et s. — **SS3/SS4**), **Code de la santé publique** (repérage / DTA), **NF X46-020** (repérage avant travaux) et arrêtés (8 avril 2013, 26 juin 2019) ⟦références non détectées — à confirmer par un expert⟧ ; côté **interfaces** où l'amiante est fréquent : conduits / fumisterie **DTU 24.1**, anciens équipements électriques **NF C 15-100** ⟦interfaces, à confirmer⟧ `[B]` ⟦cadre réglementaire à confirmer⟧. `respecte-norme`
- **Relations** : `cite-carte` → [principe-desamiantage](../../professions/desamiantage/cards/principe-desamiantage.md).
- **Tags** : `metier:desamiantage famille:specialises type:phrase usage:normes cluster:normes cluster:reglementation relation:couverture relation:chauffage relation:vitrerie relation:ramonage relation:ascenseur relation:menuiserie-exterieure relation:diagnostic`

## Historique
| Version | Date | Auteur | Validateur | Motif |
|---|---|---|---|---|
| v0.1 | 2026-08-05 | IA | ⟦—⟧ | proposition initiale (Brouillon) |
