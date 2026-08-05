# Mettre en service la boucle de captage géothermique

> **Brouillon (v0) — proposé par IA, en attente de validation métier** (Loi 7/18). Modèle : [../../../cards/CARD_TEMPLATE.md](../../../cards/CARD_TEMPLATE.md).
> Niveaux de confiance : A normes/fabricant · B technique · C terrain validé · D hypothèse. Rien n'est publié comme certitude.

## Métadonnées
| Champ | Valeur |
|---|---|
| Identifiant | `mettre-en-service-boucle-geothermie` |
| Titre | Mettre en service la boucle de captage géothermique |
| Profession | `metier:geothermie` |
| Famille | `famille:fluides` |
| Sous-famille | `sous-famille:captage` |
| Version | v0.1 |
| Auteur | IA (proposition) |
| Validateur | ⟦à valider métier⟧ |
| Statut | Brouillon |
| Indice de confiance | **C** |

## Cadrage
- **Objectif** : mettre en service le circuit de captage (remplissage, purge, pression, équilibrage) — hors forage et hors PAC frigorifique. `[C]`
- **Résumé** : remplir le circuit avec le fluide caloporteur, purger l'air, régler la pression et équilibrer les boucles, contrôler l'étanchéité avant couplage à la PAC (par le frigoriste). `[C]`

## Réalisation
- **Étapes** :
  1. Remplir avec le **fluide caloporteur** doseé. `[C]` → [remplissage-boucle-captage](../../../procedures/geothermie/remplissage-boucle-captage.md)
  2. **Purger** l'air, régler la pression. `[C]`
  3. Équilibrer les boucles au collecteur. `[C]` → [controler-collecteur-geothermie](controler-collecteur-geothermie.md)
  4. Contrôler l'étanchéité ; couplage PAC par le **frigoriste attesté**. `[A]` → [controler-pac-geothermique](../../../professions/pac/cards/controler-pac-geothermique.md)
- **Points critiques** : purge complète ; équilibrage ; le couplage à la PAC relève du frigoriste.
- **Sécurité** : produit caloporteur (EPI/env.) ; PAC frigorifique réservée F-Gaz. **Le **forage/captage vertical** relève d'un **foreur qualifié** (réglementation GMI / déclaration) ; la partie **PAC** (circuit frigorifique) est réservée à un **frigoriste attesté F-Gaz** ; le **raccordement électrique** à un intervenant **habilité**.** `[A]`

## Cadre & suites
- **Normes** : installation électrique **NF C 15-100** ; réglementation **géothermie de minime importance (GMI)** ; dimensionnement **NF EN 15450** `[B]` ⟦références/versions exactes à confirmer par le validateur⟧. `respecte-norme`
- **Contrôle** : `a-checklist` → [controle-maintenance-geothermie](../../../checklists/geothermie/controle-maintenance-geothermie.md)

## Relations & tags
- **Tags** : `metier:geothermie equipement:sonde-geothermique equipement:pac famille:fluides sous-famille:captage intervention:mettre-en-service cluster:mise-en-service cluster:captage complexite:avancee type:mise-en-service`

## Historique
| Version | Date | Auteur | Validateur | Motif |
|---|---|---|---|---|
| v0.1 | 2026-08-04 | IA | ⟦—⟧ | proposition initiale (Brouillon) |
