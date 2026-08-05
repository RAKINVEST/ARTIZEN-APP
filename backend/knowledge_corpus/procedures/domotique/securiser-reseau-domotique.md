# Sécuriser le réseau domotique (durcissement)

> **Brouillon (v0) — proposé par IA, en attente de validation métier** (Loi 7/18). Modèle : [../../cards/CARD_TEMPLATE.md](../../cards/CARD_TEMPLATE.md).
> Niveaux de confiance : A normes/fabricant · B technique · C terrain validé · D hypothèse.

## Métadonnées
| Champ | Valeur |
|---|---|
| Identifiant | `securiser-reseau-domotique` |
| Titre | Sécuriser le réseau domotique (durcissement) |
| Profession | `metier:domotique` |
| Famille | `famille:electricite` |
| Sous-famille | `sous-famille:securite` |
| Version | v0.1 |
| Auteur | IA (proposition) |
| Validateur | ⟦à valider métier⟧ |
| Statut | Brouillon |
| Indice de confiance | **B** |

## But
- Durcir la cybersécurité d'une installation domotique (objets connectés). `[A]`

## Étapes
1. **Changer tous les mots de passe** par défaut ; comptes individuels. `[A]`
2. **Segmenter** le réseau (**VLAN/SSID IoT** dédié, isolé des données sensibles). `[A]` ⟦selon équipement réseau à confirmer⟧
3. Activer les **mises à jour** ; désactiver services/ports inutiles ; préférer le **local**. `[A]`
4. **Sauvegarder** la configuration ; informer l'utilisateur (RGPD). `[C]` → [configurer-assistant-vocal](../../professions/domotique/cards/configurer-assistant-vocal.md)

> Un objet connecté non sécurisé = **porte d'entrée** dans le logement (référentiel **ANSSI**). `[B]`

## Cadre
- **Normes** : circuits / **actionneurs** pilotés **NF C 15-100** ; consignation à proximité des courants forts **NF C 18-510** ; systèmes domotiques **KNX (ISO/IEC 14543-3)**, protocoles (Zigbee/Z-Wave/**Matter**/Thread), performance de l'automatisation **NF EN ISO 52120**, cybersécurité (**ANSSI**) et données (**RGPD**) ⟦en prose, à confirmer⟧ `[B]` ⟦référence exacte à confirmer⟧. `respecte-norme`
- **Relations** : `cite-carte` → [securiser-maintenir-domotique](../../professions/domotique/cards/securiser-maintenir-domotique.md).
- **Tags** : `metier:domotique famille:electricite sous-famille:securite intervention:securiser cluster:automatisation-du-batiment cluster:passerelles type:procedure securite:cyber`

## Historique
| Version | Date | Auteur | Validateur | Motif |
|---|---|---|---|---|
| v0.1 | 2026-08-05 | IA | ⟦—⟧ | proposition initiale (Brouillon) |
