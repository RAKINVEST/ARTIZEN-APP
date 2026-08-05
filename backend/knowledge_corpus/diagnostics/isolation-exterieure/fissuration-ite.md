# Fissuration d'un ETICS

> **Brouillon (v0) — proposé par IA, en attente de validation métier** (Loi 7/18). Modèle : [../../cards/CARD_TEMPLATE.md](../../cards/CARD_TEMPLATE.md).
> Niveaux de confiance : A normes/fabricant · B technique · C terrain validé · D hypothèse.

## Métadonnées
| Champ | Valeur |
|---|---|
| Identifiant | `fissuration-ite` |
| Titre | Fissuration d'un ETICS |
| Profession | `metier:isolation-exterieure` |
| Famille | `famille:enveloppe` |
| Sous-famille | `sous-famille:isolation-exterieure` |
| Version | v0.1 |
| Auteur | IA (proposition) |
| Validateur | ⟦à valider métier⟧ |
| Statut | Brouillon |
| Indice de confiance | **C** |

## Symptôme
- **Fissures** dans la finition / le sous-enduit (souvent aux angles d'ouvertures). `[C]`

## Causes probables
1. **Armature** insuffisante / mouchoirs d'angle absents. `[C]` → [realiser-sous-enduit-arme](../../professions/isolation-exterieure/cards/realiser-sous-enduit-arme.md)
2. Joints d'isolant ouverts / défaut de planéité. `[C]` → [fixer-isolant-ite](../../professions/isolation-exterieure/cards/fixer-isolant-ite.md)
3. Mouvements/dilatations (teinte trop sombre, joints de fractionnement). `[C]`

## Résolution
- Reprendre localement avec **renfort d'armature**, dans le respect du système (composants ATec). `[C]`

## Cadre
- **Normes** : systèmes **ETICS** relevant du **CPT 3035 (CSTB)** / **ETAG 004–EAD** et d'**Avis Techniques** ⟦cadre exact à confirmer⟧ ; support en maçonnerie **DTU 20.1** ; ITE ventilée à bardage rapporté bois **DTU 41.2** `[B]` ⟦référence exacte à confirmer⟧. `respecte-norme`
- **Relations** : `traite-diagnostic` → [realiser-sous-enduit-arme](../../professions/isolation-exterieure/cards/realiser-sous-enduit-arme.md).
- **Tags** : `metier:isolation-exterieure famille:enveloppe sous-famille:isolation-exterieure probleme:fissure cluster:diagnostic cluster:armatures cluster:reparation type:diagnostic securite:hauteur`

## Historique
| Version | Date | Auteur | Validateur | Motif |
|---|---|---|---|---|
| v0.1 | 2026-08-04 | IA | ⟦—⟧ | proposition initiale (Brouillon) |
