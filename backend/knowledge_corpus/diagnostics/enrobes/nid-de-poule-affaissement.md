# Nid-de-poule / affaissement

> **Brouillon (v0) — proposé par IA, en attente de validation métier** (Loi 7/18). Modèle : [../../cards/CARD_TEMPLATE.md](../../cards/CARD_TEMPLATE.md).
> Niveaux de confiance : A normes/fabricant · B technique · C terrain validé · D hypothèse.

## Métadonnées
| Champ | Valeur |
|---|---|
| Identifiant | `nid-de-poule-affaissement` |
| Titre | Nid-de-poule / affaissement |
| Profession | `metier:enrobes` |
| Famille | `famille:gros-oeuvre` |
| Sous-famille | `sous-famille:enrobes` |
| Version | v0.1 |
| Auteur | IA (proposition) |
| Validateur | ⟦à valider métier⟧ |
| Statut | Brouillon |
| Indice de confiance | **C** |

## Symptôme
- **Nid-de-poule**, **affaissement** localisé de la chaussée (danger usagers). `[C]`

> Dégradation dangereuse pour le trafic → **signaler/baliser** et réparer rapidement. `[B]`

## Causes probables
1. **Eau** infiltrée (fissure) ayant déstructuré le support. `[C]`
2. **Support/compactage** insuffisant (tranchée rebouchée). `[C]` → [preparer-support-voirie](../../professions/enrobes/cards/preparer-support-voirie.md)
3. Sur-sollicitation (trafic lourd). `[C]`

## Résolution
- **Purger** franchement, traiter la cause (support/eau), réparer par réfection localisée. `[C]` → [reparer-nid-de-poule](../../professions/enrobes/cards/reparer-nid-de-poule.md)

## Cadre
- **Normes** : support/plateforme **DTU 12** ; voirie légère en béton (dallage) **DTU 13.3** ; enrobés hydrocarbonés **NF P 98-150** / mélanges bitumineux **NF EN 13108** et signalisation temporaire (**IISR 8e partie**) ⟦en prose, à confirmer⟧ `[B]` ⟦référence exacte à confirmer⟧. `respecte-norme`
- **Relations** : `traite-diagnostic` → [reparer-nid-de-poule](../../professions/enrobes/cards/reparer-nid-de-poule.md).
- **Tags** : `metier:enrobes famille:gros-oeuvre sous-famille:enrobes probleme:affaissement cluster:diagnostic cluster:reparations-localisees type:diagnostic securite:trafic`

## Historique
| Version | Date | Auteur | Validateur | Motif |
|---|---|---|---|---|
| v0.1 | 2026-08-05 | IA | ⟦—⟧ | proposition initiale (Brouillon) |
