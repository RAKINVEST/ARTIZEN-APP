# Contrôle / maintenance vidéosurveillance

> **Brouillon (v0) — proposé par IA, en attente de validation métier** (Loi 7/18). Modèle : [../../cards/CARD_TEMPLATE.md](../../cards/CARD_TEMPLATE.md).
> Niveaux de confiance : A normes/fabricant · B technique · C terrain validé · D hypothèse.

## Métadonnées
| Champ | Valeur |
|---|---|
| Identifiant | `controle-maintenance-videosurveillance` |
| Titre | Contrôle / maintenance vidéosurveillance |
| Profession | `metier:videosurveillance` |
| Famille | `famille:electricite` |
| Sous-famille | `sous-famille:videosurveillance` |
| Version | v0.1 |
| Auteur | IA (proposition) |
| Validateur | ⟦à valider métier⟧ |
| Statut | Brouillon |
| Indice de confiance | **C** |

## Points à vérifier
- [ ] **Caméras** : image jour/nuit, champ, optique propre. `[C]`
- [ ] **Enregistrement** effectif ; **stockage/durée** OK (RGPD). `[C]`
- [ ] **PoE**/alimentation : budget, état ; MAJ firmware. `[C]`
- [ ] **Cyber** : mots de passe, segmentation, accès restreints. `[A]`
- [ ] **Masquages** de confidentialité en place (zones). `[A]`
- [ ] **Information** (panneaux) et **registre** à jour. `[A]`

> Alimentation = **habilité** ; hauteur pour la maintenance ; **RGPD** permanent.

## Cadre
- **Normes** : alimentation électrique / **PoE** **NF C 15-100** ; consignation à l'intervention **NF C 18-510** ; systèmes de vidéosurveillance **EN 62676**, protection des données (**RGPD**, **CNIL**), cadre voie publique (**Code de la sécurité intérieure**) et cybersécurité (**ANSSI**) ⟦en prose, à confirmer⟧ `[B]` ⟦référence exacte à confirmer⟧. `respecte-norme`
- **Relations** : `verifie` → [essayer-maintenir-videosurveillance](../../professions/videosurveillance/cards/essayer-maintenir-videosurveillance.md).
- **Tags** : `metier:videosurveillance famille:electricite sous-famille:videosurveillance type:checklist cluster:maintenance cluster:essais securite:rgpd`

## Historique
| Version | Date | Auteur | Validateur | Motif |
|---|---|---|---|---|
| v0.1 | 2026-08-05 | IA | ⟦—⟧ | proposition initiale (Brouillon) |
