# Débit d'air insuffisant

> **Brouillon (v0) — proposé par IA, en attente de validation métier** (Loi 7/18). Modèle : [../../cards/CARD_TEMPLATE.md](../../cards/CARD_TEMPLATE.md).
> Niveaux de confiance : A normes/fabricant · B technique · C terrain validé · D hypothèse.

## Métadonnées
| Champ | Valeur |
|---|---|
| Identifiant | `debit-insuffisant-ventilation` |
| Titre | Débit d'air insuffisant |
| Profession | `metier:ventilation` |
| Famille | `famille:fluides` |
| Sous-famille | `sous-famille:ventilation` |
| Version | v0.1 |
| Auteur | IA (proposition) |
| Validateur | ⟦à valider métier⟧ |
| Statut | Brouillon |
| Indice de confiance | **C** |

## Symptôme
- Extraction/renouvellement d'air **insuffisant** (odeurs, humidité). `[C]`

## Causes probables
1. **Bouches** encrassées / entrées d'air obstruées. `[C]` → [remplacer-nettoyer-bouches](../../professions/ventilation/cards/remplacer-nettoyer-bouches.md)
2. **Filtres** colmatés (double flux). `[C]` → [entretenir-vmc-double-flux](../../professions/ventilation/cards/entretenir-vmc-double-flux.md)
3. **Réseau** encrassé / fuite / conduit écrasé. `[C]` → [controler-reseau-aeraulique](../../professions/ventilation/cards/controler-reseau-aeraulique.md)

## Résolution
- Nettoyer bouches/filtres, contrôler le réseau et les débits. `[C]`

## Cadre
- **Normes** : installations de ventilation mécanique **DTU 68.3** ; aération des logements (**arrêté du 24 mars 1982**) ; installation électrique **NF C 15-100** `[B]` ⟦référence exacte à confirmer⟧. `respecte-norme`
- **Relations** : `traite-diagnostic` → [entretenir-vmc-simple-flux](../../professions/ventilation/cards/entretenir-vmc-simple-flux.md).
- **Tags** : `metier:ventilation equipement:vmc famille:fluides sous-famille:ventilation probleme:debit-insuffisant cluster:diagnostic cluster:depannage cluster:extraction type:diagnostic`

## Historique
| Version | Date | Auteur | Validateur | Motif |
|---|---|---|---|---|
| v0.1 | 2026-08-04 | IA | ⟦—⟧ | proposition initiale (Brouillon) |
