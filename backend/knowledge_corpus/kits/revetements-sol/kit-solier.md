# Kit solier

> **Brouillon (v0) — proposé par IA, en attente de validation métier** (Loi 7/18). Modèle : [../../cards/CARD_TEMPLATE.md](../../cards/CARD_TEMPLATE.md).
> Niveaux de confiance : A normes/fabricant · B technique · C terrain validé · D hypothèse.

## Métadonnées
| Champ | Valeur |
|---|---|
| Identifiant | `kit-solier` |
| Titre | Kit solier |
| Profession | `metier:revetements-sol` |
| Famille | `famille:finition` |
| Sous-famille | `sous-famille:revetements-sol` |
| Version | v0.1 |
| Auteur | IA (proposition) |
| Validateur | ⟦à valider métier⟧ |
| Statut | Brouillon |
| Indice de confiance | **C** |

## Composition conseillée
- **Cutter**/lames, règle, spatules crantées, **maroufleur/rouleau** à maroufler. `[C]`
- Colles adaptées, primaire, ragréage ; **poste à souder** (soudure PVC à chaud). `[C]`
- Bombe de traçage, humidimètre (support), plots/vérins (sols techniques). `[C]`
- **EPI** : masque **COV/poussières** (+ FFP amiante → arrêt/certifié), **genouillères**, gants. `[A]`

## Cadre
- **Normes** : revêtements de sol PVC collés **DTU 53.2** ; revêtements textiles / moquettes **DTU 53.1** ; pose flottante des sols stratifiés **DTU 51.11** (interface) ; électricité (avant découpe/percement, sols techniques) **NF C 15-100** ; classement **UPEC**, étiquetage **COV** et diagnostic **amiante** (anciennes dalles/colles) ⟦en prose, à confirmer⟧ `[B]` ⟦référence exacte à confirmer⟧. `respecte-norme`
- **Relations** : `utilise-kit` → [poser-sol-pvc-vinyle-colle](../../professions/revetements-sol/cards/poser-sol-pvc-vinyle-colle.md).
- **Tags** : `metier:revetements-sol famille:finition sous-famille:revetements-sol type:kit cluster:collage cluster:revetements-pvc equipement:maroufleur`

## Historique
| Version | Date | Auteur | Validateur | Motif |
|---|---|---|---|---|
| v0.1 | 2026-08-05 | IA | ⟦—⟧ | proposition initiale (Brouillon) |
