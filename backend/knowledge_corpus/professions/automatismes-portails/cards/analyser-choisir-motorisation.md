# Analyser et choisir une motorisation

> **Brouillon (v0) — proposé par IA, en attente de validation métier** (Loi 7/18). Modèle : [../../../cards/CARD_TEMPLATE.md](../../../cards/CARD_TEMPLATE.md).
> Niveaux de confiance : A normes/fabricant · B technique · C terrain validé · D hypothèse. Rien n'est publié comme certitude.

## Métadonnées
| Champ | Valeur |
|---|---|
| Identifiant | `analyser-choisir-motorisation` |
| Titre | Analyser et choisir une motorisation |
| Profession | `metier:automatismes-portails` |
| Famille | `famille:specialises` |
| Sous-famille | `sous-famille:automatismes` |
| Version | v0.1 |
| Auteur | IA (proposition) |
| Validateur | ⟦à valider métier⟧ |
| Statut | Brouillon |
| Indice de confiance | **C** |

## Cadrage
- **Objectif** : analyser la faisabilité et choisir la **motorisation** adaptée (type de portail, poids/dimensions, usage, énergie). `[C]`
- **Résumé** : évaluer le **portail existant** (état, poids, dimensions, aplomb — un portail en mauvais état doit d'abord être repris par la **Métallerie**), le **type** (battant/coulissant), l'**usage** (fréquence, résidentiel/collectif), l'**énergie disponible** (secteur/solaire/batterie) et le passage des **gaines** (→ Terrassement) ; en déduire le moteur, les sécurités et les accessoires. `[C]` ⟦critères/dimensionnement selon fabricant à confirmer⟧

## Réalisation
- **Étapes** :
  1. Évaluer le **portail** (état/poids/aplomb) — reprise = Métallerie. `[C]`
  2. Déterminer type/usage/énergie ; passage des **gaines** (→ Terrassement). `[C]` → [realiser-fouille-tranchee](../../../professions/terrassement/cards/realiser-fouille-tranchee.md)
  3. Choisir moteur + **sécurités** obligatoires. `[A]` → [installer-dispositifs-securite](installer-dispositifs-securite.md)
  4. Choisir la pose (battant / coulissant). `[C]` → [poser-motorisation-battant](poser-motorisation-battant.md)
- **Points critiques** : portail sain (sinon Métallerie) ; motorisation **dimensionnée** (poids/usage) ; sécurités prévues ; gaines = Terrassement.
- **Sécurité** : manutention (évaluation) ; — ; — **Mouvements automatiques dangereux** : un portail motorisé peut démarrer **seul** (télécommande, horloge, cellule) → **écrasement / cisaillement / entraînement / choc**. **Consignation avant toute intervention** : couper et condamner l'alimentation, neutraliser les commandes, vérifier l'absence de tension/mouvement. **Déverrouillage manuel de secours** : connaître et vérifier le déverrouillage (coupure de courant, personne bloquée). **Dispositifs de sécurité obligatoires** : cellules photoélectriques, **bords sensibles**, **limitation d'effort**, feu clignotant — un portail motorisé est une **machine** (Directive Machines, marquage CE, EN 12453/12445) : **essais et mesure d'effort obligatoires après intervention**. **Risques électriques** : le **raccordement électrique** (alimentation, protection 30 mA) est **réservé à un électricien** → voir Électricité. **Manutention** (moteurs, portail lourd) ; **hauteur** éventuelle. **Amiante** (rénovation ancienne) : diagnostic ; retrait réservé à une **entreprise certifiée** (**jamais ici**). **Arrêt immédiat en cas de danger.** `[A]`

## Cadre & suites
- **Normes** : sécurité des portes/portails motorisés — **Directive Machines**, **marquage CE**, cellules / bords sensibles / limitation d'effort — **NF EN 12453 / NF EN 12445 / NF EN 13241** ; alimentation électrique (**interface**) **NF C 15-100** ; structure du portail (**interface** métallerie) **DTU 37.1** ⟦EN 12453/12445 et versions exactes en prose, à confirmer⟧ `[B]` ⟦références/versions exactes à confirmer par le validateur⟧. `respecte-norme`
- **Pose coulissante** : `cite-carte` → [poser-motorisation-coulissant](poser-motorisation-coulissant.md)

## Relations & tags
- **Tags** : `metier:automatismes-portails famille:specialises sous-famille:automatismes intervention:comprendre cluster:faisabilite cluster:types-motorisation complexite:moyenne type:conception securite:manutention relation:terrassement relation:serrurerie-metallerie`

## Historique
| Version | Date | Auteur | Validateur | Motif |
|---|---|---|---|---|
| v0.1 | 2026-08-05 | IA | ⟦—⟧ | proposition initiale (Brouillon) |
