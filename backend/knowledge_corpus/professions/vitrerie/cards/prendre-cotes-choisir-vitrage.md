# Prendre les cotes et choisir le vitrage

> **Brouillon (v0) — proposé par IA, en attente de validation métier** (Loi 7/18). Modèle : [../../../cards/CARD_TEMPLATE.md](../../../cards/CARD_TEMPLATE.md).
> Niveaux de confiance : A normes/fabricant · B technique · C terrain validé · D hypothèse. Rien n'est publié comme certitude.

## Métadonnées
| Champ | Valeur |
|---|---|
| Identifiant | `prendre-cotes-choisir-vitrage` |
| Titre | Prendre les cotes et choisir le vitrage |
| Profession | `metier:vitrerie` |
| Famille | `famille:specialises` |
| Sous-famille | `sous-famille:vitrerie` |
| Version | v0.1 |
| Auteur | IA (proposition) |
| Validateur | ⟦à valider métier⟧ |
| Statut | Brouillon |
| Indice de confiance | **C** |

## Cadrage
- **Objectif** : relever précisément les cotes et **choisir le vitrage** adapté à l'usage (sécurité, isolation, acénique). `[C]`
- **Résumé** : mesurer la **feuillure** (largeur/hauteur, prise en feuillure, jeux périphériques), repérer le sens de pose, puis **choisir le vitrage** selon l'usage : **sécurité** (trempé/feuilleté en allège, porte, garde-corps), **isolation** thermique (double/triple, VIR) ou acoustique, épaisseur/poids compatibles avec le châssis ; commander avec façonnage. `[C]` ⟦type/épaisseur selon usage et châssis à confirmer⟧

## Réalisation
- **Étapes** :
  1. Mesurer la **feuillure** et les jeux périphériques. `[C]`
  2. Déterminer l'**usage** (sécurité/isolation/acoustique). `[C]` → [poser-vitrage-securite-garde-corps](poser-vitrage-securite-garde-corps.md)
  3. Vérifier compatibilité **poids/épaisseur** avec le châssis. `[C]`
  4. Commander (façonnage) ou débiter. `[C]` → [couper-faconner-verre](couper-faconner-verre.md)
- **Points critiques** : cotes de **feuillure** justes ; **verre de sécurité** si l'usage l'impose ; poids compatible châssis ; sens de pose.
- **Sécurité** : — ; coupures (manipulation) ; — **Risque majeur de casse et de coupures** : le verre casse net et coupe profondément (artères) → **gants anti-coupure**, manches longues, chaussures ; évacuer immédiatement les éclats. **Manutention des vitrages lourds** : **ventouses** adaptées, binôme/levage, ne jamais porter seul un grand vitrage ; **stockage / transport** sur chevalets (vitrage **debout**, jamais à plat), calé et sanglé. **Travail en hauteur** (vitrines, verrières, façades) : échafaudage/nacelle/harnais. **Verre de sécurité selon l'usage** : **trempé** (casse en petits morceaux) ou **feuilleté** (retient les éclats) obligatoire en allège / porte / garde-corps / toiture — ne pas poser un verre inadapté. **Repérage des réseaux** avant perçage/scellement. **Amiante** (mastics/joints anciens) : diagnostic ; retrait réservé à une **entreprise certifiée** (**jamais ici**). **Arrêt immédiat en cas de danger.** `[A]`

## Cadre & suites
- **Normes** : travaux de **vitrerie-miroiterie** **DTU 39** ; menuiseries métalliques recevant le vitrage (**interface**) **DTU 37.1** ; verre de sécurité trempé / feuilleté (**NF EN 12150 / NF EN 14449 / ISO 12543**), vitrage isolant **NF EN 1279**, résistance au choc **NF EN 12600**, garde-corps **NF P01-012** ⟦en prose, à confirmer⟧ `[B]` ⟦références/versions exactes à confirmer par le validateur⟧. `respecte-norme`
- **Double vitrage** : `cite-carte` → [remplacer-double-vitrage](remplacer-double-vitrage.md)

## Relations & tags
- **Tags** : `metier:vitrerie famille:specialises sous-famille:vitrerie intervention:comprendre cluster:types-de-verre cluster:releve complexite:moyenne type:conception securite:coupure`

## Historique
| Version | Date | Auteur | Validateur | Motif |
|---|---|---|---|---|
| v0.1 | 2026-08-05 | IA | ⟦—⟧ | proposition initiale (Brouillon) |
