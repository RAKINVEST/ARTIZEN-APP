# Kit vidéosurveillance

> **Brouillon (v0) — proposé par IA, en attente de validation métier** (Loi 7/18). Modèle : [../../cards/CARD_TEMPLATE.md](../../cards/CARD_TEMPLATE.md).
> Niveaux de confiance : A normes/fabricant · B technique · C terrain validé · D hypothèse.

## Métadonnées
| Champ | Valeur |
|---|---|
| Identifiant | `kit-videosurveillance` |
| Titre | Kit vidéosurveillance |
| Profession | `metier:videosurveillance` |
| Famille | `famille:electricite` |
| Sous-famille | `sous-famille:videosurveillance` |
| Version | v0.1 |
| Auteur | IA (proposition) |
| Validateur | ⟦à valider métier⟧ |
| Statut | Brouillon |
| Indice de confiance | **C** |

## Composition conseillée
- Caméras (IP/analogiques), **NVR/DVR**, disques ; **switch PoE**/injecteurs. `[C]`
- Testeur de caméra/moniteur de champ, testeur PoE/réseau, outils de sertissage. `[C]`
- **Panneaux d'information** (RGPD), gabarits de masquage. `[C]`
- **EPI** : antichute (hauteur) ; EPI électriques pour l'alimentation (réservée **habilité**). `[A]`

## Cadre
- **Normes** : alimentation électrique / **PoE** **NF C 15-100** ; consignation à l'intervention **NF C 18-510** ; systèmes de vidéosurveillance **EN 62676**, protection des données (**RGPD**, **CNIL**), cadre voie publique (**Code de la sécurité intérieure**) et cybersécurité (**ANSSI**) ⟦en prose, à confirmer⟧ `[B]` ⟦référence exacte à confirmer⟧. `respecte-norme`
- **Relations** : `utilise-kit` → [choisir-poser-camera](../../professions/videosurveillance/cards/choisir-poser-camera.md).
- **Tags** : `metier:videosurveillance famille:electricite sous-famille:videosurveillance type:kit cluster:cameras-ip cluster:nvr equipement:testeur-camera`

## Historique
| Version | Date | Auteur | Validateur | Motif |
|---|---|---|---|---|
| v0.1 | 2026-08-05 | IA | ⟦—⟧ | proposition initiale (Brouillon) |
