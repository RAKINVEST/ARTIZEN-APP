# Diagnostiquer une attaque du bois

> **Brouillon (v0) — proposé par IA, en attente de validation métier** (Loi 7/18). Modèle : [../../../cards/CARD_TEMPLATE.md](../../../cards/CARD_TEMPLATE.md).
> Niveaux de confiance : A normes/fabricant · B technique · C terrain validé · D hypothèse. Rien n'est publié comme certitude.

## Métadonnées
| Champ | Valeur |
|---|---|
| Identifiant | `diagnostiquer-attaque-bois` |
| Titre | Diagnostiquer une attaque du bois |
| Profession | `metier:charpente` |
| Famille | `famille:enveloppe` |
| Sous-famille | `sous-famille:traitement-bois` |
| Version | v0.1 |
| Auteur | IA (proposition) |
| Validateur | ⟦à valider métier⟧ |
| Statut | Brouillon |
| Indice de confiance | **C** |

## Cadrage
- **Objectif** : identifier une attaque biologique du bois (insectes xylophages, champignons) et son étendue. `[C]`
- **Résumé** : repérer les indices (trous, vermoulure, galeries, ramollissement, mycélium), évaluer l'étendue et l'atteinte structurelle, puis orienter vers traitement et/ou renforcement. `[C]` ⟦identification espèce à confirmer par un spécialiste⟧

## Réalisation
- **Étapes** :
  1. Repérer **trous/vermoulure** (insectes) ou **mycélium/ramollissement** (champignon). `[C]`
  2. Sonder le bois (pointe) pour évaluer l'atteinte. `[C]`
  3. Évaluer l'**étendue** et l'impact structurel. `[C]` → [affaissement-charpente](../../../diagnostics/charpente/affaissement-charpente.md)
  4. Orienter : **traitement** et/ou renforcement/remplacement. `[C]` → [traiter-charpente-bois](traiter-charpente-bois.md)
- **Points critiques** : **mérule** = champignon dangereux (déclaration possible) → spécialiste ; termites → cadre réglementaire.
- **Sécurité** : hauteur ; spores/produits (EPI) ; risque structurel si atteinte porteuse. **Travail en **hauteur** : risque de **chute** — EPI antichute, protections/échafaudage, **météo** (vent/gel/pluie) surveillée. **Stabilité de l'ouvrage** : évaluer **charges** et prévoir l'**étaiement** avant toute dépose/coupe d'un élément porteur — ne jamais affaiblir la structure sans étaiement/étude. **Arrêt immédiat en cas de danger** (fissuration, mouvement, doute structurel). Une intervention structurelle relève de **compétences charpente adaptées**.** `[A]`

## Cadre & suites
- **Normes** : charpente et escaliers en bois **DTU 31.1** ; charpentes assemblées par connecteurs **DTU 31.3** ; calcul des structures bois **Eurocode 5 (NF EN 1995)** `[B]` ⟦références/versions exactes à confirmer par le validateur⟧. `respecte-norme`
- **Traitement** : `cite-carte` → [traiter-charpente-bois](traiter-charpente-bois.md)

## Relations & tags
- **Tags** : `metier:charpente famille:enveloppe sous-famille:traitement-bois intervention:diagnostiquer probleme:insectes probleme:champignon cluster:traitement-du-bois cluster:diagnostic complexite:avancee type:diagnostic securite:structure`

## Historique
| Version | Date | Auteur | Validateur | Motif |
|---|---|---|---|---|
| v0.1 | 2026-08-04 | IA | ⟦—⟧ | proposition initiale (Brouillon) |
