# Conformité RGPD / CNIL de la vidéosurveillance

> **Brouillon (v0) — proposé par IA, en attente de validation métier** (Loi 7/18). Modèle : [../../cards/CARD_TEMPLATE.md](../../cards/CARD_TEMPLATE.md).
> Niveaux de confiance : A normes/fabricant · B technique · C terrain validé · D hypothèse.

## Métadonnées
| Champ | Valeur |
|---|---|
| Identifiant | `conformite-rgpd-videosurveillance` |
| Titre | Conformité RGPD / CNIL de la vidéosurveillance |
| Profession | `metier:videosurveillance` |
| Famille | `famille:electricite` |
| Sous-famille | `sous-famille:securite` |
| Version | v0.1 |
| Auteur | IA (proposition) |
| Validateur | ⟦à valider métier⟧ |
| Statut | Brouillon |
| Indice de confiance | **B** |

## But
- Rendre une installation vidéo **conforme** au RGPD / à la CNIL (obligatoire). `[A]`

## Étapes
1. **Limiter les zones filmées** : pas la **voie publique** (sauf autorisation préfectorale), ni le voisinage/les parties privatives — **masquages**. `[A]` ⟦cadre exact à confirmer⟧
2. **Informer** les personnes (**panneaux** visibles) ; en entreprise, informer **CSE/salariés**. `[A]`
3. **Registre de traitement** ; **durée de conservation** limitée ; accès restreint. `[A]`
4. **Droit d'accès** des personnes ; sécurité des enregistrements (cyber). `[A]` → [securiser-camera-ip](../../professions/videosurveillance/cards/securiser-camera-ip.md)

> Filmer sans information/hors cadre = **non conforme** (sanctions CNIL). `[A]`

## Cadre
- **Normes** : alimentation électrique / **PoE** **NF C 15-100** ; consignation à l'intervention **NF C 18-510** ; systèmes de vidéosurveillance **EN 62676**, protection des données (**RGPD**, **CNIL**), cadre voie publique (**Code de la sécurité intérieure**) et cybersécurité (**ANSSI**) ⟦en prose, à confirmer⟧ `[B]` ⟦référence exacte à confirmer⟧. `respecte-norme`
- **Relations** : `cite-carte` → [installer-nvr-dvr-stockage](../../professions/videosurveillance/cards/installer-nvr-dvr-stockage.md).
- **Tags** : `metier:videosurveillance famille:electricite sous-famille:securite intervention:controler cluster:enregistrement cluster:stockage type:procedure securite:rgpd`

## Historique
| Version | Date | Auteur | Validateur | Motif |
|---|---|---|---|---|
| v0.1 | 2026-08-05 | IA | ⟦—⟧ | proposition initiale (Brouillon) |
