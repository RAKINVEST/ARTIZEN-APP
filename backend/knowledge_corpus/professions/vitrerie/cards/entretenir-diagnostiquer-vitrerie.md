# Entretenir / diagnostiquer une vitrerie

> **Brouillon (v0) — proposé par IA, en attente de validation métier** (Loi 7/18). Modèle : [../../../cards/CARD_TEMPLATE.md](../../../cards/CARD_TEMPLATE.md).
> Niveaux de confiance : A normes/fabricant · B technique · C terrain validé · D hypothèse. Rien n'est publié comme certitude.

## Métadonnées
| Champ | Valeur |
|---|---|
| Identifiant | `entretenir-diagnostiquer-vitrerie` |
| Titre | Entretenir / diagnostiquer une vitrerie |
| Profession | `metier:vitrerie` |
| Famille | `famille:specialises` |
| Sous-famille | `sous-famille:vitrerie` |
| Version | v0.1 |
| Auteur | IA (proposition) |
| Validateur | ⟦à valider métier⟧ |
| Statut | Brouillon |
| Indice de confiance | **C** |

## Cadrage
- **Objectif** : entretenir les vitrages (mastic/joints) et diagnostiquer les défauts (casse, embuage, jeu). `[C]`
- **Résumé** : contrôler l'état des **mastics/joints** et l'étanchéité, reprendre un joint dégradé, vérifier la **tenue** des vitrages et parcloses, repérer un **double vitrage embué** (à remplacer) ou une **fissure/casse** (sécuriser puis remplacer) ; en rénovation, les **mastics anciens** peuvent contenir de l'**amiante** → diagnostic. `[C]`

## Réalisation
- **Étapes** :
  1. Contrôler mastics/joints ; reprendre l'étanchéité. `[C]` → [vitrage-descelle-joint-hs](../../../diagnostics/vitrerie/vitrage-descelle-joint-hs.md)
  2. Repérer **embuage** (double vitrage à remplacer). `[C]` → [double-vitrage-embue](../../../diagnostics/vitrerie/double-vitrage-embue.md)
  3. **Sécuriser** une casse/fissure puis remplacer. `[A]` → [vitrage-casse-fissure](../../../diagnostics/vitrerie/vitrage-casse-fissure.md)
  4. Rénovation : **mastics anciens** → diagnostic amiante. `[C]`
- **Points critiques** : étanchéité maintenue ; vitrages tenus ; casse **sécurisée** ; **amiante** (mastics anciens) en rénovation.
- **Sécurité** : **coupures** ; manutention ; amiante (mastics anciens). **Risque majeur de casse et de coupures** : le verre casse net et coupe profondément (artères) → **gants anti-coupure**, manches longues, chaussures ; évacuer immédiatement les éclats. **Manutention des vitrages lourds** : **ventouses** adaptées, binôme/levage, ne jamais porter seul un grand vitrage ; **stockage / transport** sur chevalets (vitrage **debout**, jamais à plat), calé et sanglé. **Travail en hauteur** (vitrines, verrières, façades) : échafaudage/nacelle/harnais. **Verre de sécurité selon l'usage** : **trempé** (casse en petits morceaux) ou **feuilleté** (retient les éclats) obligatoire en allège / porte / garde-corps / toiture — ne pas poser un verre inadapté. **Repérage des réseaux** avant perçage/scellement. **Amiante** (mastics/joints anciens) : diagnostic ; retrait réservé à une **entreprise certifiée** (**jamais ici**). **Arrêt immédiat en cas de danger.** `[A]`

## Cadre & suites
- **Normes** : travaux de **vitrerie-miroiterie** **DTU 39** ; menuiseries métalliques recevant le vitrage (**interface**) **DTU 37.1** ; verre de sécurité trempé / feuilleté (**NF EN 12150 / NF EN 14449 / ISO 12543**), vitrage isolant **NF EN 1279**, résistance au choc **NF EN 12600**, garde-corps **NF P01-012** ⟦en prose, à confirmer⟧ `[B]` ⟦références/versions exactes à confirmer par le validateur⟧. `respecte-norme`
- **Kit** : `utilise-kit` → [kit-vitrier](../../../kits/vitrerie/kit-vitrier.md)

## Relations & tags
- **Tags** : `metier:vitrerie famille:specialises sous-famille:vitrerie intervention:entretenir intervention:controler cluster:entretien cluster:maintenance cluster:diagnostic complexite:moyenne type:entretien securite:coupure`

## Historique
| Version | Date | Auteur | Validateur | Motif |
|---|---|---|---|---|
| v0.1 | 2026-08-05 | IA | ⟦—⟧ | proposition initiale (Brouillon) |
