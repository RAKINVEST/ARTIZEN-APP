# Infiltration en toiture-terrasse

> **Brouillon (v0) — proposé par IA, en attente de validation métier** (Loi 7/18). Modèle : [../../cards/CARD_TEMPLATE.md](../../cards/CARD_TEMPLATE.md).
> Niveaux de confiance : A normes/fabricant · B technique · C terrain validé · D hypothèse.

## Métadonnées
| Champ | Valeur |
|---|---|
| Identifiant | `infiltration-toiture-terrasse` |
| Titre | Infiltration en toiture-terrasse |
| Profession | `metier:etancheite` |
| Famille | `famille:enveloppe` |
| Sous-famille | `sous-famille:etancheite` |
| Version | v0.1 |
| Auteur | IA (proposition) |
| Validateur | ⟦à valider métier⟧ |
| Statut | Brouillon |
| Indice de confiance | **C** |

## Symptôme
- Tache/**infiltration** au plafond sous une terrasse ou un balcon. `[C]`

> L'entrée d'eau est **rarement à l'aplomb** de la tache : suivre le cheminement. `[B]`

## Causes probables
1. **Point singulier** défaillant (relevé, évacuation, pénétration). `[C]` → [traiter-penetrations-points-singuliers](../../professions/etancheite/cards/traiter-penetrations-points-singuliers.md)
2. **Stagnation** / évacuation bouchée. `[C]` → [poser-descente-ep](../../professions/zinguerie/cards/poser-descente-ep.md)
3. Membrane percée/déchirée ou relevé décollé. `[C]` → [fissure-decollement-releve](fissure-decollement-releve.md)

## Résolution
- **Rechercher la fuite** puis réparer dans le respect du système. `[C]` → [rechercher-fuite-etancheite](../../professions/etancheite/cards/rechercher-fuite-etancheite.md)

## Cadre
- **Normes** : étanchéité des toitures-terrasses (support maçonnerie) **DTU 43.1** ; support acier **DTU 43.3** ; réfection des ouvrages d'étanchéité **DTU 43.5** ; SEL/résines sous **Avis Technique** ⟦à confirmer⟧ `[B]` ⟦référence exacte à confirmer⟧. `respecte-norme`
- **Relations** : `traite-diagnostic` → [rechercher-fuite-etancheite](../../professions/etancheite/cards/rechercher-fuite-etancheite.md).
- **Tags** : `metier:etancheite famille:enveloppe sous-famille:etancheite probleme:infiltration cluster:infiltrations cluster:recherche-de-fuite cluster:terrasses type:diagnostic securite:hauteur relation:zinguerie`

## Historique
| Version | Date | Auteur | Validateur | Motif |
|---|---|---|---|---|
| v0.1 | 2026-08-05 | IA | ⟦—⟧ | proposition initiale (Brouillon) |
