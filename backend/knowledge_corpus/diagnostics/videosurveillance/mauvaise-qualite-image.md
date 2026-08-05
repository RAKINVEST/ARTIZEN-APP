# Mauvaise qualité d'image

> **Brouillon (v0) — proposé par IA, en attente de validation métier** (Loi 7/18). Modèle : [../../cards/CARD_TEMPLATE.md](../../cards/CARD_TEMPLATE.md).
> Niveaux de confiance : A normes/fabricant · B technique · C terrain validé · D hypothèse.

## Métadonnées
| Champ | Valeur |
|---|---|
| Identifiant | `mauvaise-qualite-image` |
| Titre | Mauvaise qualité d'image |
| Profession | `metier:videosurveillance` |
| Famille | `famille:electricite` |
| Sous-famille | `sous-famille:videosurveillance` |
| Version | v0.1 |
| Auteur | IA (proposition) |
| Validateur | ⟦à valider métier⟧ |
| Statut | Brouillon |
| Indice de confiance | **C** |

## Symptôme
- Image **floue, sombre, surexposée**, halos la nuit, non exploitable. `[C]`

## Causes probables
1. **Mise au point / focale** inadaptée ; optique sale. `[C]` → [regler-objectifs-vision-nocturne](../../professions/videosurveillance/cards/regler-objectifs-vision-nocturne.md)
2. **Contre-jour** / exposition mal réglée (WDR). `[C]`
3. **Vision nocturne (IR)** : reflets/halos (surface proche, capot sale). `[C]`

## Résolution
- Nettoyer l'optique, régler mise au point/exposition/IR, repositionner si contre-jour. `[C]`

## Cadre
- **Normes** : alimentation électrique / **PoE** **NF C 15-100** ; consignation à l'intervention **NF C 18-510** ; systèmes de vidéosurveillance **EN 62676**, protection des données (**RGPD**, **CNIL**), cadre voie publique (**Code de la sécurité intérieure**) et cybersécurité (**ANSSI**) ⟦en prose, à confirmer⟧ `[B]` ⟦référence exacte à confirmer⟧. `respecte-norme`
- **Relations** : `traite-diagnostic` → [regler-objectifs-vision-nocturne](../../professions/videosurveillance/cards/regler-objectifs-vision-nocturne.md).
- **Tags** : `metier:videosurveillance famille:electricite sous-famille:videosurveillance probleme:image cluster:objectifs cluster:vision-nocturne cluster:diagnostic type:diagnostic securite:rgpd`

## Historique
| Version | Date | Auteur | Validateur | Motif |
|---|---|---|---|---|
| v0.1 | 2026-08-05 | IA | ⟦—⟧ | proposition initiale (Brouillon) |
