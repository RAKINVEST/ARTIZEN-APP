# Identifier gaine, cabine, contrepoids et guides

> **Brouillon (v0) — proposé par IA, en attente de validation métier** (Loi 7/18). Modèle : [../../../cards/CARD_TEMPLATE.md](../../../cards/CARD_TEMPLATE.md).
> Niveaux de confiance : A normes/fabricant · B technique · C terrain validé · D hypothèse. Rien n'est publié comme certitude.

## Métadonnées
| Champ | Valeur |
|---|---|
| Identifiant | `identifier-composants-gaine-cabine` |
| Titre | Identifier gaine, cabine, contrepoids et guides |
| Profession | `metier:ascenseur` |
| Famille | `famille:specialises` |
| Sous-famille | `sous-famille:ascenseur` |
| Version | v0.1 |
| Auteur | IA (proposition) |
| Validateur | ⟦à valider métier⟧ |
| Statut | Brouillon |
| Indice de confiance | **C** |

## Cadrage
- **Objectif** : identifier les composants structurels : **gaine**, **cuvette**, **cabine**, **contrepoids** et **guides**. `[C]`
- **Résumé** : reconnaître la **gaine** (volume vertical, cuvette en fond, dégagement en tête — **génie civil** relevant de la Maçonnerie), la **cabine** et son **contrepoids** équilibré, les **guides** (rails) qui les maintiennent, et les organes en cuvette/tête ; comprendre leur rôle et leurs contraintes (dimensions réglementaires, dégagements de sécurité) sans intervenir — l'accès en gaine est **réservé/consigné**. `[C]` ⟦dimensions/dégagements selon NF EN 81-20 à confirmer⟧

## Réalisation
- **Étapes** *(compréhension / organisation — aucune opération réservée décrite pas à pas)* :
  1. **Gaine / cuvette** : génie civil = **Maçonnerie** (frontière). `[C]` → [principe-maconnerie](../../../professions/maconnerie/cards/principe-maconnerie.md)
  2. **Cabine + contrepoids** : équilibrage, guidage. `[C]`
  3. **Guides** (rails) : alignement/fixation. `[C]`
  4. Accès en gaine = **réservé / consigné**. `[A]` → [consignation-securite-avant-intervention-ascenseur](../../../procedures/ascenseur/consignation-securite-avant-intervention-ascenseur.md)
- **Points critiques** : rôle de chaque composant compris ; dégagements de sécurité ; **gaine = génie civil** (Maçonnerie) ; accès réservé.
- **Sécurité** : chute en gaine ; écrasement (contrepoids) ; — **Métier à hauts risques, largement réservé à des intervenants habilités** : les opérations en **gaine**, sur la **machinerie**, les **câbles/poulies**, le **contrepoids** et les **dispositifs de sécurité** ne sont **jamais décrites pas à pas** ici — elles relèvent d'ascensoristes formés/habilités. **Chute en gaine** (fond de cuvette, vide) ; **écrasement** (cabine/contrepoids en mouvement) ; **happement** (poulies/câbles). **Consignation** électrique et mécanique **obligatoire** avant toute intervention (blocage cabine, condamnation). **Risques électriques** : alimentation / armoire / variateur → **raccordement réservé** (interface Électricité). **Personnes bloquées** : le **dégagement** suit une procédure stricte par personnel formé (risque de chute/cisaillement). **Amiante** (modernisation d'appareils anciens : garnitures de frein, joints) : diagnostic ; retrait réservé à une **entreprise certifiée** (**jamais ici**). **Arrêt immédiat en cas de danger.** `[A]`

## Cadre & suites
- **Normes** : gaine (génie civil béton, **interface** maçonnerie) **DTU 21** ; alimentation électrique (**interface**) **NF C 15-100** ; sécurité des ascenseurs **NF EN 81-20 / NF EN 81-50**, accessibilité **NF EN 81-70**, amélioration de l'existant **NF EN 81-80** (SNEL), **Directive Ascenseurs 2014/33/UE** et réglementation d'entretien / contrôle technique (Code de la construction) ⟦en prose, à confirmer⟧ `[B]` ⟦références/versions exactes à confirmer par le validateur⟧. `respecte-norme`
- **Machinerie** : `cite-carte` → [comprendre-machinerie-motorisation](comprendre-machinerie-motorisation.md)

## Relations & tags
- **Tags** : `metier:ascenseur famille:specialises sous-famille:ascenseur intervention:comprendre cluster:gaine cluster:cabine cluster:contrepoids cluster:guides complexite:moyenne type:principe securite:ecrasement relation:maconnerie`

## Historique
| Version | Date | Auteur | Validateur | Motif |
|---|---|---|---|---|
| v0.1 | 2026-08-05 | IA | ⟦—⟧ | proposition initiale (Brouillon) |
