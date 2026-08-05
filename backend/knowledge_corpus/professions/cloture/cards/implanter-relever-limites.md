# Implanter et relever les limites

> **Brouillon (v0) — proposé par IA, en attente de validation métier** (Loi 7/18). Modèle : [../../../cards/CARD_TEMPLATE.md](../../../cards/CARD_TEMPLATE.md).
> Niveaux de confiance : A normes/fabricant · B technique · C terrain validé · D hypothèse. Rien n'est publié comme certitude.

## Métadonnées
| Champ | Valeur |
|---|---|
| Identifiant | `implanter-relever-limites` |
| Titre | Implanter et relever les limites |
| Profession | `metier:cloture` |
| Famille | `famille:specialises` |
| Sous-famille | `sous-famille:cloture` |
| Version | v0.1 |
| Auteur | IA (proposition) |
| Validateur | ⟦à valider métier⟧ |
| Statut | Brouillon |
| Indice de confiance | **B** |

## Cadrage
- **Objectif** : implanter la clôture en respectant les **limites de propriété** (bornage) et les règles d'urbanisme. `[B]`
- **Résumé** : identifier les **limites** (bornes, plan de bornage — en cas de doute, **géomètre**), vérifier les règles d'**urbanisme** (PLU : hauteur, aspect, alignement) et la **mitoyenneté** (Code civil), puis tracer l'implantation (alignement, angles, emplacements de poteaux) ; une clôture posée hors limite ou non conforme au PLU expose à la dépose — la vérification est essentielle. `[B]` ⟦limites/PLU/mitoyenneté selon parcelle à confirmer⟧

## Réalisation
- **Étapes** :
  1. Identifier les **limites** (bornes / géomètre si doute). `[A]`
  2. Vérifier **PLU** (hauteur/aspect) et **mitoyenneté**. `[A]`
  3. Tracer l'implantation (alignement, poteaux). `[C]`
  4. **DICT / réseaux** avant tout creusement. `[A]` → [terrasser-reseaux-dict](../../../professions/terrassement/cards/terrasser-reseaux-dict.md)
- **Points critiques** : **limites de propriété** respectées (bornage) ; **PLU**/mitoyenneté vérifiés ; alignement ; DICT avant creusement.
- **Sécurité** : — ; réseaux (DICT) ; — **Repérage des réseaux enterrés avant creusement** (**DT-DICT**) : une clôture = de nombreux **trous de poteaux** → ne pas percer un câble/tuyau (électrocution, gaz, eau). **Terrassements légers** : effondrement des petits trous, tarière/engins. **Scellements béton** : ciment (brûlures/irritations, EPI), charges. **Manutention** (poteaux, panneaux rigides, rouleaux de grillage, platines) : binôme/moyens — dos/écrasement. **Découpe / outils électroportatifs** : meuleuse/scie (projections, coupures) — disque adapté/capot, lunettes/gants. **Fil de grillage sous tension** : coupures, fouet du fil (écran facial). **Travail en bordure** (voie/talus) : signalisation/co-activité. **Amiante** (rénovation, anciens panneaux/plaques) : diagnostic ; retrait réservé à une **entreprise certifiée** (**jamais ici**). **Arrêt immédiat en cas de danger.** `[A]`

## Cadre & suites
- **Normes** : béton de scellement des poteaux (**interface**) **DTU 21** ; ouvrages métalliques / portillons (**interface** métallerie) **DTU 37.1** ; grillages **NF EN 10223**, protection anticorrosion **NF EN ISO 1461 / NF EN ISO 12944**, règles d'**urbanisme** (PLU : hauteur/aspect), **bornage** (Code civil, géomètre) et **DT-DICT** (réseaux) ⟦en prose, à confirmer⟧ `[B]` ⟦références/versions exactes à confirmer par le validateur⟧. `respecte-norme`
- **Scellement des poteaux** : `cite-carte` → [sceller-poteaux-ancrages](sceller-poteaux-ancrages.md)

## Relations & tags
- **Tags** : `metier:cloture famille:specialises sous-famille:cloture intervention:comprendre cluster:implantation cluster:bornage complexite:moyenne type:conception securite:reseaux relation:terrassement`

## Historique
| Version | Date | Auteur | Validateur | Motif |
|---|---|---|---|---|
| v0.1 | 2026-08-05 | IA | ⟦—⟧ | proposition initiale (Brouillon) |
