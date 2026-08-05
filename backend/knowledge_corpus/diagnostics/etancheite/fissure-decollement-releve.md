# Relèvé fissuré / décollé

> **Brouillon (v0) — proposé par IA, en attente de validation métier** (Loi 7/18). Modèle : [../../cards/CARD_TEMPLATE.md](../../cards/CARD_TEMPLATE.md).
> Niveaux de confiance : A normes/fabricant · B technique · C terrain validé · D hypothèse.

## Métadonnées
| Champ | Valeur |
|---|---|
| Identifiant | `fissure-decollement-releve` |
| Titre | Relèvé fissuré / décollé |
| Profession | `metier:etancheite` |
| Famille | `famille:enveloppe` |
| Sous-famille | `sous-famille:etancheite` |
| Version | v0.1 |
| Auteur | IA (proposition) |
| Validateur | ⟦à valider métier⟧ |
| Statut | Brouillon |
| Indice de confiance | **C** |

## Symptôme
- **Relèvé** d'étanchéité **décollé**, fissuré ou déscellé en tête (acrotère). `[C]`

> Le relèvé est le **point n° 1** des infiltrations en terrasse. `[B]`

## Causes probables
1. Fixation en tête défaillante (engravure/solin). `[C]` → [realiser-releves-acrotere](../../professions/etancheite/cards/realiser-releves-acrotere.md)
2. Hauteur de relèvé insuffisante / défaut de couvertine. `[C]`
3. Mouvement de l'acrotère / dilatation. `[C]`

## Résolution
- Reprendre le relèvé (fixation en tête, couvertine), rétablir la continuité. `[C]`

## Cadre
- **Normes** : étanchéité des toitures-terrasses (support maçonnerie) **DTU 43.1** ; support acier **DTU 43.3** ; réfection des ouvrages d'étanchéité **DTU 43.5** ; SEL/résines sous **Avis Technique** ⟦à confirmer⟧ `[B]` ⟦référence exacte à confirmer⟧. `respecte-norme`
- **Relations** : `traite-diagnostic` → [realiser-releves-acrotere](../../professions/etancheite/cards/realiser-releves-acrotere.md).
- **Tags** : `metier:etancheite equipement:acrotere famille:enveloppe sous-famille:etancheite probleme:decollement cluster:diagnostic cluster:releves-d-etancheite cluster:acroteres type:diagnostic securite:hauteur`

## Historique
| Version | Date | Auteur | Validateur | Motif |
|---|---|---|---|---|
| v0.1 | 2026-08-05 | IA | ⟦—⟧ | proposition initiale (Brouillon) |
