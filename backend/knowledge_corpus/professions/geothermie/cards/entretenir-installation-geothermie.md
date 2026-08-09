# Entretenir une installation géothermique (partie captage)

> **Brouillon (v0) — proposé par IA, en attente de validation métier** (Loi 7/18). Modèle : [../../../cards/CARD_TEMPLATE.md](../../../cards/CARD_TEMPLATE.md).
> Niveaux de confiance : A normes/fabricant · B technique · C terrain validé · D hypothèse. Rien n'est publié comme certitude.

## Métadonnées
| Champ | Valeur |
|---|---|
| Identifiant | `entretenir-installation-geothermie` |
| Titre | Entretenir une installation géothermique (partie captage) |
| Profession | `metier:geothermie` |
| Famille | `famille:fluides` |
| Sous-famille | `sous-famille:captage` |
| Version | v0.1 |
| Auteur | IA (proposition) |
| Validateur | ⟦à valider métier⟧ |
| Statut | Brouillon |
| Indice de confiance | **C** |

## Cadrage
- **Objectif** : réaliser l'entretien de la partie captage/hydraulique d'une installation géothermique (hors PAC frigorifique). `[C]`
- **Résumé** : contrôler pression et caloporteur, l'équilibrage, le circulateur et le filtre, sans intervenir sur le circuit frigorifique de la PAC. `[C]`

## Réalisation
- **Étapes** :
  1. Contrôler pression et **fluide caloporteur**. `[C]` → [controler-fluide-caloporteur](controler-fluide-caloporteur.md)
  2. Vérifier le **circulateur** et le filtre. `[C]` → [controler-circulateur-captage](controler-circulateur-captage.md)
  3. Contrôler l'équilibrage et l'étanchéité. `[C]`
  4. PAC (frigorifère) : entretien par un **frigoriste attesté**. `[A]` → [controler-pac-geothermique](controler-pac-geothermique.md)
- **Points critiques** : séparer captage (géothermie) et PAC (F-Gaz) ; caloporteur adapté.
- **Sécurité** : produit ; électrique ; PAC réservée F-Gaz. **Le **forage/captage vertical** relève d'un **foreur qualifié** (réglementation GMI / déclaration) ; la partie **PAC** (circuit frigorifique) est réservée à un **frigoriste attesté F-Gaz** ; le **raccordement électrique** à un intervenant **habilité**.** `[A]`

## Cadre & suites
- **Normes** : installation électrique **NF C 15-100** ; réglementation **géothermie de minime importance (GMI)** ; dimensionnement **NF EN 15450** `[B]` ⟦références/versions exactes à confirmer par le validateur⟧. `respecte-norme`
- **Kit** : `utilise-kit` → [kit-geothermie](../../../kits/geothermie/kit-geothermie.md)

## Relations & tags
- **Tags** : `metier:geothermie equipement:sonde-geothermique famille:fluides sous-famille:captage intervention:entretenir cluster:entretien cluster:maintenance cluster:captage complexite:moyenne type:entretien`

## Historique
| Version | Date | Auteur | Validateur | Motif |
|---|---|---|---|---|
| v0.1 | 2026-08-04 | IA | ⟦—⟧ | proposition initiale (Brouillon) |
