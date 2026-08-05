# Poser une motorisation coulissante

> **Brouillon (v0) — proposé par IA, en attente de validation métier** (Loi 7/18). Modèle : [../../../cards/CARD_TEMPLATE.md](../../../cards/CARD_TEMPLATE.md).
> Niveaux de confiance : A normes/fabricant · B technique · C terrain validé · D hypothèse. Rien n'est publié comme certitude.

## Métadonnées
| Champ | Valeur |
|---|---|
| Identifiant | `poser-motorisation-coulissant` |
| Titre | Poser une motorisation coulissante |
| Profession | `metier:automatismes-portails` |
| Famille | `famille:specialises` |
| Sous-famille | `sous-famille:automatismes` |
| Version | v0.1 |
| Auteur | IA (proposition) |
| Validateur | ⟦à valider métier⟧ |
| Statut | Brouillon |
| Indice de confiance | **C** |

## Cadrage
- **Objectif** : poser une motorisation de portail **coulissant** (moteur à crémaillère sur rail/galets). `[C]`
- **Résumé** : sceller/fixer la **platine moteur** (support béton, → gaines Terrassement), fixer la **crémaillère** sur le vantail avec le bon **jeu** au pignon (usure sinon), poser les **butées** et les aimants/fins de course, vérifier le guidage (galets/rail) ; l'**alimentation** est raccordée par un **électricien** (interface). `[C]` ⟦jeu crémaillère/fins de course selon fabricant à confirmer⟧

## Réalisation
- **Étapes** :
  1. Sceller/fixer la **platine moteur** (support). `[C]`
  2. Fixer la **crémaillère** (jeu au pignon) ; galets/rail. `[C]` → [moteur-force-bruit-blocage](../../../diagnostics/automatismes-portails/moteur-force-bruit-blocage.md)
  3. Poser **butées** + aimants/fins de course. `[C]`
  4. Câblage vers l'armoire ; alimentation = **Électricité**. `[C]` → [regler-essayer-motorisation](regler-essayer-motorisation.md)
- **Points critiques** : **jeu crémaillère/pignon** correct (usure) ; fins de course/butées ; guidage sain ; alimentation = interface.
- **Sécurité** : mouvement automatique (**entraînement/cisaillement**) ; manutention ; — **Mouvements automatiques dangereux** : un portail motorisé peut démarrer **seul** (télécommande, horloge, cellule) → **écrasement / cisaillement / entraînement / choc**. **Consignation avant toute intervention** : couper et condamner l'alimentation, neutraliser les commandes, vérifier l'absence de tension/mouvement. **Déverrouillage manuel de secours** : connaître et vérifier le déverrouillage (coupure de courant, personne bloquée). **Dispositifs de sécurité obligatoires** : cellules photoélectriques, **bords sensibles**, **limitation d'effort**, feu clignotant — un portail motorisé est une **machine** (Directive Machines, marquage CE, EN 12453/12445) : **essais et mesure d'effort obligatoires après intervention**. **Risques électriques** : le **raccordement électrique** (alimentation, protection 30 mA) est **réservé à un électricien** → voir Électricité. **Manutention** (moteurs, portail lourd) ; **hauteur** éventuelle. **Amiante** (rénovation ancienne) : diagnostic ; retrait réservé à une **entreprise certifiée** (**jamais ici**). **Arrêt immédiat en cas de danger.** `[A]`

## Cadre & suites
- **Normes** : sécurité des portes/portails motorisés — **Directive Machines**, **marquage CE**, cellules / bords sensibles / limitation d'effort — **NF EN 12453 / NF EN 12445 / NF EN 13241** ; alimentation électrique (**interface**) **NF C 15-100** ; structure du portail (**interface** métallerie) **DTU 37.1** ⟦EN 12453/12445 et versions exactes en prose, à confirmer⟧ `[B]` ⟦références/versions exactes à confirmer par le validateur⟧. `respecte-norme`
- **Réglages / essais** : `cite-carte` → [regler-essayer-motorisation](regler-essayer-motorisation.md)

## Relations & tags
- **Tags** : `metier:automatismes-portails famille:specialises sous-famille:automatismes intervention:realiser cluster:motorisation-coulissant cluster:types-motorisation complexite:avancee type:installation securite:cisaillement`

## Historique
| Version | Date | Auteur | Validateur | Motif |
|---|---|---|---|---|
| v0.1 | 2026-08-05 | IA | ⟦—⟧ | proposition initiale (Brouillon) |
