# Cloque / poche d'eau sur membrane

> **Brouillon (v0) — proposé par IA, en attente de validation métier** (Loi 7/18). Modèle : [../../cards/CARD_TEMPLATE.md](../../cards/CARD_TEMPLATE.md).
> Niveaux de confiance : A normes/fabricant · B technique · C terrain validé · D hypothèse.

## Métadonnées
| Champ | Valeur |
|---|---|
| Identifiant | `cloque-poche-eau-membrane` |
| Titre | Cloque / poche d'eau sur membrane |
| Profession | `metier:etancheite` |
| Famille | `famille:enveloppe` |
| Sous-famille | `sous-famille:etancheite` |
| Version | v0.1 |
| Auteur | IA (proposition) |
| Validateur | ⟦à valider métier⟧ |
| Statut | Brouillon |
| Indice de confiance | **C** |

## Symptôme
- **Cloque**, boursouflure, ou **poche d'eau** (stagnation) sur la membrane. `[C]`

## Causes probables
1. **Humidité piégée** sous la membrane (support humide à la pose). `[C]`
2. Défaut d'adhérence / soudure. `[C]` → [poser-membrane-bitumineuse](../../professions/etancheite/cards/poser-membrane-bitumineuse.md)
3. **Défaut de pente** / évacuation → stagnation. `[C]`

## Résolution
- Traiter la cause (humidité/pente/évacuation), reprendre localement la membrane. `[C]` → [rechercher-fuite-etancheite](../../professions/etancheite/cards/rechercher-fuite-etancheite.md)

## Cadre
- **Normes** : étanchéité des toitures-terrasses (support maçonnerie) **DTU 43.1** ; support acier **DTU 43.3** ; réfection des ouvrages d'étanchéité **DTU 43.5** ; SEL/résines sous **Avis Technique** ⟦à confirmer⟧ `[B]` ⟦référence exacte à confirmer⟧. `respecte-norme`
- **Relations** : `traite-diagnostic` → [rechercher-fuite-etancheite](../../professions/etancheite/cards/rechercher-fuite-etancheite.md).
- **Tags** : `metier:etancheite famille:enveloppe sous-famille:etancheite probleme:cloque probleme:stagnation cluster:diagnostic cluster:reparation type:diagnostic securite:hauteur`

## Historique
| Version | Date | Auteur | Validateur | Motif |
|---|---|---|---|---|
| v0.1 | 2026-08-05 | IA | ⟦—⟧ | proposition initiale (Brouillon) |
