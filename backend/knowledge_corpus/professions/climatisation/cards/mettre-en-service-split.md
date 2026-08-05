# Mettre en service un split (partie accessible)

> **Brouillon (v0) — proposé par IA, en attente de validation métier** (Loi 7/18). Modèle : [../../../cards/CARD_TEMPLATE.md](../../../cards/CARD_TEMPLATE.md).
> Niveaux de confiance : A normes/fabricant · B technique · C terrain validé · D hypothèse. Rien n'est publié comme certitude.

## Métadonnées
| Champ | Valeur |
|---|---|
| Identifiant | `mettre-en-service-split` |
| Titre | Mettre en service un split (partie accessible) |
| Profession | `metier:climatisation` |
| Famille | `famille:fluides` |
| Sous-famille | `sous-famille:climatisation` |
| Version | v0.1 |
| Auteur | IA (proposition) |
| Validateur | ⟦à valider métier⟧ |
| Statut | Brouillon |
| Indice de confiance | **C** |

## Cadrage
- **Objectif** : mettre en service la partie accessible d'un split — la **liaison frigorifère et la mise en route sont réservées à un frigoriste attesté F-Gaz**. `[C]`
- **Résumé** : vérifier fixations, condensats et alimentation, faire réaliser le **tirage au vide / contrôle frigorifère** par un attesté, puis contrôler le fonctionnement et paramétrer. `[C]` ⟦procédure détaillée selon fabricant à confirmer⟧

## Réalisation
- **Étapes** :
  1. Vérifier fixations des unités et l'évacuation des **condensats**. `[C]` → [controler-evacuation-condensats](controler-evacuation-condensats.md)
  2. Vérifier l'alimentation électrique (par un intervenant habilité). `[A]`
  3. **Tirage au vide + mise en gaz + contrôle d'étanchéité** par un frigoriste **attesté F-Gaz**. `[A]`
  4. Contrôler le fonctionnement (froid/chaud) et paramétrer la régulation. `[C]` → [controle-avant-mise-en-service-clim](../../../checklists/climatisation/controle-avant-mise-en-service-clim.md)
- **Points critiques** : la partie **frigorifère** est réservée qualifiée ; évacuation des condensats correcte. `[B]`
- **Sécurité** : électricité + frigorifère réglementé. **Le circuit frigorifère contient un fluide réglementé sous pression : toute manipulation (charge, récupération, brasage) exige une **attestation de capacité F-Gaz** et l'outillage dédié — hors périmètre sans qualification.** `[A]`

## Cadre & suites
- **Normes** : climatiseurs à détente directe **DTU 65.16** `[B]` ⟦références/versions exactes à confirmer par le validateur⟧. `respecte-norme`
- **Diagnostics liés** : `traite-diagnostic` → [clim-ne-refroidit-pas](../../../diagnostics/climatisation/clim-ne-refroidit-pas.md)

## Relations & tags
- **Tags** : `metier:climatisation equipement:climatiseur famille:fluides sous-famille:climatisation intervention:mettre-en-service cluster:mise-en-service complexite:avancee type:mise-en-service securite:frigorifique`

## Historique
| Version | Date | Auteur | Validateur | Motif |
|---|---|---|---|---|
| v0.1 | 2026-08-04 | IA | ⟦—⟧ | proposition initiale (Brouillon) |
