# Traiter les fissures d'une façade

> **Brouillon (v0) — proposé par IA, en attente de validation métier** (Loi 7/18). Modèle : [../../../cards/CARD_TEMPLATE.md](../../../cards/CARD_TEMPLATE.md).
> Niveaux de confiance : A normes/fabricant · B technique · C terrain validé · D hypothèse. Rien n'est publié comme certitude.

## Métadonnées
| Champ | Valeur |
|---|---|
| Identifiant | `traiter-fissures-facade` |
| Titre | Traiter les fissures d'une façade |
| Profession | `metier:facade` |
| Famille | `famille:enveloppe` |
| Sous-famille | `sous-famille:facade` |
| Version | v0.1 |
| Auteur | IA (proposition) |
| Validateur | ⟦à valider métier⟧ |
| Statut | Brouillon |
| Indice de confiance | **C** |

## Cadrage
- **Objectif** : traiter les fissures d'une façade (microfissures, faïençage) après en avoir qualifié l'origine. `[C]`
- **Résumé** : ouvrir/nettoyer la fissure, appliquer le traitement adapté (pontage souple, revêtement d'imperméabilité, reprise d'enduit), une fissure **structurelle évoluti ve** relevant d'une étude préalable. `[C]` ⟦système/classe de fissuration à confirmer⟧

## Réalisation
- **Étapes** :
  1. Qualifier la fissure (évolutive ? structurelle ?). `[C]` → [fissure-facade](../../../diagnostics/facade/fissure-facade.md)
  2. **Ouvrir/nettoyer** la fissure ; purger le non adhérent. `[C]`
  3. Appliquer **pontage souple** / revêtement d'imperméabilité (**DTU 42.1**). `[B]` ⟦à confirmer⟧
  4. Reprendre la finition (enduit/peinture) ; contrôler l'étanchéité. `[C]` → [reprendre-enduit-facade](reprendre-enduit-facade.md)
- **Points critiques** : une fissure **structurelle évolutive** → étude (ne pas masquer) ; classe de fissuration adaptée au système.
- **Sécurité** : hauteur ; produits (EPI) ; support. **Travail en **hauteur** : risque de **chute** — protections **collectives** (échafaudage/garde-corps) prioritaires, **EPI adaptés**, **météo** (vent/gel/pluie) surveillée. **Stabilité du support** : évaluer l'état du support (purge des parties non adhérentes) avant intervention. **Produits chimiques** (nettoyants, hydrofuges, traitements) : EPI, ventilation, protection de l'environnement. **Arrêt immédiat en cas de danger.** Une intervention en façade relève de **compétences adaptées**.** `[A]`

## Cadre & suites
- **Normes** : enduits de mortiers **DTU 26.1** ; réfection de façades par revêtements d'imperméabilité **DTU 42.1** ; maçonnerie de petits éléments **DTU 20.1** `[B]` ⟦références/versions exactes à confirmer par le validateur⟧. `respecte-norme`
- **Infiltrations liées** : `traite-diagnostic` → [infiltration-facade](../../../diagnostics/facade/infiltration-facade.md)

## Relations & tags
- **Tags** : `metier:facade famille:enveloppe sous-famille:facade intervention:reparer cluster:fissures cluster:reparation cluster:infiltrations complexite:avancee type:reparation securite:hauteur`

## Historique
| Version | Date | Auteur | Validateur | Motif |
|---|---|---|---|---|
| v0.1 | 2026-08-04 | IA | ⟦—⟧ | proposition initiale (Brouillon) |
