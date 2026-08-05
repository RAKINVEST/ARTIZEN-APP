# Réaliser un chaînage

> **Brouillon (v0) — proposé par IA, en attente de validation métier** (Loi 7/18). Modèle : [../../../cards/CARD_TEMPLATE.md](../../../cards/CARD_TEMPLATE.md).
> Niveaux de confiance : A normes/fabricant · B technique · C terrain validé · D hypothèse. Rien n'est publié comme certitude.

## Métadonnées
| Champ | Valeur |
|---|---|
| Identifiant | `realiser-chainage` |
| Titre | Réaliser un chaînage |
| Profession | `metier:maconnerie` |
| Famille | `famille:gros-oeuvre` |
| Sous-famille | `sous-famille:maconnerie` |
| Version | v0.1 |
| Auteur | IA (proposition) |
| Validateur | ⟦à valider métier⟧ |
| Statut | Brouillon |
| Indice de confiance | **C** |

## Cadrage
- **Objectif** : réaliser un chaînage (horizontal/vertical) en béton armé intégré à la maçonnerie, selon le **DTU 21**. `[C]`
- **Résumé** : coffrer/positionner les armatures (chaînage **horizontal** en tête/plancher, **vertical** aux angles/refends), couler le béton et assurer la continuité des armatures pour ceinturer l'ouvrage ; le chaînage haut fait l'interface avec la **charpente**. `[C]` ⟦section/ferraillage par un bureau d'études à confirmer⟧

## Réalisation
- **Étapes** :
  1. Positionner les **armatures** (recouvrements, continuité). `[B]` ⟦à confirmer⟧
  2. Coffrer ; couler le **béton** (vibré). `[C]`
  3. Chaînage **horizontal** (tête/plancher) + **vertical** (angles/refends). `[C]`
  4. Interface **chaînage haut / charpente** (sablière/appuis). `[C]` → [inspecter-charpente](../../../professions/charpente/cards/inspecter-charpente.md)
- **Points critiques** : **continuité des armatures** (ceinturage) ; ferraillage/section selon étude ; enrobage béton ; interface charpente en tête.
- **Sécurité** : armatures (coupure) ; béton (caustique) ; manutention ; hauteur. **Ouvrage porteur** : toute **ouverture / reprise en sous-œuvre** d'un mur porteur engage la **stabilité** — **étaiement** et **étude** préalables **obligatoires** (risque d'effondrement). **Manutention lourde** (blocs, pierres) : écrasement / TMS — moyens de levage. **Poussières** (découpe = **silice**) : masque/aspiration. **Produits** (ciment/mortier **caustique**) : gants/lunettes. **Travail en hauteur** (échafaudage). **Arrêt immédiat en cas de danger.** Une intervention **structurelle** relève de **compétences adaptées**.** `[A]`

## Cadre & suites
- **Normes** : ouvrages en maçonnerie de petits éléments **DTU 20.1** ; cloisons en maçonnerie **DTU 20.13** ; chaînages / éléments en béton **DTU 21** ; calcul **Eurocode 6 (NF EN 1996)** ⟦en prose, à confirmer⟧ `[B]` ⟦références/versions exactes à confirmer par le validateur⟧. `respecte-norme`
- **Maçonnerie porteuse** : `cite-carte` → [monter-mur-cloison](monter-mur-cloison.md)

## Relations & tags
- **Tags** : `metier:maconnerie famille:gros-oeuvre sous-famille:maconnerie intervention:realiser cluster:chainages cluster:murs-porteurs complexite:expert type:installation securite:structure relation:charpente`

## Historique
| Version | Date | Auteur | Validateur | Motif |
|---|---|---|---|---|
| v0.1 | 2026-08-05 | IA | ⟦—⟧ | proposition initiale (Brouillon) |
