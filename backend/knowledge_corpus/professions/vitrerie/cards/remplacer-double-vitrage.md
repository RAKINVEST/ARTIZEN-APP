# Remplacer un double vitrage (vitrage isolant)

> **Brouillon (v0) — proposé par IA, en attente de validation métier** (Loi 7/18). Modèle : [../../../cards/CARD_TEMPLATE.md](../../../cards/CARD_TEMPLATE.md).
> Niveaux de confiance : A normes/fabricant · B technique · C terrain validé · D hypothèse. Rien n'est publié comme certitude.

## Métadonnées
| Champ | Valeur |
|---|---|
| Identifiant | `remplacer-double-vitrage` |
| Titre | Remplacer un double vitrage (vitrage isolant) |
| Profession | `metier:vitrerie` |
| Famille | `famille:specialises` |
| Sous-famille | `sous-famille:vitrerie` |
| Version | v0.1 |
| Auteur | IA (proposition) |
| Validateur | ⟦à valider métier⟧ |
| Statut | Brouillon |
| Indice de confiance | **C** |

## Cadrage
- **Objectif** : remplacer un **vitrage isolant** (double/triple) défaillant — not. embué (joint de scellement HS). `[C]`
- **Résumé** : identifier le vitrage isolant à remplacer (**embuage** = perte d'étanchéité du joint périphérique, irréparable), relever la **composition** exacte (épaisseurs, lame gaz, VIR, intercalaire), commander l'unité isolante à l'identique, déposer l'ancien et poser le neuf avec **calage** et **drainage/ventilation** de feuillure ; un vitrage isolant **ne se répare pas**, il se remplace. `[C]` ⟦composition/performances selon existant à confirmer⟧

## Réalisation
- **Étapes** :
  1. Confirmer l'**embuage** (joint isolant HS, irréparable). `[C]` → [double-vitrage-embue](../../../diagnostics/vitrerie/double-vitrage-embue.md)
  2. Relever la **composition** (épaisseurs/gaz/VIR). `[C]`
  3. Commander à l'identique ; déposer l'ancien. `[C]`
  4. Poser (calage, **drainage** de feuillure). `[C]` → [poser-remplacer-vitrage](poser-remplacer-vitrage.md)
- **Points critiques** : composition **à l'identique** (perf. thermiques) ; **drainage/ventilation** de feuillure ; calage ; irréparable = remplacement.
- **Sécurité** : coupures ; manutention (double vitrage lourd) ; hauteur. **Risque majeur de casse et de coupures** : le verre casse net et coupe profondément (artères) → **gants anti-coupure**, manches longues, chaussures ; évacuer immédiatement les éclats. **Manutention des vitrages lourds** : **ventouses** adaptées, binôme/levage, ne jamais porter seul un grand vitrage ; **stockage / transport** sur chevalets (vitrage **debout**, jamais à plat), calé et sanglé. **Travail en hauteur** (vitrines, verrières, façades) : échafaudage/nacelle/harnais. **Verre de sécurité selon l'usage** : **trempé** (casse en petits morceaux) ou **feuilleté** (retient les éclats) obligatoire en allège / porte / garde-corps / toiture — ne pas poser un verre inadapté. **Repérage des réseaux** avant perçage/scellement. **Amiante** (mastics/joints anciens) : diagnostic ; retrait réservé à une **entreprise certifiée** (**jamais ici**). **Arrêt immédiat en cas de danger.** `[A]`

## Cadre & suites
- **Normes** : travaux de **vitrerie-miroiterie** **DTU 39** ; menuiseries métalliques recevant le vitrage (**interface**) **DTU 37.1** ; verre de sécurité trempé / feuilleté (**NF EN 12150 / NF EN 14449 / ISO 12543**), vitrage isolant **NF EN 1279**, résistance au choc **NF EN 12600**, garde-corps **NF P01-012** ⟦en prose, à confirmer⟧ `[B]` ⟦références/versions exactes à confirmer par le validateur⟧. `respecte-norme`
- **Diagnostic embuage** : `cite-diagnostic` → [double-vitrage-embue](../../../diagnostics/vitrerie/double-vitrage-embue.md)

## Relations & tags
- **Tags** : `metier:vitrerie famille:specialises sous-famille:vitrerie intervention:reparer cluster:double-vitrage cluster:remplacement complexite:moyenne type:installation securite:coupure`

## Historique
| Version | Date | Auteur | Validateur | Motif |
|---|---|---|---|---|
| v0.1 | 2026-08-05 | IA | ⟦—⟧ | proposition initiale (Brouillon) |
