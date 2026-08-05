# Mauvais tirage / refoulement de fumée

> **Brouillon (v0) — proposé par IA, en attente de validation métier** (Loi 7/18). Modèle : [../../cards/CARD_TEMPLATE.md](../../cards/CARD_TEMPLATE.md).
> Niveaux de confiance : A normes/fabricant · B technique · C terrain validé · D hypothèse.

## Métadonnées
| Champ | Valeur |
|---|---|
| Identifiant | `mauvais-tirage-refoulement` |
| Titre | Mauvais tirage / refoulement de fumée |
| Profession | `metier:ramonage` |
| Famille | `famille:specialises` |
| Sous-famille | `sous-famille:ramonage` |
| Version | v0.1 |
| Auteur | IA (proposition) |
| Validateur | ⟦à valider métier⟧ |
| Statut | Brouillon |
| Indice de confiance | **C** |

## Symptôme
- **Refoulement** de fumée dans le logement, appareil qui **tire mal**, allumage difficile, odeur. `[C]`

> **DANGER monoxyde de carbone (CO)** : refoulement = risque d'**intoxication mortelle** → aérer, couper l'appareil, ne pas rester exposé. `[A]`

## Causes probables
1. **Conduit obstrué** (suie, bistre, nid). `[C]` → [ramoner-conduit-controle-visuel](../../professions/ramonage/cards/ramoner-conduit-controle-visuel.md)
2. **Ventilation** insuffisante (logement étanche, VMC, amenée d'air). `[C]` → [comprendre-tirage-ventilation-evacuation](../../professions/ramonage/cards/comprendre-tirage-ventilation-evacuation.md)
3. Conduit **sous-dimensionné/froid** ou débouché mal placé. `[C]`

## Résolution
- Ramoner/désobstruer, rétablir l'**amenée d'air**, corriger le débouché/tubage ; contrôler le CO. `[C]`

## Cadre
- **Normes** : évacuation des produits de combustion / fumisterie **DTU 24.1** ; âtrerie (cheminées/foyers) **DTU 24.2** ; conduits métalliques **NF EN 1856**, dimensionnement / tirage **NF EN 13384**, obligation de ramonage et **certificat** (**Règlement sanitaire départemental**) ⟦en prose, à confirmer⟧ `[B]` ⟦référence exacte à confirmer⟧. `respecte-norme`
- **Relations** : `traite-diagnostic` → [comprendre-tirage-ventilation-evacuation](../../professions/ramonage/cards/comprendre-tirage-ventilation-evacuation.md).
- **Tags** : `metier:ramonage famille:specialises sous-famille:ramonage probleme:tirage cluster:tirage cluster:diagnostic type:diagnostic securite:monoxyde`

## Historique
| Version | Date | Auteur | Validateur | Motif |
|---|---|---|---|---|
| v0.1 | 2026-08-05 | IA | ⟦—⟧ | proposition initiale (Brouillon) |
