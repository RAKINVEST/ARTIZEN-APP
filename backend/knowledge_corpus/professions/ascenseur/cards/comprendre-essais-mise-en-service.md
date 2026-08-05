# Comprendre les essais et la mise en service

> **Brouillon (v0) — proposé par IA, en attente de validation métier** (Loi 7/18). Modèle : [../../../cards/CARD_TEMPLATE.md](../../../cards/CARD_TEMPLATE.md).
> Niveaux de confiance : A normes/fabricant · B technique · C terrain validé · D hypothèse. Rien n'est publié comme certitude.

## Métadonnées
| Champ | Valeur |
|---|---|
| Identifiant | `comprendre-essais-mise-en-service` |
| Titre | Comprendre les essais et la mise en service |
| Profession | `metier:ascenseur` |
| Famille | `famille:specialises` |
| Sous-famille | `sous-famille:ascenseur` |
| Version | v0.1 |
| Auteur | IA (proposition) |
| Validateur | ⟦à valider métier⟧ |
| Statut | Brouillon |
| Indice de confiance | **C** |

## Cadrage
- **Objectif** : comprendre le cadre des **essais** et de la **mise en service** d'un ascenseur (réception, conformité). `[C]`
- **Résumé** : comprendre qu'avant la **mise en service**, l'appareil fait l'objet d'**essais** (fonctionnement des sécurités, parachute, freinage, précision d'arrêt, portes) et d'une **vérification de conformité** (Directive Ascenseurs, **NF EN 81-20/50**), réalisés par des **personnels compétents/organismes** ; le rôle du client/gestionnaire est de s'assurer que ces étapes ont été faites et **documentées** — ces essais ne sont **pas décrits pas à pas** ici. `[C]` ⟦essais/organismes selon réglementation à confirmer⟧

## Réalisation
- **Étapes** *(compréhension / organisation — aucune opération réservée décrite pas à pas)* :
  1. **Essais des sécurités** (parachute/freinage/portes). `[A]`
  2. **Conformité** (Directive / NF EN 81-20/50). `[A]`
  3. Mise en service **documentée** (réception). `[C]` → [controle-maintenance-ascenseur](../../../checklists/ascenseur/controle-maintenance-ascenseur.md)
  4. Réalisés par **personnels compétents/organismes**. `[A]`
- **Points critiques** : essais **documentés** ; conformité vérifiée ; réalisés par compétents ; pas de pas-à-pas d'opération réservée.
- **Sécurité** : essais = zone active (réservé) ; consignation ; — **Métier à hauts risques, largement réservé à des intervenants habilités** : les opérations en **gaine**, sur la **machinerie**, les **câbles/poulies**, le **contrepoids** et les **dispositifs de sécurité** ne sont **jamais décrites pas à pas** ici — elles relèvent d'ascensoristes formés/habilités. **Chute en gaine** (fond de cuvette, vide) ; **écrasement** (cabine/contrepoids en mouvement) ; **happement** (poulies/câbles). **Consignation** électrique et mécanique **obligatoire** avant toute intervention (blocage cabine, condamnation). **Risques électriques** : alimentation / armoire / variateur → **raccordement réservé** (interface Électricité). **Personnes bloquées** : le **dégagement** suit une procédure stricte par personnel formé (risque de chute/cisaillement). **Amiante** (modernisation d'appareils anciens : garnitures de frein, joints) : diagnostic ; retrait réservé à une **entreprise certifiée** (**jamais ici**). **Arrêt immédiat en cas de danger.** `[A]`

## Cadre & suites
- **Normes** : gaine (génie civil béton, **interface** maçonnerie) **DTU 21** ; alimentation électrique (**interface**) **NF C 15-100** ; sécurité des ascenseurs **NF EN 81-20 / NF EN 81-50**, accessibilité **NF EN 81-70**, amélioration de l'existant **NF EN 81-80** (SNEL), **Directive Ascenseurs 2014/33/UE** et réglementation d'entretien / contrôle technique (Code de la construction) ⟦en prose, à confirmer⟧ `[B]` ⟦références/versions exactes à confirmer par le validateur⟧. `respecte-norme`
- **Maintenance** : `cite-carte` → [organiser-maintenance-depannage](organiser-maintenance-depannage.md)

## Relations & tags
- **Tags** : `metier:ascenseur famille:specialises sous-famille:ascenseur intervention:comprendre cluster:essais cluster:mise-en-service complexite:moyenne type:principe securite:ecrasement`

## Historique
| Version | Date | Auteur | Validateur | Motif |
|---|---|---|---|---|
| v0.1 | 2026-08-05 | IA | ⟦—⟧ | proposition initiale (Brouillon) |
