# Arrêter et signaler en cas de doute

> **Brouillon (v0) — proposé par IA, en attente de validation métier** (Loi 7/18). Modèle : [../../../cards/CARD_TEMPLATE.md](../../../cards/CARD_TEMPLATE.md).
> Niveaux de confiance : A normes/fabricant · B technique · C terrain validé · D hypothèse. Rien n'est publié comme certitude.

## Métadonnées
| Champ | Valeur |
|---|---|
| Identifiant | `arreter-signaler-en-cas-de-doute` |
| Titre | Arrêter et signaler en cas de doute |
| Profession | `metier:desamiantage` |
| Famille | `famille:specialises` |
| Sous-famille | `sous-famille:securite` |
| Version | v0.1 |
| Auteur | IA (proposition) |
| Validateur | ⟦à valider métier⟧ |
| Statut | Brouillon |
| Indice de confiance | **B** |

## Cadrage
- **Objectif** : connaître la **conduite à tenir** face à un matériau suspect : arrêt immédiat, non-intervention, signalement. `[B]`
- **Résumé** : définir le **réflexe de sécurité** : dès le **doute** sur un matériau susceptible de contenir de l'amiante, **arrêter immédiatement** les travaux, **ne rien faire** qui disperse des fibres (ne pas percer/poncer/découper/casser/déplacer), **isoler/baliser** la zone, **signaler** au maître d'ouvrage / responsable, et **faire repérer** avant toute reprise ; c'est une **décision d'arrêt**, pas une intervention. `[A]` ⟦seuils/consignes selon réglementation à confirmer⟧

## Réalisation
- **Étapes** *(compréhension / repérage / décision — aucune opération de retrait, confinement ou démontage décrite)* :
  1. **Arrêt immédiat** au moindre doute. `[A]`
  2. **Ne pas** percer/poncer/découper/casser/déplacer. `[A]` → [materiau-suspect-decouvert](../../../diagnostics/desamiantage/materiau-suspect-decouvert.md)
  3. **Isoler / baliser** ; protéger les occupants. `[A]` → [proteger-occupants-comprendre-dechets](proteger-occupants-comprendre-dechets.md)
  4. **Signaler** + faire repérer avant reprise. `[A]` → [conduite-arret-signalement-orientation](../../../procedures/desamiantage/conduite-arret-signalement-orientation.md)
- **Points critiques** : **doute = arrêt** ; non-dispersion (ne rien faire) ; balisage ; signalement ; décision, jamais intervention.
- **Sécurité** : inhalation de fibres ; dispersion ; protection des occupants. **L'amiante est cancérogène** : l'inhalation de fibres (invisibles) provoque des maladies graves (asbestose, cancers) — **pas de seuil sans risque**. **Ce Livre n'explique jamais comment retirer, confiner ou démonter** : ces opérations sont **réservées à des entreprises certifiées** (**SS3**) ou à du personnel formé (**SS4**), sous plan de retrait / mode opératoire. **En cas de découverte ou de doute** (matériau susceptible de contenir de l'amiante) : **ARRÊT IMMÉDIAT** des travaux, **ne pas percer / poncer / découper / casser**, **ne pas déplacer** le matériau, **signaler**, faire **repérer / analyser** (diagnostiqueur / laboratoire), **orienter vers une entreprise certifiée**. **Protection des occupants** : éviter toute dispersion de fibres. **Déchets** amiantés : filière réglementée (**présentation uniquement**). **Aucun geste technique de désamiantage n'est décrit ici.** `[A]`

## Cadre & suites
- **Normes** : **cadre réglementaire amiante** : **Code du travail** (R.4412-94 et s. — **SS3/SS4**), **Code de la santé publique** (repérage / DTA), **NF X46-020** (repérage avant travaux) et arrêtés (8 avril 2013, 26 juin 2019) ⟦références non détectées — à confirmer par un expert⟧ ; côté **interfaces** où l'amiante est fréquent : conduits / fumisterie **DTU 24.1**, anciens équipements électriques **NF C 15-100** ⟦interfaces, à confirmer⟧ `[B]` ⟦cadre réglementaire à confirmer par le validateur⟧. `respecte-norme`
- **Coordination / interfaces** : `cite-carte` → [gerer-interfaces-coordination](gerer-interfaces-coordination.md)

## Relations & tags
- **Tags** : `metier:desamiantage famille:specialises sous-famille:securite intervention:securiser cluster:arret-travaux cluster:signalement complexite:moyenne type:principe securite:amiante`

## Historique
| Version | Date | Auteur | Validateur | Motif |
|---|---|---|---|---|
| v0.1 | 2026-08-05 | IA | ⟦—⟧ | proposition initiale (Brouillon) |
