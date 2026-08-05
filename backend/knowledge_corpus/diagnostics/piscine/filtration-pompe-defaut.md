# Filtration / pompe en défaut

> **Brouillon (v0) — proposé par IA, en attente de validation métier** (Loi 7/18). Modèle : [../../cards/CARD_TEMPLATE.md](../../cards/CARD_TEMPLATE.md).
> Niveaux de confiance : A normes/fabricant · B technique · C terrain validé · D hypothèse.

## Métadonnées
| Champ | Valeur |
|---|---|
| Identifiant | `filtration-pompe-defaut` |
| Titre | Filtration / pompe en défaut |
| Profession | `metier:piscine` |
| Famille | `famille:specialises` |
| Sous-famille | `sous-famille:piscine` |
| Version | v0.1 |
| Auteur | IA (proposition) |
| Validateur | ⟦à valider métier⟧ |
| Statut | Brouillon |
| Indice de confiance | **C** |

## Symptôme
- Pompe qui **ne désamorce pas**, débit faible, filtre colmaté, disjonction. `[C]`

> Eau + électricité : toute **disjonction répétée** → couper et faire intervenir un électricien (interface). `[A]`

## Causes probables
1. **Amorçage/étanchéité aspiration** (préfiltre, joint, air). `[C]` → [installer-hydraulique-filtration](../../professions/piscine/cards/installer-hydraulique-filtration.md)
2. **Filtre colmaté** (sable/cartouche) → contre-lavage/remplacement. `[C]` → [entretenir-hiverner-piscine](../../professions/piscine/cards/entretenir-hiverner-piscine.md)
3. **Défaut électrique** (disjonction, différentiel) → **Électricité** (réservé). `[A]` → [controler-mise-a-la-terre](../../professions/electricite-generale/cards/controler-mise-a-la-terre.md)

## Résolution
- Rétablir l'amorçage/l'étanchéité d'aspiration, nettoyer le filtre ; défaut électrique = électricien. `[C]`

## Cadre
- **Normes** : sécurité électrique des piscines (volumes 0/1/2, liaison équipotentielle) **NF C 15-100** (partie 7-702) ; structure béton du bassin (**interface** maçonnerie) **DTU 21** ; **sécurité des piscines** — barrières / alarmes / couvertures / abris **NF P 90-306 à 90-309** et **obligation légale** (Code de la construction), norme européenne **NF EN 16582** ⟦en prose, à confirmer⟧ `[B]` ⟦référence exacte à confirmer⟧. `respecte-norme`
- **Relations** : `traite-diagnostic` → [installer-hydraulique-filtration](../../professions/piscine/cards/installer-hydraulique-filtration.md).
- **Tags** : `metier:piscine famille:specialises sous-famille:piscine probleme:filtration cluster:filtration cluster:diagnostic type:diagnostic securite:electrique relation:electricite-generale`

## Historique
| Version | Date | Auteur | Validateur | Motif |
|---|---|---|---|---|
| v0.1 | 2026-08-05 | IA | ⟦—⟧ | proposition initiale (Brouillon) |
