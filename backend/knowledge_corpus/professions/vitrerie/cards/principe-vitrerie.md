# Principe de la vitrerie / miroiterie

> **Brouillon (v0) — proposé par IA, en attente de validation métier** (Loi 7/18). Modèle : [../../../cards/CARD_TEMPLATE.md](../../../cards/CARD_TEMPLATE.md).
> Niveaux de confiance : A normes/fabricant · B technique · C terrain validé · D hypothèse. Rien n'est publié comme certitude.

## Métadonnées
| Champ | Valeur |
|---|---|
| Identifiant | `principe-vitrerie` |
| Titre | Principe de la vitrerie / miroiterie |
| Profession | `metier:vitrerie` |
| Famille | `famille:specialises` |
| Sous-famille | `sous-famille:vitrerie` |
| Version | v0.1 |
| Auteur | IA (proposition) |
| Validateur | ⟦à valider métier⟧ |
| Statut | Brouillon |
| Indice de confiance | **C** |

## Cadrage
- **Objectif** : comprendre le métier : types de verre, **vitrerie** (vitrage des ouvrages) et **miroiterie**, et l'articulation avec les châssis. `[C]`
- **Résumé** : la vitrerie fournit, façonne et pose le **verre** (simple, double/isolant, trempé, feuilleté…) dans des châssis, et la **miroiterie** pose miroirs et parois de verre ; le vitrier **choisit le vitrage selon l'usage**, le pose et l'étanche, mais la **menuiserie** qui le reçoit relève d'autres métiers : **métallique** (Métallerie), **bois** (Menuiserie intérieure) ; un **ouvrant automatique** vitré renvoie aux **Automatismes**. `[C]` ⟦types de vitrage selon projet à confirmer⟧

## Réalisation
- **Étapes** :
  1. **Prendre les cotes / choisir** le vitrage (usage/sécurité). `[C]` → [prendre-cotes-choisir-vitrage](prendre-cotes-choisir-vitrage.md)
  2. **Poser / remplacer** un vitrage (châssis). `[C]` → [poser-remplacer-vitrage](poser-remplacer-vitrage.md)
  3. Châssis = **menuiserie** (métal/bois, métiers distincts). `[C]` → [poser-bloc-porte](../../../professions/menuiserie-interieure/cards/poser-bloc-porte.md)
  4. **Ouvrant automatique** vitré = Automatismes (interface). `[C]` → [principe-automatismes-portails](../../../professions/automatismes-portails/cards/principe-automatismes-portails.md)
- **Points critiques** : verre adapté à l'usage (sécurité) ; châssis = métiers distincts ; **casse/coupures** ; manutention/hauteur.
- **Sécurité** : coupures ; manutention (vitrages lourds) ; hauteur. **Risque majeur de casse et de coupures** : le verre casse net et coupe profondément (artères) → **gants anti-coupure**, manches longues, chaussures ; évacuer immédiatement les éclats. **Manutention des vitrages lourds** : **ventouses** adaptées, binôme/levage, ne jamais porter seul un grand vitrage ; **stockage / transport** sur chevalets (vitrage **debout**, jamais à plat), calé et sanglé. **Travail en hauteur** (vitrines, verrières, façades) : échafaudage/nacelle/harnais. **Verre de sécurité selon l'usage** : **trempé** (casse en petits morceaux) ou **feuilleté** (retient les éclats) obligatoire en allège / porte / garde-corps / toiture — ne pas poser un verre inadapté. **Repérage des réseaux** avant perçage/scellement. **Amiante** (mastics/joints anciens) : diagnostic ; retrait réservé à une **entreprise certifiée** (**jamais ici**). **Arrêt immédiat en cas de danger.** `[A]`

## Cadre & suites
- **Normes** : travaux de **vitrerie-miroiterie** **DTU 39** ; menuiseries métalliques recevant le vitrage (**interface**) **DTU 37.1** ; verre de sécurité trempé / feuilleté (**NF EN 12150 / NF EN 14449 / ISO 12543**), vitrage isolant **NF EN 1279**, résistance au choc **NF EN 12600**, garde-corps **NF P01-012** ⟦en prose, à confirmer⟧ `[B]` ⟦références/versions exactes à confirmer par le validateur⟧. `respecte-norme`
- **Entretien / diagnostic** : `cite-carte` → [entretenir-diagnostiquer-vitrerie](entretenir-diagnostiquer-vitrerie.md)

## Relations & tags
- **Tags** : `metier:vitrerie famille:specialises sous-famille:vitrerie intervention:comprendre cluster:types-de-verre cluster:vitrerie cluster:miroiterie type:principe securite:coupure relation:menuiserie-interieure relation:automatismes-portails`

## Historique
| Version | Date | Auteur | Validateur | Motif |
|---|---|---|---|---|
| v0.1 | 2026-08-05 | IA | ⟦—⟧ | proposition initiale (Brouillon) |
