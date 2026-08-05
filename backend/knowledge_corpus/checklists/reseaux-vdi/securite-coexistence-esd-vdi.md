# Sécurité — coexistence, ESD & laser (VDI)

> **Brouillon (v0) — proposé par IA, en attente de validation métier** (Loi 7/18). Modèle : [../../cards/CARD_TEMPLATE.md](../../cards/CARD_TEMPLATE.md).
> Niveaux de confiance : A normes/fabricant · B technique · C terrain validé · D hypothèse.

## Métadonnées
| Champ | Valeur |
|---|---|
| Identifiant | `securite-coexistence-esd-vdi` |
| Titre | Sécurité — coexistence, ESD & laser (VDI) |
| Profession | `metier:reseaux-vdi` |
| Famille | `famille:electricite` |
| Sous-famille | `sous-famille:securite` |
| Version | v0.1 |
| Auteur | IA (proposition) |
| Validateur | ⟦à valider métier⟧ |
| Statut | Brouillon |
| Indice de confiance | **B** |

## Points à vérifier
- [ ] **Coexistence courants forts/faibles** : distances/séparations (NF C 15-100). `[A]`
- [ ] **Consignation** dès qu'on approche des courants forts : **habilité** (NF C 18-510). `[A]`
- [ ] **Travail hors tension** privilégié (éviter les équipements alimentés). `[A]`
- [ ] **Protection ESD** des équipements électroniques (bracelet). `[B]`
- [ ] **Laser fibre** : ne jamais regarder dans une fibre active ; capuchons. `[A]`
- [ ] **Conformité** (grade/certification) ; **arrêt immédiat** en cas de danger. `[A]`

## Cadre
- **Normes** : installation électrique et **coffret de communication** résidentiel **NF C 15-100** ; opérations / consignation à proximité des courants forts **NF C 18-510** ; câblage résidentiel VDI (**UTE C 90-483**), systèmes de câblage (**NF EN 50173** / **ISO-IEC 11801**), sécurité laser fibre (**NF EN 60825**) ⟦en prose, à confirmer⟧ `[B]` ⟦référence exacte à confirmer⟧. `respecte-norme`
- **Relations** : `cite-carte` → [cabler-rj45-reseau](../../professions/reseaux-vdi/cards/cabler-rj45-reseau.md).
- **Tags** : `metier:reseaux-vdi famille:electricite sous-famille:securite type:checklist cluster:securite securite:coexistence securite:laser relation:electricite-generale`

## Historique
| Version | Date | Auteur | Validateur | Motif |
|---|---|---|---|---|
| v0.1 | 2026-08-05 | IA | ⟦—⟧ | proposition initiale (Brouillon) |
