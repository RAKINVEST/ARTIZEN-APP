# Reconnaître les matériaux susceptibles de contenir de l'amiante

> **Brouillon (v0) — proposé par IA, en attente de validation métier** (Loi 7/18). Modèle : [../../../cards/CARD_TEMPLATE.md](../../../cards/CARD_TEMPLATE.md).
> Niveaux de confiance : A normes/fabricant · B technique · C terrain validé · D hypothèse. Rien n'est publié comme certitude.

## Métadonnées
| Champ | Valeur |
|---|---|
| Identifiant | `reconnaitre-materiaux-mpca` |
| Titre | Reconnaître les matériaux susceptibles de contenir de l'amiante |
| Profession | `metier:desamiantage` |
| Famille | `famille:specialises` |
| Sous-famille | `sous-famille:desamiantage` |
| Version | v0.1 |
| Auteur | IA (proposition) |
| Validateur | ⟦à valider métier⟧ |
| Statut | Brouillon |
| Indice de confiance | **C** |

## Cadrage
- **Objectif** : savoir **repérer visuellement** les matériaux susceptibles de contenir de l'amiante (MPCA) — pour décider d'arrêter, pas pour intervenir. `[C]`
- **Résumé** : connaître les familles de **matériaux susceptibles de contenir de l'amiante** (avant 1997) : **amiante-ciment** (plaques ondulées de toiture, canalisations), **flocages** et **calorifugeages** (tuyauteries, chaudières), **dalles de sol** et colles, **enduits/mastics** (dont mastics de vitrage), joints, tresses et garnitures, faux-plafonds ; savoir qu'un simple **doute visuel suffit à arrêter** et faire analyser — seule une **analyse** confirme la présence d'amiante. `[C]` ⟦listes MPCA (annexes réglementaires) à confirmer⟧

## Réalisation
- **Étapes** *(compréhension / repérage / décision — aucune opération de retrait, confinement ou démontage décrite)* :
  1. Repérer **amiante-ciment** (toiture/canalisations — interface Couverture). `[A]` → [remplacer-tuiles-ardoises](../../../professions/couverture/cards/remplacer-tuiles-ardoises.md)
  2. Repérer **flocage / calorifugeage** (tuyauteries — interface Plomberie/Chauffage). `[A]` → [controler-etancheite-reseau](../../../professions/plomberie/cards/controler-etancheite-reseau.md)
  3. Repérer **dalles / colles / enduits / mastics / joints**. `[A]`
  4. Doute → **arrêt** + analyse (ne jamais gratter pour « vérifier »). `[A]` → [materiau-suspect-decouvert](../../../diagnostics/desamiantage/materiau-suspect-decouvert.md)
- **Points critiques** : familles de MPCA connues (avant 1997) ; **doute = arrêt** ; seule l'**analyse** confirme ; jamais gratter/prélever sans précaution.
- **Sécurité** : inhalation de fibres ; dispersion (matériau dégradé) ; — **L'amiante est cancérogène** : l'inhalation de fibres (invisibles) provoque des maladies graves (asbestose, cancers) — **pas de seuil sans risque**. **Ce Livre n'explique jamais comment retirer, confiner ou démonter** : ces opérations sont **réservées à des entreprises certifiées** (**SS3**) ou à du personnel formé (**SS4**), sous plan de retrait / mode opératoire. **En cas de découverte ou de doute** (matériau susceptible de contenir de l'amiante) : **ARRÊT IMMÉDIAT** des travaux, **ne pas percer / poncer / découper / casser**, **ne pas déplacer** le matériau, **signaler**, faire **repérer / analyser** (diagnostiqueur / laboratoire), **orienter vers une entreprise certifiée**. **Protection des occupants** : éviter toute dispersion de fibres. **Déchets** amiantés : filière réglementée (**présentation uniquement**). **Aucun geste technique de désamiantage n'est décrit ici.** `[A]`

## Cadre & suites
- **Normes** : **cadre réglementaire amiante** : **Code du travail** (R.4412-94 et s. — **SS3/SS4**), **Code de la santé publique** (repérage / DTA), **NF X46-020** (repérage avant travaux) et arrêtés (8 avril 2013, 26 juin 2019) ⟦références non détectées — à confirmer par un expert⟧ ; côté **interfaces** où l'amiante est fréquent : conduits / fumisterie **DTU 24.1**, anciens équipements électriques **NF C 15-100** ⟦interfaces, à confirmer⟧ `[B]` ⟦cadre réglementaire à confirmer par le validateur⟧. `respecte-norme`
- **Repérage / diagnostics** : `cite-carte` → [comprendre-reperage-diagnostics](comprendre-reperage-diagnostics.md)

## Relations & tags
- **Tags** : `metier:desamiantage famille:specialises sous-famille:desamiantage intervention:comprendre cluster:materiaux-mpca cluster:reperage complexite:moyenne type:principe securite:amiante relation:couverture relation:plomberie`

## Historique
| Version | Date | Auteur | Validateur | Motif |
|---|---|---|---|---|
| v0.1 | 2026-08-05 | IA | ⟦—⟧ | proposition initiale (Brouillon) |
