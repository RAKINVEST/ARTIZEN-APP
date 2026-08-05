# Corrosion / perforation d'un ouvrage métallique

> **Brouillon (v0) — proposé par IA, en attente de validation métier** (Loi 7/18). Modèle : [../../cards/CARD_TEMPLATE.md](../../cards/CARD_TEMPLATE.md).
> Niveaux de confiance : A normes/fabricant · B technique · C terrain validé · D hypothèse.

## Métadonnées
| Champ | Valeur |
|---|---|
| Identifiant | `corrosion-perforation-zinguerie` |
| Titre | Corrosion / perforation d'un ouvrage métallique |
| Profession | `metier:zinguerie` |
| Famille | `famille:enveloppe` |
| Sous-famille | `sous-famille:zinguerie` |
| Version | v0.1 |
| Auteur | IA (proposition) |
| Validateur | ⟦à valider métier⟧ |
| Statut | Brouillon |
| Indice de confiance | **C** |

## Symptôme
- Traces de **corrosion**, **perforations**, traînées. `[C]`

## Causes probables
1. Vieillissement / stagnation d'eau. `[C]`
2. **Incompatibilité galvanique** (métaux différents). `[C]` ⟦couples à confirmer⟧
3. Défaut d'évacuation (rétention). `[C]`

## Résolution
- Réparer (brasure/pièce) ou **remplacer** ; corriger la cause (pente, compatibilité). `[C]` → [controler-reparer-chenaux](../../professions/zinguerie/cards/controler-reparer-chenaux.md)

## Cadre
- **Normes** : évacuation des eaux pluviales **DTU 40.5** ; couverture zinc **DTU 40.41** ; couverture cuivre **DTU 40.45** `[B]` ⟦référence exacte à confirmer⟧. `respecte-norme`
- **Relations** : `traite-diagnostic` → [souder-zinc](../../professions/zinguerie/cards/souder-zinc.md).
- **Tags** : `metier:zinguerie famille:enveloppe sous-famille:zinguerie probleme:corrosion probleme:perforation cluster:diagnostic cluster:reparation type:diagnostic securite:hauteur`

## Historique
| Version | Date | Auteur | Validateur | Motif |
|---|---|---|---|---|
| v0.1 | 2026-08-04 | IA | ⟦—⟧ | proposition initiale (Brouillon) |
