# Interférences dues aux courants forts

> **Brouillon (v0) — proposé par IA, en attente de validation métier** (Loi 7/18). Modèle : [../../cards/CARD_TEMPLATE.md](../../cards/CARD_TEMPLATE.md).
> Niveaux de confiance : A normes/fabricant · B technique · C terrain validé · D hypothèse.

## Métadonnées
| Champ | Valeur |
|---|---|
| Identifiant | `interference-courants-forts` |
| Titre | Interférences dues aux courants forts |
| Profession | `metier:reseaux-vdi` |
| Famille | `famille:electricite` |
| Sous-famille | `sous-famille:reseaux-vdi` |
| Version | v0.1 |
| Auteur | IA (proposition) |
| Validateur | ⟦à valider métier⟧ |
| Statut | Brouillon |
| Indice de confiance | **C** |

## Symptôme
- **Perturbations**/erreurs sur le réseau, débit instable près de câbles de puissance. `[C]`

## Causes probables
1. **Défaut de séparation** courants forts/faibles (cheminement commun). `[C]` → [cabler-rj45-reseau](../../professions/reseaux-vdi/cards/cabler-rj45-reseau.md)
2. **Masse/équipotentialité** insuffisante de la baie. `[C]` → [controler-mise-a-la-terre](../../professions/electricite-generale/cards/controler-mise-a-la-terre.md)
3. Câble non blindé en environnement perturbé. `[C]`

## Résolution
- Rétablir la **séparation** (distances/blindage), la mise à la terre ; toute reprise près des courants forts → **consignation (habilité)**. `[A]`

## Cadre
- **Normes** : installation électrique et **coffret de communication** résidentiel **NF C 15-100** ; opérations / consignation à proximité des courants forts **NF C 18-510** ; câblage résidentiel VDI (**UTE C 90-483**), systèmes de câblage (**NF EN 50173** / **ISO-IEC 11801**), sécurité laser fibre (**NF EN 60825**) ⟦en prose, à confirmer⟧ `[B]` ⟦référence exacte à confirmer⟧. `respecte-norme`
- **Relations** : `traite-diagnostic` → [cabler-rj45-reseau](../../professions/reseaux-vdi/cards/cabler-rj45-reseau.md).
- **Tags** : `metier:reseaux-vdi famille:electricite sous-famille:reseaux-vdi probleme:interference cluster:diagnostic cluster:reseaux-residentiels type:diagnostic securite:coexistence relation:electricite-generale`

## Historique
| Version | Date | Auteur | Validateur | Motif |
|---|---|---|---|---|
| v0.1 | 2026-08-05 | IA | ⟦—⟧ | proposition initiale (Brouillon) |
