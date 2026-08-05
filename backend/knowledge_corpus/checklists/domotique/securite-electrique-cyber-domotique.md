# Sécurité — électrique & cyber (domotique)

> **Brouillon (v0) — proposé par IA, en attente de validation métier** (Loi 7/18). Modèle : [../../cards/CARD_TEMPLATE.md](../../cards/CARD_TEMPLATE.md).
> Niveaux de confiance : A normes/fabricant · B technique · C terrain validé · D hypothèse.

## Métadonnées
| Champ | Valeur |
|---|---|
| Identifiant | `securite-electrique-cyber-domotique` |
| Titre | Sécurité — électrique & cyber (domotique) |
| Profession | `metier:domotique` |
| Famille | `famille:electricite` |
| Sous-famille | `sous-famille:securite` |
| Version | v0.1 |
| Auteur | IA (proposition) |
| Validateur | ⟦à valider métier⟧ |
| Statut | Brouillon |
| Indice de confiance | **B** |

## Points à vérifier
- [ ] **Courant fort** (actionneurs/tableau) : **consignation** + **habilité** (NF C 18-510). `[A]`
- [ ] **Coexistence CF/CFa** : séparations respectées (NF C 15-100). `[A]`
- [ ] **Cybersécurité** : mots de passe, **segmentation**, mises à jour. `[A]`
- [ ] **Données (RGPD)** : information utilisateur, minimisation, local privilégié. `[A]`
- [ ] **Repli sûr** des scénarios (aucune situation dangereuse). `[A]`
- [ ] **Arrêt immédiat** en cas de danger. `[A]`

## Cadre
- **Normes** : circuits / **actionneurs** pilotés **NF C 15-100** ; consignation à proximité des courants forts **NF C 18-510** ; systèmes domotiques **KNX (ISO/IEC 14543-3)**, protocoles (Zigbee/Z-Wave/**Matter**/Thread), performance de l'automatisation **NF EN ISO 52120**, cybersécurité (**ANSSI**) et données (**RGPD**) ⟦en prose, à confirmer⟧ `[B]` ⟦référence exacte à confirmer⟧. `respecte-norme`
- **Relations** : `cite-procedure` → [securiser-reseau-domotique](../../procedures/domotique/securiser-reseau-domotique.md).
- **Tags** : `metier:domotique famille:electricite sous-famille:securite type:checklist cluster:automatisation-du-batiment securite:electrique securite:cyber`

## Historique
| Version | Date | Auteur | Validateur | Motif |
|---|---|---|---|---|
| v0.1 | 2026-08-05 | IA | ⟦—⟧ | proposition initiale (Brouillon) |
