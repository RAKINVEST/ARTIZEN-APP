# Fissure de carrelage / de joint

> **Brouillon (v0) — proposé par IA, en attente de validation métier** (Loi 7/18). Modèle : [../../cards/CARD_TEMPLATE.md](../../cards/CARD_TEMPLATE.md).
> Niveaux de confiance : A normes/fabricant · B technique · C terrain validé · D hypothèse.

## Métadonnées
| Champ | Valeur |
|---|---|
| Identifiant | `fissure-carrelage-joint` |
| Titre | Fissure de carrelage / de joint |
| Profession | `metier:carrelage` |
| Famille | `famille:finition` |
| Sous-famille | `sous-famille:carrelage` |
| Version | v0.1 |
| Auteur | IA (proposition) |
| Validateur | ⟦à valider métier⟧ |
| Statut | Brouillon |
| Indice de confiance | **C** |

## Symptôme
- **Fissure** traversant carreaux et/ou joints, souvent en ligne. `[C]`

## Causes probables
1. **Absence de joint souple** (périphérie/fractionnement) → contraintes. `[C]` → [realiser-joints](../../professions/carrelage/cards/realiser-joints.md)
2. **Mouvement du support** (fissure de dalle, reprise sur joint de gros œuvre). `[C]`
3. Retrait/dilatation (plancher chauffant sans joints adaptés). `[C]` → [preparer-support-ragreage](../../professions/carrelage/cards/preparer-support-ragreage.md)

## Résolution
- Traiter la cause (joint souple/fractionnement, mouvement du support), reprendre la zone. `[C]`

## Cadre
- **Normes** : pose collée des revêtements céramiques et pierres naturelles **DTU 52.2** ; pose scellée **DTU 52.1** ; électricité (plancher chauffant / zones équipées) **NF C 15-100** ; **CPT** CSTB (grands formats, SEL sous carrelage), classement **UPEC** et diagnostic **amiante** (colles anciennes) ⟦en prose, à confirmer⟧ `[B]` ⟦référence exacte à confirmer⟧. `respecte-norme`
- **Relations** : `traite-diagnostic` → [realiser-joints](../../professions/carrelage/cards/realiser-joints.md).
- **Tags** : `metier:carrelage famille:finition sous-famille:carrelage probleme:fissure cluster:joints-souples cluster:diagnostics type:diagnostic securite:silice`

## Historique
| Version | Date | Auteur | Validateur | Motif |
|---|---|---|---|---|
| v0.1 | 2026-08-05 | IA | ⟦—⟧ | proposition initiale (Brouillon) |
