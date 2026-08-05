# Contrôler une façade ITE (côté finition)

> **Brouillon (v0) — proposé par IA, en attente de validation métier** (Loi 7/18). Modèle : [../../../cards/CARD_TEMPLATE.md](../../../cards/CARD_TEMPLATE.md).
> Niveaux de confiance : A normes/fabricant · B technique · C terrain validé · D hypothèse. Rien n'est publié comme certitude.

## Métadonnées
| Champ | Valeur |
|---|---|
| Identifiant | `controler-ite-facade` |
| Titre | Contrôler une façade ITE (côté finition) |
| Profession | `metier:facade` |
| Famille | `famille:enveloppe` |
| Sous-famille | `sous-famille:facade` |
| Version | v0.1 |
| Auteur | IA (proposition) |
| Validateur | ⟦à valider métier⟧ |
| Statut | Brouillon |
| Indice de confiance | **C** |

## Cadrage
- **Objectif** : contrôler l'état d'une façade avec ITE **côté finition/revêtement** (fissures, décollement, points singuliers) — le système isolant relève du Livre Isolation. `[C]`
- **Résumé** : inspecter le revêtement extérieur d'un système ITE (enduit sur isolant, bardage), repérer fissures/décollements/défauts aux points singuliers et **ponts thermiques** visibles, et orienter ; toute reprise du cœur isolant renvoie au Livre **Isolation**. `[C]` ⟦système ETICS à confirmer⟧

## Réalisation
- **Étapes** :
  1. Inspecter le revêtement (enduit sur isolant / bardage). `[C]`
  2. Repérer fissures/décollements. `[C]` → [decollement-enduit-cloque](../../../diagnostics/facade/decollement-enduit-cloque.md)
  3. Contrôler points singuliers (encadrements, appuis) et **ponts thermiques**. `[C]`
  4. Reprise du **cœur isolant** → Livre **Isolation** (`relation:isolation`). `[C]`
- **Points critiques** : ne pas empiéter sur le métier Isolation ; l'eau ne doit pas pénétrer derrière le système ; ponts thermiques aux points singuliers.
- **Sécurité** : hauteur ; support ; produits. **Travail en **hauteur** : risque de **chute** — protections **collectives** (échafaudage/garde-corps) prioritaires, **EPI adaptés**, **météo** (vent/gel/pluie) surveillée. **Stabilité du support** : évaluer l'état du support (purge des parties non adhérentes) avant intervention. **Produits chimiques** (nettoyants, hydrofuges, traitements) : EPI, ventilation, protection de l'environnement. **Arrêt immédiat en cas de danger.** Une intervention en façade relève de **compétences adaptées**.** `[A]`

## Cadre & suites
- **Normes** : enduits de mortiers **DTU 26.1** ; réfection de façades par revêtements d'imperméabilité **DTU 42.1** ; maçonnerie de petits éléments **DTU 20.1** `[B]` ⟦références/versions exactes à confirmer par le validateur⟧. `respecte-norme`
- **Diagnostic** : `cite-carte` → [diagnostiquer-facade](diagnostiquer-facade.md)

## Relations & tags
- **Tags** : `metier:facade famille:enveloppe sous-famille:facade intervention:controler cluster:ite cluster:ponts-thermiques cluster:controle cluster:diagnostic complexite:avancee type:controle securite:hauteur relation:isolation relation:etancheite`

## Historique
| Version | Date | Auteur | Validateur | Motif |
|---|---|---|---|---|
| v0.1 | 2026-08-04 | IA | ⟦—⟧ | proposition initiale (Brouillon) |
