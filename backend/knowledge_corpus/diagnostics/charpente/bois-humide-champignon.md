# Bois humide / champignon (pourriture)

> **Brouillon (v0) — proposé par IA, en attente de validation métier** (Loi 7/18). Modèle : [../../cards/CARD_TEMPLATE.md](../../cards/CARD_TEMPLATE.md).
> Niveaux de confiance : A normes/fabricant · B technique · C terrain validé · D hypothèse.

## Métadonnées
| Champ | Valeur |
|---|---|
| Identifiant | `bois-humide-champignon` |
| Titre | Bois humide / champignon (pourriture) |
| Profession | `metier:charpente` |
| Famille | `famille:enveloppe` |
| Sous-famille | `sous-famille:traitement-bois` |
| Version | v0.1 |
| Auteur | IA (proposition) |
| Validateur | ⟦à valider métier⟧ |
| Statut | Brouillon |
| Indice de confiance | **C** |

## Symptôme
- Bois **ramolli**, coloré, **mycélium**, odeur d'humidité. `[C]`

> La **mérule** est un champignon dangereux (propagation, cadre réglementaire) → **spécialiste**. `[B]` ⟦à confirmer⟧

## Causes probables
1. **Humidité** persistante (infiltration couverture, défaut de ventilation). `[C]`
2. Champignon lignivore. `[C]` → [diagnostiquer-attaque-bois](../../professions/charpente/cards/diagnostiquer-attaque-bois.md)

## Résolution
- **Supprimer la source d'humidité** (infiltration / ventilation), traiter/renforcer. `[C]`

## Cadre
- **Normes** : charpente et escaliers en bois **DTU 31.1** ; charpentes assemblées par connecteurs **DTU 31.3** ; calcul des structures bois **Eurocode 5 (NF EN 1995)** `[B]` ⟦référence exacte à confirmer⟧. `respecte-norme`
- **Relations** : `traite-diagnostic` → [traiter-charpente-bois](../../professions/charpente/cards/traiter-charpente-bois.md).
- **Tags** : `metier:charpente famille:enveloppe sous-famille:traitement-bois probleme:champignon probleme:humidite cluster:traitement-du-bois cluster:diagnostic type:diagnostic securite:structure relation:couverture relation:ventilation`

## Historique
| Version | Date | Auteur | Validateur | Motif |
|---|---|---|---|---|
| v0.1 | 2026-08-04 | IA | ⟦—⟧ | proposition initiale (Brouillon) |
