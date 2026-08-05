# Entretenir / diagnostiquer un automatisme de portail

> **Brouillon (v0) — proposé par IA, en attente de validation métier** (Loi 7/18). Modèle : [../../../cards/CARD_TEMPLATE.md](../../../cards/CARD_TEMPLATE.md).
> Niveaux de confiance : A normes/fabricant · B technique · C terrain validé · D hypothèse. Rien n'est publié comme certitude.

## Métadonnées
| Champ | Valeur |
|---|---|
| Identifiant | `entretenir-diagnostiquer-automatisme` |
| Titre | Entretenir / diagnostiquer un automatisme de portail |
| Profession | `metier:automatismes-portails` |
| Famille | `famille:specialises` |
| Sous-famille | `sous-famille:automatismes` |
| Version | v0.1 |
| Auteur | IA (proposition) |
| Validateur | ⟦à valider métier⟧ |
| Statut | Brouillon |
| Indice de confiance | **C** |

## Cadrage
- **Objectif** : assurer l'**entretien**/la **maintenance** de l'automatisme et diagnostiquer les pannes — toujours après **consignation**. `[C]`
- **Résumé** : après **consignation**, nettoyer/graisser les organes mécaniques, contrôler cellules/bords sensibles/fins de course, l'état de la crémaillère/vérins, la batterie de secours et le **déverrouillage manuel**, puis **re-tester** (essais/mesure d'effort) après toute intervention ; en rénovation d'ouvrages anciens, **diagnostic amiante**. `[C]`

## Réalisation
- **Étapes** :
  1. **Consigner** avant toute intervention. `[A]` → [consignation-essais-avant-apres-intervention](../../../procedures/automatismes-portails/consignation-essais-avant-apres-intervention.md)
  2. Nettoyer/graisser ; contrôler sécurités et déverrouillage. `[C]` → [portail-ne-repond-plus](../../../diagnostics/automatismes-portails/portail-ne-repond-plus.md)
  3. Vérifier crémaillère/vérins/batterie. `[C]` → [moteur-force-bruit-blocage](../../../diagnostics/automatismes-portails/moteur-force-bruit-blocage.md)
  4. **Re-tester** après intervention ; rénovation → amiante. `[A]`
- **Points critiques** : **consignation** systématique ; sécurités vérifiées ; déverrouillage OK ; **re-essai** obligatoire ; amiante en rénovation.
- **Sécurité** : mouvement automatique (consignation) ; manutention ; amiante (rénovation). **Mouvements automatiques dangereux** : un portail motorisé peut démarrer **seul** (télécommande, horloge, cellule) → **écrasement / cisaillement / entraînement / choc**. **Consignation avant toute intervention** : couper et condamner l'alimentation, neutraliser les commandes, vérifier l'absence de tension/mouvement. **Déverrouillage manuel de secours** : connaître et vérifier le déverrouillage (coupure de courant, personne bloquée). **Dispositifs de sécurité obligatoires** : cellules photoélectriques, **bords sensibles**, **limitation d'effort**, feu clignotant — un portail motorisé est une **machine** (Directive Machines, marquage CE, EN 12453/12445) : **essais et mesure d'effort obligatoires après intervention**. **Risques électriques** : le **raccordement électrique** (alimentation, protection 30 mA) est **réservé à un électricien** → voir Électricité. **Manutention** (moteurs, portail lourd) ; **hauteur** éventuelle. **Amiante** (rénovation ancienne) : diagnostic ; retrait réservé à une **entreprise certifiée** (**jamais ici**). **Arrêt immédiat en cas de danger.** `[A]`

## Cadre & suites
- **Normes** : sécurité des portes/portails motorisés — **Directive Machines**, **marquage CE**, cellules / bords sensibles / limitation d'effort — **NF EN 12453 / NF EN 12445 / NF EN 13241** ; alimentation électrique (**interface**) **NF C 15-100** ; structure du portail (**interface** métallerie) **DTU 37.1** ⟦EN 12453/12445 et versions exactes en prose, à confirmer⟧ `[B]` ⟦références/versions exactes à confirmer par le validateur⟧. `respecte-norme`
- **Kit** : `utilise-kit` → [kit-automaticien-portail](../../../kits/automatismes-portails/kit-automaticien-portail.md)

## Relations & tags
- **Tags** : `metier:automatismes-portails famille:specialises sous-famille:automatismes intervention:entretenir intervention:controler cluster:entretien cluster:maintenance cluster:diagnostic cluster:deverrouillage complexite:moyenne type:entretien securite:ecrasement`

## Historique
| Version | Date | Auteur | Validateur | Motif |
|---|---|---|---|---|
| v0.1 | 2026-08-05 | IA | ⟦—⟧ | proposition initiale (Brouillon) |
