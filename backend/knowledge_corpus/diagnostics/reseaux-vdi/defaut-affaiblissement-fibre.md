# Défaut / affaiblissement fibre optique

> **Brouillon (v0) — proposé par IA, en attente de validation métier** (Loi 7/18). Modèle : [../../cards/CARD_TEMPLATE.md](../../cards/CARD_TEMPLATE.md).
> Niveaux de confiance : A normes/fabricant · B technique · C terrain validé · D hypothèse.

## Métadonnées
| Champ | Valeur |
|---|---|
| Identifiant | `defaut-affaiblissement-fibre` |
| Titre | Défaut / affaiblissement fibre optique |
| Profession | `metier:reseaux-vdi` |
| Famille | `famille:electricite` |
| Sous-famille | `sous-famille:reseaux-vdi` |
| Version | v0.1 |
| Auteur | IA (proposition) |
| Validateur | ⟦à valider métier⟧ |
| Statut | Brouillon |
| Indice de confiance | **C** |

## Symptôme
- Lien fibre **absent** ou **affaiblissement** élevé (débit dégradé). `[C]`

> **Sécurité laser** : ne jamais regarder dans une fibre/un connecteur pouvant être sous tension optique. `[A]`

## Causes probables
1. **Connecteur sale** / mal engagé. `[C]` → [raccorder-fibre-optique](../../professions/reseaux-vdi/cards/raccorder-fibre-optique.md)
2. **Rayon de courbure** trop faible / fibre pincée. `[C]`
3. Soudure/connectique défaillante ; fibre coupée. `[C]`

## Résolution
- Nettoyer les connecteurs, mesurer (photomètre/**OTDR**), reprendre la soudure/le cheminement. `[C]`

## Cadre
- **Normes** : installation électrique et **coffret de communication** résidentiel **NF C 15-100** ; opérations / consignation à proximité des courants forts **NF C 18-510** ; câblage résidentiel VDI (**UTE C 90-483**), systèmes de câblage (**NF EN 50173** / **ISO-IEC 11801**), sécurité laser fibre (**NF EN 60825**) ⟦en prose, à confirmer⟧ `[B]` ⟦référence exacte à confirmer⟧. `respecte-norme`
- **Relations** : `traite-diagnostic` → [raccorder-fibre-optique](../../professions/reseaux-vdi/cards/raccorder-fibre-optique.md).
- **Tags** : `metier:reseaux-vdi famille:electricite sous-famille:reseaux-vdi probleme:fibre cluster:fibre-optique cluster:diagnostic type:diagnostic securite:laser`

## Historique
| Version | Date | Auteur | Validateur | Motif |
|---|---|---|---|---|
| v0.1 | 2026-08-05 | IA | ⟦—⟧ | proposition initiale (Brouillon) |
