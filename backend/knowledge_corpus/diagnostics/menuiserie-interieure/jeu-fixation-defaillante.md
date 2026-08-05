# Jeu / fixation défaillante (bloc-porte, habillage)

> **Brouillon (v0) — proposé par IA, en attente de validation métier** (Loi 7/18). Modèle : [../../cards/CARD_TEMPLATE.md](../../cards/CARD_TEMPLATE.md).
> Niveaux de confiance : A normes/fabricant · B technique · C terrain validé · D hypothèse.

## Métadonnées
| Champ | Valeur |
|---|---|
| Identifiant | `jeu-fixation-defaillante` |
| Titre | Jeu / fixation défaillante (bloc-porte, habillage) |
| Profession | `metier:menuiserie-interieure` |
| Famille | `famille:finition` |
| Sous-famille | `sous-famille:menuiserie-interieure` |
| Version | v0.1 |
| Auteur | IA (proposition) |
| Validateur | ⟦à valider métier⟧ |
| Statut | Brouillon |
| Indice de confiance | **C** |

## Symptôme
- Bloc-porte/huisserie qui **bouge**, chambranle décollé, jeu à la fixation. `[C]`

> Un bloc-porte mal fixé peut **chuter** → sécuriser. `[B]`

## Causes probables
1. **Fixation** insuffisante / cheville inadaptée au support (plaque de plâtre). `[C]` → [poser-bloc-porte](../../professions/menuiserie-interieure/cards/poser-bloc-porte.md)
2. Calage manquant / huisserie non bloquée. `[C]`
3. Support dégradé. `[C]`

## Résolution
- Reprendre la **fixation** (chevilles adaptées/pattes), recaler, re-régler l'ouvrant. `[C]`

## Cadre
- **Normes** : menuiseries intérieures en bois **DTU 36.2** ; menuiserie bois **DTU 36.1** ; électricité (avant perçage, à proximité des réseaux) **NF C 15-100** ; accessibilité (largeurs de passage) et diagnostic **amiante** (ouvrages anciens) ⟦en prose, à confirmer⟧ `[B]` ⟦référence exacte à confirmer⟧. `respecte-norme`
- **Relations** : `traite-diagnostic` → [poser-bloc-porte](../../professions/menuiserie-interieure/cards/poser-bloc-porte.md).
- **Tags** : `metier:menuiserie-interieure famille:finition sous-famille:menuiserie-interieure probleme:fixation cluster:blocs-portes cluster:diagnostic type:diagnostic securite:manutention`

## Historique
| Version | Date | Auteur | Validateur | Motif |
|---|---|---|---|---|
| v0.1 | 2026-08-05 | IA | ⟦—⟧ | proposition initiale (Brouillon) |
