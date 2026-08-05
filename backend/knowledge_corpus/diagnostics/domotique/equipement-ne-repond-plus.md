# Équipement domotique qui ne répond plus

> **Brouillon (v0) — proposé par IA, en attente de validation métier** (Loi 7/18). Modèle : [../../cards/CARD_TEMPLATE.md](../../cards/CARD_TEMPLATE.md).
> Niveaux de confiance : A normes/fabricant · B technique · C terrain validé · D hypothèse.

## Métadonnées
| Champ | Valeur |
|---|---|
| Identifiant | `equipement-ne-repond-plus` |
| Titre | Équipement domotique qui ne répond plus |
| Profession | `metier:domotique` |
| Famille | `famille:electricite` |
| Sous-famille | `sous-famille:domotique` |
| Version | v0.1 |
| Auteur | IA (proposition) |
| Validateur | ⟦à valider métier⟧ |
| Statut | Brouillon |
| Indice de confiance | **C** |

## Symptôme
- Un objet/**actionneur** ne répond plus à la commande (app/assistant). `[C]`

## Causes probables
1. **Réseau/passerelle** (Wi-Fi/box) HS ou hors ligne. `[C]` → [installer-box-domotique](../../professions/domotique/cards/installer-box-domotique.md)
2. **Alimentation** (pile capteur, actionneur, coupure). `[C]` → [poser-capteurs-domotique](../../professions/domotique/cards/poser-capteurs-domotique.md)
3. **Désappairage** / mise à jour ayant cassé la compatibilité. `[C]`

## Résolution
- Vérifier réseau/box, alimentation/piles, ré-appairer ; côté **courant fort** → électricien **habilité**. `[C]` → [controler-tableau-electrique](../../professions/electricite-generale/cards/controler-tableau-electrique.md)

## Cadre
- **Normes** : circuits / **actionneurs** pilotés **NF C 15-100** ; consignation à proximité des courants forts **NF C 18-510** ; systèmes domotiques **KNX (ISO/IEC 14543-3)**, protocoles (Zigbee/Z-Wave/**Matter**/Thread), performance de l'automatisation **NF EN ISO 52120**, cybersécurité (**ANSSI**) et données (**RGPD**) ⟦en prose, à confirmer⟧ `[B]` ⟦référence exacte à confirmer⟧. `respecte-norme`
- **Relations** : `traite-diagnostic` → [securiser-maintenir-domotique](../../professions/domotique/cards/securiser-maintenir-domotique.md).
- **Tags** : `metier:domotique famille:electricite sous-famille:domotique probleme:panne cluster:passerelles cluster:diagnostic type:diagnostic securite:coexistence relation:electricite-generale`

## Historique
| Version | Date | Auteur | Validateur | Motif |
|---|---|---|---|---|
| v0.1 | 2026-08-05 | IA | ⟦—⟧ | proposition initiale (Brouillon) |
