# Renforcer une panne / un élément de ferme

> **Brouillon (v0) — proposé par IA, en attente de validation métier** (Loi 7/18). Modèle : [../../../cards/CARD_TEMPLATE.md](../../../cards/CARD_TEMPLATE.md).
> Niveaux de confiance : A normes/fabricant · B technique · C terrain validé · D hypothèse. Rien n'est publié comme certitude.

## Métadonnées
| Champ | Valeur |
|---|---|
| Identifiant | `renforcer-panne-ferme` |
| Titre | Renforcer une panne / un élément de ferme |
| Profession | `metier:charpente` |
| Famille | `famille:enveloppe` |
| Sous-famille | `sous-famille:charpente` |
| Version | v0.1 |
| Auteur | IA (proposition) |
| Validateur | ⟦à valider métier⟧ |
| Statut | Brouillon |
| Indice de confiance | **C** |

## Cadrage
- **Objectif** : renforcer un élément porteur affaibli (panne, arbalétrier, entrait) — opération **structurelle** relevant d'une étude. `[C]`
- **Résumé** : après **étude/diagnostic structurel**, mettre en place l'étaiement, renforcer (moisage, prothèse, ferrure) selon prescription, contrôler la reprise de charge. `[C]` ⟦solution/dimensionnement par un bureau d'études à confirmer⟧

## Réalisation
- **Étapes** :
  1. **Étude structurelle** préalable (bureau d'études / charpentier qualifié). `[A]` ⟦requis⟧
  2. Mettre en place l'**étaiement**. `[A]` → [etaiement-avant-intervention](../../../procedures/charpente/etaiement-avant-intervention.md)
  3. Renforcer (**moisage**, prothèse, ferrures) selon prescription. `[B]` ⟦à confirmer⟧
  4. Contrôler la reprise de charge et retirer l'étaiement **progressivement**. `[B]`
- **Points critiques** : opération **structurelle** → étude obligatoire ; étaiement ; ne jamais improviser un renfort porteur.
- **Sécurité** : hauteur ; **stabilité** ; charges ; étaiement ; arrêt si mouvement. **Travail en **hauteur** : risque de **chute** — EPI antichute, protections/échafaudage, **météo** (vent/gel/pluie) surveillée. **Stabilité de l'ouvrage** : évaluer **charges** et prévoir l'**étaiement** avant toute dépose/coupe d'un élément porteur — ne jamais affaiblir la structure sans étaiement/étude. **Arrêt immédiat en cas de danger** (fissuration, mouvement, doute structurel). Une intervention structurelle relève de **compétences charpente adaptées**.** `[A]`

## Cadre & suites
- **Normes** : charpente et escaliers en bois **DTU 31.1** ; charpentes assemblées par connecteurs **DTU 31.3** ; calcul des structures bois **Eurocode 5 (NF EN 1995)** `[B]` ⟦références/versions exactes à confirmer par le validateur⟧. `respecte-norme`
- **Diagnostics liés** : `traite-diagnostic` → [affaissement-charpente](../../../diagnostics/charpente/affaissement-charpente.md)

## Relations & tags
- **Tags** : `metier:charpente equipement:ferme equipement:panne famille:enveloppe sous-famille:charpente intervention:reparer intervention:renforcer cluster:fermes cluster:pannes cluster:reparation complexite:expert type:reparation securite:hauteur securite:structure`

## Historique
| Version | Date | Auteur | Validateur | Motif |
|---|---|---|---|---|
| v0.1 | 2026-08-04 | IA | ⟦—⟧ | proposition initiale (Brouillon) |
