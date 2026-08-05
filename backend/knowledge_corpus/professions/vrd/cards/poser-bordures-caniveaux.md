# Poser bordures et caniveaux (voirie légère)

> **Brouillon (v0) — proposé par IA, en attente de validation métier** (Loi 7/18). Modèle : [../../../cards/CARD_TEMPLATE.md](../../../cards/CARD_TEMPLATE.md).
> Niveaux de confiance : A normes/fabricant · B technique · C terrain validé · D hypothèse. Rien n'est publié comme certitude.

## Métadonnées
| Champ | Valeur |
|---|---|
| Identifiant | `poser-bordures-caniveaux` |
| Titre | Poser bordures et caniveaux (voirie légère) |
| Profession | `metier:vrd` |
| Famille | `famille:gros-oeuvre` |
| Sous-famille | `sous-famille:vrd` |
| Version | v0.1 |
| Auteur | IA (proposition) |
| Validateur | ⟦à valider métier⟧ |
| Statut | Brouillon |
| Indice de confiance | **C** |

## Cadrage
- **Objectif** : poser bordures et caniveaux et réaliser une voirie légère avec un écoulement maîtrisé. `[C]`
- **Résumé** : implanter la ligne, réaliser la **fondation béton** et l'épaulement des bordures/caniveaux, régler l'**altimétrie** et les pentes d'écoulement, puis mettre en œuvre la voirie légère (couches/revêtement) ; le revêtement enrobé relève des **Enrobés**. `[C]` ⟦cotes/pentes/fondation selon projet à confirmer⟧

## Réalisation
- **Étapes** :
  1. Implanter la ligne (cotes/altimétrie). `[C]`
  2. Fondation béton + **épaulement** des bordures/caniveaux. `[C]`
  3. Régler **pentes d'écoulement** (caniveaux vers avaloirs). `[C]`
  4. Voirie légère (couches) ; enrobé = **Enrobés** (`relation:enrobes`). `[C]`
- **Points critiques** : altimétrie/pentes (écoulement) ; fondation/épaulement (tenue) ; interface avaloirs/réseau EP ; enrobé hors périmètre.
- **Sécurité** : engins ; circulation routière ; manutention (bordures). **Réseaux enterrés** : **DICT / AIPR** obligatoires avant ouverture — **proximité gaz** (explosion), **électrique** (électrocution), **eau / télécom** ; terrassement **manuel** à l'approche. **Tranchées** : **blindage** / talutage (risque d'**effondrement / ensevelissement**), **jamais** descendre dans une tranchée non protégée. **Circulation routière** : **signalisation temporaire** (balisage/déviation) conforme, protection des intervenants et des usagers. **Engins / levage** : zones balisées, angles morts. **Arrêt immédiat en cas de danger.** Ces opérations exigent compétences, **autorisations (AIPR)** et moyens adaptés.** `[A]`

## Cadre & suites
- **Normes** : terrassement des tranchées **DTU 12** ; branchements/réseaux électriques **NF C 15-100** ; ouverture/réfection de tranchées **NF P 98-331**, assainissement **NF EN 1610**, réglementation réseaux (**DICT/AIPR**) et signalisation temporaire ⟦en prose, à confirmer⟧ `[B]` ⟦références/versions exactes à confirmer par le validateur⟧. `respecte-norme`
- **Nivellement/contrôle** : `cite-carte` → [controler-receptionner-vrd](controler-receptionner-vrd.md)

## Relations & tags
- **Tags** : `metier:vrd famille:gros-oeuvre sous-famille:vrd intervention:poser cluster:bordures cluster:caniveaux cluster:voirie-legere cluster:nivellement complexite:moyenne type:installation securite:manutention relation:enrobes`

## Historique
| Version | Date | Auteur | Validateur | Motif |
|---|---|---|---|---|
| v0.1 | 2026-08-05 | IA | ⟦—⟧ | proposition initiale (Brouillon) |
