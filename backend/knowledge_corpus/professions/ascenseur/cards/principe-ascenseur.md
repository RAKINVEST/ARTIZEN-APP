# Principe du métier d'ascensoriste

> **Brouillon (v0) — proposé par IA, en attente de validation métier** (Loi 7/18). Modèle : [../../../cards/CARD_TEMPLATE.md](../../../cards/CARD_TEMPLATE.md).
> Niveaux de confiance : A normes/fabricant · B technique · C terrain validé · D hypothèse. Rien n'est publié comme certitude.

## Métadonnées
| Champ | Valeur |
|---|---|
| Identifiant | `principe-ascenseur` |
| Titre | Principe du métier d'ascensoriste |
| Profession | `metier:ascenseur` |
| Famille | `famille:specialises` |
| Sous-famille | `sous-famille:ascenseur` |
| Version | v0.1 |
| Auteur | IA (proposition) |
| Validateur | ⟦à valider métier⟧ |
| Statut | Brouillon |
| Indice de confiance | **C** |

## Cadrage
- **Objectif** : comprendre la constitution d'un ascenseur et le fait que c'est un métier **réglementé**, largement **réservé** à des intervenants habilités. `[C]`
- **Résumé** : un ascenseur associe une **gaine**, une **cabine** et son **contrepoids** guidés, une **machinerie** (avec ou sans local) qui entraîne les **câbles**, des **portes palières** et des **dispositifs de sécurité** (parachute, limiteur, verrouillage) ; sa construction, sa **mise en service**, sa **maintenance réglementée** et son dépannage relèvent d'**ascensoristes habilités** ; l'électricien, le maçon (gaine), le métallier et le diagnostiqueur sont des **métiers distincts**. `[C]` ⟦type/configuration selon appareil à confirmer⟧

## Réalisation
- **Étapes** *(compréhension / organisation — aucune opération réservée décrite pas à pas)* :
  1. **Identifier** gaine/cabine/contrepoids/guides. `[C]` → [identifier-composants-gaine-cabine](identifier-composants-gaine-cabine.md)
  2. **Comprendre** machinerie/motorisation. `[C]` → [comprendre-machinerie-motorisation](comprendre-machinerie-motorisation.md)
  3. **Dispositifs de sécurité** (parachute/limiteur/verrouillage). `[A]` → [comprendre-dispositifs-securite](comprendre-dispositifs-securite.md)
  4. Ouvrages métalliques = **Métallier** (frontière, métier distinct). `[C]` → [principe-serrurerie-metallerie](../../../professions/serrurerie-metallerie/cards/principe-serrurerie-metallerie.md)
- **Points critiques** : métier **réservé/habilité** ; sécurité (gaine/écrasement) ; **frontières** (électricien/maçon/métallier/diagnostiqueur) ; consignation.
- **Sécurité** : chute en gaine ; écrasement (cabine/contrepoids) ; électrique (interface). **Métier à hauts risques, largement réservé à des intervenants habilités** : les opérations en **gaine**, sur la **machinerie**, les **câbles/poulies**, le **contrepoids** et les **dispositifs de sécurité** ne sont **jamais décrites pas à pas** ici — elles relèvent d'ascensoristes formés/habilités. **Chute en gaine** (fond de cuvette, vide) ; **écrasement** (cabine/contrepoids en mouvement) ; **happement** (poulies/câbles). **Consignation** électrique et mécanique **obligatoire** avant toute intervention (blocage cabine, condamnation). **Risques électriques** : alimentation / armoire / variateur → **raccordement réservé** (interface Électricité). **Personnes bloquées** : le **dégagement** suit une procédure stricte par personnel formé (risque de chute/cisaillement). **Amiante** (modernisation d'appareils anciens : garnitures de frein, joints) : diagnostic ; retrait réservé à une **entreprise certifiée** (**jamais ici**). **Arrêt immédiat en cas de danger.** `[A]`

## Cadre & suites
- **Normes** : gaine (génie civil béton, **interface** maçonnerie) **DTU 21** ; alimentation électrique (**interface**) **NF C 15-100** ; sécurité des ascenseurs **NF EN 81-20 / NF EN 81-50**, accessibilité **NF EN 81-70**, amélioration de l'existant **NF EN 81-80** (SNEL), **Directive Ascenseurs 2014/33/UE** et réglementation d'entretien / contrôle technique (Code de la construction) ⟦en prose, à confirmer⟧ `[B]` ⟦références/versions exactes à confirmer par le validateur⟧. `respecte-norme`
- **Maintenance réglementée** : `cite-carte` → [organiser-maintenance-depannage](organiser-maintenance-depannage.md)

## Relations & tags
- **Tags** : `metier:ascenseur famille:specialises sous-famille:ascenseur intervention:comprendre cluster:gaine cluster:cabine cluster:machinerie type:principe securite:ecrasement relation:serrurerie-metallerie relation:diagnostic`

## Historique
| Version | Date | Auteur | Validateur | Motif |
|---|---|---|---|---|
| v0.1 | 2026-08-05 | IA | ⟦—⟧ | proposition initiale (Brouillon) |
