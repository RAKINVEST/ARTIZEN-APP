# Paramétrer la régulation d'une installation de froid

> **Brouillon (v0) — proposé par IA, en attente de validation métier** (Loi 7/18). Modèle : [../../../cards/CARD_TEMPLATE.md](../../../cards/CARD_TEMPLATE.md).
> Niveaux de confiance : A normes/fabricant · B technique · C terrain validé · D hypothèse. Rien n'est publié comme certitude.

## Métadonnées
| Champ | Valeur |
|---|---|
| Identifiant | `parametrer-regulation-froid` |
| Titre | Paramétrer la régulation d'une installation de froid |
| Profession | `metier:froid` |
| Famille | `famille:fluides` |
| Sous-famille | `sous-famille:froid-commercial` |
| Version | v0.1 |
| Auteur | IA (proposition) |
| Validateur | ⟦à valider métier⟧ |
| Statut | Brouillon |
| Indice de confiance | **C** |

## Cadrage
- **Objectif** : contrôler et ajuster les paramètres du régulateur (consigne, dégivrage, alarmes) selon les denrées et le fabricant. `[C]`
- **Résumé** : vérifier la consigne de température, les paramètres de dégivrage (fréquence/durée), les alarmes haute température, et l'enregistrement, selon la doc fabricant. `[C]` ⟦valeurs selon denrées/fabricant à confirmer⟧

## Réalisation
- **Étapes** :
  1. Relever la **consigne** et la température réelle. `[C]`
  2. Contrôler les paramètres de **dégivrage** (fréquence, durée, mode). `[C]`
  3. Vérifier les **alarmes** haute température et leur report. `[B]`
  4. Vérifier l'enregistrement des températures (traçabilité). `[C]`
- **Points critiques** : consigne adaptée aux **denrées** ; alarmes actives ; traçabilité (chaîne du froid).
- **Sécurité** : paramétrage électronique ; ne pas toucher au circuit frigorifique ;  **Toute manipulation du circuit frigorifique (compresseur, détendeur, charge, récupération, brasage) est **réservée à un frigoriste disposant de l'attestation de capacité F-Gaz**. Ne jamais ouvrir le circuit sans qualification.** `[A]`

## Cadre & suites
- **Normes** : sécurité des systèmes frigorifiques **NF EN 378** ; installation électrique **NF C 15-100** ; réglementation **F-Gaz** (UE 517/2014) `[B]` ⟦références/versions exactes à confirmer par le validateur⟧. `respecte-norme`
- **Contrôle** : `cite-procedure` → [controle-chaine-du-froid](../../../procedures/froid/controle-chaine-du-froid.md)

## Relations & tags
- **Tags** : `metier:froid equipement:regulateur famille:fluides sous-famille:froid-commercial intervention:regler cluster:regulation cluster:controle complexite:moyenne type:reglage securite:frigorifique`

## Historique
| Version | Date | Auteur | Validateur | Motif |
|---|---|---|---|---|
| v0.1 | 2026-08-04 | IA | ⟦—⟧ | proposition initiale (Brouillon) |
