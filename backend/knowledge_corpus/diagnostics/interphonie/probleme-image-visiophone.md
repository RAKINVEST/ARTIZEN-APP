# Problème d'image (visiophone)

> **Brouillon (v0) — proposé par IA, en attente de validation métier** (Loi 7/18). Modèle : [../../cards/CARD_TEMPLATE.md](../../cards/CARD_TEMPLATE.md).
> Niveaux de confiance : A normes/fabricant · B technique · C terrain validé · D hypothèse.

## Métadonnées
| Champ | Valeur |
|---|---|
| Identifiant | `probleme-image-visiophone` |
| Titre | Problème d'image (visiophone) |
| Profession | `metier:interphonie` |
| Famille | `famille:electricite` |
| Sous-famille | `sous-famille:interphonie` |
| Version | v0.1 |
| Auteur | IA (proposition) |
| Validateur | ⟦à valider métier⟧ |
| Statut | Brouillon |
| Indice de confiance | **C** |

## Symptôme
- **Pas d'image** ou image **floue/sombre** sur le moniteur du visiophone. `[C]`

## Causes probables
1. **Caméra** de platine défaillante / objectif sale. `[C]` → [installer-platine-rue](../../professions/interphonie/cards/installer-platine-rue.md)
2. **Câblage/alimentation** insuffisants (vidéo = plus exigeant). `[C]` → [cabler-bus-2-fils](../../professions/interphonie/cards/cabler-bus-2-fils.md)
3. **Éclairage/contre-jour** à l'entrée ; vision nocturne. `[C]`

## Résolution
- Nettoyer l'optique, vérifier câblage/alim, régler l'éclairage/le contre-jour ; respecter la vie privée (champ). `[C]`

## Cadre
- **Normes** : alimentation des équipements **NF C 15-100** ; consignation à l'intervention **NF C 18-510** ; systèmes d'interphonie de bâtiment **EN 62820**, communication **SIP** (IP), données/images (**RGPD**, **CNIL**) et cybersécurité (**ANSSI**) ⟦en prose, à confirmer⟧ `[B]` ⟦référence exacte à confirmer⟧. `respecte-norme`
- **Relations** : `traite-diagnostic` → [installer-platine-rue](../../professions/interphonie/cards/installer-platine-rue.md).
- **Tags** : `metier:interphonie famille:electricite sous-famille:interphonie probleme:image cluster:visiophones cluster:diagnostic type:diagnostic securite:rgpd`

## Historique
| Version | Date | Auteur | Validateur | Motif |
|---|---|---|---|---|
| v0.1 | 2026-08-05 | IA | ⟦—⟧ | proposition initiale (Brouillon) |
