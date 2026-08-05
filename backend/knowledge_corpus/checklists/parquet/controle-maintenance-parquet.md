# Contrôle / maintenance parquet

> **Brouillon (v0) — proposé par IA, en attente de validation métier** (Loi 7/18). Modèle : [../../cards/CARD_TEMPLATE.md](../../cards/CARD_TEMPLATE.md).
> Niveaux de confiance : A normes/fabricant · B technique · C terrain validé · D hypothèse.

## Métadonnées
| Champ | Valeur |
|---|---|
| Identifiant | `controle-maintenance-parquet` |
| Titre | Contrôle / maintenance parquet |
| Profession | `metier:parquet` |
| Famille | `famille:finition` |
| Sous-famille | `sous-famille:parquet` |
| Version | v0.1 |
| Auteur | IA (proposition) |
| Validateur | ⟦à valider métier⟧ |
| Statut | Brouillon |
| Indice de confiance | **C** |

## Points à vérifier
- [ ] **Humidité** du support mesurée (sous seuil) avant pose. `[A]`
- [ ] **Jeux de dilatation** périphériques respectés. `[C]`
- [ ] **Fixation** (cloué/collé) ou sous-couche (flottant) correctes. `[C]`
- [ ] **Finition** (vitrifié/huilé) en bon état ; entretien adapté. `[C]`
- [ ] **Plancher chauffant** : parquet compatible + protocole. `[C]`
- [ ] Rénovation : **amiante** (colles) vérifié. `[A]`

> Ponçage = **aspiration** (poussière de bois cancérogène) ; **chiffons d'huile** immergés.

## Cadre
- **Normes** : pose des parquets à clouer **DTU 51.1** ; parquets collés **DTU 51.2** ; pose flottante des parquets contrecollés **DTU 51.11** ; électricité (avant percement, plancher chauffant) **NF C 15-100** ; taux d'humidité du support et diagnostic **amiante** (colles anciennes) ⟦en prose, à confirmer⟧ `[B]` ⟦référence exacte à confirmer⟧. `respecte-norme`
- **Relations** : `verifie` → [reparer-entretenir-parquet](../../professions/parquet/cards/reparer-entretenir-parquet.md).
- **Tags** : `metier:parquet famille:finition sous-famille:parquet type:checklist cluster:entretien cluster:maintenance securite:poussieres`

## Historique
| Version | Date | Auteur | Validateur | Motif |
|---|---|---|---|---|
| v0.1 | 2026-08-05 | IA | ⟦—⟧ | proposition initiale (Brouillon) |
