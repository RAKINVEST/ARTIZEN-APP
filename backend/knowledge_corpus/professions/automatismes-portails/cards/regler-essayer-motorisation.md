# Régler et essayer la motorisation (mesure d'effort)

> **Brouillon (v0) — proposé par IA, en attente de validation métier** (Loi 7/18). Modèle : [../../../cards/CARD_TEMPLATE.md](../../../cards/CARD_TEMPLATE.md).
> Niveaux de confiance : A normes/fabricant · B technique · C terrain validé · D hypothèse. Rien n'est publié comme certitude.

## Métadonnées
| Champ | Valeur |
|---|---|
| Identifiant | `regler-essayer-motorisation` |
| Titre | Régler et essayer la motorisation (mesure d'effort) |
| Profession | `metier:automatismes-portails` |
| Famille | `famille:specialises` |
| Sous-famille | `sous-famille:automatismes` |
| Version | v0.1 |
| Auteur | IA (proposition) |
| Validateur | ⟦à valider métier⟧ |
| Statut | Brouillon |
| Indice de confiance | **C** |

## Cadrage
- **Objectif** : régler la motorisation (fins de course, effort, ralentissement) et réaliser les **essais obligatoires** après intervention. `[A]`
- **Résumé** : régler les **fins de course**, la **temporisation**, le **ralentissement** en fin de course et la **limitation d'effort**, apprendre le cycle, puis réaliser les **essais** : test des cellules et bords sensibles, **mesure d'effort** (conformité machine EN 12445), test du **déverrouillage de secours** ; consigner les résultats et informer l'utilisateur. `[A]` ⟦seuils d'effort/temps selon norme et fabricant à confirmer⟧

## Réalisation
- **Étapes** :
  1. Régler fins de course / effort / ralentissement. `[C]`
  2. Tester **cellules** et **bords sensibles**. `[A]`
  3. **Mesure d'effort** (conformité machine). `[A]` → [consignation-essais-avant-apres-intervention](../../../procedures/automatismes-portails/consignation-essais-avant-apres-intervention.md)
  4. Tester le **déverrouillage de secours** ; informer l'usager. `[A]` → [installer-dispositifs-securite](installer-dispositifs-securite.md)
- **Points critiques** : effort/ralentissement conformes ; **essais + mesure d'effort** faits ; déverrouillage testé ; résultats consignés.
- **Sécurité** : mouvement automatique (essais = zone active) ; — ; — **Mouvements automatiques dangereux** : un portail motorisé peut démarrer **seul** (télécommande, horloge, cellule) → **écrasement / cisaillement / entraînement / choc**. **Consignation avant toute intervention** : couper et condamner l'alimentation, neutraliser les commandes, vérifier l'absence de tension/mouvement. **Déverrouillage manuel de secours** : connaître et vérifier le déverrouillage (coupure de courant, personne bloquée). **Dispositifs de sécurité obligatoires** : cellules photoélectriques, **bords sensibles**, **limitation d'effort**, feu clignotant — un portail motorisé est une **machine** (Directive Machines, marquage CE, EN 12453/12445) : **essais et mesure d'effort obligatoires après intervention**. **Risques électriques** : le **raccordement électrique** (alimentation, protection 30 mA) est **réservé à un électricien** → voir Électricité. **Manutention** (moteurs, portail lourd) ; **hauteur** éventuelle. **Amiante** (rénovation ancienne) : diagnostic ; retrait réservé à une **entreprise certifiée** (**jamais ici**). **Arrêt immédiat en cas de danger.** `[A]`

## Cadre & suites
- **Normes** : sécurité des portes/portails motorisés — **Directive Machines**, **marquage CE**, cellules / bords sensibles / limitation d'effort — **NF EN 12453 / NF EN 12445 / NF EN 13241** ; alimentation électrique (**interface**) **NF C 15-100** ; structure du portail (**interface** métallerie) **DTU 37.1** ⟦EN 12453/12445 et versions exactes en prose, à confirmer⟧ `[B]` ⟦références/versions exactes à confirmer par le validateur⟧. `respecte-norme`
- **Accessoires / commandes** : `cite-carte` → [installer-accessoires-commandes](installer-accessoires-commandes.md)

## Relations & tags
- **Tags** : `metier:automatismes-portails famille:specialises sous-famille:automatismes intervention:regler cluster:reglages cluster:essais complexite:avancee type:reglage securite:ecrasement`

## Historique
| Version | Date | Auteur | Validateur | Motif |
|---|---|---|---|---|
| v0.1 | 2026-08-05 | IA | ⟦—⟧ | proposition initiale (Brouillon) |
