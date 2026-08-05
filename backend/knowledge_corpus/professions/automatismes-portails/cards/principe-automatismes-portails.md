# Principe de l'automatisme de portail

> **Brouillon (v0) — proposé par IA, en attente de validation métier** (Loi 7/18). Modèle : [../../../cards/CARD_TEMPLATE.md](../../../cards/CARD_TEMPLATE.md).
> Niveaux de confiance : A normes/fabricant · B technique · C terrain validé · D hypothèse. Rien n'est publié comme certitude.

## Métadonnées
| Champ | Valeur |
|---|---|
| Identifiant | `principe-automatismes-portails` |
| Titre | Principe de l'automatisme de portail |
| Profession | `metier:automatismes-portails` |
| Famille | `famille:specialises` |
| Sous-famille | `sous-famille:automatismes` |
| Version | v0.1 |
| Auteur | IA (proposition) |
| Validateur | ⟦à valider métier⟧ |
| Statut | Brouillon |
| Indice de confiance | **C** |

## Cadrage
- **Objectif** : comprendre la motorisation d'un portail (battant/coulissant/enterré) et le fait qu'un portail motorisé est une **machine**. `[C]`
- **Résumé** : automatiser un portail enchaîne : **analyse de faisabilité** (portail adapté, poids/dimensions, usage), pose de la **motorisation** (battant : vérins/bras ; coulissant : crémaillère ; enterré), **dispositifs de sécurité** obligatoires, **réglages + essais** (mesure d'effort) et accessoires ; la **structure** du portail relève de la **Métallerie**, l'**alimentation** de l'**Électricité** — interfaces. Un portail motorisé = **machine** (Directive Machines, CE). `[C]` ⟦type/motorisation selon portail à confirmer⟧

## Réalisation
- **Étapes** :
  1. **Structure du portail** = Métallerie (interface). `[C]` → [poser-portail-grille-metallique](../../../professions/serrurerie-metallerie/cards/poser-portail-grille-metallique.md)
  2. **Analyser / choisir** la motorisation. `[C]` → [analyser-choisir-motorisation](analyser-choisir-motorisation.md)
  3. **Dispositifs de sécurité** obligatoires. `[A]` → [installer-dispositifs-securite](installer-dispositifs-securite.md)
  4. **Réglages + essais** (mesure d'effort). `[A]` → [regler-essayer-motorisation](regler-essayer-motorisation.md)
- **Points critiques** : portail motorisé = **machine** (CE, essais) ; sécurité (écrasement) ; structure/alimentation = **interfaces** ; consignation.
- **Sécurité** : mouvement automatique (écrasement) ; électrique (interface) ; manutention. **Mouvements automatiques dangereux** : un portail motorisé peut démarrer **seul** (télécommande, horloge, cellule) → **écrasement / cisaillement / entraînement / choc**. **Consignation avant toute intervention** : couper et condamner l'alimentation, neutraliser les commandes, vérifier l'absence de tension/mouvement. **Déverrouillage manuel de secours** : connaître et vérifier le déverrouillage (coupure de courant, personne bloquée). **Dispositifs de sécurité obligatoires** : cellules photoélectriques, **bords sensibles**, **limitation d'effort**, feu clignotant — un portail motorisé est une **machine** (Directive Machines, marquage CE, EN 12453/12445) : **essais et mesure d'effort obligatoires après intervention**. **Risques électriques** : le **raccordement électrique** (alimentation, protection 30 mA) est **réservé à un électricien** → voir Électricité. **Manutention** (moteurs, portail lourd) ; **hauteur** éventuelle. **Amiante** (rénovation ancienne) : diagnostic ; retrait réservé à une **entreprise certifiée** (**jamais ici**). **Arrêt immédiat en cas de danger.** `[A]`

## Cadre & suites
- **Normes** : sécurité des portes/portails motorisés — **Directive Machines**, **marquage CE**, cellules / bords sensibles / limitation d'effort — **NF EN 12453 / NF EN 12445 / NF EN 13241** ; alimentation électrique (**interface**) **NF C 15-100** ; structure du portail (**interface** métallerie) **DTU 37.1** ⟦EN 12453/12445 et versions exactes en prose, à confirmer⟧ `[B]` ⟦références/versions exactes à confirmer par le validateur⟧. `respecte-norme`
- **Entretien / diagnostic** : `cite-carte` → [entretenir-diagnostiquer-automatisme](entretenir-diagnostiquer-automatisme.md)

## Relations & tags
- **Tags** : `metier:automatismes-portails famille:specialises sous-famille:automatismes intervention:comprendre cluster:types-motorisation cluster:faisabilite cluster:securite type:principe securite:ecrasement relation:serrurerie-metallerie`

## Historique
| Version | Date | Auteur | Validateur | Motif |
|---|---|---|---|---|
| v0.1 | 2026-08-05 | IA | ⟦—⟧ | proposition initiale (Brouillon) |
