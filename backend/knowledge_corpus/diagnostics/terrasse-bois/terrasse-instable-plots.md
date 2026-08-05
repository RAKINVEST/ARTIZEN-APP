# Terrasse instable / plots déréglés

> **Brouillon (v0) — proposé par IA, en attente de validation métier** (Loi 7/18). Modèle : [../../cards/CARD_TEMPLATE.md](../../cards/CARD_TEMPLATE.md).
> Niveaux de confiance : A normes/fabricant · B technique · C terrain validé · D hypothèse.

## Métadonnées
| Champ | Valeur |
|---|---|
| Identifiant | `terrasse-instable-plots` |
| Titre | Terrasse instable / plots déréglés |
| Profession | `metier:terrasse-bois` |
| Famille | `famille:specialises` |
| Sous-famille | `sous-famille:terrasse-bois` |
| Version | v0.1 |
| Auteur | IA (proposition) |
| Validateur | ⟦à valider métier⟧ |
| Statut | Brouillon |
| Indice de confiance | **C** |

## Symptôme
- Terrasse qui **bouge**, lames qui s'enfoncent, **point mou**, bruit sous le pas. `[C]`

## Causes probables
1. **Plots** déréglés/tassés ou mal répartis. `[C]` → [poser-plots-lambourdes-solives](../../professions/terrasse-bois/cards/poser-plots-lambourdes-solives.md)
2. **Entraxe** de lambourdes trop grand (flèche des lames). `[C]`
3. **Support** qui a bougé (dalle = Maçonnerie / terrassement). `[C]` → [etudier-support-implanter](../../professions/terrasse-bois/cards/etudier-support-implanter.md)

## Résolution
- Régler/ajouter des plots, réduire l'entraxe, reprendre le support ; contrôler ventilation/drainage. `[C]`

## Cadre
- **Normes** : platelages extérieurs en bois **DTU 51.4** ; dalle / support béton (**interface** maçonnerie) **DTU 21** ; classes d'emploi du bois **NF EN 335**, durabilité **NF EN 350**, bois composite **NF EN 15534**, éclairage intégré (**interface** électricité) **NF C 15-100** et **DT-DICT** (réseaux) ⟦en prose, à confirmer⟧ `[B]` ⟦référence exacte à confirmer⟧. `respecte-norme`
- **Relations** : `traite-diagnostic` → [poser-plots-lambourdes-solives](../../professions/terrasse-bois/cards/poser-plots-lambourdes-solives.md).
- **Tags** : `metier:terrasse-bois famille:specialises sous-famille:terrasse-bois probleme:instabilite cluster:plots-reglables cluster:diagnostic type:diagnostic securite:manutention relation:maconnerie`

## Historique
| Version | Date | Auteur | Validateur | Motif |
|---|---|---|---|---|
| v0.1 | 2026-08-05 | IA | ⟦—⟧ | proposition initiale (Brouillon) |
