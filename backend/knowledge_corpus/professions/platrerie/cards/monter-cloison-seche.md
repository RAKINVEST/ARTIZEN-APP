# Monter une cloison sèche

> **Brouillon (v0) — proposé par IA, en attente de validation métier** (Loi 7/18). Modèle : [../../../cards/CARD_TEMPLATE.md](../../../cards/CARD_TEMPLATE.md).
> Niveaux de confiance : A normes/fabricant · B technique · C terrain validé · D hypothèse. Rien n'est publié comme certitude.

## Métadonnées
| Champ | Valeur |
|---|---|
| Identifiant | `monter-cloison-seche` |
| Titre | Monter une cloison sèche |
| Profession | `metier:platrerie` |
| Famille | `famille:finition` |
| Sous-famille | `sous-famille:platrerie` |
| Version | v0.1 |
| Auteur | IA (proposition) |
| Validateur | ⟦à valider métier⟧ |
| Statut | Brouillon |
| Indice de confiance | **C** |

## Cadrage
- **Objectif** : monter une cloison sèche (rails + montants + plaques) selon le **DTU 25.41**. `[C]`
- **Résumé** : tracer l'implantation, fixer les **rails** haut/bas, poser les **montants** à l'entraxe requis, passer les **réseaux/réservations** (élec), poser l'**isolation** éventuelle, visser les **plaques** (décalées) puis traiter les joints ; adapter le type de plaque (hydro/feu) au local. `[C]` ⟦entraxe/type de plaque selon hauteur et local à confirmer⟧

## Réalisation
- **Étapes** :
  1. Tracer ; fixer **rails** (haut/bas) et **montants** (entraxe). `[C]` ⟦à confirmer⟧
  2. Passer **réseaux/réservations** (élec). `[C]` → [integrer-isolation-reseaux](integrer-isolation-reseaux.md)
  3. Poser **isolation** ; visser les **plaques** (joints décalés). `[C]`
  4. Traiter les **joints** (bandes). `[C]` → [realiser-bandes-jointoiement](realiser-bandes-jointoiement.md)
- **Points critiques** : entraxe/hauteur admissible ; type de plaque (hydro/feu) ; **réservations** avant fermeture ; joints décalés.
- **Sécurité** : manutention/TMS (plaques) ; coupures (rails) ; poussières. **Poussières de plâtre** (découpe/ponçage des bandes) : masque, aspiration, ventilation. **Manutention des plaques** (lourdes/encombrantes) : lève-plaque, binôme, gestes — **TMS**. **Travail en hauteur** (plafonds suspendus) : échafaudage/plateforme, EPI. **Coupures** (cutter, plaques, rails métalliques — arêtes vives) : gants. **Électricité lors des percements** : repérer/consigner circuits et gaines **avant de percer/visser** (risque de percer un câble sous tension) — NF C 15-100. **Amiante en rénovation** : sur un bâti ancien, le **diagnostic amiante avant travaux est obligatoire** ; en présence d'amiante (anciens plâtres/colles/flocages), **arrêt** → le retrait est **réservé à une entreprise certifiée** (activité Désamiantage, **jamais réalisée ici**). **Arrêt immédiat en cas de danger.** `[A]`

## Cadre & suites
- **Normes** : ouvrages en plaques de plâtre **DTU 25.41** ; doublages / habillages **DTU 25.42** ; plafonds suspendus **DTU 58.1** ; électricité (perc ements / boîtes) **NF C 15-100** ; en rénovation, diagnostic **amiante** avant travaux (Code de la santé) ⟦en prose, à confirmer⟧ `[B]` ⟦références/versions exactes à confirmer par le validateur⟧. `respecte-norme`
- **Doublage** : `cite-carte` → [poser-doublage](poser-doublage.md)

## Relations & tags
- **Tags** : `metier:platrerie famille:finition sous-famille:platrerie intervention:realiser cluster:cloisons-seches cluster:rails cluster:montants cluster:plaques-de-platre complexite:moyenne type:installation securite:manutention`

## Historique
| Version | Date | Auteur | Validateur | Motif |
|---|---|---|---|---|
| v0.1 | 2026-08-05 | IA | ⟦—⟧ | proposition initiale (Brouillon) |
