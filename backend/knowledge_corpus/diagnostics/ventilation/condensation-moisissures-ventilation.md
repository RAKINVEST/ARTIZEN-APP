# Condensation / moisissures (sous-ventilation)

> **Brouillon (v0) — proposé par IA, en attente de validation métier** (Loi 7/18). Modèle : [../../cards/CARD_TEMPLATE.md](../../cards/CARD_TEMPLATE.md).
> Niveaux de confiance : A normes/fabricant · B technique · C terrain validé · D hypothèse.

## Métadonnées
| Champ | Valeur |
|---|---|
| Identifiant | `condensation-moisissures-ventilation` |
| Titre | Condensation / moisissures (sous-ventilation) |
| Profession | `metier:ventilation` |
| Famille | `famille:fluides` |
| Sous-famille | `sous-famille:ventilation` |
| Version | v0.1 |
| Auteur | IA (proposition) |
| Validateur | ⟦à valider métier⟧ |
| Statut | Brouillon |
| Indice de confiance | **C** |

## Symptôme
- **Condensation** et **moisissures** (SdB, angles, fenêtres). `[C]`

## Causes probables
1. **Sous-ventilation** (débit insuffisant). `[C]` → [debit-insuffisant-ventilation](debit-insuffisant-ventilation.md)
2. Entrées d'air obstruées / bouches HS. `[C]`
3. Isolation/condensation dans les **conduits**. `[C]` → [controler-reseau-aeraulique](../../professions/ventilation/cards/controler-reseau-aeraulique.md)

## Résolution
- Rétablir les débits, dégager les entrées d'air, isoler les conduits (qualité de l'air). `[C]`

## Cadre
- **Normes** : installations de ventilation mécanique **DTU 68.3** ; aération des logements (**arrêté du 24 mars 1982**) ; installation électrique **NF C 15-100** `[B]` ⟦référence exacte à confirmer⟧. `respecte-norme`
- **Relations** : `traite-diagnostic` → [debit-insuffisant-ventilation](debit-insuffisant-ventilation.md).
- **Tags** : `metier:ventilation famille:fluides sous-famille:ventilation probleme:condensation probleme:moisissures cluster:diagnostic cluster:depannage relation:qualite-air type:diagnostic`

## Historique
| Version | Date | Auteur | Validateur | Motif |
|---|---|---|---|---|
| v0.1 | 2026-08-04 | IA | ⟦—⟧ | proposition initiale (Brouillon) |
