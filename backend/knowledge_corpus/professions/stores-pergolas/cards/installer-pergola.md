# Installer une pergola (bioclimatique / adossée / autoportée)

> **Brouillon (v0) — proposé par IA, en attente de validation métier** (Loi 7/18). Modèle : [../../../cards/CARD_TEMPLATE.md](../../../cards/CARD_TEMPLATE.md).
> Niveaux de confiance : A normes/fabricant · B technique · C terrain validé · D hypothèse. Rien n'est publié comme certitude.

## Métadonnées
| Champ | Valeur |
|---|---|
| Identifiant | `installer-pergola` |
| Titre | Installer une pergola (bioclimatique / adossée / autoportée) |
| Profession | `metier:stores-pergolas` |
| Famille | `famille:enveloppe` |
| Sous-famille | `sous-famille:stores-pergolas` |
| Version | v0.1 |
| Auteur | IA (proposition) |
| Validateur | ⟦à valider métier⟧ |
| Statut | Brouillon |
| Indice de confiance | **C** |

## Cadrage
- **Objectif** : installer une pergola (bioclimatique à lames, adossée ou autoportée) avec un ancrage et une évacuation d'eau maîtrisés. `[C]`
- **Résumé** : implanter et sceller/ancrer les **poteaux** (charges vent/neige selon Eurocodes), monter la structure, gérer l'**évacuation d'eau** (lames/chenaux vers descentes), et pour l'**adossée** traiter l'interface au mur/toiture (étanchéité). `[C]` ⟦fondations/ancrage selon charges à confirmer⟧

## Réalisation
- **Étapes** :
  1. Implanter et **ancrer/sceller les poteaux** (fondations, charges). `[A]` ⟦dimensionnement à confirmer⟧
  2. Monter structure et **lames** (bioclimatique) / couverture. `[C]`
  3. Gérer l'**évacuation d'eau** (chenaux → descentes). `[C]`
  4. **Adossée** : interface mur/toiture → Étanchéité. `[C]` → [traiter-penetrations-points-singuliers](../../../professions/etancheite/cards/traiter-penetrations-points-singuliers.md)
- **Points critiques** : **ancrage/charges** (vent/neige) dimensionnés ; évacuation d'eau ; interface étanche pour l'adossée (jamais improvisée).
- **Sécurité** : manutention lourde ; hauteur ; stabilité pendant le montage ; électricité (lames/capteurs). **Travail en **hauteur** (pose en façade) : protections collectives / EPI. **Manutention** de structures lourdes (armature de store banne **sous tension**, poteaux de pergola) : risque d'écrasement — levage/binôme. **Fixation & stabilité** : un ancrage sous-dimensionné = **arrachement au vent** (danger majeur) → fixation adaptée au support et aux **charges** (vent/neige). **Motorisation / capteurs** : raccordement électrique **réservé à un professionnel** (voir Électricité). **Pincement** (mécanisme articulé, lames orientables). **Météo** (vent) surveillée. **Arrêt immédiat en cas de danger.** Une intervention relève de **compétences adaptées**.** `[A]`

## Cadre & suites
- **Normes** : fermetures / stores **DTU 34.1** ; fixation sur support maçonné **DTU 20.1** ; stores extérieurs **NF EN 13561** (classes de résistance au vent) et pergolas dimensionnées selon les **Eurocodes** (charges vent/neige) ⟦à confirmer⟧ `[B]` ⟦références/versions exactes à confirmer par le validateur⟧. `respecte-norme`
- **Motorisation lames** : `cite-carte` → [motoriser-regler-store-pergola](motoriser-regler-store-pergola.md)

## Relations & tags
- **Tags** : `metier:stores-pergolas equipement:pergola famille:enveloppe sous-famille:stores-pergolas intervention:poser intervention:realiser cluster:pergolas-bioclimatiques cluster:pergolas-adossees cluster:pergolas-autoportees complexite:expert type:installation securite:manutention relation:etancheite`

## Historique
| Version | Date | Auteur | Validateur | Motif |
|---|---|---|---|---|
| v0.1 | 2026-08-05 | IA | ⟦—⟧ | proposition initiale (Brouillon) |
