# VMC bruyante

> **Brouillon (v0) — proposé par IA, en attente de validation métier** (Loi 7/18). Modèle : [../../cards/CARD_TEMPLATE.md](../../cards/CARD_TEMPLATE.md).
> Niveaux de confiance : A normes/fabricant · B technique · C terrain validé · D hypothèse.

## Métadonnées
| Champ | Valeur |
|---|---|
| Identifiant | `vmc-bruyante` |
| Titre | VMC bruyante |
| Profession | `metier:ventilation` |
| Famille | `famille:fluides` |
| Sous-famille | `sous-famille:ventilation` |
| Version | v0.1 |
| Auteur | IA (proposition) |
| Validateur | ⟦à valider métier⟧ |
| Statut | Brouillon |
| Indice de confiance | **C** |

## Symptôme
- Bruit anormal (ronflement, sifflement, vibration). `[C]`

## Causes probables
1. **Roue/turbine** encrassée ou déséquilibrée. `[C]` → [controler-caisson-vmc](../../professions/ventilation/cards/controler-caisson-vmc.md)
2. Fixations **antivibratiles** dégradées / caisson mal suspendu. `[C]`
3. Sifflement aux **bouches** (débit/section). `[C]` → [remplacer-nettoyer-bouches](../../professions/ventilation/cards/remplacer-nettoyer-bouches.md)

## Résolution
- Nettoyer la roue, revoir la suspension/antivibratiles, contrôler les bouches. `[C]`

## Cadre
- **Normes** : installations de ventilation mécanique **DTU 68.3** ; aération des logements (**arrêté du 24 mars 1982**) ; installation électrique **NF C 15-100** `[B]` ⟦référence exacte à confirmer⟧. `respecte-norme`
- **Relations** : `traite-diagnostic` → [controler-caisson-vmc](../../professions/ventilation/cards/controler-caisson-vmc.md).
- **Tags** : `metier:ventilation equipement:caisson famille:fluides sous-famille:ventilation probleme:bruit probleme:vibration cluster:diagnostic cluster:depannage cluster:caisson type:diagnostic`

## Historique
| Version | Date | Auteur | Validateur | Motif |
|---|---|---|---|---|
| v0.1 | 2026-08-04 | IA | ⟦—⟧ | proposition initiale (Brouillon) |
