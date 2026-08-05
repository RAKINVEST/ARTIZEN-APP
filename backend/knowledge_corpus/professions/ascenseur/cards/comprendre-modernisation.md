# Comprendre la modernisation (mise en conformité)

> **Brouillon (v0) — proposé par IA, en attente de validation métier** (Loi 7/18). Modèle : [../../../cards/CARD_TEMPLATE.md](../../../cards/CARD_TEMPLATE.md).
> Niveaux de confiance : A normes/fabricant · B technique · C terrain validé · D hypothèse. Rien n'est publié comme certitude.

## Métadonnées
| Champ | Valeur |
|---|---|
| Identifiant | `comprendre-modernisation` |
| Titre | Comprendre la modernisation (mise en conformité) |
| Profession | `metier:ascenseur` |
| Famille | `famille:specialises` |
| Sous-famille | `sous-famille:ascenseur` |
| Version | v0.1 |
| Auteur | IA (proposition) |
| Validateur | ⟦à valider métier⟧ |
| Statut | Brouillon |
| Indice de confiance | **C** |

## Cadrage
- **Objectif** : comprendre la **modernisation** d'un ascenseur existant (mise en sécurité / conformité, **SNEL**). `[C]`
- **Résumé** : comprendre la **modernisation** : remise à niveau de sécurité d'appareils anciens (verrouillage/précision d'arrêt/parachute, référentiel **NF EN 81-80 / SNEL**), amélioration de l'accessibilité (**NF EN 81-70**), remplacement de composants (variateur, portes) ; ces travaux sont réalisés par des **ascensoristes habilités**, et la **modernisation d'appareils anciens** peut révéler de l'**amiante** (garnitures de frein, joints) → diagnostic. `[C]` ⟦programme SNEL selon appareil à confirmer⟧

## Réalisation
- **Étapes** *(compréhension / organisation — aucune opération réservée décrite pas à pas)* :
  1. **Mise en sécurité** de l'existant (SNEL / NF EN 81-80). `[A]`
  2. Accessibilité (**NF EN 81-70**) ; remplacement composants. `[C]`
  3. Réalisée par **ascensoristes habilités**. `[A]`
  4. Appareil ancien → **diagnostic amiante** (garnitures/joints). `[C]`
- **Points critiques** : mise en conformité (SNEL) comprise ; accessibilité ; par habilités ; **amiante** (appareils anciens) en interface.
- **Sécurité** : écrasement/chute (chantier gaine) ; amiante (modernisation) ; consignation. **Métier à hauts risques, largement réservé à des intervenants habilités** : les opérations en **gaine**, sur la **machinerie**, les **câbles/poulies**, le **contrepoids** et les **dispositifs de sécurité** ne sont **jamais décrites pas à pas** ici — elles relèvent d'ascensoristes formés/habilités. **Chute en gaine** (fond de cuvette, vide) ; **écrasement** (cabine/contrepoids en mouvement) ; **happement** (poulies/câbles). **Consignation** électrique et mécanique **obligatoire** avant toute intervention (blocage cabine, condamnation). **Risques électriques** : alimentation / armoire / variateur → **raccordement réservé** (interface Électricité). **Personnes bloquées** : le **dégagement** suit une procédure stricte par personnel formé (risque de chute/cisaillement). **Amiante** (modernisation d'appareils anciens : garnitures de frein, joints) : diagnostic ; retrait réservé à une **entreprise certifiée** (**jamais ici**). **Arrêt immédiat en cas de danger.** `[A]`

## Cadre & suites
- **Normes** : gaine (génie civil béton, **interface** maçonnerie) **DTU 21** ; alimentation électrique (**interface**) **NF C 15-100** ; sécurité des ascenseurs **NF EN 81-20 / NF EN 81-50**, accessibilité **NF EN 81-70**, amélioration de l'existant **NF EN 81-80** (SNEL), **Directive Ascenseurs 2014/33/UE** et réglementation d'entretien / contrôle technique (Code de la construction) ⟦en prose, à confirmer⟧ `[B]` ⟦références/versions exactes à confirmer par le validateur⟧. `respecte-norme`
- **Kit** : `utilise-kit` → [kit-ascensoriste](../../../kits/ascenseur/kit-ascensoriste.md)

## Relations & tags
- **Tags** : `metier:ascenseur famille:specialises sous-famille:ascenseur intervention:comprendre cluster:modernisation complexite:moyenne type:principe securite:amiante relation:diagnostic`

## Historique
| Version | Date | Auteur | Validateur | Motif |
|---|---|---|---|---|
| v0.1 | 2026-08-05 | IA | ⟦—⟧ | proposition initiale (Brouillon) |
