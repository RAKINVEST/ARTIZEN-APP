# Diagnostiquer une façade

> **Brouillon (v0) — proposé par IA, en attente de validation métier** (Loi 7/18). Modèle : [../../../cards/CARD_TEMPLATE.md](../../../cards/CARD_TEMPLATE.md).
> Niveaux de confiance : A normes/fabricant · B technique · C terrain validé · D hypothèse. Rien n'est publié comme certitude.

## Métadonnées
| Champ | Valeur |
|---|---|
| Identifiant | `diagnostiquer-facade` |
| Titre | Diagnostiquer une façade |
| Profession | `metier:facade` |
| Famille | `famille:enveloppe` |
| Sous-famille | `sous-famille:facade` |
| Version | v0.1 |
| Auteur | IA (proposition) |
| Validateur | ⟦à valider métier⟧ |
| Statut | Brouillon |
| Indice de confiance | **C** |

## Cadrage
- **Objectif** : réaliser le diagnostic d'une façade (fissures, infiltrations, décollement, état du support) avant toute réfection. `[C]`
- **Résumé** : observer et sonder la façade pour repérer fissures, humidité/infiltrations, décollements et zones non adhérentes, qualifier la gravité et orienter vers la réparation adaptée. `[C]`

## Réalisation
- **Étapes** :
  1. Sécuriser l'accès (protections, EPI). `[A]`
  2. Repérer et qualifier les **fissures**. `[C]` → [fissure-facade](../../../diagnostics/facade/fissure-facade.md)
  3. Rechercher **infiltrations/humidité**. `[C]` → [infiltration-facade](../../../diagnostics/facade/infiltration-facade.md)
  4. **Sonder** le revêtement (décollement, sonorité creuse). `[C]` → [decollement-enduit-cloque](../../../diagnostics/facade/decollement-enduit-cloque.md)
- **Points critiques** : distinguer fissure **structurelle** (→ étude) et de revêtement ; localiser l'origine de l'eau.
- **Sécurité** : hauteur ; stabilité du support évaluée avant de s'appuyer. **Travail en **hauteur** : risque de **chute** — protections **collectives** (échafaudage/garde-corps) prioritaires, **EPI adaptés**, **météo** (vent/gel/pluie) surveillée. **Stabilité du support** : évaluer l'état du support (purge des parties non adhérentes) avant intervention. **Produits chimiques** (nettoyants, hydrofuges, traitements) : EPI, ventilation, protection de l'environnement. **Arrêt immédiat en cas de danger.** Une intervention en façade relève de **compétences adaptées**.** `[A]`

## Cadre & suites
- **Normes** : enduits de mortiers **DTU 26.1** ; réfection de façades par revêtements d'imperméabilité **DTU 42.1** ; maçonnerie de petits éléments **DTU 20.1** `[B]` ⟦références/versions exactes à confirmer par le validateur⟧. `respecte-norme`
- **Contrôle** : `cite-procedure` → [controle-facade-avant-reprise](../../../procedures/facade/controle-facade-avant-reprise.md)

## Relations & tags
- **Tags** : `metier:facade famille:enveloppe sous-famille:facade intervention:diagnostiquer intervention:controler cluster:diagnostic cluster:controle cluster:fissures cluster:infiltrations complexite:moyenne type:diagnostic securite:hauteur`

## Historique
| Version | Date | Auteur | Validateur | Motif |
|---|---|---|---|---|
| v0.1 | 2026-08-04 | IA | ⟦—⟧ | proposition initiale (Brouillon) |
