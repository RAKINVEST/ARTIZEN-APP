# Contrôle / maintenance réseau VDI

> **Brouillon (v0) — proposé par IA, en attente de validation métier** (Loi 7/18). Modèle : [../../cards/CARD_TEMPLATE.md](../../cards/CARD_TEMPLATE.md).
> Niveaux de confiance : A normes/fabricant · B technique · C terrain validé · D hypothèse.

## Métadonnées
| Champ | Valeur |
|---|---|
| Identifiant | `controle-maintenance-vdi` |
| Titre | Contrôle / maintenance réseau VDI |
| Profession | `metier:reseaux-vdi` |
| Famille | `famille:electricite` |
| Sous-famille | `sous-famille:reseaux-vdi` |
| Version | v0.1 |
| Auteur | IA (proposition) |
| Validateur | ⟦à valider métier⟧ |
| Statut | Brouillon |
| Indice de confiance | **C** |

## Points à vérifier
- [ ] **Repérage** des liens/brassage à jour. `[C]`
- [ ] **Certification** disponible / liens conformes. `[C]`
- [ ] **Séparation** courants forts/faibles respectée. `[C]`
- [ ] **Mise à la terre**/équipotentialité de la baie. `[C]`
- [ ] **Fibre** : connecteurs propres, affaiblissement OK. `[C]`
- [ ] Actifs : ventilation, alimentation, état. `[C]`

> Toute intervention près des **courants forts** : **consignation (habilité)** ; **ESD** pour les actifs.

## Cadre
- **Normes** : installation électrique et **coffret de communication** résidentiel **NF C 15-100** ; opérations / consignation à proximité des courants forts **NF C 18-510** ; câblage résidentiel VDI (**UTE C 90-483**), systèmes de câblage (**NF EN 50173** / **ISO-IEC 11801**), sécurité laser fibre (**NF EN 60825**) ⟦en prose, à confirmer⟧ `[B]` ⟦référence exacte à confirmer⟧. `respecte-norme`
- **Relations** : `verifie` → [diagnostiquer-maintenir-vdi](../../professions/reseaux-vdi/cards/diagnostiquer-maintenir-vdi.md).
- **Tags** : `metier:reseaux-vdi famille:electricite sous-famille:reseaux-vdi type:checklist cluster:maintenance cluster:tests-et-certification securite:coexistence`

## Historique
| Version | Date | Auteur | Validateur | Motif |
|---|---|---|---|---|
| v0.1 | 2026-08-05 | IA | ⟦—⟧ | proposition initiale (Brouillon) |
