# Ouvrir une tranchée technique

> **Brouillon (v0) — proposé par IA, en attente de validation métier** (Loi 7/18). Modèle : [../../../cards/CARD_TEMPLATE.md](../../../cards/CARD_TEMPLATE.md).
> Niveaux de confiance : A normes/fabricant · B technique · C terrain validé · D hypothèse. Rien n'est publié comme certitude.

## Métadonnées
| Champ | Valeur |
|---|---|
| Identifiant | `ouvrir-tranchee-technique` |
| Titre | Ouvrir une tranchée technique |
| Profession | `metier:vrd` |
| Famille | `famille:gros-oeuvre` |
| Sous-famille | `sous-famille:vrd` |
| Version | v0.1 |
| Auteur | IA (proposition) |
| Validateur | ⟦à valider métier⟧ |
| Statut | Brouillon |
| Indice de confiance | **C** |

## Cadrage
- **Objectif** : ouvrir une tranchée technique pour réseaux (DICT, blindage, lit de pose) en sécurité. `[C]`
- **Résumé** : après **DICT/AIPR** et signalisation, ouvrir la tranchée à la largeur/profondeur prévues, **blinder** selon la profondeur, réaliser le **lit de pose** (sable), et respecter les distances entre réseaux ; **ne jamais** descendre dans une tranchée non protégée. `[C]` ⟦largeur/profondeur/blindage selon réseau et Code du travail à confirmer⟧

## Réalisation
- **Étapes** :
  1. **DICT/AIPR** + signalisation temporaire. `[A]` → [terrasser-reseaux-dict](../../../professions/terrassement/cards/terrasser-reseaux-dict.md)
  2. Ouvrir ; **blinder**/taluter selon profondeur. `[A]` → [blinder-securiser-fouille](../../../professions/terrassement/cards/blinder-securiser-fouille.md)
  3. Réaliser le **lit de pose** (sable) ; respecter les distances réseaux. `[C]`
  4. Préparer la pose du réseau. `[C]` → [poser-fourreaux-reseaux-secs](poser-fourreaux-reseaux-secs.md)
- **Points critiques** : DICT respectée ; **blindage obligatoire** ; lit de pose régulier ; distances/hauteurs entre réseaux (secs/humides).
- **Sécurité** : **effondrement / ensevelissement** ; réseaux enterrés ; engins. **Réseaux enterrés** : **DICT / AIPR** obligatoires avant ouverture — **proximité gaz** (explosion), **électrique** (électrocution), **eau / télécom** ; terrassement **manuel** à l'approche. **Tranchées** : **blindage** / talutage (risque d'**effondrement / ensevelissement**), **jamais** descendre dans une tranchée non protégée. **Circulation routière** : **signalisation temporaire** (balisage/déviation) conforme, protection des intervenants et des usagers. **Engins / levage** : zones balisées, angles morts. **Arrêt immédiat en cas de danger.** Ces opérations exigent compétences, **autorisations (AIPR)** et moyens adaptés.** `[A]`

## Cadre & suites
- **Normes** : terrassement des tranchées **DTU 12** ; branchements/réseaux électriques **NF C 15-100** ; ouverture/réfection de tranchées **NF P 98-331**, assainissement **NF EN 1610**, réglementation réseaux (**DICT/AIPR**) et signalisation temporaire ⟦en prose, à confirmer⟧ `[B]` ⟦références/versions exactes à confirmer par le validateur⟧. `respecte-norme`
- **Désordre** : `traite-diagnostic` → [effondrement-tranchee-vrd](../../../diagnostics/vrd/effondrement-tranchee-vrd.md)

## Relations & tags
- **Tags** : `metier:vrd famille:gros-oeuvre sous-famille:vrd intervention:realiser cluster:tranchees-techniques cluster:reseaux-secs complexite:expert type:realisation securite:effondrement securite:reseaux relation:terrassement`

## Historique
| Version | Date | Auteur | Validateur | Motif |
|---|---|---|---|---|
| v0.1 | 2026-08-05 | IA | ⟦—⟧ | proposition initiale (Brouillon) |
