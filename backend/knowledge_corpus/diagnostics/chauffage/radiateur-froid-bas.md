# Radiateur froid en bas

> **Brouillon (v0) — proposé par IA, en attente de validation métier** (Loi 7/18). Modèle : [../../cards/CARD_TEMPLATE.md](../../cards/CARD_TEMPLATE.md).
> Niveaux de confiance : A normes/fabricant · B technique · C terrain validé · D hypothèse.

## Métadonnées
| Champ | Valeur |
|---|---|
| Identifiant | `radiateur-froid-bas` |
| Titre | Radiateur froid en bas |
| Profession | `metier:chauffage` |
| Famille | `famille:fluides` |
| Version | v0.1 |
| Auteur | IA (proposition) |
| Statut | Brouillon |
| Indice de confiance | **C** |

## Symptôme
- Le radiateur est **chaud en haut, froid en bas** (parfois bruits de circulation). `[C]`

## Cause probable
- **Boues** (oxydes) accumulées en fond de radiateur — embouage du circuit. `[C]`

## Démarche de diagnostic
- Comparer plusieurs émetteurs ; vérifier l'écart départ/retour ; contrôler la présence de boues (eau noire à la purge). `[C]`

## Résolution
- **Désembouer** le circuit et protéger par inhibiteur + filtre magnétique. → [desembouer-circuit-chauffage](../../professions/chauffage/cards/desembouer-circuit-chauffage.md)

## Cadre
- **Normes** : installations de chauffage central — **DTU 65.11** `[B]` ⟦référence exacte à confirmer⟧. `respecte-norme`
- **Relations** : `traite-diagnostic` (résolu par le désembouage).
- **Tags** : `metier:chauffage famille:fluides probleme:boue probleme:embouage probleme:radiateur-froid equipement:radiateur type:diagnostic`

## Historique
| Version | Date | Auteur | Validateur | Motif |
|---|---|---|---|---|
| v0.1 | 2026-08-04 | IA | ⟦—⟧ | proposition initiale (Brouillon) |
