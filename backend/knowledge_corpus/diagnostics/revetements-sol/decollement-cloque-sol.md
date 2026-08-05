# Décollement / cloque d'un revêtement

> **Brouillon (v0) — proposé par IA, en attente de validation métier** (Loi 7/18). Modèle : [../../cards/CARD_TEMPLATE.md](../../cards/CARD_TEMPLATE.md).
> Niveaux de confiance : A normes/fabricant · B technique · C terrain validé · D hypothèse.

## Métadonnées
| Champ | Valeur |
|---|---|
| Identifiant | `decollement-cloque-sol` |
| Titre | Décollement / cloque d'un revêtement |
| Profession | `metier:revetements-sol` |
| Famille | `famille:finition` |
| Sous-famille | `sous-famille:revetements-sol` |
| Version | v0.1 |
| Auteur | IA (proposition) |
| Validateur | ⟦à valider métier⟧ |
| Statut | Brouillon |
| Indice de confiance | **C** |

## Symptôme
- Revêtement qui **cloque**, se **décolle**, tuile aux joints. `[C]`

## Causes probables
1. **Humidité résiduelle** du support (dalle non sèche) sous revêtement étanche. `[C]` → [remontees-humidite-sol](remontees-humidite-sol.md)
2. **Colle** inadaptée / temps de gommage non respecté / support poussiéreux. `[C]` → [poser-sol-pvc-vinyle-colle](../../professions/revetements-sol/cards/poser-sol-pvc-vinyle-colle.md)
3. Support non préparé (pas de primaire/ragréage). `[C]` → [preparer-support-sol](../../professions/revetements-sol/cards/preparer-support-sol.md)

## Résolution
- Traiter la cause (humidité), reprendre support/colle, remplacer la zone ; ressouder les joints PVC. `[C]`

## Cadre
- **Normes** : revêtements de sol PVC collés **DTU 53.2** ; revêtements textiles / moquettes **DTU 53.1** ; pose flottante des sols stratifiés **DTU 51.11** (interface) ; électricité (avant découpe/percement, sols techniques) **NF C 15-100** ; classement **UPEC**, étiquetage **COV** et diagnostic **amiante** (anciennes dalles/colles) ⟦en prose, à confirmer⟧ `[B]` ⟦référence exacte à confirmer⟧. `respecte-norme`
- **Relations** : `traite-diagnostic` → [poser-sol-pvc-vinyle-colle](../../professions/revetements-sol/cards/poser-sol-pvc-vinyle-colle.md).
- **Tags** : `metier:revetements-sol famille:finition sous-famille:revetements-sol probleme:decollement cluster:collage cluster:diagnostic type:diagnostic securite:cov`

## Historique
| Version | Date | Auteur | Validateur | Motif |
|---|---|---|---|---|
| v0.1 | 2026-08-05 | IA | ⟦—⟧ | proposition initiale (Brouillon) |
