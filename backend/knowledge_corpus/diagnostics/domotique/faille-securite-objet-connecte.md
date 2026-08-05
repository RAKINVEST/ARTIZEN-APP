# Faille de sécurité d'un objet connecté

> **Brouillon (v0) — proposé par IA, en attente de validation métier** (Loi 7/18). Modèle : [../../cards/CARD_TEMPLATE.md](../../cards/CARD_TEMPLATE.md).
> Niveaux de confiance : A normes/fabricant · B technique · C terrain validé · D hypothèse.

## Métadonnées
| Champ | Valeur |
|---|---|
| Identifiant | `faille-securite-objet-connecte` |
| Titre | Faille de sécurité d'un objet connecté |
| Profession | `metier:domotique` |
| Famille | `famille:electricite` |
| Sous-famille | `sous-famille:domotique` |
| Version | v0.1 |
| Auteur | IA (proposition) |
| Validateur | ⟦à valider métier⟧ |
| Statut | Brouillon |
| Indice de confiance | **C** |

## Symptôme
- Objet connecté **vulnérable/compromis** (accès non autorisé, comportement anormal, alerte). `[C]`

> Un objet compromis peut donner **accès au logement/aux données** → traiter en priorité. `[A]`

## Causes probables
1. **Mot de passe par défaut** / non changé. `[C]` → [securiser-reseau-domotique](../../procedures/domotique/securiser-reseau-domotique.md)
2. **Firmware** obsolète (faille connue). `[C]` → [securiser-maintenir-domotique](../../professions/domotique/cards/securiser-maintenir-domotique.md)
3. Objet **non segmenté** (même réseau que les données sensibles). `[C]`

## Résolution
- Isoler l'objet, **mettre à jour**, changer les identifiants, **segmenter** (VLAN IoT), voire remplacer si non maintenu. `[A]`

## Cadre
- **Normes** : circuits / **actionneurs** pilotés **NF C 15-100** ; consignation à proximité des courants forts **NF C 18-510** ; systèmes domotiques **KNX (ISO/IEC 14543-3)**, protocoles (Zigbee/Z-Wave/**Matter**/Thread), performance de l'automatisation **NF EN ISO 52120**, cybersécurité (**ANSSI**) et données (**RGPD**) ⟦en prose, à confirmer⟧ `[B]` ⟦référence exacte à confirmer⟧. `respecte-norme`
- **Relations** : `traite-diagnostic` → [securiser-reseau-domotique](../../procedures/domotique/securiser-reseau-domotique.md).
- **Tags** : `metier:domotique famille:electricite sous-famille:domotique probleme:cybersecurite cluster:automatisation-du-batiment cluster:diagnostic type:diagnostic securite:cyber`

## Historique
| Version | Date | Auteur | Validateur | Motif |
|---|---|---|---|---|
| v0.1 | 2026-08-05 | IA | ⟦—⟧ | proposition initiale (Brouillon) |
