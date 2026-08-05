# Kit entretien PAC (partie accessible)

> **Brouillon (v0) — proposé par IA, en attente de validation métier** (Loi 7/18). Modèle : [../../cards/CARD_TEMPLATE.md](../../cards/CARD_TEMPLATE.md).
> Niveaux de confiance : A normes/fabricant · B technique · C terrain validé · D hypothèse.

## Métadonnées
| Champ | Valeur |
|---|---|
| Identifiant | `kit-entretien-pac` |
| Titre | Kit entretien PAC (partie accessible) |
| Profession | `metier:pac` |
| Famille | `famille:fluides` |
| Sous-famille | `sous-famille:pac` |
| Version | v0.1 |
| Auteur | IA (proposition) |
| Validateur | ⟦à valider métier⟧ |
| Statut | Brouillon |
| Indice de confiance | **C** |

## Composition conseillée
- Produits de nettoyage échangeurs/ailettes. `[C]`
- Filtres (unité intérieure air/air) selon modèle. `[C]` ⟦selon fabricant⟧
- Filtre magnétique + inhibiteur (côté hydraulique). `[C]`
- EPI. `[B]`

> Le kit **ne couvre pas** l'intervention frigorifère (outillage + qualification F-Gaz dédiés).

## Cadre
- **Normes** : installations de PAC **DTU 65.16** `[B]` ⟦référence exacte à confirmer⟧. `respecte-norme`
- **Relations** : `utilise-kit` → [entretenir-pac](../../professions/pac/cards/entretenir-pac.md).
- **Tags** : `metier:pac equipement:pac famille:fluides sous-famille:pac type:kit cluster:entretien equipement:pac`

## Historique
| Version | Date | Auteur | Validateur | Motif |
|---|---|---|---|---|
| v0.1 | 2026-08-04 | IA | ⟦—⟧ | proposition initiale (Brouillon) |
