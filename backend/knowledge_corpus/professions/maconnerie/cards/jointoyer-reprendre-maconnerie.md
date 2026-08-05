# Jointoyer / reprendre une maçonnerie

> **Brouillon (v0) — proposé par IA, en attente de validation métier** (Loi 7/18). Modèle : [../../../cards/CARD_TEMPLATE.md](../../../cards/CARD_TEMPLATE.md).
> Niveaux de confiance : A normes/fabricant · B technique · C terrain validé · D hypothèse. Rien n'est publié comme certitude.

## Métadonnées
| Champ | Valeur |
|---|---|
| Identifiant | `jointoyer-reprendre-maconnerie` |
| Titre | Jointoyer / reprendre une maçonnerie |
| Profession | `metier:maconnerie` |
| Famille | `famille:gros-oeuvre` |
| Sous-famille | `sous-famille:maconnerie` |
| Version | v0.1 |
| Auteur | IA (proposition) |
| Validateur | ⟦à valider métier⟧ |
| Statut | Brouillon |
| Indice de confiance | **C** |

## Cadrage
- **Objectif** : rejointoyer une maçonnerie (pierre/brique apparente) ou reprendre une zone dégradée (fissure, élément cassé). `[C]`
- **Résumé** : dégarnir les **joints** dégradés et rejointoyer au mortier **compatible** (chaux si pierre), ou reprendre une zone (harpage, remplacement d'éléments) ; une fissure **structurelle** relève d'un diagnostic préalable. `[C]` ⟦mortier compatible à confirmer⟧

## Réalisation
- **Étapes** :
  1. Qualifier le désordre (esthétique vs **structurel**). `[C]` → [fissure-mur-maconnerie](../../../diagnostics/maconnerie/fissure-mur-maconnerie.md)
  2. **Dégarnir** les joints ; nettoyer/humidifier. `[C]`
  3. Rejointoyer au **mortier compatible** (chaux/pierre). `[C]` ⟦à confirmer⟧
  4. Reprise de zone (**harpage**, remplacement d'éléments). `[C]`
- **Points critiques** : **compatibilité** du mortier (chaux vs ciment sur pierre) ; ne pas piéger l'humidité ; fissure structurelle → étude.
- **Sécurité** : poussières (dégarnissage/silice) ; mortier ; hauteur. **Ouvrage porteur** : toute **ouverture / reprise en sous-œuvre** d'un mur porteur engage la **stabilité** — **étaiement** et **étude** préalables **obligatoires** (risque d'effondrement). **Manutention lourde** (blocs, pierres) : écrasement / TMS — moyens de levage. **Poussières** (découpe = **silice**) : masque/aspiration. **Produits** (ciment/mortier **caustique**) : gants/lunettes. **Travail en hauteur** (échafaudage). **Arrêt immédiat en cas de danger.** Une intervention **structurelle** relève de **compétences adaptées**.** `[A]`

## Cadre & suites
- **Normes** : ouvrages en maçonnerie de petits éléments **DTU 20.1** ; cloisons en maçonnerie **DTU 20.13** ; chaînages / éléments en béton **DTU 21** ; calcul **Eurocode 6 (NF EN 1996)** ⟦en prose, à confirmer⟧ `[B]` ⟦références/versions exactes à confirmer par le validateur⟧. `respecte-norme`
- **Finition (Façade)** : `cite-carte` → [reprendre-enduit-facade](../../../professions/facade/cards/reprendre-enduit-facade.md)

## Relations & tags
- **Tags** : `metier:maconnerie famille:gros-oeuvre sous-famille:maconnerie intervention:reparer intervention:entretenir cluster:joints cluster:reprises cluster:reparations cluster:pierres complexite:moyenne type:reparation securite:structure relation:facade`

## Historique
| Version | Date | Auteur | Validateur | Motif |
|---|---|---|---|---|
| v0.1 | 2026-08-05 | IA | ⟦—⟧ | proposition initiale (Brouillon) |
