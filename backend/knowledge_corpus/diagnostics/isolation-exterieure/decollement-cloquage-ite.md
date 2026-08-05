# Décollement / cloquage d'un ETICS

> **Brouillon (v0) — proposé par IA, en attente de validation métier** (Loi 7/18). Modèle : [../../cards/CARD_TEMPLATE.md](../../cards/CARD_TEMPLATE.md).
> Niveaux de confiance : A normes/fabricant · B technique · C terrain validé · D hypothèse.

## Métadonnées
| Champ | Valeur |
|---|---|
| Identifiant | `decollement-cloquage-ite` |
| Titre | Décollement / cloquage d'un ETICS |
| Profession | `metier:isolation-exterieure` |
| Famille | `famille:enveloppe` |
| Sous-famille | `sous-famille:isolation-exterieure` |
| Version | v0.1 |
| Auteur | IA (proposition) |
| Validateur | ⟦à valider métier⟧ |
| Statut | Brouillon |
| Indice de confiance | **C** |

## Symptôme
- Zone **sonnant creux**, panneau ou enduit qui se **décolle**/cloque. `[C]`

> Risque de **chute de matériaux** → purger/protéger et sécuriser la zone. `[B]`

## Causes probables
1. **Collage/chevillage** insuffisant ou support non cohésif. `[C]` → [fixer-isolant-ite](../../professions/isolation-exterieure/cards/fixer-isolant-ite.md)
2. **Eau** derrière le système (point singulier défaillant). `[C]` → [traiter-points-singuliers-ite](../../professions/isolation-exterieure/cards/traiter-points-singuliers-ite.md)
3. Incompatibilité de composants (hors système). `[C]`

## Résolution
- Déposer la zone atteinte, traiter la cause, **reposer selon l'ATec** (re-collage/chevillage, armature, finition). `[C]`

## Cadre
- **Normes** : systèmes **ETICS** relevant du **CPT 3035 (CSTB)** / **ETAG 004–EAD** et d'**Avis Techniques** ⟦cadre exact à confirmer⟧ ; support en maçonnerie **DTU 20.1** ; ITE ventilée à bardage rapporté bois **DTU 41.2** `[B]` ⟦référence exacte à confirmer⟧. `respecte-norme`
- **Relations** : `traite-diagnostic` → [fixer-isolant-ite](../../professions/isolation-exterieure/cards/fixer-isolant-ite.md).
- **Tags** : `metier:isolation-exterieure famille:enveloppe sous-famille:isolation-exterieure probleme:decollement cluster:diagnostic cluster:fixation-collee cluster:fixation-chevillee type:diagnostic securite:hauteur`

## Historique
| Version | Date | Auteur | Validateur | Motif |
|---|---|---|---|---|
| v0.1 | 2026-08-04 | IA | ⟦—⟧ | proposition initiale (Brouillon) |
