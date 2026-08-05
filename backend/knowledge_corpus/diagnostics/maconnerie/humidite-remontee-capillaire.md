# Humidité / remontée capillaire

> **Brouillon (v0) — proposé par IA, en attente de validation métier** (Loi 7/18). Modèle : [../../cards/CARD_TEMPLATE.md](../../cards/CARD_TEMPLATE.md).
> Niveaux de confiance : A normes/fabricant · B technique · C terrain validé · D hypothèse.

## Métadonnées
| Champ | Valeur |
|---|---|
| Identifiant | `humidite-remontee-capillaire` |
| Titre | Humidité / remontée capillaire |
| Profession | `metier:maconnerie` |
| Famille | `famille:gros-oeuvre` |
| Sous-famille | `sous-famille:maconnerie` |
| Version | v0.1 |
| Auteur | IA (proposition) |
| Validateur | ⟦à valider métier⟧ |
| Statut | Brouillon |
| Indice de confiance | **C** |

## Symptôme
- Bas de mur **humide**, **salpêtre**, enduit qui cloque, odeur d'humidité. `[C]`

## Causes probables
1. **Remontée capillaire** (absence/défaut de coupure de capillarité). `[C]`
2. Infiltration latérale / terrain (→ drainage, Terrassement). `[C]`
3. Condensation (défaut de ventilation). `[C]`

## Résolution
- Identifier la source, traiter (drainage, coupure de capillarité, ventilation) **avant** toute reprise d'enduit. `[C]` → [diagnostiquer-maconnerie](../../professions/maconnerie/cards/diagnostiquer-maconnerie.md)

## Cadre
- **Normes** : ouvrages en maçonnerie de petits éléments **DTU 20.1** ; cloisons en maçonnerie **DTU 20.13** ; chaînages / éléments en béton **DTU 21** ; calcul **Eurocode 6 (NF EN 1996)** ⟦en prose, à confirmer⟧ `[B]` ⟦référence exacte à confirmer⟧. `respecte-norme`
- **Relations** : `traite-diagnostic` → [diagnostiquer-maconnerie](../../professions/maconnerie/cards/diagnostiquer-maconnerie.md).
- **Tags** : `metier:maconnerie famille:gros-oeuvre sous-famille:maconnerie probleme:humidite cluster:diagnostic type:diagnostic securite:structure relation:terrassement`

## Historique
| Version | Date | Auteur | Validateur | Motif |
|---|---|---|---|---|
| v0.1 | 2026-08-05 | IA | ⟦—⟧ | proposition initiale (Brouillon) |
