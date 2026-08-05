# Contrôle / maintenance domotique

> **Brouillon (v0) — proposé par IA, en attente de validation métier** (Loi 7/18). Modèle : [../../cards/CARD_TEMPLATE.md](../../cards/CARD_TEMPLATE.md).
> Niveaux de confiance : A normes/fabricant · B technique · C terrain validé · D hypothèse.

## Métadonnées
| Champ | Valeur |
|---|---|
| Identifiant | `controle-maintenance-domotique` |
| Titre | Contrôle / maintenance domotique |
| Profession | `metier:domotique` |
| Famille | `famille:electricite` |
| Sous-famille | `sous-famille:domotique` |
| Version | v0.1 |
| Auteur | IA (proposition) |
| Validateur | ⟦à valider métier⟧ |
| Statut | Brouillon |
| Indice de confiance | **C** |

## Points à vérifier
- [ ] **Box/passerelle** à jour et en ligne ; sauvegarde récente. `[C]`
- [ ] **Objets connectés** à jour (firmware). `[C]`
- [ ] **Segmentation** réseau (IoT) + mots de passe robustes. `[A]`
- [ ] **Capteurs** : piles/portée OK ; pas de faux positifs. `[C]`
- [ ] **Scénarios** critiques testés + **repli sûr**. `[A]`
- [ ] Documentation à jour (éviter le « boîte noire »). `[C]`

> Courant fort (actionneurs/tableau) : **habilité/consignation** ; données : **RGPD**.

## Cadre
- **Normes** : circuits / **actionneurs** pilotés **NF C 15-100** ; consignation à proximité des courants forts **NF C 18-510** ; systèmes domotiques **KNX (ISO/IEC 14543-3)**, protocoles (Zigbee/Z-Wave/**Matter**/Thread), performance de l'automatisation **NF EN ISO 52120**, cybersécurité (**ANSSI**) et données (**RGPD**) ⟦en prose, à confirmer⟧ `[B]` ⟦référence exacte à confirmer⟧. `respecte-norme`
- **Relations** : `verifie` → [securiser-maintenir-domotique](../../professions/domotique/cards/securiser-maintenir-domotique.md).
- **Tags** : `metier:domotique famille:electricite sous-famille:domotique type:checklist cluster:automatisation-du-batiment cluster:gtb-residentielle securite:cyber`

## Historique
| Version | Date | Auteur | Validateur | Motif |
|---|---|---|---|---|
| v0.1 | 2026-08-05 | IA | ⟦—⟧ | proposition initiale (Brouillon) |
