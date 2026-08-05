# Principe de la plâtrerie (cloisons sèches, doublages, plafonds)

> **Brouillon (v0) — proposé par IA, en attente de validation métier** (Loi 7/18). Modèle : [../../../cards/CARD_TEMPLATE.md](../../../cards/CARD_TEMPLATE.md).
> Niveaux de confiance : A normes/fabricant · B technique · C terrain validé · D hypothèse. Rien n'est publié comme certitude.

## Métadonnées
| Champ | Valeur |
|---|---|
| Identifiant | `principe-platrerie` |
| Titre | Principe de la plâtrerie (cloisons sèches, doublages, plafonds) |
| Profession | `metier:platrerie` |
| Famille | `famille:finition` |
| Sous-famille | `sous-famille:platrerie` |
| Version | v0.1 |
| Auteur | IA (proposition) |
| Validateur | ⟦à valider métier⟧ |
| Statut | Brouillon |
| Indice de confiance | **C** |

## Cadrage
- **Objectif** : comprendre les ouvrages de plâtrerie sèche : cloisons, doublages et plafonds en **plaques de plâtre** sur ossature. `[C]`
- **Résumé** : la plâtrerie sèche réalise **cloisons**, **doublages** et **plafonds suspendus** à partir de **plaques de plâtre** (standard, hydro, feu, phônique) vissées sur une **ossature métallique** (**rails + montants**), avec **isolation** éventuelle et finition des joints par **bandes** ; elle précède la peinture (métier distinct). `[C]` ⟦type de plaque/ossature selon local à confirmer⟧

## Réalisation
- **Étapes** :
  1. **Cloisons sèches** (rails/montants + plaques). `[C]` → [monter-cloison-seche](monter-cloison-seche.md)
  2. **Doublages** (isolation associée). `[C]` → [poser-doublage](poser-doublage.md)
  3. **Plafonds suspendus**. `[C]` → [poser-plafond-suspendu](poser-plafond-suspendu.md)
  4. **Bandes / jointoiement** (finition avant peinture). `[C]` → [realiser-bandes-jointoiement](realiser-bandes-jointoiement.md)
- **Points critiques** : type de plaque adapté (**hydro** en pièce humide, **feu**) ; ossature/entraxes ; joints soignés ; interface **peinture** (`relation:peinture`).
- **Sécurité** : poussières ; manutention/TMS ; hauteur (plafond). **Poussières de plâtre** (découpe/ponçage des bandes) : masque, aspiration, ventilation. **Manutention des plaques** (lourdes/encombrantes) : lève-plaque, binôme, gestes — **TMS**. **Travail en hauteur** (plafonds suspendus) : échafaudage/plateforme, EPI. **Coupures** (cutter, plaques, rails métalliques — arêtes vives) : gants. **Électricité lors des percements** : repérer/consigner circuits et gaines **avant de percer/visser** (risque de percer un câble sous tension) — NF C 15-100. **Amiante en rénovation** : sur un bâti ancien, le **diagnostic amiante avant travaux est obligatoire** ; en présence d'amiante (anciens plâtres/colles/flocages), **arrêt** → le retrait est **réservé à une entreprise certifiée** (activité Désamiantage, **jamais réalisée ici**). **Arrêt immédiat en cas de danger.** `[A]`

## Cadre & suites
- **Normes** : ouvrages en plaques de plâtre **DTU 25.41** ; doublages / habillages **DTU 25.42** ; plafonds suspendus **DTU 58.1** ; électricité (perc ements / boîtes) **NF C 15-100** ; en rénovation, diagnostic **amiante** avant travaux (Code de la santé) ⟦en prose, à confirmer⟧ `[B]` ⟦références/versions exactes à confirmer par le validateur⟧. `respecte-norme`
- **Diagnostic / contrôle** : `cite-carte` → [diagnostiquer-controler-platrerie](diagnostiquer-controler-platrerie.md)

## Relations & tags
- **Tags** : `metier:platrerie famille:finition sous-famille:platrerie intervention:comprendre cluster:cloisons-seches cluster:plaques-de-platre cluster:doublages cluster:plafonds-suspendus type:principe securite:poussieres relation:peinture`

## Historique
| Version | Date | Auteur | Validateur | Motif |
|---|---|---|---|---|
| v0.1 | 2026-08-05 | IA | ⟦—⟧ | proposition initiale (Brouillon) |
