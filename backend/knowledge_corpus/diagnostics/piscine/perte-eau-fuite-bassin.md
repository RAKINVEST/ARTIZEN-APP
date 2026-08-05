# Perte d'eau / fuite du bassin

> **Brouillon (v0) — proposé par IA, en attente de validation métier** (Loi 7/18). Modèle : [../../cards/CARD_TEMPLATE.md](../../cards/CARD_TEMPLATE.md).
> Niveaux de confiance : A normes/fabricant · B technique · C terrain validé · D hypothèse.

## Métadonnées
| Champ | Valeur |
|---|---|
| Identifiant | `perte-eau-fuite-bassin` |
| Titre | Perte d'eau / fuite du bassin |
| Profession | `metier:piscine` |
| Famille | `famille:specialises` |
| Sous-famille | `sous-famille:piscine` |
| Version | v0.1 |
| Auteur | IA (proposition) |
| Validateur | ⟦à valider métier⟧ |
| Statut | Brouillon |
| Indice de confiance | **C** |

## Symptôme
- **Baisse du niveau** anormale, sol détrempé aux abords, consommation d'eau élevée. `[C]`

## Causes probables
1. **Étanchéité** du revêtement (liner percé, PVC armé, brides des pièces à sceller). `[C]` → [poser-revetement-etancheite](../../professions/piscine/cards/poser-revetement-etancheite.md)
2. **Hydraulique** (canalisation/collage fuyard). `[C]` → [installer-hydraulique-filtration](../../professions/piscine/cards/installer-hydraulique-filtration.md)
3. Évaporation (à distinguer d'une fuite — test du seau). `[C]`

## Résolution
- Localiser (test du seau, colorant aux brides), reprendre l'**étanchéité**/le collage ; contrôler le remblai. `[C]`

## Cadre
- **Normes** : sécurité électrique des piscines (volumes 0/1/2, liaison équipotentielle) **NF C 15-100** (partie 7-702) ; structure béton du bassin (**interface** maçonnerie) **DTU 21** ; **sécurité des piscines** — barrières / alarmes / couvertures / abris **NF P 90-306 à 90-309** et **obligation légale** (Code de la construction), norme européenne **NF EN 16582** ⟦en prose, à confirmer⟧ `[B]` ⟦référence exacte à confirmer⟧. `respecte-norme`
- **Relations** : `traite-diagnostic` → [poser-revetement-etancheite](../../professions/piscine/cards/poser-revetement-etancheite.md).
- **Tags** : `metier:piscine famille:specialises sous-famille:piscine probleme:fuite cluster:etancheite cluster:diagnostic type:diagnostic securite:manutention`

## Historique
| Version | Date | Auteur | Validateur | Motif |
|---|---|---|---|---|
| v0.1 | 2026-08-05 | IA | ⟦—⟧ | proposition initiale (Brouillon) |
