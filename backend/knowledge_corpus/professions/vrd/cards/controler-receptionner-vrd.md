# Contrôler / réceptionner un VRD

> **Brouillon (v0) — proposé par IA, en attente de validation métier** (Loi 7/18). Modèle : [../../../cards/CARD_TEMPLATE.md](../../../cards/CARD_TEMPLATE.md).
> Niveaux de confiance : A normes/fabricant · B technique · C terrain validé · D hypothèse. Rien n'est publié comme certitude.

## Métadonnées
| Champ | Valeur |
|---|---|
| Identifiant | `controler-receptionner-vrd` |
| Titre | Contrôler / réceptionner un VRD |
| Profession | `metier:vrd` |
| Famille | `famille:gros-oeuvre` |
| Sous-famille | `sous-famille:vrd` |
| Version | v0.1 |
| Auteur | IA (proposition) |
| Validateur | ⟦à valider métier⟧ |
| Statut | Brouillon |
| Indice de confiance | **C** |

## Cadrage
- **Objectif** : contrôler et réceptionner un ouvrage VRD (cotes, pentes, compactage, essais, récolement). `[C]`
- **Résumé** : vérifier l'**altimétrie/les pentes**, le **compactage** des remblais, l'étanchéité/écoulement des réseaux (essais), la mise à niveau des regards/tampons, et établir le **récolement** (plan des réseaux). `[C]`

## Réalisation
- **Étapes** :
  1. Vérifier **cotes / pentes / altimétrie**. `[C]`
  2. Contrôler le **compactage** des remblais. `[C]` → [affaissement-voirie-reseau](../../../diagnostics/vrd/affaissement-voirie-reseau.md)
  3. **Essais** réseaux (étanchéité/écoulement) ; tampons à niveau. `[C]`
  4. Établir le **récolement** (plan des réseaux posés). `[C]`
- **Points critiques** : pentes/écoulement ; compactage (pas de tassement futur) ; essais réseaux ; **récolement** indispensable (repérage).
- **Sécurité** : circulation ; tranchées ouvertes ; engins. **Réseaux enterrés** : **DICT / AIPR** obligatoires avant ouverture — **proximité gaz** (explosion), **électrique** (électrocution), **eau / télécom** ; terrassement **manuel** à l'approche. **Tranchées** : **blindage** / talutage (risque d'**effondrement / ensevelissement**), **jamais** descendre dans une tranchée non protégée. **Circulation routière** : **signalisation temporaire** (balisage/déviation) conforme, protection des intervenants et des usagers. **Engins / levage** : zones balisées, angles morts. **Arrêt immédiat en cas de danger.** Ces opérations exigent compétences, **autorisations (AIPR)** et moyens adaptés.** `[A]`

## Cadre & suites
- **Normes** : terrassement des tranchées **DTU 12** ; branchements/réseaux électriques **NF C 15-100** ; ouverture/réfection de tranchées **NF P 98-331**, assainissement **NF EN 1610**, réglementation réseaux (**DICT/AIPR**) et signalisation temporaire ⟦en prose, à confirmer⟧ `[B]` ⟦références/versions exactes à confirmer par le validateur⟧. `respecte-norme`
- **Contrôle réception** : `a-checklist` → [controle-reception-vrd](../../../checklists/vrd/controle-reception-vrd.md)

## Relations & tags
- **Tags** : `metier:vrd famille:gros-oeuvre sous-famille:vrd intervention:controler intervention:diagnostiquer cluster:controle cluster:diagnostic cluster:nivellement complexite:moyenne type:controle securite:reseaux`

## Historique
| Version | Date | Auteur | Validateur | Motif |
|---|---|---|---|---|
| v0.1 | 2026-08-05 | IA | ⟦—⟧ | proposition initiale (Brouillon) |
