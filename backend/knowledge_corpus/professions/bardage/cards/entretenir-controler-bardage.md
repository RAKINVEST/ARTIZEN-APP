# Entretenir / contrôler un bardage

> **Brouillon (v0) — proposé par IA, en attente de validation métier** (Loi 7/18). Modèle : [../../../cards/CARD_TEMPLATE.md](../../../cards/CARD_TEMPLATE.md).
> Niveaux de confiance : A normes/fabricant · B technique · C terrain validé · D hypothèse. Rien n'est publié comme certitude.

## Métadonnées
| Champ | Valeur |
|---|---|
| Identifiant | `entretenir-controler-bardage` |
| Titre | Entretenir / contrôler un bardage |
| Profession | `metier:bardage` |
| Famille | `famille:enveloppe` |
| Sous-famille | `sous-famille:bardage` |
| Version | v0.1 |
| Auteur | IA (proposition) |
| Validateur | ⟦à valider métier⟧ |
| Statut | Brouillon |
| Indice de confiance | **C** |

## Cadrage
- **Objectif** : entretenir et contrôler un bardage (tenue des fixations, ventilation, état du matériau) pour prévenir les désordres. `[C]`
- **Résumé** : contrôler la tenue des **fixations**, l'état des éléments (gauchissement, fissures, corrosion, grisaillement), la **ventilation** de la lame d'air (grilles dégagées), les points singuliers, et réaliser l'entretien adapté au matériau. `[C]`

## Réalisation
- **Étapes** :
  1. Sécuriser l'accès (échafaudage/EPI). `[A]`
  2. Contrôler **fixations** et tenue des éléments. `[C]` → [fixation-defaillante-bardage](../../../diagnostics/bardage/fixation-defaillante-bardage.md)
  3. Vérifier la **ventilation** (grilles bas/haut dégagées). `[C]` → [lame-air-obstruee-ventilation](../../../diagnostics/bardage/lame-air-obstruee-ventilation.md)
  4. Entretien adapté (bois : traitement/saturateur ; autres : nettoyage). `[C]` ⟦produit à confirmer⟧
- **Points critiques** : ventilation dégagée ; fixations saines ; entretien **adapté au matériau** ; détecter la corrosion/pourriture tôt.
- **Sécurité** : hauteur/échafaudage ; produits (traitement) ; glissade selon accès. **Travail en **hauteur** (façade) : risque de **chute** — **échafaudage** / protections **collectives** prioritaires, EPI antichute, **stabilité du support/ossature** vérifiée, **météo** (vent — prise au vent des éléments longs) surveillée. **Découpe** : poussières — **fibres-ciment = silice** (masque adapté/aspiration), bois (poussières), métal (**coupure**). **Manutention** des éléments longs. **Arrêt immédiat en cas de danger.** Une intervention en bardage relève de **compétences adaptées**.** `[A]`

## Cadre & suites
- **Normes** : revêtements extérieurs en bois (bardage) **DTU 41.2** ; support en maçonnerie **DTU 20.1** ; bardages composite/fibres-ciment/métallique/terre cuite sous **Avis Technique** ⟦à confirmer⟧ `[B]` ⟦références/versions exactes à confirmer par le validateur⟧. `respecte-norme`
- **Kit** : `utilise-kit` → [kit-bardage](../../../kits/bardage/kit-bardage.md)

## Relations & tags
- **Tags** : `metier:bardage famille:enveloppe sous-famille:bardage intervention:entretenir intervention:controler cluster:entretien cluster:maintenance cluster:controle complexite:simple type:entretien securite:hauteur`

## Historique
| Version | Date | Auteur | Validateur | Motif |
|---|---|---|---|---|
| v0.1 | 2026-08-05 | IA | ⟦—⟧ | proposition initiale (Brouillon) |
