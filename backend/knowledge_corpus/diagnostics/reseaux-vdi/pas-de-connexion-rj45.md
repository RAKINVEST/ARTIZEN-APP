# Pas de connexion / débit faible (RJ45)

> **Brouillon (v0) — proposé par IA, en attente de validation métier** (Loi 7/18). Modèle : [../../cards/CARD_TEMPLATE.md](../../cards/CARD_TEMPLATE.md).
> Niveaux de confiance : A normes/fabricant · B technique · C terrain validé · D hypothèse.

## Métadonnées
| Champ | Valeur |
|---|---|
| Identifiant | `pas-de-connexion-rj45` |
| Titre | Pas de connexion / débit faible (RJ45) |
| Profession | `metier:reseaux-vdi` |
| Famille | `famille:electricite` |
| Sous-famille | `sous-famille:reseaux-vdi` |
| Version | v0.1 |
| Auteur | IA (proposition) |
| Validateur | ⟦à valider métier⟧ |
| Statut | Brouillon |
| Indice de confiance | **C** |

## Symptôme
- **Pas de lien** réseau, ou **débit faible**/coupures sur une prise RJ45. `[C]`

## Causes probables
1. **Connectique** RJ45 défectueuse (détoronnage, paire inversée). `[C]` → [cabler-rj45-reseau](../../professions/reseaux-vdi/cards/cabler-rj45-reseau.md)
2. **Brassage** absent/erroné dans le coffret. `[C]` → [installer-baie-coffret-brassage](../../professions/reseaux-vdi/cards/installer-baie-coffret-brassage.md)
3. Longueur excessive / câble endommagé / catégorie inadaptée. `[C]`

## Résolution
- **Tester** (certificateur), reprendre la connectique/le brassage, vérifier la longueur. `[C]` → [tester-certifier-reseau](../../professions/reseaux-vdi/cards/tester-certifier-reseau.md)

## Cadre
- **Normes** : installation électrique et **coffret de communication** résidentiel **NF C 15-100** ; opérations / consignation à proximité des courants forts **NF C 18-510** ; câblage résidentiel VDI (**UTE C 90-483**), systèmes de câblage (**NF EN 50173** / **ISO-IEC 11801**), sécurité laser fibre (**NF EN 60825**) ⟦en prose, à confirmer⟧ `[B]` ⟦référence exacte à confirmer⟧. `respecte-norme`
- **Relations** : `traite-diagnostic` → [tester-certifier-reseau](../../professions/reseaux-vdi/cards/tester-certifier-reseau.md).
- **Tags** : `metier:reseaux-vdi famille:electricite sous-famille:reseaux-vdi probleme:connexion cluster:cablage-rj45 cluster:diagnostic type:diagnostic securite:coexistence`

## Historique
| Version | Date | Auteur | Validateur | Motif |
|---|---|---|---|---|
| v0.1 | 2026-08-05 | IA | ⟦—⟧ | proposition initiale (Brouillon) |
