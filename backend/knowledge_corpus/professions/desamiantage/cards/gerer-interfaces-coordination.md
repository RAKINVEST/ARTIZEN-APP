# Gérer les interfaces et la coordination de chantier

> **Brouillon (v0) — proposé par IA, en attente de validation métier** (Loi 7/18). Modèle : [../../../cards/CARD_TEMPLATE.md](../../../cards/CARD_TEMPLATE.md).
> Niveaux de confiance : A normes/fabricant · B technique · C terrain validé · D hypothèse. Rien n'est publié comme certitude.

## Métadonnées
| Champ | Valeur |
|---|---|
| Identifiant | `gerer-interfaces-coordination` |
| Titre | Gérer les interfaces et la coordination de chantier |
| Profession | `metier:desamiantage` |
| Famille | `famille:specialises` |
| Sous-famille | `sous-famille:desamiantage` |
| Version | v0.1 |
| Auteur | IA (proposition) |
| Validateur | ⟦à valider métier⟧ |
| Statut | Brouillon |
| Indice de confiance | **C** |

## Cadrage
- **Objectif** : comprendre le désamiantage comme **métier d'interface** : quand chaque corps d'état s'arrête et oriente. `[C]`
- **Résumé** : l'amiante se trouve dans des ouvrages travaillés par d'**autres corps d'état** : le **couvreur** (amiante-ciment), le **chauffagiste** (calorifuge), le **vitrier** (mastics), le **ramoneur** (conduits/joints), l'**ascensoriste** (garnitures), le **maçon** (enduits/colles), l'**électricien** (anciens tableaux), le **menuisier** (mastics) ; chacun doit **arrêter et signaler** en cas de doute, et la reprise s'organise **après repérage et, si besoin, désamiantage** par une entreprise certifiée (coordination). `[C]` ⟦organisation de coordination selon chantier à confirmer⟧

## Réalisation
- **Étapes** *(compréhension / repérage / décision — aucune opération de retrait, confinement ou démontage décrite)* :
  1. **Chauffagiste** (calorifuge/chaudière) : arrêt si doute. `[A]` → [entretenir-chaudiere](../../../professions/chauffage/cards/entretenir-chaudiere.md)
  2. **Vitrier** (mastics anciens) : arrêt si doute. `[A]` → [entretenir-diagnostiquer-vitrerie](../../../professions/vitrerie/cards/entretenir-diagnostiquer-vitrerie.md)
  3. **Ramoneur** (conduits/joints) : arrêt si doute. `[A]` → [entretenir-diagnostiquer-conduit](../../../professions/ramonage/cards/entretenir-diagnostiquer-conduit.md)
  4. **Ascensoriste** (garnitures de frein) : arrêt si doute. `[A]` → [comprendre-modernisation](../../../professions/ascenseur/cards/comprendre-modernisation.md)
- **Points critiques** : chaque corps d'état **arrête/signale** ; reprise **après repérage/désamiantage** ; coordination ; jamais d'absorption des métiers.
- **Sécurité** : inhalation (co-activité) ; dispersion ; — **L'amiante est cancérogène** : l'inhalation de fibres (invisibles) provoque des maladies graves (asbestose, cancers) — **pas de seuil sans risque**. **Ce Livre n'explique jamais comment retirer, confiner ou démonter** : ces opérations sont **réservées à des entreprises certifiées** (**SS3**) ou à du personnel formé (**SS4**), sous plan de retrait / mode opératoire. **En cas de découverte ou de doute** (matériau susceptible de contenir de l'amiante) : **ARRÊT IMMÉDIAT** des travaux, **ne pas percer / poncer / découper / casser**, **ne pas déplacer** le matériau, **signaler**, faire **repérer / analyser** (diagnostiqueur / laboratoire), **orienter vers une entreprise certifiée**. **Protection des occupants** : éviter toute dispersion de fibres. **Déchets** amiantés : filière réglementée (**présentation uniquement**). **Aucun geste technique de désamiantage n'est décrit ici.** `[A]`

## Cadre & suites
- **Normes** : **cadre réglementaire amiante** : **Code du travail** (R.4412-94 et s. — **SS3/SS4**), **Code de la santé publique** (repérage / DTA), **NF X46-020** (repérage avant travaux) et arrêtés (8 avril 2013, 26 juin 2019) ⟦références non détectées — à confirmer par un expert⟧ ; côté **interfaces** où l'amiante est fréquent : conduits / fumisterie **DTU 24.1**, anciens équipements électriques **NF C 15-100** ⟦interfaces, à confirmer⟧ `[B]` ⟦cadre réglementaire à confirmer par le validateur⟧. `respecte-norme`
- **Documentation** : `cite-carte` → [maintenir-documentation-dta](maintenir-documentation-dta.md)

## Relations & tags
- **Tags** : `metier:desamiantage famille:specialises sous-famille:desamiantage intervention:comprendre cluster:interfaces cluster:coordination-chantier complexite:moyenne type:principe securite:amiante relation:chauffage relation:vitrerie relation:ramonage relation:ascenseur`

## Historique
| Version | Date | Auteur | Validateur | Motif |
|---|---|---|---|---|
| v0.1 | 2026-08-05 | IA | ⟦—⟧ | proposition initiale (Brouillon) |
