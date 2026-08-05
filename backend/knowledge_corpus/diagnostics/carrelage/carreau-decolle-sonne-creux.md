# Carreau décollé / sonne creux

> **Brouillon (v0) — proposé par IA, en attente de validation métier** (Loi 7/18). Modèle : [../../cards/CARD_TEMPLATE.md](../../cards/CARD_TEMPLATE.md).
> Niveaux de confiance : A normes/fabricant · B technique · C terrain validé · D hypothèse.

## Métadonnées
| Champ | Valeur |
|---|---|
| Identifiant | `carreau-decolle-sonne-creux` |
| Titre | Carreau décollé / sonne creux |
| Profession | `metier:carrelage` |
| Famille | `famille:finition` |
| Sous-famille | `sous-famille:carrelage` |
| Version | v0.1 |
| Auteur | IA (proposition) |
| Validateur | ⟦à valider métier⟧ |
| Statut | Brouillon |
| Indice de confiance | **C** |

## Symptôme
- Carreau qui **sonne creux**, bouge ou se **décolle**. `[C]`

## Causes probables
1. **Taux d'encollage** insuffisant / pas de double encollage (grand format). `[C]` → [poser-carrelage-colle](../../professions/carrelage/cards/poser-carrelage-colle.md)
2. **Support** non préparé (poussière, pas de primaire, humidité). `[C]` → [preparer-support-ragreage](../../professions/carrelage/cards/preparer-support-ragreage.md)
3. **Mouvement** du support / absence de joint souple. `[C]` → [fissure-carrelage-joint](fissure-carrelage-joint.md)

## Résolution
- Déposer les carreaux atteints, reprendre le support/collage (double encollage), reposer ; traiter la cause. `[C]`

## Cadre
- **Normes** : pose collée des revêtements céramiques et pierres naturelles **DTU 52.2** ; pose scellée **DTU 52.1** ; électricité (plancher chauffant / zones équipées) **NF C 15-100** ; **CPT** CSTB (grands formats, SEL sous carrelage), classement **UPEC** et diagnostic **amiante** (colles anciennes) ⟦en prose, à confirmer⟧ `[B]` ⟦référence exacte à confirmer⟧. `respecte-norme`
- **Relations** : `traite-diagnostic` → [poser-carrelage-colle](../../professions/carrelage/cards/poser-carrelage-colle.md).
- **Tags** : `metier:carrelage famille:finition sous-famille:carrelage probleme:decollement cluster:pose-collee cluster:diagnostics type:diagnostic securite:silice`

## Historique
| Version | Date | Auteur | Validateur | Motif |
|---|---|---|---|---|
| v0.1 | 2026-08-05 | IA | ⟦—⟧ | proposition initiale (Brouillon) |
