# Poser un robinet d'arrêt

> **Brouillon (v0) — proposé par IA, en attente de validation métier** (Loi 7/18). Modèle : [../../../cards/CARD_TEMPLATE.md](../../../cards/CARD_TEMPLATE.md).
> Niveaux de confiance : A normes/fabricant · B technique · C terrain validé · D hypothèse. Rien n'est publié comme certitude.

## Métadonnées
| Champ | Valeur |
|---|---|
| Identifiant | `poser-robinet-arret` |
| Titre | Poser un robinet d'arrêt |
| Profession | `metier:plomberie` |
| Famille | `famille:fluides` |
| Sous-famille | `sous-famille:alimentation` |
| Version | v0.1 |
| Auteur | IA (proposition) |
| Validateur | ⟦à valider métier⟧ |
| Statut | Brouillon |
| Indice de confiance | **C** (geste courant ; type de raccord à confirmer) |

## Cadrage
- **Objectif** : installer un robinet d'arrêt pour isoler un appareil sans couper toute l'installation. `[C]`
- **Résumé** : couper l'eau générale, préparer le piquage/arrivée, poser le robinet d'arrêt (à visser ou à sertir), remettre en eau et contrôler. `[C]`
- **Description complète** : ⟦à compléter/valider métier⟧ — sur cuivre (à souder/sertir), PER ou multicouche selon réseau. `[C]`
- **Pré-requis** : accès à l'arrivée, coupure générale possible. `[B]`
- **Difficulté** : `moyenne` `[C]`
- **Temps moyen** : ~30–45 min `[C]` ⟦à confirmer⟧
- **Compétences nécessaires** : raccordement selon matériau, étanchéité. `[C]`

## Ressources
- **Outillage** : `outil:manuel` (+ pince à sertir/chalumeau selon réseau). `[C]`
- **Matériel** : robinet d'arrêt adapté au diamètre/matériau. `[C]`
- **Consommables** : filasse/téflon ou raccords à sertir. `[C]`

## Réalisation
- **Étapes** :
  1. Couper l'eau générale et **purger**. `[B]` → [consignation-eau](../../../procedures/plomberie/consignation-eau.md)
  2. Préparer l'arrivée (coupe propre, ébavurage). `[C]`
  3. Poser le robinet d'arrêt selon le type de raccord (visser/sertir/souder). `[C]`
  4. Remettre en eau **progressivement**, purger l'air. `[B]`
  5. **Contrôler** l'étanchéité et la manœuvre du robinet. `[C]` → [controle-etancheite](../../../checklists/plomberie/controle-etancheite.md)
- **Contrôles** : ouverture/fermeture franche, aucune fuite. `[C]`
- **Points critiques** : compatibilité matériau/raccord ; **ne pas** créer de coup de bélier à la remise en eau. `[C]` → [coup-de-belier](../../../diagnostics/plomberie/coup-de-belier.md)
- **Sécurité** : soudure = risque brûlure/incendie (protéger, extincteur à proximité). `[B]`

## Cadre & suites
- **Normes** : installation sanitaire / dimensionnement — **DTU 60.1** / **DTU 60.11** ; cuivre **DTU 60.5** `[B]` ⟦références exactes à confirmer par le validateur⟧. `respecte-norme`

## Média & preuves
- **Photos / Vidéos** : ⟦à fournir⟧

## Relations & tags
- **Relations** : `cite-procedure`, `a-checklist`, `traite-diagnostic`.
- **Tags** : `metier:plomberie famille:fluides sous-famille:alimentation intervention:installer intervention:poser equipement:robinet-arret materiau:cuivre materiau:per complexite:moyenne type:installation`

## Historique
| Version | Date | Auteur | Validateur | Motif |
|---|---|---|---|---|
| v0.1 | 2026-08-04 | IA | ⟦—⟧ | proposition initiale (Brouillon) |
