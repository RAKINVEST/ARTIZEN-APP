# Remplacer un élément de bardage

> **Brouillon (v0) — proposé par IA, en attente de validation métier** (Loi 7/18). Modèle : [../../../cards/CARD_TEMPLATE.md](../../../cards/CARD_TEMPLATE.md).
> Niveaux de confiance : A normes/fabricant · B technique · C terrain validé · D hypothèse. Rien n'est publié comme certitude.

## Métadonnées
| Champ | Valeur |
|---|---|
| Identifiant | `remplacer-element-bardage` |
| Titre | Remplacer un élément de bardage |
| Profession | `metier:bardage` |
| Famille | `famille:enveloppe` |
| Sous-famille | `sous-famille:bardage` |
| Version | v0.1 |
| Auteur | IA (proposition) |
| Validateur | ⟦à valider métier⟧ |
| Statut | Brouillon |
| Indice de confiance | **C** |

## Cadrage
- **Objectif** : remplacer une lame/un panneau de bardage dégradé sans compromettre la ventilation ni l'étanchéité à l'eau. `[C]`
- **Résumé** : déposer l'élément atteint (en préservant les voisins et les fixations), contrôler l'ossature/pare-pluie derrière, poser un élément **identique** (matériau/teinte) et rétablir fixations et jeux. `[C]` ⟦référence élément à confirmer⟧

## Réalisation
- **Étapes** :
  1. Identifier l'élément et sa fixation (visible/invisible). `[C]` → [bardage-lame-degradee](../../../diagnostics/bardage/bardage-lame-degradee.md)
  2. Déposer sans endommager les voisins ; contrôler **ossature/pare-pluie**. `[C]` → [lame-air-obstruee-ventilation](../../../diagnostics/bardage/lame-air-obstruee-ventilation.md)
  3. Poser un élément **identique** (matériau/teinte) ; rétablir jeux/fixations. `[C]`
  4. Contrôler ventilation et étanchéité à l'eau. `[C]`
- **Points critiques** : élément identique ; ne pas dégrader pare-pluie/ossature ; conserver jeux et ventilation.
- **Sécurité** : hauteur ; dépose/manutention ; découpe. **Travail en **hauteur** (façade) : risque de **chute** — **échafaudage** / protections **collectives** prioritaires, EPI antichute, **stabilité du support/ossature** vérifiée, **météo** (vent — prise au vent des éléments longs) surveillée. **Découpe** : poussières — **fibres-ciment = silice** (masque adapté/aspiration), bois (poussières), métal (**coupure**). **Manutention** des éléments longs. **Arrêt immédiat en cas de danger.** Une intervention en bardage relève de **compétences adaptées**.** `[A]`

## Cadre & suites
- **Normes** : revêtements extérieurs en bois (bardage) **DTU 41.2** ; support en maçonnerie **DTU 20.1** ; bardages composite/fibres-ciment/métallique/terre cuite sous **Avis Technique** ⟦à confirmer⟧ `[B]` ⟦références/versions exactes à confirmer par le validateur⟧. `respecte-norme`
- **Entretien** : `cite-carte` → [entretenir-controler-bardage](entretenir-controler-bardage.md)

## Relations & tags
- **Tags** : `metier:bardage famille:enveloppe sous-famille:bardage intervention:remplacer intervention:reparer cluster:reparation cluster:remplacement complexite:moyenne type:remplacement securite:hauteur`

## Historique
| Version | Date | Auteur | Validateur | Motif |
|---|---|---|---|---|
| v0.1 | 2026-08-05 | IA | ⟦—⟧ | proposition initiale (Brouillon) |
