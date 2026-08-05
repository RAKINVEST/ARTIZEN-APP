# Installer les dispositifs de sécurité (cellules, bords sensibles, effort)

> **Brouillon (v0) — proposé par IA, en attente de validation métier** (Loi 7/18). Modèle : [../../../cards/CARD_TEMPLATE.md](../../../cards/CARD_TEMPLATE.md).
> Niveaux de confiance : A normes/fabricant · B technique · C terrain validé · D hypothèse. Rien n'est publié comme certitude.

## Métadonnées
| Champ | Valeur |
|---|---|
| Identifiant | `installer-dispositifs-securite` |
| Titre | Installer les dispositifs de sécurité (cellules, bords sensibles, effort) |
| Profession | `metier:automatismes-portails` |
| Famille | `famille:specialises` |
| Sous-famille | `sous-famille:securite` |
| Version | v0.1 |
| Auteur | IA (proposition) |
| Validateur | ⟦à valider métier⟧ |
| Statut | Brouillon |
| Indice de confiance | **B** |

## Cadrage
- **Objectif** : installer les **dispositifs de sécurité obligatoires** d'un portail motorisé (machine) : cellules, bords sensibles, limitation d'effort. `[A]`
- **Résumé** : poser et positionner les **cellules photoélectriques** (détection d'obstacle), les **bords sensibles** (arrêt au contact), le **feu clignotant**, et paramétrer la **limitation d'effort** de l'armoire ; ces protections sont **obligatoires** (portail = machine, Directive Machines / EN 12453) et complètent le déverrouillage de secours ; elles seront **validées par les essais** (mesure d'effort). `[A]` ⟦disposition/nombre de cellules selon configuration à confirmer⟧

## Réalisation
- **Étapes** :
  1. Poser **cellules** photoélectriques (hauteur/portée). `[A]`
  2. Poser **bords sensibles** + feu clignotant. `[A]`
  3. Paramétrer la **limitation d'effort** (armoire). `[A]` → [regler-essayer-motorisation](regler-essayer-motorisation.md)
  4. Vérifier par les **essais** (mesure d'effort). `[A]` → [consignation-essais-avant-apres-intervention](../../../procedures/automatismes-portails/consignation-essais-avant-apres-intervention.md)
- **Points critiques** : **sécurités obligatoires** (cellules/bords/effort) ; conformes machine (EN 12453) ; **validées par essais** ; déverrouillage OK.
- **Sécurité** : mouvement automatique (écrasement) ; électrique (interface) ; — **Mouvements automatiques dangereux** : un portail motorisé peut démarrer **seul** (télécommande, horloge, cellule) → **écrasement / cisaillement / entraînement / choc**. **Consignation avant toute intervention** : couper et condamner l'alimentation, neutraliser les commandes, vérifier l'absence de tension/mouvement. **Déverrouillage manuel de secours** : connaître et vérifier le déverrouillage (coupure de courant, personne bloquée). **Dispositifs de sécurité obligatoires** : cellules photoélectriques, **bords sensibles**, **limitation d'effort**, feu clignotant — un portail motorisé est une **machine** (Directive Machines, marquage CE, EN 12453/12445) : **essais et mesure d'effort obligatoires après intervention**. **Risques électriques** : le **raccordement électrique** (alimentation, protection 30 mA) est **réservé à un électricien** → voir Électricité. **Manutention** (moteurs, portail lourd) ; **hauteur** éventuelle. **Amiante** (rénovation ancienne) : diagnostic ; retrait réservé à une **entreprise certifiée** (**jamais ici**). **Arrêt immédiat en cas de danger.** `[A]`

## Cadre & suites
- **Normes** : sécurité des portes/portails motorisés — **Directive Machines**, **marquage CE**, cellules / bords sensibles / limitation d'effort — **NF EN 12453 / NF EN 12445 / NF EN 13241** ; alimentation électrique (**interface**) **NF C 15-100** ; structure du portail (**interface** métallerie) **DTU 37.1** ⟦EN 12453/12445 et versions exactes en prose, à confirmer⟧ `[B]` ⟦références/versions exactes à confirmer par le validateur⟧. `respecte-norme`
- **Portail qui se rouvre seul** : `cite-diagnostic` → [portail-securite-inverse](../../../diagnostics/automatismes-portails/portail-securite-inverse.md)

## Relations & tags
- **Tags** : `metier:automatismes-portails famille:specialises sous-famille:securite intervention:securiser cluster:securite cluster:dispositifs-securite complexite:avancee type:installation securite:ecrasement`

## Historique
| Version | Date | Auteur | Validateur | Motif |
|---|---|---|---|---|
| v0.1 | 2026-08-05 | IA | ⟦—⟧ | proposition initiale (Brouillon) |
