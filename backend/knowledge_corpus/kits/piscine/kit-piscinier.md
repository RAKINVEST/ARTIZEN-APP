# Kit piscinier

> **Brouillon (v0) — proposé par IA, en attente de validation métier** (Loi 7/18). Modèle : [../../cards/CARD_TEMPLATE.md](../../cards/CARD_TEMPLATE.md).
> Niveaux de confiance : A normes/fabricant · B technique · C terrain validé · D hypothèse.

## Métadonnées
| Champ | Valeur |
|---|---|
| Identifiant | `kit-piscinier` |
| Titre | Kit piscinier |
| Profession | `metier:piscine` |
| Famille | `famille:specialises` |
| Sous-famille | `sous-famille:piscine` |
| Version | v0.1 |
| Auteur | IA (proposition) |
| Validateur | ⟦à valider métier⟧ |
| Statut | Brouillon |
| Indice de confiance | **C** |

## Composition conseillée
- Niveau laser, laser rotatif, outillage **collage PVC pression**, clés de raccords, pistolet à souder liner/PVC armé. `[C]`
- **Trousse d'analyse de l'eau** (pH/désinfectant), épuisette/balai/robot, clé de contre-lavage. `[C]`
- **Détecteur de réseaux**, matériel de manutention (ventouses/élingues) pour coque/margelles. `[C]`
- **EPI** : gants/lunettes (**produits chimiques**), protection pour manutention. `[A]`

## Cadre
- **Normes** : sécurité électrique des piscines (volumes 0/1/2, liaison équipotentielle) **NF C 15-100** (partie 7-702) ; structure béton du bassin (**interface** maçonnerie) **DTU 21** ; **sécurité des piscines** — barrières / alarmes / couvertures / abris **NF P 90-306 à 90-309** et **obligation légale** (Code de la construction), norme européenne **NF EN 16582** ⟦en prose, à confirmer⟧ `[B]` ⟦référence exacte à confirmer⟧. `respecte-norme`
- **Relations** : `utilise-kit` → [installer-hydraulique-filtration](../../professions/piscine/cards/installer-hydraulique-filtration.md).
- **Tags** : `metier:piscine famille:specialises sous-famille:piscine type:kit cluster:hydraulique cluster:maintenance equipement:analyse-eau`

## Historique
| Version | Date | Auteur | Validateur | Motif |
|---|---|---|---|---|
| v0.1 | 2026-08-05 | IA | ⟦—⟧ | proposition initiale (Brouillon) |
