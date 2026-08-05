# Scier / carotter (béton, maçonnerie)

> **Brouillon (v0) — proposé par IA, en attente de validation métier** (Loi 7/18). Modèle : [../../../cards/CARD_TEMPLATE.md](../../../cards/CARD_TEMPLATE.md).
> Niveaux de confiance : A normes/fabricant · B technique · C terrain validé · D hypothèse. Rien n'est publié comme certitude.

## Métadonnées
| Champ | Valeur |
|---|---|
| Identifiant | `scier-carotter` |
| Titre | Scier / carotter (béton, maçonnerie) |
| Profession | `metier:demolition` |
| Famille | `famille:gros-oeuvre` |
| Sous-famille | `sous-famille:demolition` |
| Version | v0.1 |
| Auteur | IA (proposition) |
| Validateur | ⟦à valider métier⟧ |
| Statut | Brouillon |
| Indice de confiance | **C** |

## Cadrage
- **Objectif** : réaliser des découpes propres par **sciage** ou **carottage** (béton, maçonnerie) pour ouvertures/réservations. `[C]`
- **Résumé** : délimiter la découpe, vérifier l'absence de réseaux/armatures sensibles, scier (mur/sol) ou **carotter** à l'eau (limiter la **silice** et échauffement), étayer si porteur, et évacuer les carottes/déchets. `[C]` ⟦matériel/refroidissement selon ouvrage à confirmer⟧

## Réalisation
- **Étapes** :
  1. Délimiter ; vérifier réseaux/armatures (repérage). `[A]`
  2. Scier / **carotter à l'eau** (limite poussières/silice). `[C]`
  3. Étayer si l'ouverture touche un **porteur**. `[A]` → [demolir-partiel-porteur-etaiement](demolir-partiel-porteur-etaiement.md)
  4. Évacuer carottes/gravats. `[C]`
- **Points critiques** : coupe à l'eau (silice) ; repérage réseaux/armatures ; étaiement si porteur ; découpe maîtrisée.
- **Sécurité** : silice (privilégier voie humide) ; électricité (outil/eau) ; projections ; bruit. **Stabilité de l'ouvrage** : toute démolition partielle/sélective d'un élément porteur engage la structure — **diagnostic + étaiement préalables** (risque d'**effondrement**), démolir dans le bon ordre (haut vers bas, non-porteur avant porteur). **Amiante / plomb** : **diagnostic avant travaux obligatoire** ; en présence d'amiante, opération **réservée à une entreprise certifiée** — **jamais** en démolition courante. **Consignation des réseaux** (élec/gaz/eau) avant dépose. **Poussières (silice)**, **bruit**, **vibrations**, **projections**, **chute d'objets**, **hauteur**, **manutention/levage/engins** : EPI, **balisage**, périmètre. **Arrêt immédiat en cas de danger.** Opérations lourdes/réglementées **réservées aux entreprises qualifiées**.** `[A]`

## Cadre & suites
- **Normes** : démolition/reprise d'ouvrages en maçonnerie **DTU 20.1** et en béton **DTU 21** ; diagnostics réglementaires avant travaux (**PEMD** déchets, **amiante**, **plomb/CREP**) et **Code du travail** (étaiement/protection) ⟦en prose, à confirmer⟧ `[B]` ⟦références/versions exactes à confirmer par le validateur⟧. `respecte-norme`
- **Contrôle** : `a-checklist` → [controle-avant-demolition](../../../checklists/demolition/controle-avant-demolition.md)

## Relations & tags
- **Tags** : `metier:demolition famille:gros-oeuvre sous-famille:demolition intervention:realiser cluster:sciage cluster:carottage complexite:avancee type:technique securite:silice`

## Historique
| Version | Date | Auteur | Validateur | Motif |
|---|---|---|---|---|
| v0.1 | 2026-08-05 | IA | ⟦—⟧ | proposition initiale (Brouillon) |
