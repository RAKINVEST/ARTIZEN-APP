# Comprendre les dispositifs de sécurité

> **Brouillon (v0) — proposé par IA, en attente de validation métier** (Loi 7/18). Modèle : [../../../cards/CARD_TEMPLATE.md](../../../cards/CARD_TEMPLATE.md).
> Niveaux de confiance : A normes/fabricant · B technique · C terrain validé · D hypothèse. Rien n'est publié comme certitude.

## Métadonnées
| Champ | Valeur |
|---|---|
| Identifiant | `comprendre-dispositifs-securite` |
| Titre | Comprendre les dispositifs de sécurité |
| Profession | `metier:ascenseur` |
| Famille | `famille:specialises` |
| Sous-famille | `sous-famille:securite` |
| Version | v0.1 |
| Auteur | IA (proposition) |
| Validateur | ⟦à valider métier⟧ |
| Statut | Brouillon |
| Indice de confiance | **B** |

## Cadrage
- **Objectif** : comprendre les organes de sécurité : **parachute**, **limiteur de vitesse**, **verrouillage des portes**. `[B]`
- **Résumé** : comprendre le rôle des **dispositifs de sécurité** (**NF EN 81-20**) : le **limiteur de vitesse** détecte la survitesse et déclenche le **parachute** (blocage de la cabine sur les guides), le **verrouillage des portes** (palières et cabine) empêche le départ porte ouverte et l'accès à la gaine, plus fin de course, amortisseurs, contacts de sécurité ; ces organes sont **vitaux** — leur vérification/réglage est **réservé aux habilités** et jamais neutralisé. `[A]` ⟦organes/essais selon NF EN 81-20/50 à confirmer⟧

## Réalisation
- **Étapes** *(compréhension / organisation — aucune opération réservée décrite pas à pas)* :
  1. **Limiteur de vitesse** → déclenche le **parachute** (survitesse). `[A]`
  2. **Verrouillage des portes** (départ porte ouverte interdit). `[A]` → [porte-paliere-defaut](../../../diagnostics/ascenseur/porte-paliere-defaut.md)
  3. Amortisseurs / contacts / fins de course. `[C]`
  4. Organes **jamais neutralisés** ; contrôle par **habilités**. `[A]` → [consignation-securite-avant-intervention-ascenseur](../../../procedures/ascenseur/consignation-securite-avant-intervention-ascenseur.md)
- **Points critiques** : **sécurités vitales** (parachute/limiteur/verrouillage) comprises ; jamais neutralisées ; vérification = habilités.
- **Sécurité** : chute/écrasement (si sécurité défaillante) ; consignation ; — **Métier à hauts risques, largement réservé à des intervenants habilités** : les opérations en **gaine**, sur la **machinerie**, les **câbles/poulies**, le **contrepoids** et les **dispositifs de sécurité** ne sont **jamais décrites pas à pas** ici — elles relèvent d'ascensoristes formés/habilités. **Chute en gaine** (fond de cuvette, vide) ; **écrasement** (cabine/contrepoids en mouvement) ; **happement** (poulies/câbles). **Consignation** électrique et mécanique **obligatoire** avant toute intervention (blocage cabine, condamnation). **Risques électriques** : alimentation / armoire / variateur → **raccordement réservé** (interface Électricité). **Personnes bloquées** : le **dégagement** suit une procédure stricte par personnel formé (risque de chute/cisaillement). **Amiante** (modernisation d'appareils anciens : garnitures de frein, joints) : diagnostic ; retrait réservé à une **entreprise certifiée** (**jamais ici**). **Arrêt immédiat en cas de danger.** `[A]`

## Cadre & suites
- **Normes** : gaine (génie civil béton, **interface** maçonnerie) **DTU 21** ; alimentation électrique (**interface**) **NF C 15-100** ; sécurité des ascenseurs **NF EN 81-20 / NF EN 81-50**, accessibilité **NF EN 81-70**, amélioration de l'existant **NF EN 81-80** (SNEL), **Directive Ascenseurs 2014/33/UE** et réglementation d'entretien / contrôle technique (Code de la construction) ⟦en prose, à confirmer⟧ `[B]` ⟦références/versions exactes à confirmer par le validateur⟧. `respecte-norme`
- **Essais / mise en service** : `cite-carte` → [comprendre-essais-mise-en-service](comprendre-essais-mise-en-service.md)

## Relations & tags
- **Tags** : `metier:ascenseur famille:specialises sous-famille:securite intervention:comprendre cluster:dispositifs-securite cluster:parachute cluster:verrouillage complexite:avancee type:principe securite:ecrasement`

## Historique
| Version | Date | Auteur | Validateur | Motif |
|---|---|---|---|---|
| v0.1 | 2026-08-05 | IA | ⟦—⟧ | proposition initiale (Brouillon) |
