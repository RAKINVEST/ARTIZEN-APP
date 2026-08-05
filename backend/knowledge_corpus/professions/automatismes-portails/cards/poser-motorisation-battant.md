# Poser une motorisation à battant

> **Brouillon (v0) — proposé par IA, en attente de validation métier** (Loi 7/18). Modèle : [../../../cards/CARD_TEMPLATE.md](../../../cards/CARD_TEMPLATE.md).
> Niveaux de confiance : A normes/fabricant · B technique · C terrain validé · D hypothèse. Rien n'est publié comme certitude.

## Métadonnées
| Champ | Valeur |
|---|---|
| Identifiant | `poser-motorisation-battant` |
| Titre | Poser une motorisation à battant |
| Profession | `metier:automatismes-portails` |
| Famille | `famille:specialises` |
| Sous-famille | `sous-famille:automatismes` |
| Version | v0.1 |
| Auteur | IA (proposition) |
| Validateur | ⟦à valider métier⟧ |
| Statut | Brouillon |
| Indice de confiance | **C** |

## Cadrage
- **Objectif** : poser une motorisation de portail **à battant** (vérins électromécaniques ou bras articulés). `[C]`
- **Résumé** : fixer les **pattes/platines** sur piliers et vantaux (respecter les cotes de pose du fabricant — elles déterminent l'angle et l'effort), poser les **vérins**/**bras**, poser les **butées** d'ouverture/fermeture, tirer les câblages basse tension jusqu'à l'armoire ; l'**alimentation** (arrivée secteur, protection 30 mA) est raccordée par un **électricien** (interface). `[C]` ⟦cotes de pose selon fabricant à confirmer⟧

## Réalisation
- **Étapes** :
  1. Fixer pattes/platines (cotes fabricant). `[C]`
  2. Poser vérins/bras + **butées** d'ouverture/fermeture. `[C]`
  3. Câblage basse tension vers l'armoire. `[C]` → [regler-essayer-motorisation](regler-essayer-motorisation.md)
  4. **Alimentation** (secteur/30 mA) = **Électricité** (interface). `[A]` → [poser-interrupteur-differentiel](../../../professions/electricite-generale/cards/poser-interrupteur-differentiel.md)
- **Points critiques** : **cotes de pose** fabricant (angle/effort) ; butées présentes ; câblage propre ; **alimentation = interface** Élec.
- **Sécurité** : mouvement automatique (écrasement) ; manutention ; électrique (interface). **Mouvements automatiques dangereux** : un portail motorisé peut démarrer **seul** (télécommande, horloge, cellule) → **écrasement / cisaillement / entraînement / choc**. **Consignation avant toute intervention** : couper et condamner l'alimentation, neutraliser les commandes, vérifier l'absence de tension/mouvement. **Déverrouillage manuel de secours** : connaître et vérifier le déverrouillage (coupure de courant, personne bloquée). **Dispositifs de sécurité obligatoires** : cellules photoélectriques, **bords sensibles**, **limitation d'effort**, feu clignotant — un portail motorisé est une **machine** (Directive Machines, marquage CE, EN 12453/12445) : **essais et mesure d'effort obligatoires après intervention**. **Risques électriques** : le **raccordement électrique** (alimentation, protection 30 mA) est **réservé à un électricien** → voir Électricité. **Manutention** (moteurs, portail lourd) ; **hauteur** éventuelle. **Amiante** (rénovation ancienne) : diagnostic ; retrait réservé à une **entreprise certifiée** (**jamais ici**). **Arrêt immédiat en cas de danger.** `[A]`

## Cadre & suites
- **Normes** : sécurité des portes/portails motorisés — **Directive Machines**, **marquage CE**, cellules / bords sensibles / limitation d'effort — **NF EN 12453 / NF EN 12445 / NF EN 13241** ; alimentation électrique (**interface**) **NF C 15-100** ; structure du portail (**interface** métallerie) **DTU 37.1** ⟦EN 12453/12445 et versions exactes en prose, à confirmer⟧ `[B]` ⟦références/versions exactes à confirmer par le validateur⟧. `respecte-norme`
- **Dispositifs de sécurité** : `cite-carte` → [installer-dispositifs-securite](installer-dispositifs-securite.md)

## Relations & tags
- **Tags** : `metier:automatismes-portails famille:specialises sous-famille:automatismes intervention:realiser cluster:motorisation-battant cluster:types-motorisation complexite:avancee type:installation securite:ecrasement relation:electricite-generale`

## Historique
| Version | Date | Auteur | Validateur | Motif |
|---|---|---|---|---|
| v0.1 | 2026-08-05 | IA | ⟦—⟧ | proposition initiale (Brouillon) |
