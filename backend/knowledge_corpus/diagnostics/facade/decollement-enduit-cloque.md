# Décollement / cloquage d'un revêtement de façade

> **Brouillon (v0) — proposé par IA, en attente de validation métier** (Loi 7/18). Modèle : [../../cards/CARD_TEMPLATE.md](../../cards/CARD_TEMPLATE.md).
> Niveaux de confiance : A normes/fabricant · B technique · C terrain validé · D hypothèse.

## Métadonnées
| Champ | Valeur |
|---|---|
| Identifiant | `decollement-enduit-cloque` |
| Titre | Décollement / cloquage d'un revêtement de façade |
| Profession | `metier:facade` |
| Famille | `famille:enveloppe` |
| Sous-famille | `sous-famille:facade` |
| Version | v0.1 |
| Auteur | IA (proposition) |
| Validateur | ⟦à valider métier⟧ |
| Statut | Brouillon |
| Indice de confiance | **C** |

## Symptôme
- Revêtement **sonnant creux**, **cloqué**, écaillé ou qui se détache. `[C]`

> Risque de **chute de matériaux** → purger/protéger la zone. `[B]`

## Causes probables
1. Défaut d'adhérence au support (préparation insuffisante). `[C]`
2. **Humidité** derrière le revêtement. `[C]` → [infiltration-facade](infiltration-facade.md)
3. Incompatibilité revêtement/support. `[C]`

## Résolution
- **Purger** le non adhérent, traiter la cause (humidité), reprendre l'enduit/revêtement. `[C]` → [reprendre-enduit-facade](../../professions/facade/cards/reprendre-enduit-facade.md)

## Cadre
- **Normes** : enduits de mortiers **DTU 26.1** ; réfection de façades par revêtements d'imperméabilité **DTU 42.1** ; maçonnerie de petits éléments **DTU 20.1** `[B]` ⟦référence exacte à confirmer⟧. `respecte-norme`
- **Relations** : `traite-diagnostic` → [reprendre-enduit-facade](../../professions/facade/cards/reprendre-enduit-facade.md).
- **Tags** : `metier:facade famille:enveloppe sous-famille:facade probleme:decollement cluster:diagnostic cluster:revetements type:diagnostic securite:hauteur`

## Historique
| Version | Date | Auteur | Validateur | Motif |
|---|---|---|---|---|
| v0.1 | 2026-08-04 | IA | ⟦—⟧ | proposition initiale (Brouillon) |
