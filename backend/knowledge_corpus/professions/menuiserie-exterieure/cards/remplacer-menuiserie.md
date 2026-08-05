# Remplacer une menuiserie extérieure

> **Brouillon (v0) — proposé par IA, en attente de validation métier** (Loi 7/18). Modèle : [../../../cards/CARD_TEMPLATE.md](../../../cards/CARD_TEMPLATE.md).
> Niveaux de confiance : A normes/fabricant · B technique · C terrain validé · D hypothèse. Rien n'est publié comme certitude.

## Métadonnées
| Champ | Valeur |
|---|---|
| Identifiant | `remplacer-menuiserie` |
| Titre | Remplacer une menuiserie extérieure |
| Profession | `metier:menuiserie-exterieure` |
| Famille | `famille:enveloppe` |
| Sous-famille | `sous-famille:menuiserie-exterieure` |
| Version | v0.1 |
| Auteur | IA (proposition) |
| Validateur | ⟦à valider métier⟧ |
| Statut | Brouillon |
| Indice de confiance | **C** |

## Cadrage
- **Objectif** : remplacer une menuiserie (dépose totale ou pose en rénovation sur dormant existant) en rétablissant l'étanchéité. `[C]`
- **Résumé** : choisir entre **dépose totale** (dormant compris) et **rénovation** (conservation du dormant), déposer en sécurité, contrôler l'appui/le seuil, poser la neuve, rétablir calfeutrement AEV et drainage, en gérant l'interface façade/bardage. `[C]` ⟦solution (dépose totale/réno) selon existant à confirmer⟧

## Réalisation
- **Étapes** :
  1. Choisir **dépose totale** ou **rénovation** (dormant conservé). `[C]`
  2. Déposer en sécurité ; contrôler **appui/seuil** (étanchéité). `[C]` → [traiter-penetrations-points-singuliers](../../../professions/etancheite/cards/traiter-penetrations-points-singuliers.md)
  3. Poser la neuve d'aplomb ; **calfeutrement AEV**. `[C]`
  4. Gérer l'encadrement (façade/**bardage**). `[C]` → [traiter-points-singuliers-bardage](../../../professions/bardage/cards/traiter-points-singuliers-bardage.md)
- **Points critiques** : rénovation = perte de clair de jour à anticiper ; étanchéité de l'appui/seuil ; interface encadrement (façade/bardage).
- **Sécurité** : manutention/dépose ; hauteur ; coupure (verre). **Manutention** de menuiseries/**vitrages lourds** : risque d'écrasement / **coupure** (verre) — moyens de levage, gants anti-coupure, travail en binôme. **Travail en **hauteur** (baies d'étage, dépose) : protections collectives / EPI. **Produits** (mousse PU, mastics, solvants) : EPI / ventilation. **Motorisation de volet** : le **raccordement électrique** relève d'un professionnel (voir Électricité). **Stabilité** du support/de la baie vérifiée avant dépose. **Arrêt immédiat en cas de danger.** Une intervention relève de **compétences adaptées**.** `[A]`

## Cadre & suites
- **Normes** : mise en œuvre des fenêtres et portes extérieures **DTU 36.5** ; vitrerie-miroiterie **DTU 39** ; fermetures / volets **DTU 34.1** ; performance **classement AEV (Air-Eau-Vent)** ⟦à confirmer⟧ `[B]` ⟦références/versions exactes à confirmer par le validateur⟧. `respecte-norme`
- **Tableau ITE** : `cite-carte` → [traiter-points-singuliers-ite](../../../professions/isolation-exterieure/cards/traiter-points-singuliers-ite.md)

## Relations & tags
- **Tags** : `metier:menuiserie-exterieure famille:enveloppe sous-famille:menuiserie-exterieure intervention:remplacer cluster:remplacement cluster:seuils cluster:dormants complexite:avancee type:remplacement securite:manutention relation:etancheite relation:bardage relation:isolation-exterieure`

## Historique
| Version | Date | Auteur | Validateur | Motif |
|---|---|---|---|---|
| v0.1 | 2026-08-05 | IA | ⟦—⟧ | proposition initiale (Brouillon) |
