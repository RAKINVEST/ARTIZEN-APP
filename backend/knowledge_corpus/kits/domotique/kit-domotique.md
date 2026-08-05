# Kit domotique / mise en œuvre

> **Brouillon (v0) — proposé par IA, en attente de validation métier** (Loi 7/18). Modèle : [../../cards/CARD_TEMPLATE.md](../../cards/CARD_TEMPLATE.md).
> Niveaux de confiance : A normes/fabricant · B technique · C terrain validé · D hypothèse.

## Métadonnées
| Champ | Valeur |
|---|---|
| Identifiant | `kit-domotique` |
| Titre | Kit domotique / mise en œuvre |
| Profession | `metier:domotique` |
| Famille | `famille:electricite` |
| Sous-famille | `sous-famille:domotique` |
| Version | v0.1 |
| Auteur | IA (proposition) |
| Validateur | ⟦à valider métier⟧ |
| Statut | Brouillon |
| Indice de confiance | **C** |

## Composition conseillée
- Box/contrôleur + **passerelles** (Zigbee/Z-Wave), câble réseau. `[C]`
- Actionneurs (micromodules/DIN), capteurs (temp/présence/ouverture), piles. `[C]`
- Outils de configuration + **routeur/switch gérable** (VLAN IoT). `[C]`
- **EPI** électriques pour la partie courant fort (réservée **habilité**). `[A]`

## Cadre
- **Normes** : circuits / **actionneurs** pilotés **NF C 15-100** ; consignation à proximité des courants forts **NF C 18-510** ; systèmes domotiques **KNX (ISO/IEC 14543-3)**, protocoles (Zigbee/Z-Wave/**Matter**/Thread), performance de l'automatisation **NF EN ISO 52120**, cybersécurité (**ANSSI**) et données (**RGPD**) ⟦en prose, à confirmer⟧ `[B]` ⟦référence exacte à confirmer⟧. `respecte-norme`
- **Relations** : `utilise-kit` → [installer-box-domotique](../../professions/domotique/cards/installer-box-domotique.md).
- **Tags** : `metier:domotique famille:electricite sous-famille:domotique type:kit cluster:passerelles cluster:actionneurs equipement:box-domotique`

## Historique
| Version | Date | Auteur | Validateur | Motif |
|---|---|---|---|---|
| v0.1 | 2026-08-05 | IA | ⟦—⟧ | proposition initiale (Brouillon) |
