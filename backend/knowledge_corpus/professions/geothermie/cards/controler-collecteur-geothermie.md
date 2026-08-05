# Contrôler un collecteur géothermique

> **Brouillon (v0) — proposé par IA, en attente de validation métier** (Loi 7/18). Modèle : [../../../cards/CARD_TEMPLATE.md](../../../cards/CARD_TEMPLATE.md).
> Niveaux de confiance : A normes/fabricant · B technique · C terrain validé · D hypothèse. Rien n'est publié comme certitude.

## Métadonnées
| Champ | Valeur |
|---|---|
| Identifiant | `controler-collecteur-geothermie` |
| Titre | Contrôler un collecteur géothermique |
| Profession | `metier:geothermie` |
| Famille | `famille:fluides` |
| Sous-famille | `sous-famille:captage` |
| Version | v0.1 |
| Auteur | IA (proposition) |
| Validateur | ⟦à valider métier⟧ |
| Statut | Brouillon |
| Indice de confiance | **C** |

## Cadrage
- **Objectif** : contrôler le collecteur reliant les boucles de captage (équilibrage, débits, étanchéité). `[C]`
- **Résumé** : vérifier les débits par boucle, l'équilibrage, l'étanchéité des raccords et le repérage au collecteur. `[C]`

## Réalisation
- **Étapes** :
  1. Repérer les boucles au **collecteur**. `[C]`
  2. Contrôler les **débits** par boucle (débitmètres). `[C]`
  3. Équilibrer si nécessaire. `[C]`
  4. Contrôler l'étanchéité des raccords. `[C]`
- **Points critiques** : équilibrage entre boucles = performance ; repérage indispensable.
- **Sécurité** : circuit sous pression. **Le **forage/captage vertical** relève d'un **foreur qualifié** (réglementation GMI / déclaration) ; la partie **PAC** (circuit frigorifique) est réservée à un **frigoriste attesté F-Gaz** ; le **raccordement électrique** à un intervenant **habilité**.** `[A]`

## Cadre & suites
- **Normes** : installation électrique **NF C 15-100** ; réglementation **géothermie de minime importance (GMI)** ; dimensionnement **NF EN 15450** `[B]` ⟦références/versions exactes à confirmer par le validateur⟧. `respecte-norme`
- **Champ de captage** : `cite-carte` → [controler-champ-de-captage](controler-champ-de-captage.md)

## Relations & tags
- **Tags** : `metier:geothermie equipement:collecteur famille:fluides sous-famille:captage intervention:controler cluster:collecteurs cluster:captage cluster:controle complexite:moyenne type:controle`

## Historique
| Version | Date | Auteur | Validateur | Motif |
|---|---|---|---|---|
| v0.1 | 2026-08-04 | IA | ⟦—⟧ | proposition initiale (Brouillon) |
