# Traiter une charpente en bois (curatif / préventif)

> **Brouillon (v0) — proposé par IA, en attente de validation métier** (Loi 7/18). Modèle : [../../../cards/CARD_TEMPLATE.md](../../../cards/CARD_TEMPLATE.md).
> Niveaux de confiance : A normes/fabricant · B technique · C terrain validé · D hypothèse. Rien n'est publié comme certitude.

## Métadonnées
| Champ | Valeur |
|---|---|
| Identifiant | `traiter-charpente-bois` |
| Titre | Traiter une charpente en bois (curatif / préventif) |
| Profession | `metier:charpente` |
| Famille | `famille:enveloppe` |
| Sous-famille | `sous-famille:traitement-bois` |
| Version | v0.1 |
| Auteur | IA (proposition) |
| Validateur | ⟦à valider métier⟧ |
| Statut | Brouillon |
| Indice de confiance | **C** |

## Cadrage
- **Objectif** : traiter une charpente contre les attaques biologiques (insectes/champignons) en curatif et/ou préventif. `[C]`
- **Résumé** : préparer (bûchage des parties atteintes), appliquer le produit adapté (pulvérisation/injection) selon la classe d'emploi et les préconisations, en respectant sécurité et environnement. `[C]` ⟦produit/dosage/DTA à confirmer⟧

## Réalisation
- **Étapes** :
  1. Identifier l'attaque et l'étendue. `[C]` → [diagnostiquer-attaque-bois](diagnostiquer-attaque-bois.md)
  2. **Bûcher** les parties fortement atteintes ; dépoussiérer. `[C]`
  3. Appliquer le produit (pulvérisation/**injection**) selon préconisations. `[C]` ⟦produit certifié à confirmer⟧
  4. Évaluer si **renforcement/remplacement** structurel nécessaire. `[C]`
- **Points critiques** : un bois structurellement atteint doit être **renforcé/remplacé**, pas seulement traité ; classe d'emploi adaptée.
- **Sécurité** : produits biocides (EPI, ventilation, environnement) ; hauteur ; structure. **Travail en **hauteur** : risque de **chute** — EPI antichute, protections/échafaudage, **météo** (vent/gel/pluie) surveillée. **Stabilité de l'ouvrage** : évaluer **charges** et prévoir l'**étaiement** avant toute dépose/coupe d'un élément porteur — ne jamais affaiblir la structure sans étaiement/étude. **Arrêt immédiat en cas de danger** (fissuration, mouvement, doute structurel). Une intervention structurelle relève de **compétences charpente adaptées**.** `[A]`

## Cadre & suites
- **Normes** : charpente et escaliers en bois **DTU 31.1** ; charpentes assemblées par connecteurs **DTU 31.3** ; calcul des structures bois **Eurocode 5 (NF EN 1995)** `[B]` ⟦références/versions exactes à confirmer par le validateur⟧. `respecte-norme`
- **Diagnostics liés** : `traite-diagnostic` → [bois-humide-champignon](../../../diagnostics/charpente/bois-humide-champignon.md)

## Relations & tags
- **Tags** : `metier:charpente famille:enveloppe sous-famille:traitement-bois intervention:entretenir intervention:traiter cluster:traitement-du-bois cluster:maintenance probleme:insectes probleme:champignon complexite:avancee type:entretien securite:structure`

## Historique
| Version | Date | Auteur | Validateur | Motif |
|---|---|---|---|---|
| v0.1 | 2026-08-04 | IA | ⟦—⟧ | proposition initiale (Brouillon) |
