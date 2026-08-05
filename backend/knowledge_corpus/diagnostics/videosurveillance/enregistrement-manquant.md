# Enregistrement manquant / stockage plein

> **Brouillon (v0) — proposé par IA, en attente de validation métier** (Loi 7/18). Modèle : [../../cards/CARD_TEMPLATE.md](../../cards/CARD_TEMPLATE.md).
> Niveaux de confiance : A normes/fabricant · B technique · C terrain validé · D hypothèse.

## Métadonnées
| Champ | Valeur |
|---|---|
| Identifiant | `enregistrement-manquant` |
| Titre | Enregistrement manquant / stockage plein |
| Profession | `metier:videosurveillance` |
| Famille | `famille:electricite` |
| Sous-famille | `sous-famille:videosurveillance` |
| Version | v0.1 |
| Auteur | IA (proposition) |
| Validateur | ⟦à valider métier⟧ |
| Statut | Brouillon |
| Indice de confiance | **C** |

## Symptôme
- **Pas d'enregistrement** disponible à la relecture, ou **stockage plein**. `[C]`

> Un enregistrement manquant peut avoir des conséquences (preuve) — vérifier régulièrement. `[B]`

## Causes probables
1. **Disque** plein / défaillant (NVR/DVR). `[C]` → [installer-nvr-dvr-stockage](../../professions/videosurveillance/cards/installer-nvr-dvr-stockage.md)
2. **Durée de conservation** écoulée (écrasement) — paramétrage RGPD. `[C]`
3. Détection/enregistrement mal configuré. `[C]` → [configurer-detection-mouvement](../../professions/videosurveillance/cards/configurer-detection-mouvement.md)

## Résolution
- Vérifier disque/santé SMART, paramètres d'enregistrement et **durée de conservation** (conforme RGPD). `[C]`

## Cadre
- **Normes** : alimentation électrique / **PoE** **NF C 15-100** ; consignation à l'intervention **NF C 18-510** ; systèmes de vidéosurveillance **EN 62676**, protection des données (**RGPD**, **CNIL**), cadre voie publique (**Code de la sécurité intérieure**) et cybersécurité (**ANSSI**) ⟦en prose, à confirmer⟧ `[B]` ⟦référence exacte à confirmer⟧. `respecte-norme`
- **Relations** : `traite-diagnostic` → [installer-nvr-dvr-stockage](../../professions/videosurveillance/cards/installer-nvr-dvr-stockage.md).
- **Tags** : `metier:videosurveillance famille:electricite sous-famille:videosurveillance probleme:enregistrement cluster:stockage cluster:diagnostic type:diagnostic securite:rgpd`

## Historique
| Version | Date | Auteur | Validateur | Motif |
|---|---|---|---|---|
| v0.1 | 2026-08-05 | IA | ⟦—⟧ | proposition initiale (Brouillon) |
