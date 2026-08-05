# Kit courants faibles / VDI

> **Brouillon (v0) — proposé par IA, en attente de validation métier** (Loi 7/18). Modèle : [../../cards/CARD_TEMPLATE.md](../../cards/CARD_TEMPLATE.md).
> Niveaux de confiance : A normes/fabricant · B technique · C terrain validé · D hypothèse.

## Métadonnées
| Champ | Valeur |
|---|---|
| Identifiant | `kit-courants-faibles` |
| Titre | Kit courants faibles / VDI |
| Profession | `metier:reseaux-vdi` |
| Famille | `famille:electricite` |
| Sous-famille | `sous-famille:reseaux-vdi` |
| Version | v0.1 |
| Auteur | IA (proposition) |
| Validateur | ⟦à valider métier⟧ |
| Statut | Brouillon |
| Indice de confiance | **C** |

## Composition conseillée
- Pince à sertir RJ45, **outil d'insertion** (LSA/110), dénudeur, testeur de câblage. `[C]`
- **Certificateur** (ou testeur qualifié) ; **photomètre**/OTDR + kit de nettoyage fibre. `[C]`
- Panneaux/cordons de brassage, repères, aiguille tire-fils. `[C]`
- **EPI/ESD** : bracelet antistatique ; protection laser (fibre). `[B]`

## Cadre
- **Normes** : installation électrique et **coffret de communication** résidentiel **NF C 15-100** ; opérations / consignation à proximité des courants forts **NF C 18-510** ; câblage résidentiel VDI (**UTE C 90-483**), systèmes de câblage (**NF EN 50173** / **ISO-IEC 11801**), sécurité laser fibre (**NF EN 60825**) ⟦en prose, à confirmer⟧ `[B]` ⟦référence exacte à confirmer⟧. `respecte-norme`
- **Relations** : `utilise-kit` → [cabler-rj45-reseau](../../professions/reseaux-vdi/cards/cabler-rj45-reseau.md).
- **Tags** : `metier:reseaux-vdi famille:electricite sous-famille:reseaux-vdi type:kit cluster:cablage-rj45 cluster:tests-et-certification equipement:certificateur`

## Historique
| Version | Date | Auteur | Validateur | Motif |
|---|---|---|---|---|
| v0.1 | 2026-08-05 | IA | ⟦—⟧ | proposition initiale (Brouillon) |
