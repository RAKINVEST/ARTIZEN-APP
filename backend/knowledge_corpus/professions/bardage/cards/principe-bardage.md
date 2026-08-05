# Principe du bardage rapporté ventilé

> **Brouillon (v0) — proposé par IA, en attente de validation métier** (Loi 7/18). Modèle : [../../../cards/CARD_TEMPLATE.md](../../../cards/CARD_TEMPLATE.md).
> Niveaux de confiance : A normes/fabricant · B technique · C terrain validé · D hypothèse. Rien n'est publié comme certitude.

## Métadonnées
| Champ | Valeur |
|---|---|
| Identifiant | `principe-bardage` |
| Titre | Principe du bardage rapporté ventilé |
| Profession | `metier:bardage` |
| Famille | `famille:enveloppe` |
| Sous-famille | `sous-famille:bardage` |
| Version | v0.1 |
| Auteur | IA (proposition) |
| Validateur | ⟦à valider métier⟧ |
| Statut | Brouillon |
| Indice de confiance | **C** |

## Cadrage
- **Objectif** : comprendre le système de bardage rapporté ventilé (ossature + lame d'air + pare-pluie + revêtement) et ses variantes de matériaux. `[C]`
- **Résumé** : le **bardage rapporté ventilé** est un revêtement extérieur porté par une **ossature secondaire**, avec **lame d'air ventilée** et **pare-pluie**, en bois/composite/fibres-ciment/métallique/PVC/terre cuite ; la pose comme *option de revêtement de façade* est vue côté **Façade**, et la variante isolante relève de l'**ITE** — ici, la **discipline bardage** (structure, ventilation, calepinage, points singuliers). `[C]` ⟦système/entraxes selon matériau et AT à confirmer⟧

## Réalisation
- **Étapes** :
  1. **Ossature + lame d'air ventilée + pare-pluie**. `[C]` → [poser-ossature-lame-air](poser-ossature-lame-air.md)
  2. **Matériau** de bardage (bois, composite, fibres-ciment, métal, terre cuite). `[C]` → [choisir-bardage](choisir-bardage.md)
  3. **Frontière Façade** : pose-revêtement vue côté Façade. `[C]` → [poser-bardage-rapporte](../../../professions/facade/cards/poser-bardage-rapporte.md)
  4. **Frontière ITE** : bardage sur isolant = ITE ventilée. `[C]` → [principe-ite](../../../professions/isolation-exterieure/cards/principe-ite.md)
- **Points critiques** : **lame d'air ventilée continue** (entrée bas / sortie haut) ; pare-pluie ; ne pas confondre discipline bardage et finition façade/ITE.
- **Sécurité** : hauteur/échafaudage ; découpe (poussières/silice) ; météo. **Travail en **hauteur** (façade) : risque de **chute** — **échafaudage** / protections **collectives** prioritaires, EPI antichute, **stabilité du support/ossature** vérifiée, **météo** (vent — prise au vent des éléments longs) surveillée. **Découpe** : poussières — **fibres-ciment = silice** (masque adapté/aspiration), bois (poussières), métal (**coupure**). **Manutention** des éléments longs. **Arrêt immédiat en cas de danger.** Une intervention en bardage relève de **compétences adaptées**.** `[A]`

## Cadre & suites
- **Normes** : revêtements extérieurs en bois (bardage) **DTU 41.2** ; support en maçonnerie **DTU 20.1** ; bardages composite/fibres-ciment/métallique/terre cuite sous **Avis Technique** ⟦à confirmer⟧ `[B]` ⟦références/versions exactes à confirmer par le validateur⟧. `respecte-norme`
- **Points singuliers** : `cite-carte` → [traiter-points-singuliers-bardage](traiter-points-singuliers-bardage.md)

## Relations & tags
- **Tags** : `metier:bardage famille:enveloppe sous-famille:bardage intervention:comprendre cluster:bardage-bois cluster:bardage-composite cluster:bardage-metallique cluster:lame-air-ventilee cluster:ossature type:principe securite:hauteur relation:facade relation:isolation-exterieure`

## Historique
| Version | Date | Auteur | Validateur | Motif |
|---|---|---|---|---|
| v0.1 | 2026-08-05 | IA | ⟦—⟧ | proposition initiale (Brouillon) |
