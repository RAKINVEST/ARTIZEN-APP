# Installer accessoires et commandes

> **Brouillon (v0) — proposé par IA, en attente de validation métier** (Loi 7/18). Modèle : [../../../cards/CARD_TEMPLATE.md](../../../cards/CARD_TEMPLATE.md).
> Niveaux de confiance : A normes/fabricant · B technique · C terrain validé · D hypothèse. Rien n'est publié comme certitude.

## Métadonnées
| Champ | Valeur |
|---|---|
| Identifiant | `installer-accessoires-commandes` |
| Titre | Installer accessoires et commandes |
| Profession | `metier:automatismes-portails` |
| Famille | `famille:specialises` |
| Sous-famille | `sous-famille:automatismes` |
| Version | v0.1 |
| Auteur | IA (proposition) |
| Validateur | ⟦à valider métier⟧ |
| Statut | Brouillon |
| Indice de confiance | **C** |

## Cadrage
- **Objectif** : installer les **commandes** et **accessoires** : télécommandes, récepteur radio, batterie/solaire ; clavier/interphone = **interfaces**. `[C]`
- **Résumé** : programmer les **télécommandes**/récepteur radio, poser une **batterie de secours** ou une alimentation **solaire** éventuelle, et **interfacer** (sans les traiter) les commandes relevant d'autres métiers : **clavier à code / badge** (→ Contrôle d'accès), **interphone/visiophone** (→ Interphonie), dont le raccordement électrique reste Électricité. `[C]` ⟦compatibilités/protocoles selon fabricant à confirmer⟧

## Réalisation
- **Étapes** :
  1. Programmer télécommandes / récepteur radio. `[C]`
  2. Poser batterie de secours / solaire (option). `[C]`
  3. **Clavier / badge** = **Contrôle d'accès** (interface). `[C]` → [installer-lecteurs-claviers](../../../professions/controle-acces/cards/installer-lecteurs-claviers.md)
  4. **Interphone / visiophone** = **Interphonie** (interface). `[C]` → [raccorder-commande-gache](../../../professions/interphonie/cards/raccorder-commande-gache.md)
- **Points critiques** : commandes programmées ; **frontières respectées** (contrôle d'accès / interphonie = métiers distincts) ; autonomie de secours.
- **Sécurité** : mouvement automatique ; électrique (interface) ; — **Mouvements automatiques dangereux** : un portail motorisé peut démarrer **seul** (télécommande, horloge, cellule) → **écrasement / cisaillement / entraînement / choc**. **Consignation avant toute intervention** : couper et condamner l'alimentation, neutraliser les commandes, vérifier l'absence de tension/mouvement. **Déverrouillage manuel de secours** : connaître et vérifier le déverrouillage (coupure de courant, personne bloquée). **Dispositifs de sécurité obligatoires** : cellules photoélectriques, **bords sensibles**, **limitation d'effort**, feu clignotant — un portail motorisé est une **machine** (Directive Machines, marquage CE, EN 12453/12445) : **essais et mesure d'effort obligatoires après intervention**. **Risques électriques** : le **raccordement électrique** (alimentation, protection 30 mA) est **réservé à un électricien** → voir Électricité. **Manutention** (moteurs, portail lourd) ; **hauteur** éventuelle. **Amiante** (rénovation ancienne) : diagnostic ; retrait réservé à une **entreprise certifiée** (**jamais ici**). **Arrêt immédiat en cas de danger.** `[A]`

## Cadre & suites
- **Normes** : sécurité des portes/portails motorisés — **Directive Machines**, **marquage CE**, cellules / bords sensibles / limitation d'effort — **NF EN 12453 / NF EN 12445 / NF EN 13241** ; alimentation électrique (**interface**) **NF C 15-100** ; structure du portail (**interface** métallerie) **DTU 37.1** ⟦EN 12453/12445 et versions exactes en prose, à confirmer⟧ `[B]` ⟦références/versions exactes à confirmer par le validateur⟧. `respecte-norme`
- **Maintenance** : `cite-carte` → [entretenir-diagnostiquer-automatisme](entretenir-diagnostiquer-automatisme.md)

## Relations & tags
- **Tags** : `metier:automatismes-portails famille:specialises sous-famille:automatismes intervention:realiser cluster:accessoires cluster:commandes complexite:moyenne type:installation securite:ecrasement relation:controle-acces relation:interphonie relation:electricite-generale`

## Historique
| Version | Date | Auteur | Validateur | Motif |
|---|---|---|---|---|
| v0.1 | 2026-08-05 | IA | ⟦—⟧ | proposition initiale (Brouillon) |
