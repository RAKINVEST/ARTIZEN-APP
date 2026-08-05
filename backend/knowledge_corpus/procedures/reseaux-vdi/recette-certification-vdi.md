# Recette & certification d'un réseau VDI

> **Brouillon (v0) — proposé par IA, en attente de validation métier** (Loi 7/18). Modèle : [../../cards/CARD_TEMPLATE.md](../../cards/CARD_TEMPLATE.md).
> Niveaux de confiance : A normes/fabricant · B technique · C terrain validé · D hypothèse.

## Métadonnées
| Champ | Valeur |
|---|---|
| Identifiant | `recette-certification-vdi` |
| Titre | Recette & certification d'un réseau VDI |
| Profession | `metier:reseaux-vdi` |
| Famille | `famille:electricite` |
| Sous-famille | `sous-famille:reseaux-vdi` |
| Version | v0.1 |
| Auteur | IA (proposition) |
| Validateur | ⟦à valider métier⟧ |
| Statut | Brouillon |
| Indice de confiance | **C** |

## But
- Réceptionner un réseau VDI par des **mesures normalisées** et un PV de certification. `[C]`

## Étapes
1. Régler le **certificateur** (catégorie/classe visée). `[C]` ⟦à confirmer⟧
2. Tester **chaque lien** (cuivre : mapping/longueur/affaiblissement/diaphonie ; fibre : affaiblissement). `[C]` → [tester-certifier-reseau](../../professions/reseaux-vdi/cards/tester-certifier-reseau.md)
3. **Corriger** les liens non conformes ; retester. `[C]`
4. Établir le **PV** (repérage, résultats, traçabilité). `[C]`

> Un simple test de continuité **ne vaut pas** une certification normalisée. `[B]`

## Cadre
- **Normes** : installation électrique et **coffret de communication** résidentiel **NF C 15-100** ; opérations / consignation à proximité des courants forts **NF C 18-510** ; câblage résidentiel VDI (**UTE C 90-483**), systèmes de câblage (**NF EN 50173** / **ISO-IEC 11801**), sécurité laser fibre (**NF EN 60825**) ⟦en prose, à confirmer⟧ `[B]` ⟦référence exacte à confirmer⟧. `respecte-norme`
- **Relations** : `cite-carte` → [tester-certifier-reseau](../../professions/reseaux-vdi/cards/tester-certifier-reseau.md).
- **Tags** : `metier:reseaux-vdi famille:electricite sous-famille:reseaux-vdi intervention:controler cluster:tests-et-certification cluster:reseaux-residentiels type:procedure securite:coexistence`

## Historique
| Version | Date | Auteur | Validateur | Motif |
|---|---|---|---|---|
| v0.1 | 2026-08-05 | IA | ⟦—⟧ | proposition initiale (Brouillon) |
