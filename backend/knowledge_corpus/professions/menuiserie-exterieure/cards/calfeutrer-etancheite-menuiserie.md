# Calfeutrer / étanchéifier une menuiserie (AEV)

> **Brouillon (v0) — proposé par IA, en attente de validation métier** (Loi 7/18). Modèle : [../../../cards/CARD_TEMPLATE.md](../../../cards/CARD_TEMPLATE.md).
> Niveaux de confiance : A normes/fabricant · B technique · C terrain validé · D hypothèse. Rien n'est publié comme certitude.

## Métadonnées
| Champ | Valeur |
|---|---|
| Identifiant | `calfeutrer-etancheite-menuiserie` |
| Titre | Calfeutrer / étanchéifier une menuiserie (AEV) |
| Profession | `metier:menuiserie-exterieure` |
| Famille | `famille:enveloppe` |
| Sous-famille | `sous-famille:menuiserie-exterieure` |
| Version | v0.1 |
| Auteur | IA (proposition) |
| Validateur | ⟦à valider métier⟧ |
| Statut | Brouillon |
| Indice de confiance | **C** |

## Cadrage
- **Objectif** : réaliser le calfeutrement et l'étanchéité air-eau-vent (AEV) de la liaison menuiserie/gros œuvre. `[C]`
- **Résumé** : assurer la **triple barrière** : étanchéité à l'eau extérieure (mastic/bavette d'appui), étanchéité à l'air intérieure (compribande/membrane), avec **drainage** intermédiaire, en interface avec la façade (joint), l'ITE (tableau) et l'étanchéité (appui/seuil). `[C]` ⟦système de calfeutrement selon configuration à confirmer⟧

## Réalisation
- **Étapes** :
  1. Étanchéité **eau** extérieure (mastic/bavette d'appui). `[C]` → [traiter-penetrations-points-singuliers](../../../professions/etancheite/cards/traiter-penetrations-points-singuliers.md)
  2. Étanchéité **air** intérieure (compribande/membrane). `[C]` → [poser-pare-vapeur](../../../professions/isolation/cards/poser-pare-vapeur.md)
  3. Ménager le **drainage** intermédiaire. `[C]`
  4. Interface **tableau ITE** / façade. `[C]` → [traiter-points-singuliers-ite](../../../professions/isolation-exterieure/cards/traiter-points-singuliers-ite.md)
- **Points critiques** : AEV = **eau dehors, air dedans, drainage au milieu** ; continuité sans rupture ; compatibilité des mastics/supports.
- **Sécurité** : produits (mastics/mousses) ; hauteur ; interfaces multiples. **Manutention** de menuiseries/**vitrages lourds** : risque d'écrasement / **coupure** (verre) — moyens de levage, gants anti-coupure, travail en binôme. **Travail en **hauteur** (baies d'étage, dépose) : protections collectives / EPI. **Produits** (mousse PU, mastics, solvants) : EPI / ventilation. **Motorisation de volet** : le **raccordement électrique** relève d'un professionnel (voir Électricité). **Stabilité** du support/de la baie vérifiée avant dépose. **Arrêt immédiat en cas de danger.** Une intervention relève de **compétences adaptées**.** `[A]`

## Cadre & suites
- **Normes** : mise en œuvre des fenêtres et portes extérieures **DTU 36.5** ; vitrerie-miroiterie **DTU 39** ; fermetures / volets **DTU 34.1** ; performance **classement AEV (Air-Eau-Vent)** ⟦à confirmer⟧ `[B]` ⟦références/versions exactes à confirmer par le validateur⟧. `respecte-norme`
- **Diagnostic infiltration** : `traite-diagnostic` → [infiltration-air-eau-menuiserie](../../../diagnostics/menuiserie-exterieure/infiltration-air-eau-menuiserie.md)

## Relations & tags
- **Tags** : `metier:menuiserie-exterieure famille:enveloppe sous-famille:menuiserie-exterieure intervention:realiser cluster:joints cluster:seuils cluster:points-singuliers complexite:avancee type:installation securite:manutention relation:etancheite relation:isolation relation:isolation-exterieure`

## Historique
| Version | Date | Auteur | Validateur | Motif |
|---|---|---|---|---|
| v0.1 | 2026-08-05 | IA | ⟦—⟧ | proposition initiale (Brouillon) |
