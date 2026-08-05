# Poser une fenêtre / une porte extérieure

> **Brouillon (v0) — proposé par IA, en attente de validation métier** (Loi 7/18). Modèle : [../../../cards/CARD_TEMPLATE.md](../../../cards/CARD_TEMPLATE.md).
> Niveaux de confiance : A normes/fabricant · B technique · C terrain validé · D hypothèse. Rien n'est publié comme certitude.

## Métadonnées
| Champ | Valeur |
|---|---|
| Identifiant | `poser-fenetre-porte` |
| Titre | Poser une fenêtre / une porte extérieure |
| Profession | `metier:menuiserie-exterieure` |
| Famille | `famille:enveloppe` |
| Sous-famille | `sous-famille:menuiserie-exterieure` |
| Version | v0.1 |
| Auteur | IA (proposition) |
| Validateur | ⟦à valider métier⟧ |
| Statut | Brouillon |
| Indice de confiance | **C** |

## Cadrage
- **Objectif** : poser une menuiserie extérieure (neuf/rénovation) d'aplomb et étanche à l'air et à l'eau, selon le **DTU 36.5**. `[C]`
- **Résumé** : préparer/contrôler la baie, poser et fixer le **dormant** d'aplomb/de niveau, réaliser le **calfeutrement AEV** (compribande/mastic) et l'étanchéité à l'air côté intérieur, assurer le drainage, puis régler l'ouvrant. `[C]` ⟦type de pose (applique/tunnel/réno) selon baie à confirmer⟧

## Réalisation
- **Étapes** :
  1. Contrôler la baie (dimensions, aplomb, support). `[C]`
  2. Fixer le **dormant** d'aplomb/de niveau (pattes/vis selon DTU 36.5). `[B]` ⟦à confirmer⟧
  3. **Calfeutrement AEV** (compribande/mastic) + étanchéité à l'air intérieure. `[C]` → [poser-pare-vapeur](../../../professions/isolation/cards/poser-pare-vapeur.md)
  4. Assurer le **drainage**, régler l'ouvrant, contrôler l'AEV. `[C]` → [regler-ouvrant-quincaillerie](regler-ouvrant-quincaillerie.md)
- **Points critiques** : aplomb/niveau/équerrage ; **étanchéité AEV** continue ; drainage vers l'extérieur ; calfeutrement = interface Façade (joint).
- **Sécurité** : manutention (poids) ; hauteur ; produits (mousse/mastic). **Manutention** de menuiseries/**vitrages lourds** : risque d'écrasement / **coupure** (verre) — moyens de levage, gants anti-coupure, travail en binôme. **Travail en **hauteur** (baies d'étage, dépose) : protections collectives / EPI. **Produits** (mousse PU, mastics, solvants) : EPI / ventilation. **Motorisation de volet** : le **raccordement électrique** relève d'un professionnel (voir Électricité). **Stabilité** du support/de la baie vérifiée avant dépose. **Arrêt immédiat en cas de danger.** Une intervention relève de **compétences adaptées**.** `[A]`

## Cadre & suites
- **Normes** : mise en œuvre des fenêtres et portes extérieures **DTU 36.5** ; vitrerie-miroiterie **DTU 39** ; fermetures / volets **DTU 34.1** ; performance **classement AEV (Air-Eau-Vent)** ⟦à confirmer⟧ `[B]` ⟦références/versions exactes à confirmer par le validateur⟧. `respecte-norme`
- **Calfeutrement (interface Façade)** : `cite-carte` → [refaire-joints-facade](../../../professions/facade/cards/refaire-joints-facade.md)

## Relations & tags
- **Tags** : `metier:menuiserie-exterieure equipement:dormant famille:enveloppe sous-famille:menuiserie-exterieure intervention:poser cluster:fenetres cluster:portes cluster:dormants cluster:joints complexite:avancee type:installation securite:manutention relation:facade relation:isolation`

## Historique
| Version | Date | Auteur | Validateur | Motif |
|---|---|---|---|---|
| v0.1 | 2026-08-05 | IA | ⟦—⟧ | proposition initiale (Brouillon) |
