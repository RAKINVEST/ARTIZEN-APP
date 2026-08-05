# Poser un mitigeur d'évier

> **Brouillon (v0) — proposé par IA, en attente de validation métier** (Loi 7/18). Modèle : [../../../cards/CARD_TEMPLATE.md](../../../cards/CARD_TEMPLATE.md).
> Niveaux de confiance : A normes/fabricant · B technique · C terrain validé · D hypothèse. Rien n'est publié comme certitude.

## Métadonnées
| Champ | Valeur |
|---|---|
| Identifiant | `poser-mitigeur-evier` |
| Titre | Poser un mitigeur d'évier |
| Profession | `metier:plomberie` |
| Famille | `famille:fluides` |
| Sous-famille | `sous-famille:robinetterie` |
| Version | v0.1 |
| Auteur | IA (proposition) |
| Validateur | ⟦à valider métier⟧ |
| Statut | Brouillon |
| Indice de confiance | **C** (geste courant ; références exactes à confirmer) |

## Cadrage
- **Objectif** : installer un mitigeur monotrou sur un évier et garantir l'étanchéité des raccords. `[C]`
- **Résumé** : couper et purger l'eau, présenter le mitigeur avec son joint de base, fixer par-dessous, raccorder les flexibles sur les arrivées EF/ECS, remettre en eau et contrôler l'absence de fuite. `[C]`
- **Description complète** : ⟦à compléter/valider métier⟧ — variantes selon flexibles fournis (à sertir ou à visser) et entraxe des arrivées. `[D]`
- **Pré-requis** : arrivées EF/ECS avec robinets d'arrêt accessibles ; perçage évier au bon diamètre. `[B]`
- **Difficulté** : `simple` `[C]`
- **Temps moyen** : ~30–45 min `[C]` ⟦à confirmer⟧
- **Compétences nécessaires** : raccordement robinetterie, contrôle d'étanchéité. `[C]`

## Ressources
- **Outillage** : `outil:manuel` (clé à lavabo, clés plates), `outil:controle`. `[C]`
- **Matériel** : mitigeur monotrou, flexibles compatibles, joint de base. `[B]`
- **Consommables** : téflon/filasse selon raccords, graisse sanitaire. `[C]`
- **Kit conseillé** : `utilise-kit` → [kit-robinetterie](../../../kits/plomberie/kit-robinetterie.md)

## Réalisation
- **Étapes** :
  1. Fermer les robinets d'arrêt EF/ECS et **purger** en ouvrant l'ancien robinet. `[B]` → [consignation-eau](../../../procedures/plomberie/consignation-eau.md)
  2. Déposer l'ancien mitigeur ; nettoyer le plan de pose. `[C]`
  3. Monter les flexibles sur le mitigeur **avant** la pose (accès plus facile). `[C]`
  4. Présenter le mitigeur avec son joint ; fixer la bride/écrou par-dessous. `[B]`
  5. Raccorder les flexibles aux robinets d'arrêt (EF sur droite, ECS sur gauche). `[C]`
  6. Rouvrir l'eau **progressivement** ; purger l'air en ouvrant le mitigeur. `[B]`
  7. Contrôler l'étanchéité de tous les raccords. `[C]` → [controle-etancheite](../../../checklists/plomberie/controle-etancheite.md)
- **Contrôles** : `a-checklist` → [controle-avant-remise-en-service](../../../checklists/plomberie/controle-avant-remise-en-service.md)
- **Points critiques** : ne pas **surserrer** les flexibles (écrasement du joint) ; respecter EF/ECS ; vérifier la portée du joint de base. `[C]`
- **Sécurité** : couper l'eau et vérifier l'absence de pression avant dépose ; attention à l'eau chaude résiduelle côté ECS. `[B]`

## Cadre & suites
- **Normes** : installation sanitaire — **DTU 60.1** ; canalisations cuivre **DTU 60.5** le cas échéant `[B]` ⟦références/versions exactes à confirmer par le validateur⟧. `respecte-norme`
- **Garantie** : `cite-phrase` → [garantie-piece-main-oeuvre](../../../phrases/plomberie/garantie-piece-main-oeuvre.md)
- **Diagnostics liés** : `traite-diagnostic` → [robinet-qui-goutte](../../../diagnostics/plomberie/robinet-qui-goutte.md)

## Média & preuves
- **Photos / Vidéos** : ⟦à fournir — terrain, sans donnée personnelle⟧

## Langage & réutilisation
- **Phrases associées** : `cite-phrase` → [devis-remplacement-mitigeur](../../../phrases/plomberie/devis-remplacement-mitigeur.md)
- **FAQ** : « Faut-il du téflon sur les flexibles ? » — non sur les écrous à joint plat ; oui/filasse sur les raccords coniques mâles. `[C]` ⟦à valider⟧
- **Retours terrain** : `enrichie-par` → [retour-terrain-cartouche-calcaire](../../../phrases/plomberie/retour-terrain-cartouche-calcaire.md)

## Relations & tags
- **Relations** : `utilise-kit`, `a-checklist`, `traite-diagnostic`, `cite-phrase`, `enrichie-par`.
- **Tags** : `metier:plomberie famille:fluides sous-famille:robinetterie intervention:installer intervention:poser equipement:mitigeur equipement:evier piece:cuisine complexite:simple type:installation`

## Historique
| Version | Date | Auteur | Validateur | Motif |
|---|---|---|---|---|
| v0.1 | 2026-08-03 | IA | ⟦—⟧ | proposition initiale (Brouillon) |
