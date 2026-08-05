# Joint dégradé / infiltration (pièce humide)

> **Brouillon (v0) — proposé par IA, en attente de validation métier** (Loi 7/18). Modèle : [../../cards/CARD_TEMPLATE.md](../../cards/CARD_TEMPLATE.md).
> Niveaux de confiance : A normes/fabricant · B technique · C terrain validé · D hypothèse.

## Métadonnées
| Champ | Valeur |
|---|---|
| Identifiant | `joint-degrade-infiltration` |
| Titre | Joint dégradé / infiltration (pièce humide) |
| Profession | `metier:carrelage` |
| Famille | `famille:finition` |
| Sous-famille | `sous-famille:carrelage` |
| Version | v0.1 |
| Auteur | IA (proposition) |
| Validateur | ⟦à valider métier⟧ |
| Statut | Brouillon |
| Indice de confiance | **C** |

## Symptôme
- Joints **fissurés/moisis**, joint souple décollé, traces d'humidité derrière le carrelage. `[C]`

## Causes probables
1. **Joint souple** (angles/pourtour douche) dégradé → infiltration. `[C]` → [realiser-joints](../../professions/carrelage/cards/realiser-joints.md)
2. **Étanchéité sous carrelage** absente/défaillante en zone d'eau. `[C]` → [poser-faience-murale](../../professions/carrelage/cards/poser-faience-murale.md)
3. Ventilation insuffisante (moisissures). `[C]`

## Résolution
- Refaire les **joints souples**, vérifier/reprendre l'étanchéité ; ne pas se contenter du joint de surface. `[C]`

## Cadre
- **Normes** : pose collée des revêtements céramiques et pierres naturelles **DTU 52.2** ; pose scellée **DTU 52.1** ; électricité (plancher chauffant / zones équipées) **NF C 15-100** ; **CPT** CSTB (grands formats, SEL sous carrelage), classement **UPEC** et diagnostic **amiante** (colles anciennes) ⟦en prose, à confirmer⟧ `[B]` ⟦référence exacte à confirmer⟧. `respecte-norme`
- **Relations** : `traite-diagnostic` → [diagnostiquer-controler-carrelage](../../professions/carrelage/cards/diagnostiquer-controler-carrelage.md).
- **Tags** : `metier:carrelage famille:finition sous-famille:carrelage probleme:infiltration cluster:joints cluster:diagnostics type:diagnostic securite:silice`

## Historique
| Version | Date | Auteur | Validateur | Motif |
|---|---|---|---|---|
| v0.1 | 2026-08-05 | IA | ⟦—⟧ | proposition initiale (Brouillon) |
