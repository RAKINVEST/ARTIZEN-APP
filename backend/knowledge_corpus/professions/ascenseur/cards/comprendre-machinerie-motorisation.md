# Comprendre la machinerie et la motorisation

> **Brouillon (v0) — proposé par IA, en attente de validation métier** (Loi 7/18). Modèle : [../../../cards/CARD_TEMPLATE.md](../../../cards/CARD_TEMPLATE.md).
> Niveaux de confiance : A normes/fabricant · B technique · C terrain validé · D hypothèse. Rien n'est publié comme certitude.

## Métadonnées
| Champ | Valeur |
|---|---|
| Identifiant | `comprendre-machinerie-motorisation` |
| Titre | Comprendre la machinerie et la motorisation |
| Profession | `metier:ascenseur` |
| Famille | `famille:specialises` |
| Sous-famille | `sous-famille:ascenseur` |
| Version | v0.1 |
| Auteur | IA (proposition) |
| Validateur | ⟦à valider métier⟧ |
| Statut | Brouillon |
| Indice de confiance | **C** |

## Cadrage
- **Objectif** : comprendre la **machinerie** (avec/sans local), la **motorisation**, le **variateur**, les **câbles** et **poulies**. `[C]`
- **Résumé** : distinguer les configurations : **avec local** de machinerie ou **sans local** (MRL, machine en gaine), la **motorisation** (à traction par câbles/poulies, ou hydraulique), le **variateur** de fréquence (confort/précision d'arrêt) et le rôle des **câbles/poulies** ; l'**alimentation électrique** et l'armoire relèvent de l'**Électricité** (interface) — toute intervention sur la machinerie est **réservée/consignée**. `[C]` ⟦type de motorisation selon appareil à confirmer⟧

## Réalisation
- **Étapes** *(compréhension / organisation — aucune opération réservée décrite pas à pas)* :
  1. **Machinerie** avec local / **sans local** (MRL). `[C]`
  2. **Motorisation** (traction câbles / hydraulique) + **variateur**. `[C]`
  3. **Câbles / poulies** : rôle, contrôle par habilité. `[C]` → [bruit-vibration-a-coups](../../../diagnostics/ascenseur/bruit-vibration-a-coups.md)
  4. **Alimentation / armoire** = **Électricité** (interface). `[A]` → [controler-tableau-electrique](../../../professions/electricite-generale/cards/controler-tableau-electrique.md)
- **Points critiques** : configuration comprise ; rôle variateur/câbles/poulies ; **électricité = interface** ; intervention réservée.
- **Sécurité** : happement (poulies/câbles) ; électrique (interface) ; consignation. **Métier à hauts risques, largement réservé à des intervenants habilités** : les opérations en **gaine**, sur la **machinerie**, les **câbles/poulies**, le **contrepoids** et les **dispositifs de sécurité** ne sont **jamais décrites pas à pas** ici — elles relèvent d'ascensoristes formés/habilités. **Chute en gaine** (fond de cuvette, vide) ; **écrasement** (cabine/contrepoids en mouvement) ; **happement** (poulies/câbles). **Consignation** électrique et mécanique **obligatoire** avant toute intervention (blocage cabine, condamnation). **Risques électriques** : alimentation / armoire / variateur → **raccordement réservé** (interface Électricité). **Personnes bloquées** : le **dégagement** suit une procédure stricte par personnel formé (risque de chute/cisaillement). **Amiante** (modernisation d'appareils anciens : garnitures de frein, joints) : diagnostic ; retrait réservé à une **entreprise certifiée** (**jamais ici**). **Arrêt immédiat en cas de danger.** `[A]`

## Cadre & suites
- **Normes** : gaine (génie civil béton, **interface** maçonnerie) **DTU 21** ; alimentation électrique (**interface**) **NF C 15-100** ; sécurité des ascenseurs **NF EN 81-20 / NF EN 81-50**, accessibilité **NF EN 81-70**, amélioration de l'existant **NF EN 81-80** (SNEL), **Directive Ascenseurs 2014/33/UE** et réglementation d'entretien / contrôle technique (Code de la construction) ⟦en prose, à confirmer⟧ `[B]` ⟦références/versions exactes à confirmer par le validateur⟧. `respecte-norme`
- **Dispositifs de sécurité** : `cite-carte` → [comprendre-dispositifs-securite](comprendre-dispositifs-securite.md)

## Relations & tags
- **Tags** : `metier:ascenseur famille:specialises sous-famille:ascenseur intervention:comprendre cluster:machinerie cluster:motorisation cluster:variateur cluster:cables-poulies complexite:avancee type:principe securite:electrique relation:electricite-generale`

## Historique
| Version | Date | Auteur | Validateur | Motif |
|---|---|---|---|---|
| v0.1 | 2026-08-05 | IA | ⟦—⟧ | proposition initiale (Brouillon) |
