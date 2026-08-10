# Contrôler l'étanchéité frigorifère (climatiseur)

> **Brouillon (v0) — proposé par IA, en attente de validation métier** (Loi 7/18). Modèle : [../../../cards/CARD_TEMPLATE.md](../../../cards/CARD_TEMPLATE.md).
> Niveaux de confiance : A normes/fabricant · B technique · C terrain validé · D hypothèse. Rien n'est publié comme certitude.

## Métadonnées
| Champ | Valeur |
|---|---|
| Identifiant | `controler-circuit-frigorifique-clim` |
| Titre | Contrôler l'étanchéité frigorifère (climatiseur) |
| Profession | `metier:climatisation` |
| Famille | `famille:fluides` |
| Sous-famille | `sous-famille:frigorifique` |
| Version | v0.1 |
| Auteur | IA (proposition) |
| Validateur | ⟦à valider métier⟧ |
| Statut | Brouillon |
| Indice de confiance | **C** |

## Cadrage
- **Objectif** : réaliser le **contrôle d'étanchéité** réglementaire du circuit frigorifère — **réservé à un frigoriste attesté F-Gaz**. `[B]`
- **Résumé** : le contrôle d'étanchéité périodique est **obligatoire** au-delà d'un seuil de charge (équivalent CO₂, règlement F-Gaz) et nécessite une attestation de capacité. `[B]` ⟦seuils/périodicité exacts à confirmer⟧

## Réalisation
- **Étapes** :
  1. **Prérequis : attestation de capacité F-Gaz** + outillage dédié. `[A]`
  2. Vérifier l'absence de fuite (détecteur adapté au fluide). `[B]`
  3. Consigner le contrôle (fiche/registre). `[B]` ⟦cadre réglementaire à confirmer⟧
- **Points critiques** : **tout acte frigorifère sans qualification F-Gaz est proscrit** ; fluide sous pression. `[A]`
- **Sécurité** : **Le circuit frigorifère contient un fluide réglementé sous pression : toute manipulation (charge, récupération, brasage) exige une **attestation de capacité F-Gaz** et l'outillage dédié — hors périmètre sans qualification.** `[A]`

## Cadre & suites
- **Normes** : climatiseurs **et PAC** à détente directe / systèmes frigorifères **DTU 65.16** ; réglementation **F-Gaz** (UE 517/2014) ⟦à confirmer⟧ `[B]` ⟦références/versions exactes à confirmer par le validateur⟧. `respecte-norme`
- **Sécurité** : `a-checklist` → [securite-frigorifique-clim](../../../checklists/climatisation/securite-frigorifique-clim.md)

## Relations & tags
- **Tags** : `metier:climatisation equipement:climatiseur equipement:pac famille:fluides sous-famille:frigorifique intervention:controler cluster:frigorifique cluster:securite cluster:normes securite:frigorifique complexite:expert type:controle`

## Historique
| Version | Date | Auteur | Validateur | Motif |
|---|---|---|---|---|
| v0.1 | 2026-08-04 | IA | ⟦—⟧ | proposition initiale (Brouillon) |
