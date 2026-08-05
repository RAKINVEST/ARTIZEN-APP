# Poser un réseau humide (eau, EU, EP)

> **Brouillon (v0) — proposé par IA, en attente de validation métier** (Loi 7/18). Modèle : [../../../cards/CARD_TEMPLATE.md](../../../cards/CARD_TEMPLATE.md).
> Niveaux de confiance : A normes/fabricant · B technique · C terrain validé · D hypothèse. Rien n'est publié comme certitude.

## Métadonnées
| Champ | Valeur |
|---|---|
| Identifiant | `poser-reseau-humide` |
| Titre | Poser un réseau humide (eau, EU, EP) |
| Profession | `metier:vrd` |
| Famille | `famille:gros-oeuvre` |
| Sous-famille | `sous-famille:vrd` |
| Version | v0.1 |
| Auteur | IA (proposition) |
| Validateur | ⟦à valider métier⟧ |
| Statut | Brouillon |
| Indice de confiance | **C** |

## Cadrage
- **Objectif** : poser un réseau humide (eau potable, eaux usées, eaux pluviales) avec pente et essais. `[C]`
- **Résumé** : poser les canalisations sur lit de pose avec la **pente** requise (gravitaire pour EU/EP), assembler les raccords, poser regards/branchements, réaliser les **essais d'étanchéité** puis remblayer ; la spécialité **assainissement** (EU/EP, traitement) est une activité distincte. `[C]` ⟦pentes/diamètres/essais selon réseau et NF EN 1610 à confirmer⟧

## Réalisation
- **Étapes** :
  1. Poser les canalisations sur lit de pose à la **pente** requise. `[B]` ⟦à confirmer⟧
  2. Assembler raccords ; poser **regards**/branchements. `[C]` → [poser-regard-chambre](poser-regard-chambre.md)
  3. **Essais d'étanchéité** (avant remblai). `[C]` → [controler-receptionner-vrd](controler-receptionner-vrd.md)
  4. Remblayer/compacter par couches (protection). `[C]`
- **Points critiques** : **pente** correcte (gravitaire) ; essais avant remblai ; séparation EU/EP ; spécificités EU/EP → Assainissement.
- **Sécurité** : tranchée (effondrement) ; manutention ; réseaux. **Réseaux enterrés** : **DICT / AIPR** obligatoires avant ouverture — **proximité gaz** (explosion), **électrique** (électrocution), **eau / télécom** ; terrassement **manuel** à l'approche. **Tranchées** : **blindage** / talutage (risque d'**effondrement / ensevelissement**), **jamais** descendre dans une tranchée non protégée. **Circulation routière** : **signalisation temporaire** (balisage/déviation) conforme, protection des intervenants et des usagers. **Engins / levage** : zones balisées, angles morts. **Arrêt immédiat en cas de danger.** Ces opérations exigent compétences, **autorisations (AIPR)** et moyens adaptés.** `[A]`

## Cadre & suites
- **Normes** : terrassement des tranchées **DTU 12** ; branchements/réseaux électriques **NF C 15-100** ; ouverture/réfection de tranchées **NF P 98-331**, assainissement **NF EN 1610**, réglementation réseaux (**DICT/AIPR**) et signalisation temporaire ⟦en prose, à confirmer⟧ `[B]` ⟦références/versions exactes à confirmer par le validateur⟧. `respecte-norme`
- **Assainissement (EU/EP spécialisé)** : `relation:assainissement` (futur Livre Gros Œuvre)

## Relations & tags
- **Tags** : `metier:vrd famille:gros-oeuvre sous-famille:vrd intervention:poser cluster:reseaux-humides cluster:raccordements complexite:avancee type:installation securite:reseaux relation:assainissement`

## Historique
| Version | Date | Auteur | Validateur | Motif |
|---|---|---|---|---|
| v0.1 | 2026-08-05 | IA | ⟦—⟧ | proposition initiale (Brouillon) |
