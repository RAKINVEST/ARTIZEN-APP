# Parquet qui tuile / gonfle

> **Brouillon (v0) — proposé par IA, en attente de validation métier** (Loi 7/18). Modèle : [../../cards/CARD_TEMPLATE.md](../../cards/CARD_TEMPLATE.md).
> Niveaux de confiance : A normes/fabricant · B technique · C terrain validé · D hypothèse.

## Métadonnées
| Champ | Valeur |
|---|---|
| Identifiant | `parquet-tuile-gonfle` |
| Titre | Parquet qui tuile / gonfle |
| Profession | `metier:parquet` |
| Famille | `famille:finition` |
| Sous-famille | `sous-famille:parquet` |
| Version | v0.1 |
| Auteur | IA (proposition) |
| Validateur | ⟦à valider métier⟧ |
| Statut | Brouillon |
| Indice de confiance | **C** |

## Symptôme
- Lames qui **tuilent** (bords relevés), **gonflent**, se soulèvent. `[C]`

> Le bois travaille avec l'humidité : un excès (support/ambiance) ou l'absence de **jeu** provoque le tuilage/gonflement. `[B]`

## Causes probables
1. **Humidité** (support non sec, dégât des eaux, ambiance). `[C]` → [preparer-support-parquet](../../professions/parquet/cards/preparer-support-parquet.md)
2. **Jeux de dilatation** absents/insuffisants (bridage). `[C]` → [poser-parquet-flottant](../../professions/parquet/cards/poser-parquet-flottant.md)
3. Bois non acclimaté avant pose. `[C]`

## Résolution
- Traiter la cause d'humidité, rétablir les jeux, remplacer les lames atteintes après stabilisation. `[C]`

## Cadre
- **Normes** : pose des parquets à clouer **DTU 51.1** ; parquets collés **DTU 51.2** ; pose flottante des parquets contrecollés **DTU 51.11** ; électricité (avant percement, plancher chauffant) **NF C 15-100** ; taux d'humidité du support et diagnostic **amiante** (colles anciennes) ⟦en prose, à confirmer⟧ `[B]` ⟦référence exacte à confirmer⟧. `respecte-norme`
- **Relations** : `traite-diagnostic` → [preparer-support-parquet](../../professions/parquet/cards/preparer-support-parquet.md).
- **Tags** : `metier:parquet famille:finition sous-famille:parquet probleme:humidite cluster:humidite-des-supports cluster:diagnostic type:diagnostic securite:poussieres`

## Historique
| Version | Date | Auteur | Validateur | Motif |
|---|---|---|---|---|
| v0.1 | 2026-08-05 | IA | ⟦—⟧ | proposition initiale (Brouillon) |
