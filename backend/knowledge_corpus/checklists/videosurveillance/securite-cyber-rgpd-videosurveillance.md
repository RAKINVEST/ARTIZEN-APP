# Sécurité — cyber & RGPD (vidéosurveillance)

> **Brouillon (v0) — proposé par IA, en attente de validation métier** (Loi 7/18). Modèle : [../../cards/CARD_TEMPLATE.md](../../cards/CARD_TEMPLATE.md).
> Niveaux de confiance : A normes/fabricant · B technique · C terrain validé · D hypothèse.

## Métadonnées
| Champ | Valeur |
|---|---|
| Identifiant | `securite-cyber-rgpd-videosurveillance` |
| Titre | Sécurité — cyber & RGPD (vidéosurveillance) |
| Profession | `metier:videosurveillance` |
| Famille | `famille:electricite` |
| Sous-famille | `sous-famille:securite` |
| Version | v0.1 |
| Auteur | IA (proposition) |
| Validateur | ⟦à valider métier⟧ |
| Statut | Brouillon |
| Indice de confiance | **B** |

## Points à vérifier
- [ ] **Consignation** si intervention sur l'alimentation (**habilité**). `[A]`
- [ ] **Cybersécurité** : mots de passe, MAJ, **segmentation** (VLAN caméras). `[A]`
- [ ] **Protection des enregistrements** : accès restreint, durée limitée. `[A]`
- [ ] **RGPD / droit à l'image** : information (panneaux), registre. `[A]`
- [ ] **Zones filmées** limitées (voie publique/voisinage exclus). `[A]`
- [ ] **Hauteur** (pose/maintenance) ; **arrêt** si danger. `[A]`

## Cadre
- **Normes** : alimentation électrique / **PoE** **NF C 15-100** ; consignation à l'intervention **NF C 18-510** ; systèmes de vidéosurveillance **EN 62676**, protection des données (**RGPD**, **CNIL**), cadre voie publique (**Code de la sécurité intérieure**) et cybersécurité (**ANSSI**) ⟦en prose, à confirmer⟧ `[B]` ⟦référence exacte à confirmer⟧. `respecte-norme`
- **Relations** : `cite-procedure` → [conformite-rgpd-videosurveillance](../../procedures/videosurveillance/conformite-rgpd-videosurveillance.md).
- **Tags** : `metier:videosurveillance famille:electricite sous-famille:securite type:checklist cluster:cameras-ip securite:cyber securite:rgpd`

## Historique
| Version | Date | Auteur | Validateur | Motif |
|---|---|---|---|---|
| v0.1 | 2026-08-05 | IA | ⟦—⟧ | proposition initiale (Brouillon) |
