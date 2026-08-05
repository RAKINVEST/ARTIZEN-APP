# Contrôler le circulateur du circuit de captage

> **Brouillon (v0) — proposé par IA, en attente de validation métier** (Loi 7/18). Modèle : [../../../cards/CARD_TEMPLATE.md](../../../cards/CARD_TEMPLATE.md).
> Niveaux de confiance : A normes/fabricant · B technique · C terrain validé · D hypothèse. Rien n'est publié comme certitude.

## Métadonnées
| Champ | Valeur |
|---|---|
| Identifiant | `controler-circulateur-captage` |
| Titre | Contrôler le circulateur du circuit de captage |
| Profession | `metier:geothermie` |
| Famille | `famille:fluides` |
| Sous-famille | `sous-famille:captage` |
| Version | v0.1 |
| Auteur | IA (proposition) |
| Validateur | ⟦à valider métier⟧ |
| Statut | Brouillon |
| Indice de confiance | **C** |

## Cadrage
- **Objectif** : contrôler la pompe de circulation du circuit de captage (débit, bruit, étanchéité). `[C]`
- **Résumé** : vérifier le fonctionnement, le débit, l'absence d'air/bruit et l'étanchéité ; purger si nécessaire, sans intervenir sur la PAC. `[C]`

## Réalisation
- **Étapes** :
  1. Couper l'alimentation électrique. `[A]`
  2. Vérifier le fonctionnement et le **débit** (réglage vitesse). `[C]`
  3. Purger l'air (bruit/cavitation). `[C]`
  4. Contrôler l'étanchéité. `[C]` → [circulateur-captage-en-defaut](../../../diagnostics/geothermie/circulateur-captage-en-defaut.md)
- **Points critiques** : débit adapté au captage ; air = cavitation/perte de performance.
- **Sécurité** : électricité (consignation) ; raccordement réservé habilité. **Le **forage/captage vertical** relève d'un **foreur qualifié** (réglementation GMI / déclaration) ; la partie **PAC** (circuit frigorifique) est réservée à un **frigoriste attesté F-Gaz** ; le **raccordement électrique** à un intervenant **habilité**.** `[A]`

## Cadre & suites
- **Normes** : installation électrique **NF C 15-100** ; réglementation **géothermie de minime importance (GMI)** ; dimensionnement **NF EN 15450** `[B]` ⟦références/versions exactes à confirmer par le validateur⟧. `respecte-norme`
- **Diagnostics liés** : `traite-diagnostic` → [circulateur-captage-en-defaut](../../../diagnostics/geothermie/circulateur-captage-en-defaut.md)

## Relations & tags
- **Tags** : `metier:geothermie equipement:circulateur famille:fluides sous-famille:captage intervention:controler cluster:pompes-de-circulation cluster:captage cluster:controle complexite:moyenne type:controle securite:electrique`

## Historique
| Version | Date | Auteur | Validateur | Motif |
|---|---|---|---|---|
| v0.1 | 2026-08-04 | IA | ⟦—⟧ | proposition initiale (Brouillon) |
