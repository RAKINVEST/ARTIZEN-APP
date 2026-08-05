# Poser un doublage (isolation associée)

> **Brouillon (v0) — proposé par IA, en attente de validation métier** (Loi 7/18). Modèle : [../../../cards/CARD_TEMPLATE.md](../../../cards/CARD_TEMPLATE.md).
> Niveaux de confiance : A normes/fabricant · B technique · C terrain validé · D hypothèse. Rien n'est publié comme certitude.

## Métadonnées
| Champ | Valeur |
|---|---|
| Identifiant | `poser-doublage` |
| Titre | Poser un doublage (isolation associée) |
| Profession | `metier:platrerie` |
| Famille | `famille:finition` |
| Sous-famille | `sous-famille:platrerie` |
| Version | v0.1 |
| Auteur | IA (proposition) |
| Validateur | ⟦à valider métier⟧ |
| Statut | Brouillon |
| Indice de confiance | **C** |

## Cadrage
- **Objectif** : poser un doublage de mur (collé ou sur ossature) avec l'**isolation associée**, selon le **DTU 25.42**. `[C]`
- **Résumé** : réaliser un **doublage** — **collé** (complexe plaque+isolant) ou **sur ossature** (montants + isolant + plaque) — pour l'isolation thermique/phônique intérieure ; gérer le **pare-vapeur**/point de rosée et les réservations ; le calcul thermique relève du Livre **Isolation**. `[C]` ⟦système/épaisseur d'isolant selon paroi à confirmer⟧

## Réalisation
- **Étapes** :
  1. Choisir **collé** (complexe) ou **sur ossature** + isolant. `[C]`
  2. Gérer **pare-vapeur**/point de rosée (→ Isolation). `[C]` → [isoler-murs-interieur](../../../professions/isolation/cards/isoler-murs-interieur.md)
  3. Poser plaques ; réservations élec. `[C]`
  4. Traiter les joints (bandes). `[C]` → [realiser-bandes-jointoiement](realiser-bandes-jointoiement.md)
- **Points critiques** : **isolation** cohérente (thermique/point de rosée = Isolation) ; support sain ; réservations ; planéité.
- **Sécurité** : manutention/TMS ; poussières (fibres isolant) ; coupures. **Poussières de plâtre** (découpe/ponçage des bandes) : masque, aspiration, ventilation. **Manutention des plaques** (lourdes/encombrantes) : lève-plaque, binôme, gestes — **TMS**. **Travail en hauteur** (plafonds suspendus) : échafaudage/plateforme, EPI. **Coupures** (cutter, plaques, rails métalliques — arêtes vives) : gants. **Électricité lors des percements** : repérer/consigner circuits et gaines **avant de percer/visser** (risque de percer un câble sous tension) — NF C 15-100. **Amiante en rénovation** : sur un bâti ancien, le **diagnostic amiante avant travaux est obligatoire** ; en présence d'amiante (anciens plâtres/colles/flocages), **arrêt** → le retrait est **réservé à une entreprise certifiée** (activité Désamiantage, **jamais réalisée ici**). **Arrêt immédiat en cas de danger.** `[A]`

## Cadre & suites
- **Normes** : ouvrages en plaques de plâtre **DTU 25.41** ; doublages / habillages **DTU 25.42** ; plafonds suspendus **DTU 58.1** ; électricité (perc ements / boîtes) **NF C 15-100** ; en rénovation, diagnostic **amiante** avant travaux (Code de la santé) ⟦en prose, à confirmer⟧ `[B]` ⟦références/versions exactes à confirmer par le validateur⟧. `respecte-norme`
- **Isolation (thermique)** : `relation:isolation`

## Relations & tags
- **Tags** : `metier:platrerie famille:finition sous-famille:platrerie intervention:realiser cluster:doublages cluster:isolation-associee complexite:moyenne type:installation securite:manutention relation:isolation`

## Historique
| Version | Date | Auteur | Validateur | Motif |
|---|---|---|---|---|
| v0.1 | 2026-08-05 | IA | ⟦—⟧ | proposition initiale (Brouillon) |
