# Poser un bardage rapporté (façade)

> **Brouillon (v0) — proposé par IA, en attente de validation métier** (Loi 7/18). Modèle : [../../../cards/CARD_TEMPLATE.md](../../../cards/CARD_TEMPLATE.md).
> Niveaux de confiance : A normes/fabricant · B technique · C terrain validé · D hypothèse. Rien n'est publié comme certitude.

## Métadonnées
| Champ | Valeur |
|---|---|
| Identifiant | `poser-bardage-rapporte` |
| Titre | Poser un bardage rapporté (façade) |
| Profession | `metier:facade` |
| Famille | `famille:enveloppe` |
| Sous-famille | `sous-famille:facade` |
| Version | v0.1 |
| Auteur | IA (proposition) |
| Validateur | ⟦à valider métier⟧ |
| Statut | Brouillon |
| Indice de confiance | **C** |

## Cadrage
- **Objectif** : poser/remplacer un bardage rapporté ventilé comme revêtement de façade sur ossature. `[C]`
- **Résumé** : poser l'ossature (pattes/tasseaux) d'aplomb, ménager la **lame d'air ventilée**, fixer les éléments de bardage et traiter les points singuliers ; le cœur **isolant** (ITE) relève du Livre **Isolation** (`relation:isolation`). `[C]` ⟦système/entraxes selon fabricant à confirmer⟧

## Réalisation
- **Étapes** :
  1. Contrôler le support/ossature. `[C]` → [inspecter-charpente](../../../professions/charpente/cards/inspecter-charpente.md)
  2. Poser l'**ossature** d'aplomb (pattes/tasseaux). `[C]` ⟦entraxes à confirmer⟧
  3. Ménager la **lame d'air ventilée** ; grilles anti-rongeurs. `[B]`
  4. Fixer le bardage ; traiter les **points singuliers** (rives, encadrements). `[C]` → [realiser-solin-abergement](../../../professions/zinguerie/cards/realiser-solin-abergement.md)
- **Points critiques** : lame d'air **ventilée** continue ; aplomb ; l'**isolation** éventuelle relève du Livre Isolation (non traitée ici).
- **Sécurité** : hauteur ; support ; coupure/manutention. **Travail en **hauteur** : risque de **chute** — protections **collectives** (échafaudage/garde-corps) prioritaires, **EPI adaptés**, **météo** (vent/gel/pluie) surveillée. **Stabilité du support** : évaluer l'état du support (purge des parties non adhérentes) avant intervention. **Produits chimiques** (nettoyants, hydrofuges, traitements) : EPI, ventilation, protection de l'environnement. **Arrêt immédiat en cas de danger.** Une intervention en façade relève de **compétences adaptées**.** `[A]`

## Cadre & suites
- **Normes** : enduits de mortiers **DTU 26.1** ; réfection de façades par revêtements d'imperméabilité **DTU 42.1** ; maçonnerie de petits éléments **DTU 20.1** `[B]` ⟦références/versions exactes à confirmer par le validateur⟧. `respecte-norme`
- **Isolation (cœur ITE)** : `relation:isolation` (voir Livre Isolation)

## Relations & tags
- **Tags** : `metier:facade equipement:bardage famille:enveloppe sous-famille:facade intervention:poser intervention:remplacer cluster:bardages cluster:revetements cluster:remplacement cluster:ponts-thermiques complexite:avancee type:installation securite:hauteur relation:isolation relation:charpente relation:zinguerie`

## Historique
| Version | Date | Auteur | Validateur | Motif |
|---|---|---|---|---|
| v0.1 | 2026-08-04 | IA | ⟦—⟧ | proposition initiale (Brouillon) |
