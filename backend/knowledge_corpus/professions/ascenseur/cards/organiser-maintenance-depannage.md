# Organiser la maintenance réglementée et le dépannage

> **Brouillon (v0) — proposé par IA, en attente de validation métier** (Loi 7/18). Modèle : [../../../cards/CARD_TEMPLATE.md](../../../cards/CARD_TEMPLATE.md).
> Niveaux de confiance : A normes/fabricant · B technique · C terrain validé · D hypothèse. Rien n'est publié comme certitude.

## Métadonnées
| Champ | Valeur |
|---|---|
| Identifiant | `organiser-maintenance-depannage` |
| Titre | Organiser la maintenance réglementée et le dépannage |
| Profession | `metier:ascenseur` |
| Famille | `famille:specialises` |
| Sous-famille | `sous-famille:ascenseur` |
| Version | v0.1 |
| Auteur | IA (proposition) |
| Validateur | ⟦à valider métier⟧ |
| Statut | Brouillon |
| Indice de confiance | **C** |

## Cadrage
- **Objectif** : comprendre la **maintenance réglementée** (obligation d'entretien) et le cadre du **dépannage** / dégagement. `[C]`
- **Résumé** : comprendre l'**obligation d'entretien** d'un ascenseur (contrat d'entretien avec un ascensoriste, visites périodiques, **contrôle technique quinquennal**, tenue d'un **carnet/registre**), et le cadre du **dépannage** : la mise en sécurité et le **dégagement des personnes bloquées** suivent une procédure stricte par personnel **formé** (jamais improvisée) ; le rôle du gestionnaire est d'organiser ce suivi, pas d'intervenir. `[C]` ⟦périodicités/obligations selon réglementation à confirmer⟧

## Réalisation
- **Étapes** *(compréhension / organisation — aucune opération réservée décrite pas à pas)* :
  1. **Contrat d'entretien** + visites périodiques. `[A]`
  2. **Contrôle technique quinquennal** ; registre/carnet. `[A]` → [controle-maintenance-ascenseur](../../../checklists/ascenseur/controle-maintenance-ascenseur.md)
  3. **Dégagement** des personnes bloquées = personnel **formé**. `[A]`
  4. Panne → mettre hors service et appeler l'ascensoriste. `[C]` → [ascenseur-arrete-hors-service](../../../diagnostics/ascenseur/ascenseur-arrete-hors-service.md)
- **Points critiques** : **obligation d'entretien** ; contrôle quinquennal ; dégagement = formés ; traçabilité (registre) ; rôle d'organisation.
- **Sécurité** : écrasement/chute (dégagement) ; consignation ; — **Métier à hauts risques, largement réservé à des intervenants habilités** : les opérations en **gaine**, sur la **machinerie**, les **câbles/poulies**, le **contrepoids** et les **dispositifs de sécurité** ne sont **jamais décrites pas à pas** ici — elles relèvent d'ascensoristes formés/habilités. **Chute en gaine** (fond de cuvette, vide) ; **écrasement** (cabine/contrepoids en mouvement) ; **happement** (poulies/câbles). **Consignation** électrique et mécanique **obligatoire** avant toute intervention (blocage cabine, condamnation). **Risques électriques** : alimentation / armoire / variateur → **raccordement réservé** (interface Électricité). **Personnes bloquées** : le **dégagement** suit une procédure stricte par personnel formé (risque de chute/cisaillement). **Amiante** (modernisation d'appareils anciens : garnitures de frein, joints) : diagnostic ; retrait réservé à une **entreprise certifiée** (**jamais ici**). **Arrêt immédiat en cas de danger.** `[A]`

## Cadre & suites
- **Normes** : gaine (génie civil béton, **interface** maçonnerie) **DTU 21** ; alimentation électrique (**interface**) **NF C 15-100** ; sécurité des ascenseurs **NF EN 81-20 / NF EN 81-50**, accessibilité **NF EN 81-70**, amélioration de l'existant **NF EN 81-80** (SNEL), **Directive Ascenseurs 2014/33/UE** et réglementation d'entretien / contrôle technique (Code de la construction) ⟦en prose, à confirmer⟧ `[B]` ⟦références/versions exactes à confirmer par le validateur⟧. `respecte-norme`
- **Modernisation** : `cite-carte` → [comprendre-modernisation](comprendre-modernisation.md)

## Relations & tags
- **Tags** : `metier:ascenseur famille:specialises sous-famille:ascenseur intervention:controler cluster:maintenance-reglementee cluster:depannage complexite:moyenne type:entretien securite:ecrasement`

## Historique
| Version | Date | Auteur | Validateur | Motif |
|---|---|---|---|---|
| v0.1 | 2026-08-05 | IA | ⟦—⟧ | proposition initiale (Brouillon) |
