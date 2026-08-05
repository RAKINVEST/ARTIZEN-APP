# Dysfonctionnement d'un ANC

> **Brouillon (v0) — proposé par IA, en attente de validation métier** (Loi 7/18). Modèle : [../../cards/CARD_TEMPLATE.md](../../cards/CARD_TEMPLATE.md).
> Niveaux de confiance : A normes/fabricant · B technique · C terrain validé · D hypothèse.

## Métadonnées
| Champ | Valeur |
|---|---|
| Identifiant | `dysfonctionnement-anc` |
| Titre | Dysfonctionnement d'un ANC |
| Profession | `metier:assainissement` |
| Famille | `famille:gros-oeuvre` |
| Sous-famille | `sous-famille:assainissement` |
| Version | v0.1 |
| Auteur | IA (proposition) |
| Validateur | ⟦à valider métier⟧ |
| Statut | Brouillon |
| Indice de confiance | **C** |

## Symptôme
- ANC saturé : épandage **engorgé**, rejet non conforme, odeurs, remontées. `[C]`

## Causes probables
1. **Entretien/vidange** non réalisé (fosse pleine, boues). `[C]` → [entretenir-vidanger-assainissement](../../professions/assainissement/cards/entretenir-vidanger-assainissement.md)
2. **Épandage colmaté** / sol inadapté / surcharge hydraulique. `[C]` → [installer-anc-fosse-epandage](../../professions/assainissement/cards/installer-anc-fosse-epandage.md)
3. Microstation mal entretenue / défaut électrique. `[C]` → [installer-microstation](../../professions/assainissement/cards/installer-microstation.md)

## Résolution
- **Vidanger** (vidangeur agréé), rétablir la ventilation, réhabiliter l'épandage si colmaté ; contrôle **SPANC**. `[C]`

## Cadre
- **Normes** : assainissement non collectif **DTU 64.1** ; évacuation EU/EP **DTU 60.11** ; mise en œuvre/essais des collecteurs **NF EN 1610**, réglementation ANC (**arrêté du 7 sept. 2009**, contrôle **SPANC**) ⟦en prose, à confirmer⟧ `[B]` ⟦référence exacte à confirmer⟧. `respecte-norme`
- **Relations** : `traite-diagnostic` → [entretenir-vidanger-assainissement](../../professions/assainissement/cards/entretenir-vidanger-assainissement.md).
- **Tags** : `metier:assainissement famille:gros-oeuvre sous-famille:assainissement probleme:saturation cluster:assainissement-non-collectif cluster:epandage cluster:diagnostic type:diagnostic securite:confine`

## Historique
| Version | Date | Auteur | Validateur | Motif |
|---|---|---|---|---|
| v0.1 | 2026-08-05 | IA | ⟦—⟧ | proposition initiale (Brouillon) |
