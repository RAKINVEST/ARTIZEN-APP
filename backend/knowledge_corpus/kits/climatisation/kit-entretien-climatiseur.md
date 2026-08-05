# Kit entretien climatiseur (partie accessible)

> **Brouillon (v0) — proposé par IA, en attente de validation métier** (Loi 7/18). Modèle : [../../cards/CARD_TEMPLATE.md](../../cards/CARD_TEMPLATE.md).
> Niveaux de confiance : A normes/fabricant · B technique · C terrain validé · D hypothèse.

## Métadonnées
| Champ | Valeur |
|---|---|
| Identifiant | `kit-entretien-climatiseur` |
| Titre | Kit entretien climatiseur (partie accessible) |
| Profession | `metier:climatisation` |
| Famille | `famille:fluides` |
| Sous-famille | `sous-famille:climatisation` |
| Version | v0.1 |
| Auteur | IA (proposition) |
| Validateur | ⟦à valider métier⟧ |
| Statut | Brouillon |
| Indice de confiance | **C** |

## Composition conseillée
- Filtres de rechange selon modèle. `[C]` ⟦selon fabricant⟧
- Produits de nettoyage échangeurs + **désinfectant** bac/évaporateur. `[C]`
- Nettoyeur de ligne de condensats. `[C]`
- EPI. `[B]`

> Le kit **ne couvre pas** l'intervention frigorifère (outillage + qualification F-Gaz dédiés).

## Cadre
- **Normes** : climatiseurs à détente directe **DTU 65.16** `[B]` ⟦référence exacte à confirmer⟧. `respecte-norme`
- **Relations** : `utilise-kit` → [entretenir-climatiseur](../../professions/climatisation/cards/entretenir-climatiseur.md).
- **Tags** : `metier:climatisation equipement:climatiseur famille:fluides sous-famille:climatisation type:kit cluster:entretien`

## Historique
| Version | Date | Auteur | Validateur | Motif |
|---|---|---|---|---|
| v0.1 | 2026-08-04 | IA | ⟦—⟧ | proposition initiale (Brouillon) |
