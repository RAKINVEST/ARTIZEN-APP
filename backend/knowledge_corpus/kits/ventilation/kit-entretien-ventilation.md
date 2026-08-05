# Kit entretien ventilation

> **Brouillon (v0) — proposé par IA, en attente de validation métier** (Loi 7/18). Modèle : [../../cards/CARD_TEMPLATE.md](../../cards/CARD_TEMPLATE.md).
> Niveaux de confiance : A normes/fabricant · B technique · C terrain validé · D hypothèse.

## Métadonnées
| Champ | Valeur |
|---|---|
| Identifiant | `kit-entretien-ventilation` |
| Titre | Kit entretien ventilation |
| Profession | `metier:ventilation` |
| Famille | `famille:fluides` |
| Sous-famille | `sous-famille:ventilation` |
| Version | v0.1 |
| Auteur | IA (proposition) |
| Validateur | ⟦à valider métier⟧ |
| Statut | Brouillon |
| Indice de confiance | **C** |

## Composition conseillée
- **Filtres** de rechange (double flux) selon modèle. `[C]` ⟦classe/modèle à confirmer⟧
- Brosses/aspirateur pour bouches et roue. `[C]`
- **Anémomètre / débitmètre** pour contrôle des débits. `[B]`
- EPI (hauteur, poussières). `[B]`

## Cadre
- **Normes** : installations de ventilation mécanique **DTU 68.3** ; aération des logements (**arrêté du 24 mars 1982**) ; installation électrique **NF C 15-100** `[B]` ⟦référence exacte à confirmer⟧. `respecte-norme`
- **Relations** : `utilise-kit` → [entretenir-vmc-double-flux](../../professions/ventilation/cards/entretenir-vmc-double-flux.md).
- **Tags** : `metier:ventilation equipement:filtre famille:fluides sous-famille:ventilation type:kit cluster:entretien cluster:filtres`

## Historique
| Version | Date | Auteur | Validateur | Motif |
|---|---|---|---|---|
| v0.1 | 2026-08-04 | IA | ⟦—⟧ | proposition initiale (Brouillon) |
