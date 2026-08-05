# Intégrer isolation et réseaux (réservations)

> **Brouillon (v0) — proposé par IA, en attente de validation métier** (Loi 7/18). Modèle : [../../../cards/CARD_TEMPLATE.md](../../../cards/CARD_TEMPLATE.md).
> Niveaux de confiance : A normes/fabricant · B technique · C terrain validé · D hypothèse. Rien n'est publié comme certitude.

## Métadonnées
| Champ | Valeur |
|---|---|
| Identifiant | `integrer-isolation-reseaux` |
| Titre | Intégrer isolation et réseaux (réservations) |
| Profession | `metier:platrerie` |
| Famille | `famille:finition` |
| Sous-famille | `sous-famille:platrerie` |
| Version | v0.1 |
| Auteur | IA (proposition) |
| Validateur | ⟦à valider métier⟧ |
| Statut | Brouillon |
| Indice de confiance | **C** |

## Cadrage
- **Objectif** : intégrer l'**isolation associée** et les **réservations de réseaux** (élec) dans les ouvrages avant fermeture. `[C]`
- **Résumé** : poser l'**isolant** (laine) entre montants/dans le doublage sans le tasser, prévoir les **réservations** et boîtes électriques (percements maîtrisés), et gérer les traversées ; le raccordement électrique relève d'un **électricien** — repérer/consigner avant de percer. `[C]` ⟦isolant/réservations selon projet à confirmer⟧

## Réalisation
- **Étapes** :
  1. Poser l'**isolant** entre montants (sans tassement). `[C]` → [isoler-murs-interieur](../../../professions/isolation/cards/isoler-murs-interieur.md)
  2. Prévoir **réservations / boîtes élec** (percements). `[C]` → [remplacer-prise-courant](../../../professions/electricite-generale/cards/remplacer-prise-courant.md)
  3. **Repérer/consigner** avant de percer (câbles sous tension). `[A]`
  4. Gérer les traversées ; fermer les ouvrages. `[C]`
- **Points critiques** : isolant non tassé (performance) ; **réservations avant fermeture** ; percements sécurisés (élec) ; raccordement = électricien.
- **Sécurité** : **électricité (percements)** ; poussières/fibres ; coupures. **Poussières de plâtre** (découpe/ponçage des bandes) : masque, aspiration, ventilation. **Manutention des plaques** (lourdes/encombrantes) : lève-plaque, binôme, gestes — **TMS**. **Travail en hauteur** (plafonds suspendus) : échafaudage/plateforme, EPI. **Coupures** (cutter, plaques, rails métalliques — arêtes vives) : gants. **Électricité lors des percements** : repérer/consigner circuits et gaines **avant de percer/visser** (risque de percer un câble sous tension) — NF C 15-100. **Amiante en rénovation** : sur un bâti ancien, le **diagnostic amiante avant travaux est obligatoire** ; en présence d'amiante (anciens plâtres/colles/flocages), **arrêt** → le retrait est **réservé à une entreprise certifiée** (activité Désamiantage, **jamais réalisée ici**). **Arrêt immédiat en cas de danger.** `[A]`

## Cadre & suites
- **Normes** : ouvrages en plaques de plâtre **DTU 25.41** ; doublages / habillages **DTU 25.42** ; plafonds suspendus **DTU 58.1** ; électricité (perc ements / boîtes) **NF C 15-100** ; en rénovation, diagnostic **amiante** avant travaux (Code de la santé) ⟦en prose, à confirmer⟧ `[B]` ⟦références/versions exactes à confirmer par le validateur⟧. `respecte-norme`
- **Électricité (raccordement)** : `relation:electricite-generale`

## Relations & tags
- **Tags** : `metier:platrerie famille:finition sous-famille:platrerie intervention:realiser cluster:isolation-associee cluster:rails complexite:moyenne type:installation securite:electrique relation:isolation relation:electricite-generale`

## Historique
| Version | Date | Auteur | Validateur | Motif |
|---|---|---|---|---|
| v0.1 | 2026-08-05 | IA | ⟦—⟧ | proposition initiale (Brouillon) |
