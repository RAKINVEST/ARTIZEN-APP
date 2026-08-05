# Remontées d'humidité sous revêtement

> **Brouillon (v0) — proposé par IA, en attente de validation métier** (Loi 7/18). Modèle : [../../cards/CARD_TEMPLATE.md](../../cards/CARD_TEMPLATE.md).
> Niveaux de confiance : A normes/fabricant · B technique · C terrain validé · D hypothèse.

## Métadonnées
| Champ | Valeur |
|---|---|
| Identifiant | `remontees-humidite-sol` |
| Titre | Remontées d'humidité sous revêtement |
| Profession | `metier:revetements-sol` |
| Famille | `famille:finition` |
| Sous-famille | `sous-famille:revetements-sol` |
| Version | v0.1 |
| Auteur | IA (proposition) |
| Validateur | ⟦à valider métier⟧ |
| Statut | Brouillon |
| Indice de confiance | **C** |

## Symptôme
- Revêtement **étanche** (PVC/lino) qui **cloque/se décolle**, moisissures, odeur (dalle humide). `[C]`

> Poser un revêtement étanche sur un support **non sec** piège l'humidité → désordre garanti. `[B]`

## Causes probables
1. **Humidité résiduelle** du support (béton/chape non sec). `[C]` → [preparer-support-sol](../../professions/revetements-sol/cards/preparer-support-sol.md)
2. Absence de **barrière** / remontées capillaires. `[C]`
3. Fuite / défaut d'étanchéité. `[C]`

## Résolution
- **Mesurer l'humidité** ; sécher / traiter la cause / barrière ; ne reposer qu'un support **sec**. `[C]`

## Cadre
- **Normes** : revêtements de sol PVC collés **DTU 53.2** ; revêtements textiles / moquettes **DTU 53.1** ; pose flottante des sols stratifiés **DTU 51.11** (interface) ; électricité (avant découpe/percement, sols techniques) **NF C 15-100** ; classement **UPEC**, étiquetage **COV** et diagnostic **amiante** (anciennes dalles/colles) ⟦en prose, à confirmer⟧ `[B]` ⟦référence exacte à confirmer⟧. `respecte-norme`
- **Relations** : `traite-diagnostic` → [decollement-cloque-sol](decollement-cloque-sol.md).
- **Tags** : `metier:revetements-sol famille:finition sous-famille:revetements-sol probleme:humidite cluster:preparation-des-supports cluster:diagnostic type:diagnostic securite:cov`

## Historique
| Version | Date | Auteur | Validateur | Motif |
|---|---|---|---|---|
| v0.1 | 2026-08-05 | IA | ⟦—⟧ | proposition initiale (Brouillon) |
