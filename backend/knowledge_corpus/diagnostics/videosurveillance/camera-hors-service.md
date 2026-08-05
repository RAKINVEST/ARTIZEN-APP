# Caméra hors service / pas d'image

> **Brouillon (v0) — proposé par IA, en attente de validation métier** (Loi 7/18). Modèle : [../../cards/CARD_TEMPLATE.md](../../cards/CARD_TEMPLATE.md).
> Niveaux de confiance : A normes/fabricant · B technique · C terrain validé · D hypothèse.

## Métadonnées
| Champ | Valeur |
|---|---|
| Identifiant | `camera-hors-service` |
| Titre | Caméra hors service / pas d'image |
| Profession | `metier:videosurveillance` |
| Famille | `famille:electricite` |
| Sous-famille | `sous-famille:videosurveillance` |
| Version | v0.1 |
| Auteur | IA (proposition) |
| Validateur | ⟦à valider métier⟧ |
| Statut | Brouillon |
| Indice de confiance | **C** |

## Symptôme
- Une caméra **ne remonte plus d'image** (écran noir/hors ligne). `[C]`

## Causes probables
1. **Alimentation PoE** (budget dépassé, switch, injecteur). `[C]` → [cabler-alimenter-poe](../../professions/videosurveillance/cards/cabler-alimenter-poe.md)
2. **Câble/connectique** RJ45 ou coaxial défectueux. `[C]` → [cabler-rj45-reseau](../../professions/reseaux-vdi/cards/cabler-rj45-reseau.md)
3. **Config réseau/IP** (adresse, VLAN, NVR). `[C]` → [installer-nvr-dvr-stockage](../../professions/videosurveillance/cards/installer-nvr-dvr-stockage.md)

## Résolution
- Vérifier alimentation/PoE, câble, config IP/NVR ; côté alimentation → **habilité**. `[C]`

## Cadre
- **Normes** : alimentation électrique / **PoE** **NF C 15-100** ; consignation à l'intervention **NF C 18-510** ; systèmes de vidéosurveillance **EN 62676**, protection des données (**RGPD**, **CNIL**), cadre voie publique (**Code de la sécurité intérieure**) et cybersécurité (**ANSSI**) ⟦en prose, à confirmer⟧ `[B]` ⟦référence exacte à confirmer⟧. `respecte-norme`
- **Relations** : `traite-diagnostic` → [essayer-maintenir-videosurveillance](../../professions/videosurveillance/cards/essayer-maintenir-videosurveillance.md).
- **Tags** : `metier:videosurveillance famille:electricite sous-famille:videosurveillance probleme:panne cluster:poe cluster:diagnostic type:diagnostic securite:electrique relation:reseaux-vdi`

## Historique
| Version | Date | Auteur | Validateur | Motif |
|---|---|---|---|---|
| v0.1 | 2026-08-05 | IA | ⟦—⟧ | proposition initiale (Brouillon) |
