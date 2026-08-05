# Entretenir / contrôler une maçonnerie

> **Brouillon (v0) — proposé par IA, en attente de validation métier** (Loi 7/18). Modèle : [../../../cards/CARD_TEMPLATE.md](../../../cards/CARD_TEMPLATE.md).
> Niveaux de confiance : A normes/fabricant · B technique · C terrain validé · D hypothèse. Rien n'est publié comme certitude.

## Métadonnées
| Champ | Valeur |
|---|---|
| Identifiant | `entretenir-controler-maconnerie` |
| Titre | Entretenir / contrôler une maçonnerie |
| Profession | `metier:maconnerie` |
| Famille | `famille:gros-oeuvre` |
| Sous-famille | `sous-famille:maconnerie` |
| Version | v0.1 |
| Auteur | IA (proposition) |
| Validateur | ⟦à valider métier⟧ |
| Statut | Brouillon |
| Indice de confiance | **C** |

## Cadrage
- **Objectif** : entretenir et contrôler une maçonnerie (joints, humidité, fissures, appuis) pour prévenir les désordres. `[C]`
- **Résumé** : contrôler l'état des **joints**, l'absence de fissures évolutives, la gestion de l'humidité et l'état des appuis/linteaux, réaliser l'entretien courant (rejointoiement ponctuel) et orienter vers un diagnostic si désordre. `[C]`

## Réalisation
- **Étapes** :
  1. Contrôler **joints** et éléments (épaufrures, dégarnissage). `[C]`
  2. Surveiller **fissures** (pose de témoins si doute). `[C]` → [fissure-mur-maconnerie](../../../diagnostics/maconnerie/fissure-mur-maconnerie.md)
  3. Gérer l'**humidité** (drainage, ventilation basse). `[C]`
  4. Entretien courant (rejointoiement ponctuel). `[C]` → [jointoyer-reprendre-maconnerie](jointoyer-reprendre-maconnerie.md)
- **Points critiques** : surveiller l'évolutivité des fissures (témoins) ; traiter la cause de l'humidité ; joints entretenus.
- **Sécurité** : hauteur ; poussières ; produits. **Ouvrage porteur** : toute **ouverture / reprise en sous-œuvre** d'un mur porteur engage la **stabilité** — **étaiement** et **étude** préalables **obligatoires** (risque d'effondrement). **Manutention lourde** (blocs, pierres) : écrasement / TMS — moyens de levage. **Poussières** (découpe = **silice**) : masque/aspiration. **Produits** (ciment/mortier **caustique**) : gants/lunettes. **Travail en hauteur** (échafaudage). **Arrêt immédiat en cas de danger.** Une intervention **structurelle** relève de **compétences adaptées**.** `[A]`

## Cadre & suites
- **Normes** : ouvrages en maçonnerie de petits éléments **DTU 20.1** ; cloisons en maçonnerie **DTU 20.13** ; chaînages / éléments en béton **DTU 21** ; calcul **Eurocode 6 (NF EN 1996)** ⟦en prose, à confirmer⟧ `[B]` ⟦références/versions exactes à confirmer par le validateur⟧. `respecte-norme`
- **Kit** : `utilise-kit` → [kit-macon](../../../kits/maconnerie/kit-macon.md)

## Relations & tags
- **Tags** : `metier:maconnerie famille:gros-oeuvre sous-famille:maconnerie intervention:entretenir intervention:controler cluster:entretien cluster:controle cluster:joints complexite:simple type:entretien securite:structure`

## Historique
| Version | Date | Auteur | Validateur | Motif |
|---|---|---|---|---|
| v0.1 | 2026-08-05 | IA | ⟦—⟧ | proposition initiale (Brouillon) |
