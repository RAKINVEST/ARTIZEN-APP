# Choc / impact sur ETICS (soubassement)

> **Brouillon (v0) — proposé par IA, en attente de validation métier** (Loi 7/18). Modèle : [../../cards/CARD_TEMPLATE.md](../../cards/CARD_TEMPLATE.md).
> Niveaux de confiance : A normes/fabricant · B technique · C terrain validé · D hypothèse.

## Métadonnées
| Champ | Valeur |
|---|---|
| Identifiant | `choc-impact-ite` |
| Titre | Choc / impact sur ETICS (soubassement) |
| Profession | `metier:isolation-exterieure` |
| Famille | `famille:enveloppe` |
| Sous-famille | `sous-famille:isolation-exterieure` |
| Version | v0.1 |
| Auteur | IA (proposition) |
| Validateur | ⟦à valider métier⟧ |
| Statut | Brouillon |
| Indice de confiance | **C** |

## Symptôme
- **Enfoncement**, perforation ou épaufrure, souvent en **soubassement** (zone exposée aux chocs). `[C]`

## Causes probables
1. Choc mécanique (zone basse, passages). `[C]`
2. Résistance aux chocs insuffisante pour l'exposition. `[C]` ⟦classe de résistance à confirmer⟧
3. Isolant/finition non adaptés au soubassement. `[C]`

## Résolution
- Réparer localement (isolant + armature renforcée + finition) ; en zone de choc, système/soubassement renforcé. `[C]` → [traiter-points-singuliers-ite](../../professions/isolation-exterieure/cards/traiter-points-singuliers-ite.md)

## Cadre
- **Normes** : systèmes **ETICS** relevant du **CPT 3035 (CSTB)** / **ETAG 004–EAD** et d'**Avis Techniques** ⟦cadre exact à confirmer⟧ ; support en maçonnerie **DTU 20.1** ; ITE ventilée à bardage rapporté bois **DTU 41.2** `[B]` ⟦référence exacte à confirmer⟧. `respecte-norme`
- **Relations** : `traite-diagnostic` → [traiter-points-singuliers-ite](../../professions/isolation-exterieure/cards/traiter-points-singuliers-ite.md).
- **Tags** : `metier:isolation-exterieure famille:enveloppe sous-famille:isolation-exterieure probleme:choc cluster:diagnostic cluster:points-singuliers cluster:reparation type:diagnostic securite:hauteur`

## Historique
| Version | Date | Auteur | Validateur | Motif |
|---|---|---|---|---|
| v0.1 | 2026-08-04 | IA | ⟦—⟧ | proposition initiale (Brouillon) |
