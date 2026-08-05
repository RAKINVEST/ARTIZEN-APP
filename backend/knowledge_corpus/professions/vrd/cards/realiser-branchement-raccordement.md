# Réaliser un branchement / raccordement

> **Brouillon (v0) — proposé par IA, en attente de validation métier** (Loi 7/18). Modèle : [../../../cards/CARD_TEMPLATE.md](../../../cards/CARD_TEMPLATE.md).
> Niveaux de confiance : A normes/fabricant · B technique · C terrain validé · D hypothèse. Rien n'est publié comme certitude.

## Métadonnées
| Champ | Valeur |
|---|---|
| Identifiant | `realiser-branchement-raccordement` |
| Titre | Réaliser un branchement / raccordement |
| Profession | `metier:vrd` |
| Famille | `famille:gros-oeuvre` |
| Sous-famille | `sous-famille:vrd` |
| Version | v0.1 |
| Auteur | IA (proposition) |
| Validateur | ⟦à valider métier⟧ |
| Statut | Brouillon |
| Indice de confiance | **C** |

## Cadrage
- **Objectif** : réaliser le branchement/raccordement d'un réseau au réseau public, en coordination avec le concessionnaire. `[C]`
- **Résumé** : préparer l'attente et le point de raccordement selon les prescriptions du **concessionnaire/gestionnaire**, réaliser la partie privée (tranchée/pose), la partie sous domaine public et le raccordement étant **encadrés/réservés** ; contrôler et repérer (récolement). `[C]` ⟦prescriptions concessionnaire à confirmer⟧

## Réalisation
- **Étapes** :
  1. Obtenir les **prescriptions du concessionnaire** (point/attente). `[C]` ⟦à confirmer⟧
  2. Réaliser la partie privée (tranchée/pose). `[C]` → [ouvrir-tranchee-technique](ouvrir-tranchee-technique.md)
  3. Domaine public / raccordement = **encadré/réservé** (autorisations). `[A]`
  4. Contrôler + **récolement** (plan des réseaux posés). `[C]` → [controler-receptionner-vrd](controler-receptionner-vrd.md)
- **Points critiques** : prescriptions concessionnaire ; autorisations de voirie ; **récolement** ; séparation/repérage des réseaux.
- **Sécurité** : réseaux (gaz/élec) ; circulation (domaine public) ; tranchée. **Réseaux enterrés** : **DICT / AIPR** obligatoires avant ouverture — **proximité gaz** (explosion), **électrique** (électrocution), **eau / télécom** ; terrassement **manuel** à l'approche. **Tranchées** : **blindage** / talutage (risque d'**effondrement / ensevelissement**), **jamais** descendre dans une tranchée non protégée. **Circulation routière** : **signalisation temporaire** (balisage/déviation) conforme, protection des intervenants et des usagers. **Engins / levage** : zones balisées, angles morts. **Arrêt immédiat en cas de danger.** Ces opérations exigent compétences, **autorisations (AIPR)** et moyens adaptés.** `[A]`

## Cadre & suites
- **Normes** : terrassement des tranchées **DTU 12** ; branchements/réseaux électriques **NF C 15-100** ; ouverture/réfection de tranchées **NF P 98-331**, assainissement **NF EN 1610**, réglementation réseaux (**DICT/AIPR**) et signalisation temporaire ⟦en prose, à confirmer⟧ `[B]` ⟦références/versions exactes à confirmer par le validateur⟧. `respecte-norme`
- **Réglementation** : `cite-phrase` → [normes-reglementation-vrd](../../../phrases/vrd/normes-reglementation-vrd.md)

## Relations & tags
- **Tags** : `metier:vrd famille:gros-oeuvre sous-famille:vrd intervention:realiser cluster:branchements cluster:raccordements complexite:avancee type:realisation securite:reseaux relation:assainissement`

## Historique
| Version | Date | Auteur | Validateur | Motif |
|---|---|---|---|---|
| v0.1 | 2026-08-05 | IA | ⟦—⟧ | proposition initiale (Brouillon) |
