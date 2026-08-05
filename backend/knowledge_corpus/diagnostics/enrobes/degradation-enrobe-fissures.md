# Dégradation d'enrobé (fissures, ornières)

> **Brouillon (v0) — proposé par IA, en attente de validation métier** (Loi 7/18). Modèle : [../../cards/CARD_TEMPLATE.md](../../cards/CARD_TEMPLATE.md).
> Niveaux de confiance : A normes/fabricant · B technique · C terrain validé · D hypothèse.

## Métadonnées
| Champ | Valeur |
|---|---|
| Identifiant | `degradation-enrobe-fissures` |
| Titre | Dégradation d'enrobé (fissures, ornières) |
| Profession | `metier:enrobes` |
| Famille | `famille:gros-oeuvre` |
| Sous-famille | `sous-famille:enrobes` |
| Version | v0.1 |
| Auteur | IA (proposition) |
| Validateur | ⟦à valider métier⟧ |
| Statut | Brouillon |
| Indice de confiance | **C** |

## Symptôme
- **Fissures** (longitudinales/faïençage), **ornières**, arrachements de surface. `[C]`

## Causes probables
1. **Fatigue** / trafic supérieur à la structure. `[C]`
2. **Eau** / support dégradé (drainage). `[C]` → [nid-de-poule-affaissement](nid-de-poule-affaissement.md)
3. **Joint** de reprise défaillant / défaut de compactage. `[C]` → [traiter-joints-reprises](../../professions/enrobes/cards/traiter-joints-reprises.md)

## Résolution
- Colmater les fissures / **purger-réparer**, traiter le drainage ; réfection de la couche de roulement si généralisé. `[C]` → [reparer-nid-de-poule](../../professions/enrobes/cards/reparer-nid-de-poule.md)

## Cadre
- **Normes** : support/plateforme **DTU 12** ; voirie légère en béton (dallage) **DTU 13.3** ; enrobés hydrocarbonés **NF P 98-150** / mélanges bitumineux **NF EN 13108** et signalisation temporaire (**IISR 8e partie**) ⟦en prose, à confirmer⟧ `[B]` ⟦référence exacte à confirmer⟧. `respecte-norme`
- **Relations** : `traite-diagnostic` → [entretenir-controler-voirie](../../professions/enrobes/cards/entretenir-controler-voirie.md).
- **Tags** : `metier:enrobes famille:gros-oeuvre sous-famille:enrobes probleme:fissure cluster:diagnostic cluster:reparations-localisees type:diagnostic securite:trafic`

## Historique
| Version | Date | Auteur | Validateur | Motif |
|---|---|---|---|---|
| v0.1 | 2026-08-05 | IA | ⟦—⟧ | proposition initiale (Brouillon) |
