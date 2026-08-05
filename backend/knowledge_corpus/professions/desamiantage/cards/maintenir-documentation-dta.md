# Maintenir la documentation (DTA, traçabilité)

> **Brouillon (v0) — proposé par IA, en attente de validation métier** (Loi 7/18). Modèle : [../../../cards/CARD_TEMPLATE.md](../../../cards/CARD_TEMPLATE.md).
> Niveaux de confiance : A normes/fabricant · B technique · C terrain validé · D hypothèse. Rien n'est publié comme certitude.

## Métadonnées
| Champ | Valeur |
|---|---|
| Identifiant | `maintenir-documentation-dta` |
| Titre | Maintenir la documentation (DTA, traçabilité) |
| Profession | `metier:desamiantage` |
| Famille | `famille:specialises` |
| Sous-famille | `sous-famille:desamiantage` |
| Version | v0.1 |
| Auteur | IA (proposition) |
| Validateur | ⟦à valider métier⟧ |
| Statut | Brouillon |
| Indice de confiance | **C** |

## Cadrage
- **Objectif** : comprendre la **maintenance documentaire** : DTA, repérages, traçabilité des décisions et signalements. `[C]`
- **Résumé** : comprendre l'importance de la **documentation amiante** : consulter et tenir à jour le **DTA** (Dossier Technique Amiante), conserver les **repérages** (RAT, avant vente/démolition), tracer les **signalements**, **arrêts** et **orientations** vers des entreprises certifiées, et transmettre l'information aux intervenants ; cette traçabilité protège occupants et intervenants — c'est une **maintenance documentaire**, pas une intervention. `[C]` ⟦contenu/mise à jour du DTA à confirmer⟧

## Réalisation
- **Étapes** *(compréhension / repérage / décision — aucune opération de retrait, confinement ou démontage décrite)* :
  1. Consulter / tenir à jour le **DTA**. `[A]` → [controle-documentaire-dta-amiante](../../../checklists/desamiantage/controle-documentaire-dta-amiante.md)
  2. Conserver les **repérages** (RAT / avant démolition). `[C]`
  3. Tracer **signalements / arrêts / orientations**. `[C]`
  4. **Anciens équipements** (élec/menuiseries) : vérifier le DTA. `[C]` → [controler-tableau-electrique](../../../professions/electricite-generale/cards/controler-tableau-electrique.md)
- **Points critiques** : DTA **à jour** ; repérages conservés ; décisions tracées ; information transmise ; protection par la traçabilité.
- **Sécurité** : inhalation (si info perdue) ; — ; — **L'amiante est cancérogène** : l'inhalation de fibres (invisibles) provoque des maladies graves (asbestose, cancers) — **pas de seuil sans risque**. **Ce Livre n'explique jamais comment retirer, confiner ou démonter** : ces opérations sont **réservées à des entreprises certifiées** (**SS3**) ou à du personnel formé (**SS4**), sous plan de retrait / mode opératoire. **En cas de découverte ou de doute** (matériau susceptible de contenir de l'amiante) : **ARRÊT IMMÉDIAT** des travaux, **ne pas percer / poncer / découper / casser**, **ne pas déplacer** le matériau, **signaler**, faire **repérer / analyser** (diagnostiqueur / laboratoire), **orienter vers une entreprise certifiée**. **Protection des occupants** : éviter toute dispersion de fibres. **Déchets** amiantés : filière réglementée (**présentation uniquement**). **Aucun geste technique de désamiantage n'est décrit ici.** `[A]`

## Cadre & suites
- **Normes** : **cadre réglementaire amiante** : **Code du travail** (R.4412-94 et s. — **SS3/SS4**), **Code de la santé publique** (repérage / DTA), **NF X46-020** (repérage avant travaux) et arrêtés (8 avril 2013, 26 juin 2019) ⟦références non détectées — à confirmer par un expert⟧ ; côté **interfaces** où l'amiante est fréquent : conduits / fumisterie **DTU 24.1**, anciens équipements électriques **NF C 15-100** ⟦interfaces, à confirmer⟧ `[B]` ⟦cadre réglementaire à confirmer par le validateur⟧. `respecte-norme`
- **Interface menuiseries** (mastics anciens) : `renvoie-vers` → [remplacer-menuiserie](../../../professions/menuiserie-exterieure/cards/remplacer-menuiserie.md)

## Relations & tags
- **Tags** : `metier:desamiantage famille:specialises sous-famille:desamiantage intervention:controler cluster:maintenance-documentaire cluster:reperage complexite:moyenne type:principe securite:amiante relation:electricite-generale relation:menuiserie-exterieure`

## Historique
| Version | Date | Auteur | Validateur | Motif |
|---|---|---|---|---|
| v0.1 | 2026-08-05 | IA | ⟦—⟧ | proposition initiale (Brouillon) |
