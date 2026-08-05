# Odeurs d'assainissement

> **Brouillon (v0) — proposé par IA, en attente de validation métier** (Loi 7/18). Modèle : [../../cards/CARD_TEMPLATE.md](../../cards/CARD_TEMPLATE.md).
> Niveaux de confiance : A normes/fabricant · B technique · C terrain validé · D hypothèse.

## Métadonnées
| Champ | Valeur |
|---|---|
| Identifiant | `odeurs-assainissement` |
| Titre | Odeurs d'assainissement |
| Profession | `metier:assainissement` |
| Famille | `famille:gros-oeuvre` |
| Sous-famille | `sous-famille:assainissement` |
| Version | v0.1 |
| Auteur | IA (proposition) |
| Validateur | ⟦à valider métier⟧ |
| Statut | Brouillon |
| Indice de confiance | **C** |

## Symptôme
- **Odeurs** (œuf pourri = **H₂S**) dans le logement ou près des ouvrages. `[C]`

> H₂S : gaz **toxique** — en concentration (fosse/regard) = **danger mortel** (espace confiné). `[A]`

## Causes probables
1. **Siphon** désiphonné / garde d'eau perdue. `[C]`
2. **Ventilation** primaire/secondaire absente ou obstruée. `[C]` → [poser-regards-ventilation](../../professions/assainissement/cards/poser-regards-ventilation.md)
3. ANC / regard mal ventilé ou en dysfonctionnement. `[C]` → [dysfonctionnement-anc](dysfonctionnement-anc.md)

## Résolution
- Rétablir garde d'eau + **ventilation** du réseau ; ne jamais entrer en ouvrage confiné pour « sentir ». `[A]`

## Cadre
- **Normes** : assainissement non collectif **DTU 64.1** ; évacuation EU/EP **DTU 60.11** ; mise en œuvre/essais des collecteurs **NF EN 1610**, réglementation ANC (**arrêté du 7 sept. 2009**, contrôle **SPANC**) ⟦en prose, à confirmer⟧ `[B]` ⟦référence exacte à confirmer⟧. `respecte-norme`
- **Relations** : `traite-diagnostic` → [poser-regards-ventilation](../../professions/assainissement/cards/poser-regards-ventilation.md).
- **Tags** : `metier:assainissement famille:gros-oeuvre sous-famille:assainissement probleme:odeurs cluster:ventilation-primaire cluster:diagnostic type:diagnostic securite:confine`

## Historique
| Version | Date | Auteur | Validateur | Motif |
|---|---|---|---|---|
| v0.1 | 2026-08-05 | IA | ⟦—⟧ | proposition initiale (Brouillon) |
