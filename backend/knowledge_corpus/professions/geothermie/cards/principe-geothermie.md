# Principe de la géothermie de surface

> **Brouillon (v0) — proposé par IA, en attente de validation métier** (Loi 7/18). Modèle : [../../../cards/CARD_TEMPLATE.md](../../../cards/CARD_TEMPLATE.md).
> Niveaux de confiance : A normes/fabricant · B technique · C terrain validé · D hypothèse. Rien n'est publié comme certitude.

## Métadonnées
| Champ | Valeur |
|---|---|
| Identifiant | `principe-geothermie` |
| Titre | Principe de la géothermie de surface |
| Profession | `metier:geothermie` |
| Famille | `famille:fluides` |
| Sous-famille | `sous-famille:geothermie` |
| Version | v0.1 |
| Auteur | IA (proposition) |
| Validateur | ⟦à valider métier⟧ |
| Statut | Brouillon |
| Indice de confiance | **C** |

## Cadrage
- **Objectif** : comprendre une installation de géothermie de surface : **captage** (vertical/horizontal) + **PAC géothermique** + émission. `[C]`
- **Résumé** : un champ de captage (sondes verticales ou capteurs horizontaux) prélève la chaleur du sol via un **fluide caloporteur** ; une **PAC** (équipement, ⟦equipement:pac⟧) l'élève pour le chauffage. `[C]` ⟦schémas/COP selon installation à confirmer⟧

## Réalisation
- **Étapes** :
  1. **Captage vertical** (sondes/forage) ou **horizontal** (capteurs enterrés). `[C]`
  2. Fluide **caloporteur** (eau glycolée) circulant dans le captage. `[C]` → [controler-fluide-caloporteur](controler-fluide-caloporteur.md)
  3. **PAC géothermique** (équipement transversal) — partie frigorifique réservée. `[C]` → [controler-pac-geothermique](../../../professions/pac/cards/controler-pac-geothermique.md)
  4. Émission vers le circuit de chauffage. `[C]`
- **Points critiques** : distinguer **captage** (géothermie), **PAC** (équipement F-Gaz) et **forage** (foreur).
- **Sécurité** : chaque domaine (forage, frigorifique, electrique) releve de sa qualification propre. **Le **forage/captage vertical** relève d'un **foreur qualifié** (réglementation GMI / déclaration) ; la partie **PAC** (circuit frigorifique) est réservée à un **frigoriste attesté F-Gaz** ; le **raccordement électrique** à un intervenant **habilité**.** `[A]`

## Cadre & suites
- **Normes** : installation électrique **NF C 15-100** ; réglementation **géothermie de minime importance (GMI)** ; dimensionnement **NF EN 15450** `[B]` ⟦références/versions exactes à confirmer par le validateur⟧. `respecte-norme`
- **Sécurité liée** : `a-checklist` → [securite-geothermie](../../../checklists/geothermie/securite-geothermie.md)

## Relations & tags
- **Tags** : `metier:geothermie equipement:sonde-geothermique equipement:pac famille:fluides sous-famille:geothermie intervention:comprendre cluster:principe cluster:geothermie-verticale cluster:geothermie-horizontale cluster:captage type:principe`

## Historique
| Version | Date | Auteur | Validateur | Motif |
|---|---|---|---|---|
| v0.1 | 2026-08-04 | IA | ⟦—⟧ | proposition initiale (Brouillon) |
