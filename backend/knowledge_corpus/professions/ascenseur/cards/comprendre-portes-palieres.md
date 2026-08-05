# Comprendre les portes palières et l'accès

> **Brouillon (v0) — proposé par IA, en attente de validation métier** (Loi 7/18). Modèle : [../../../cards/CARD_TEMPLATE.md](../../../cards/CARD_TEMPLATE.md).
> Niveaux de confiance : A normes/fabricant · B technique · C terrain validé · D hypothèse. Rien n'est publié comme certitude.

## Métadonnées
| Champ | Valeur |
|---|---|
| Identifiant | `comprendre-portes-palieres` |
| Titre | Comprendre les portes palières et l'accès |
| Profession | `metier:ascenseur` |
| Famille | `famille:specialises` |
| Sous-famille | `sous-famille:ascenseur` |
| Version | v0.1 |
| Auteur | IA (proposition) |
| Validateur | ⟦à valider métier⟧ |
| Statut | Brouillon |
| Indice de confiance | **C** |

## Cadrage
- **Objectif** : comprendre les **portes palières** (verrouillage, sécurité d'accès) et leur interface avec le bâti. `[C]`
- **Résumé** : comprendre les **portes palières** (à chaque niveau) et de **cabine** : leur **verrouillage** interdit l'ouverture hors zone de déverrouillage et le départ porte ouverte, leur cinématique (coulissantes automatiques), leur **résistance au feu** éventuelle et leur scellement dans le bâti (interface **Maçonnerie** pour l'huisserie maçonnée) ; toute intervention sur le verrouillage est **réservée** (sécurité vitale). `[C]` ⟦type/feu des portes selon appareil à confirmer⟧

## Réalisation
- **Étapes** *(compréhension / organisation — aucune opération réservée décrite pas à pas)* :
  1. **Verrouillage** : pas de départ porte ouverte. `[A]`
  2. Cinématique (coulissantes automatiques). `[C]` → [porte-paliere-defaut](../../../diagnostics/ascenseur/porte-paliere-defaut.md)
  3. Résistance au feu / scellement dans le bâti. `[C]`
  4. Intervention sur verrouillage = **réservée**. `[A]` → [comprendre-dispositifs-securite](comprendre-dispositifs-securite.md)
- **Points critiques** : **verrouillage** compris (sécurité d'accès) ; feu/scellement ; intervention réservée ; interface bâti.
- **Sécurité** : chute en gaine (porte déverrouillée) ; écrasement ; — **Métier à hauts risques, largement réservé à des intervenants habilités** : les opérations en **gaine**, sur la **machinerie**, les **câbles/poulies**, le **contrepoids** et les **dispositifs de sécurité** ne sont **jamais décrites pas à pas** ici — elles relèvent d'ascensoristes formés/habilités. **Chute en gaine** (fond de cuvette, vide) ; **écrasement** (cabine/contrepoids en mouvement) ; **happement** (poulies/câbles). **Consignation** électrique et mécanique **obligatoire** avant toute intervention (blocage cabine, condamnation). **Risques électriques** : alimentation / armoire / variateur → **raccordement réservé** (interface Électricité). **Personnes bloquées** : le **dégagement** suit une procédure stricte par personnel formé (risque de chute/cisaillement). **Amiante** (modernisation d'appareils anciens : garnitures de frein, joints) : diagnostic ; retrait réservé à une **entreprise certifiée** (**jamais ici**). **Arrêt immédiat en cas de danger.** `[A]`

## Cadre & suites
- **Normes** : gaine (génie civil béton, **interface** maçonnerie) **DTU 21** ; alimentation électrique (**interface**) **NF C 15-100** ; sécurité des ascenseurs **NF EN 81-20 / NF EN 81-50**, accessibilité **NF EN 81-70**, amélioration de l'existant **NF EN 81-80** (SNEL), **Directive Ascenseurs 2014/33/UE** et réglementation d'entretien / contrôle technique (Code de la construction) ⟦en prose, à confirmer⟧ `[B]` ⟦références/versions exactes à confirmer par le validateur⟧. `respecte-norme`
- **Modernisation** : `cite-carte` → [comprendre-modernisation](comprendre-modernisation.md)

## Relations & tags
- **Tags** : `metier:ascenseur famille:specialises sous-famille:ascenseur intervention:comprendre cluster:portes-palieres cluster:verrouillage complexite:moyenne type:principe securite:ecrasement`

## Historique
| Version | Date | Auteur | Validateur | Motif |
|---|---|---|---|---|
| v0.1 | 2026-08-05 | IA | ⟦—⟧ | proposition initiale (Brouillon) |
