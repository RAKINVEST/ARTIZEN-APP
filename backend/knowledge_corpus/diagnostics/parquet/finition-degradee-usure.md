# Finition dégradée / usure

> **Brouillon (v0) — proposé par IA, en attente de validation métier** (Loi 7/18). Modèle : [../../cards/CARD_TEMPLATE.md](../../cards/CARD_TEMPLATE.md).
> Niveaux de confiance : A normes/fabricant · B technique · C terrain validé · D hypothèse.

## Métadonnées
| Champ | Valeur |
|---|---|
| Identifiant | `finition-degradee-usure` |
| Titre | Finition dégradée / usure |
| Profession | `metier:parquet` |
| Famille | `famille:finition` |
| Sous-famille | `sous-famille:parquet` |
| Version | v0.1 |
| Auteur | IA (proposition) |
| Validateur | ⟦à valider métier⟧ |
| Statut | Brouillon |
| Indice de confiance | **C** |

## Symptôme
- **Vitrificateur** rayé/usé, **taches**, zones ternes, bois qui grise (huilé). `[C]`

## Causes probables
1. **Usure** normale / trafic (vitrificateur en fin de vie). `[C]` → [finir-vitrifier-huiler-cirer](../../professions/parquet/cards/finir-vitrifier-huiler-cirer.md)
2. **Entretien inadapté** (excès d'eau, produits agressifs). `[C]` → [reparer-entretenir-parquet](../../professions/parquet/cards/reparer-entretenir-parquet.md)
3. Huile non entretenue (parquet huilé grise). `[C]`

## Résolution
- Rénover la finition (ponçage partiel/complet + re-vitrification/huilage) ; adapter l'entretien. `[C]`

## Cadre
- **Normes** : pose des parquets à clouer **DTU 51.1** ; parquets collés **DTU 51.2** ; pose flottante des parquets contrecollés **DTU 51.11** ; électricité (avant percement, plancher chauffant) **NF C 15-100** ; taux d'humidité du support et diagnostic **amiante** (colles anciennes) ⟦en prose, à confirmer⟧ `[B]` ⟦référence exacte à confirmer⟧. `respecte-norme`
- **Relations** : `traite-diagnostic` → [poncer-parquet](../../professions/parquet/cards/poncer-parquet.md).
- **Tags** : `metier:parquet famille:finition sous-famille:parquet probleme:usure cluster:vitrification cluster:diagnostic type:diagnostic securite:cov`

## Historique
| Version | Date | Auteur | Validateur | Motif |
|---|---|---|---|---|
| v0.1 | 2026-08-05 | IA | ⟦—⟧ | proposition initiale (Brouillon) |
