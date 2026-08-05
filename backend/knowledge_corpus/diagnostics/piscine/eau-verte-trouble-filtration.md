# Eau verte / trouble

> **Brouillon (v0) — proposé par IA, en attente de validation métier** (Loi 7/18). Modèle : [../../cards/CARD_TEMPLATE.md](../../cards/CARD_TEMPLATE.md).
> Niveaux de confiance : A normes/fabricant · B technique · C terrain validé · D hypothèse.

## Métadonnées
| Champ | Valeur |
|---|---|
| Identifiant | `eau-verte-trouble-filtration` |
| Titre | Eau verte / trouble |
| Profession | `metier:piscine` |
| Famille | `famille:specialises` |
| Sous-famille | `sous-famille:piscine` |
| Version | v0.1 |
| Auteur | IA (proposition) |
| Validateur | ⟦à valider métier⟧ |
| Statut | Brouillon |
| Indice de confiance | **C** |

## Symptôme
- Eau **verte** (algues), **trouble** (laiteuse), dépôts. `[C]`

## Causes probables
1. **Désinfection/pH** déséquilibrés (chlore bas, pH élevé). `[C]` → [mettre-en-eau-traiter](../../professions/piscine/cards/mettre-en-eau-traiter.md)
2. **Filtration** insuffisante (temps/filtre encrassé). `[C]` → [filtration-pompe-defaut](filtration-pompe-defaut.md)
3. Chimie de l'eau → **Traitement de l'eau** (interface). `[C]` → [principe-traitement-eau](../../professions/traitement-eau/cards/principe-traitement-eau.md)

## Résolution
- Équilibrer **pH** puis **désinfecter** (traitement choc si besoin), augmenter la **filtration**, nettoyer le filtre. `[C]`

> **Ne jamais mélanger** les produits (chlore + acide = gaz toxique). `[A]`

## Cadre
- **Normes** : sécurité électrique des piscines (volumes 0/1/2, liaison équipotentielle) **NF C 15-100** (partie 7-702) ; structure béton du bassin (**interface** maçonnerie) **DTU 21** ; **sécurité des piscines** — barrières / alarmes / couvertures / abris **NF P 90-306 à 90-309** et **obligation légale** (Code de la construction), norme européenne **NF EN 16582** ⟦en prose, à confirmer⟧ `[B]` ⟦référence exacte à confirmer⟧. `respecte-norme`
- **Relations** : `traite-diagnostic` → [mettre-en-eau-traiter](../../professions/piscine/cards/mettre-en-eau-traiter.md).
- **Tags** : `metier:piscine famille:specialises sous-famille:piscine probleme:eau-verte cluster:traitement cluster:diagnostic type:diagnostic securite:produits-chimiques relation:traitement-eau`

## Historique
| Version | Date | Auteur | Validateur | Motif |
|---|---|---|---|---|
| v0.1 | 2026-08-05 | IA | ⟦—⟧ | proposition initiale (Brouillon) |
