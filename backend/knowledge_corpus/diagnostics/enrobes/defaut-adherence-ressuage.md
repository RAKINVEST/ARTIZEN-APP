# Défaut d'adhérence / ressuage

> **Brouillon (v0) — proposé par IA, en attente de validation métier** (Loi 7/18). Modèle : [../../cards/CARD_TEMPLATE.md](../../cards/CARD_TEMPLATE.md).
> Niveaux de confiance : A normes/fabricant · B technique · C terrain validé · D hypothèse.

## Métadonnées
| Champ | Valeur |
|---|---|
| Identifiant | `defaut-adherence-ressuage` |
| Titre | Défaut d'adhérence / ressuage |
| Profession | `metier:enrobes` |
| Famille | `famille:gros-oeuvre` |
| Sous-famille | `sous-famille:enrobes` |
| Version | v0.1 |
| Auteur | IA (proposition) |
| Validateur | ⟦à valider métier⟧ |
| Statut | Brouillon |
| Indice de confiance | **C** |

## Symptôme
- Surface **glissante**, **ressuage** (remontée de bitume), plumage/perte de gravillons. `[C]`

## Causes probables
1. **Ressuage** (excès de liant / sur-compactage / chaleur). `[C]` → [compacter-enrobes](../../professions/enrobes/cards/compacter-enrobes.md)
2. **Plumage** (défaut d'adhésivité liant/granulat, sous-compactage). `[C]`
3. Pollution de surface. `[C]`

## Résolution
- Selon le défaut : **grenaillage/gravillonnage** (adhérence) ou réfection de la couche de roulement. `[C]`

## Cadre
- **Normes** : support/plateforme **DTU 12** ; voirie légère en béton (dallage) **DTU 13.3** ; enrobés hydrocarbonés **NF P 98-150** / mélanges bitumineux **NF EN 13108** et signalisation temporaire (**IISR 8e partie**) ⟦en prose, à confirmer⟧ `[B]` ⟦référence exacte à confirmer⟧. `respecte-norme`
- **Relations** : `traite-diagnostic` → [entretenir-controler-voirie](../../professions/enrobes/cards/entretenir-controler-voirie.md).
- **Tags** : `metier:enrobes famille:gros-oeuvre sous-famille:enrobes probleme:adherence cluster:diagnostic cluster:couches-de-roulement type:diagnostic securite:trafic`

## Historique
| Version | Date | Auteur | Validateur | Motif |
|---|---|---|---|---|
| v0.1 | 2026-08-05 | IA | ⟦—⟧ | proposition initiale (Brouillon) |
