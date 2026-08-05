# Quincaillerie usée / bloquée

> **Brouillon (v0) — proposé par IA, en attente de validation métier** (Loi 7/18). Modèle : [../../cards/CARD_TEMPLATE.md](../../cards/CARD_TEMPLATE.md).
> Niveaux de confiance : A normes/fabricant · B technique · C terrain validé · D hypothèse.

## Métadonnées
| Champ | Valeur |
|---|---|
| Identifiant | `quincaillerie-usee-bloquee` |
| Titre | Quincaillerie usée / bloquée |
| Profession | `metier:menuiserie-interieure` |
| Famille | `famille:finition` |
| Sous-famille | `sous-famille:menuiserie-interieure` |
| Version | v0.1 |
| Auteur | IA (proposition) |
| Validateur | ⟦à valider métier⟧ |
| Statut | Brouillon |
| Indice de confiance | **C** |

## Symptôme
- **Serrure**/poignée dure, bloquée, qui joue, paumelles qui grincent. `[C]`

## Causes probables
1. **Usure/encrassement** (serrure/béquille) — lubrification/remplacement. `[C]` → [installer-quincaillerie-ferrures](../../professions/menuiserie-interieure/cards/installer-quincaillerie-ferrures.md)
2. **Désalignement** serrure/gâche (réglage). `[C]` → [regler-ouvrant-interieur](../../professions/menuiserie-interieure/cards/regler-ouvrant-interieur.md)
3. Paumelles/portage insuffisants. `[C]`

## Résolution
- Lubrifier/remplacer la quincaillerie, réaligner gâche/serrure, reprendre le réglage. `[C]`

## Cadre
- **Normes** : menuiseries intérieures en bois **DTU 36.2** ; menuiserie bois **DTU 36.1** ; électricité (avant perçage, à proximité des réseaux) **NF C 15-100** ; accessibilité (largeurs de passage) et diagnostic **amiante** (ouvrages anciens) ⟦en prose, à confirmer⟧ `[B]` ⟦référence exacte à confirmer⟧. `respecte-norme`
- **Relations** : `traite-diagnostic` → [installer-quincaillerie-ferrures](../../professions/menuiserie-interieure/cards/installer-quincaillerie-ferrures.md).
- **Tags** : `metier:menuiserie-interieure famille:finition sous-famille:menuiserie-interieure probleme:quincaillerie cluster:quincaillerie cluster:diagnostic type:diagnostic securite:manutention`

## Historique
| Version | Date | Auteur | Validateur | Motif |
|---|---|---|---|---|
| v0.1 | 2026-08-05 | IA | ⟦—⟧ | proposition initiale (Brouillon) |
