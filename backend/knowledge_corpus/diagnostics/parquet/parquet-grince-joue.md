# Parquet qui grince / joue

> **Brouillon (v0) — proposé par IA, en attente de validation métier** (Loi 7/18). Modèle : [../../cards/CARD_TEMPLATE.md](../../cards/CARD_TEMPLATE.md).
> Niveaux de confiance : A normes/fabricant · B technique · C terrain validé · D hypothèse.

## Métadonnées
| Champ | Valeur |
|---|---|
| Identifiant | `parquet-grince-joue` |
| Titre | Parquet qui grince / joue |
| Profession | `metier:parquet` |
| Famille | `famille:finition` |
| Sous-famille | `sous-famille:parquet` |
| Version | v0.1 |
| Auteur | IA (proposition) |
| Validateur | ⟦à valider métier⟧ |
| Statut | Brouillon |
| Indice de confiance | **C** |

## Symptôme
- **Grincements**, lames qui **jouent** / bougent au passage. `[C]`

## Causes probables
1. **Fixation** (clouage/collage) insuffisante ou lambourdes desserrées. `[C]` → [poser-parquet-cloue](../../professions/parquet/cards/poser-parquet-cloue.md)
2. **Variations hygrométriques** (retrait/jeu saisonnier). `[C]`
3. Sous-couche/support inadaptés (flottant). `[C]` → [poser-parquet-flottant](../../professions/parquet/cards/poser-parquet-flottant.md)

## Résolution
- Reprendre la fixation/le support, stabiliser l'hygrométrie ; en flottant, vérifier sous-couche/jeux. `[C]`

## Cadre
- **Normes** : pose des parquets à clouer **DTU 51.1** ; parquets collés **DTU 51.2** ; pose flottante des parquets contrecollés **DTU 51.11** ; électricité (avant percement, plancher chauffant) **NF C 15-100** ; taux d'humidité du support et diagnostic **amiante** (colles anciennes) ⟦en prose, à confirmer⟧ `[B]` ⟦référence exacte à confirmer⟧. `respecte-norme`
- **Relations** : `traite-diagnostic` → [reparer-entretenir-parquet](../../professions/parquet/cards/reparer-entretenir-parquet.md).
- **Tags** : `metier:parquet famille:finition sous-famille:parquet probleme:grincement cluster:parquet-cloue cluster:diagnostic type:diagnostic securite:poussieres`

## Historique
| Version | Date | Auteur | Validateur | Motif |
|---|---|---|---|---|
| v0.1 | 2026-08-05 | IA | ⟦—⟧ | proposition initiale (Brouillon) |
