# Porte qui frotte / ferme mal

> **Brouillon (v0) — proposé par IA, en attente de validation métier** (Loi 7/18). Modèle : [../../cards/CARD_TEMPLATE.md](../../cards/CARD_TEMPLATE.md).
> Niveaux de confiance : A normes/fabricant · B technique · C terrain validé · D hypothèse.

## Métadonnées
| Champ | Valeur |
|---|---|
| Identifiant | `porte-frotte-ferme-mal` |
| Titre | Porte qui frotte / ferme mal |
| Profession | `metier:menuiserie-interieure` |
| Famille | `famille:finition` |
| Sous-famille | `sous-famille:menuiserie-interieure` |
| Version | v0.1 |
| Auteur | IA (proposition) |
| Validateur | ⟦à valider métier⟧ |
| Statut | Brouillon |
| Indice de confiance | **C** |

## Symptôme
- Porte intérieure qui **frotte**, ferme mal, ne reste pas fermée. `[C]`

## Causes probables
1. **Réglage** (paumelles/aplomb/jeux) à reprendre. `[C]` → [regler-ouvrant-interieur](../../professions/menuiserie-interieure/cards/regler-ouvrant-interieur.md)
2. **Affaissement** (paumelles/portage insuffisant) ou huisserie qui a bougé. `[C]` → [jeu-fixation-defaillante](jeu-fixation-defaillante.md)
3. **Hygrométrie** (gonflement du bois) / nouveau revêtement de sol (jeu bas). `[C]`

## Résolution
- Régler paumelles/jeux, reprendre le portage, ajuster le **jeu bas** ; ne pas raboter à l'excès. `[C]`

## Cadre
- **Normes** : menuiseries intérieures en bois **DTU 36.2** ; menuiserie bois **DTU 36.1** ; électricité (avant perçage, à proximité des réseaux) **NF C 15-100** ; accessibilité (largeurs de passage) et diagnostic **amiante** (ouvrages anciens) ⟦en prose, à confirmer⟧ `[B]` ⟦référence exacte à confirmer⟧. `respecte-norme`
- **Relations** : `traite-diagnostic` → [regler-ouvrant-interieur](../../professions/menuiserie-interieure/cards/regler-ouvrant-interieur.md).
- **Tags** : `metier:menuiserie-interieure famille:finition sous-famille:menuiserie-interieure probleme:frottement cluster:reglages cluster:diagnostic type:diagnostic securite:manutention`

## Historique
| Version | Date | Auteur | Validateur | Motif |
|---|---|---|---|---|
| v0.1 | 2026-08-05 | IA | ⟦—⟧ | proposition initiale (Brouillon) |
