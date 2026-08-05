# Contrôle d'humidité & amiante avant pose de parquet

> **Brouillon (v0) — proposé par IA, en attente de validation métier** (Loi 7/18). Modèle : [../../cards/CARD_TEMPLATE.md](../../cards/CARD_TEMPLATE.md).
> Niveaux de confiance : A normes/fabricant · B technique · C terrain validé · D hypothèse.

## Métadonnées
| Champ | Valeur |
|---|---|
| Identifiant | `controle-humidite-amiante-avant-pose` |
| Titre | Contrôle d'humidité & amiante avant pose de parquet |
| Profession | `metier:parquet` |
| Famille | `famille:finition` |
| Sous-famille | `sous-famille:securite` |
| Version | v0.1 |
| Auteur | IA (proposition) |
| Validateur | ⟦à valider métier⟧ |
| Statut | Brouillon |
| Indice de confiance | **B** |

## But
- Vérifier l'aptitude du support (**humidité**) et, en rénovation, l'absence d'amiante — sans jamais réaliser de retrait. `[A]`

## Étapes
1. **Mesurer l'humidité** du support (béton/chape) : sous le seuil admissible pour le bois. `[A]` ⟦seuil exact à confirmer⟧
2. **Acclimater** le parquet au local (température/hygrométrie). `[C]` → [preparer-support-parquet](../../professions/parquet/cards/preparer-support-parquet.md)
3. Rénovation : **diagnostic amiante avant travaux** — anciennes **colles** sous parquet suspectes. `[A]` `relation:desamiantage`
4. Matériau **suspect** → **ne pas déposer/poncer** ; **arrêt** ; retrait par **entreprise certifiée**. `[A]`

> Poser du bois sur un support **humide** = tuilage/gonflement garanti ; le **retrait d'amiante** n'est jamais réalisé en parquet. `[A]`

## Cadre
- **Normes** : pose des parquets à clouer **DTU 51.1** ; parquets collés **DTU 51.2** ; pose flottante des parquets contrecollés **DTU 51.11** ; électricité (avant percement, plancher chauffant) **NF C 15-100** ; taux d'humidité du support et diagnostic **amiante** (colles anciennes) ⟦en prose, à confirmer⟧ `[B]` ⟦référence exacte à confirmer⟧. `respecte-norme`
- **Relations** : `cite-carte` → [preparer-support-parquet](../../professions/parquet/cards/preparer-support-parquet.md).
- **Tags** : `metier:parquet famille:finition sous-famille:securite intervention:controler cluster:humidite-des-supports cluster:reglementation type:procedure securite:amiante relation:desamiantage`

## Historique
| Version | Date | Auteur | Validateur | Motif |
|---|---|---|---|---|
| v0.1 | 2026-08-05 | IA | ⟦—⟧ | proposition initiale (Brouillon) |
