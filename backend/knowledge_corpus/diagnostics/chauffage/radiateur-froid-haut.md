# Radiateur froid en haut

> **Brouillon (v0) — proposé par IA, en attente de validation métier** (Loi 7/18). Modèle : [../../cards/CARD_TEMPLATE.md](../../cards/CARD_TEMPLATE.md).
> Niveaux de confiance : A normes/fabricant · B technique · C terrain validé · D hypothèse.

## Métadonnées
| Champ | Valeur |
|---|---|
| Identifiant | `radiateur-froid-haut` |
| Titre | Radiateur froid en haut |
| Profession | `metier:chauffage` |
| Famille | `famille:fluides` |
| Version | v0.1 |
| Auteur | IA (proposition) |
| Statut | Brouillon |
| Indice de confiance | **C** |

## Symptôme
- Le radiateur est **chaud en bas, froid en haut**. `[C]`

## Cause probable
- **Air** accumulé en partie haute (poche d'air). `[C]`

## Démarche de diagnostic
- Vérifier la pression du circuit ; écouter/purger le radiateur concerné. `[C]`

## Résolution
- **Purger** le radiateur puis rétablir la pression. → [purger-radiateur](../../professions/chauffage/cards/purger-radiateur.md)
- Si récurrent : vérifier l'étanchéité (entrée d'air) et le vase d'expansion. `[C]`

## Cadre
- **Normes** : installations de chauffage central — **DTU 65.11** `[B]` ⟦référence exacte à confirmer⟧. `respecte-norme`
- **Relations** : `traite-diagnostic` (résolu par la purge).
- **Tags** : `metier:chauffage famille:fluides probleme:air probleme:radiateur-froid equipement:radiateur type:diagnostic`

## Historique
| Version | Date | Auteur | Validateur | Motif |
|---|---|---|---|---|
| v0.1 | 2026-08-04 | IA | ⟦—⟧ | proposition initiale (Brouillon) |
