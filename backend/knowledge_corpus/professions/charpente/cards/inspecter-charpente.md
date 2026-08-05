# Inspecter une charpente

> **Brouillon (v0) — proposé par IA, en attente de validation métier** (Loi 7/18). Modèle : [../../../cards/CARD_TEMPLATE.md](../../../cards/CARD_TEMPLATE.md).
> Niveaux de confiance : A normes/fabricant · B technique · C terrain validé · D hypothèse. Rien n'est publié comme certitude.

## Métadonnées
| Champ | Valeur |
|---|---|
| Identifiant | `inspecter-charpente` |
| Titre | Inspecter une charpente |
| Profession | `metier:charpente` |
| Famille | `famille:enveloppe` |
| Sous-famille | `sous-famille:charpente` |
| Version | v0.1 |
| Auteur | IA (proposition) |
| Validateur | ⟦à valider métier⟧ |
| Statut | Brouillon |
| Indice de confiance | **C** |

## Cadrage
- **Objectif** : réaliser l'inspection visuelle d'une charpente (déformations, humidité, attaques du bois, assemblages). `[C]`
- **Résumé** : contrôler les déformations, l'humidité, les traces d'attaque biologique et l'état des assemblages/appuis, en sécurité, et orienter vers diagnostic/réparation. `[C]`

## Réalisation
- **Étapes** :
  1. Sécuriser l'accès (hauteur, éclairage). `[A]`
  2. Rechercher **déformations** (flèche, déversement) et fissures. `[C]` → [affaissement-charpente](../../../diagnostics/charpente/affaissement-charpente.md)
  3. Contrôler l'**humidité** et les traces d'attaque (insectes/champignons). `[C]` → [diagnostiquer-attaque-bois](diagnostiquer-attaque-bois.md)
  4. Vérifier **assemblages**, appuis et sablières. `[C]` → [controler-assemblages](controler-assemblages.md)
- **Points critiques** : distinguer désordre esthétique et **structurel** ; doute → étude.
- **Sécurité** : hauteur ; évaluer la stabilité avant de circuler sur l'ouvrage. **Travail en **hauteur** : risque de **chute** — EPI antichute, protections/échafaudage, **météo** (vent/gel/pluie) surveillée. **Stabilité de l'ouvrage** : évaluer **charges** et prévoir l'**étaiement** avant toute dépose/coupe d'un élément porteur — ne jamais affaiblir la structure sans étaiement/étude. **Arrêt immédiat en cas de danger** (fissuration, mouvement, doute structurel). Une intervention structurelle relève de **compétences charpente adaptées**.** `[A]`

## Cadre & suites
- **Normes** : charpente et escaliers en bois **DTU 31.1** ; charpentes assemblées par connecteurs **DTU 31.3** ; calcul des structures bois **Eurocode 5 (NF EN 1995)** `[B]` ⟦références/versions exactes à confirmer par le validateur⟧. `respecte-norme`
- **Contrôle** : `a-checklist` → [inspection-controle-charpente](../../../checklists/charpente/inspection-controle-charpente.md)

## Relations & tags
- **Tags** : `metier:charpente famille:enveloppe sous-famille:charpente intervention:controler intervention:inspecter cluster:inspection cluster:diagnostic cluster:controle complexite:moyenne type:controle securite:hauteur securite:structure`

## Historique
| Version | Date | Auteur | Validateur | Motif |
|---|---|---|---|---|
| v0.1 | 2026-08-04 | IA | ⟦—⟧ | proposition initiale (Brouillon) |
