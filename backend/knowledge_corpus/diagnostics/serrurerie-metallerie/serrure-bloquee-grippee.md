# Serrure bloquée / grippée

> **Brouillon (v0) — proposé par IA, en attente de validation métier** (Loi 7/18). Modèle : [../../cards/CARD_TEMPLATE.md](../../cards/CARD_TEMPLATE.md).
> Niveaux de confiance : A normes/fabricant · B technique · C terrain validé · D hypothèse.

## Métadonnées
| Champ | Valeur |
|---|---|
| Identifiant | `serrure-bloquee-grippee` |
| Titre | Serrure bloquée / grippée |
| Profession | `metier:serrurerie-metallerie` |
| Famille | `famille:specialises` |
| Sous-famille | `sous-famille:serrurerie` |
| Version | v0.1 |
| Auteur | IA (proposition) |
| Validateur | ⟦à valider métier⟧ |
| Statut | Brouillon |
| Indice de confiance | **C** |

## Symptôme
- Clé qui **force**, serrure **grippée**, point dur, clé cassée dans le cylindre. `[C]`

## Causes probables
1. **Encrassement / manque de lubrifiant** du mécanisme. `[C]` → [entretenir-diagnostiquer-serrurerie-metallerie](../../professions/serrurerie-metallerie/cards/entretenir-diagnostiquer-serrurerie-metallerie.md)
2. **Gâche/points** mal alignés (porte qui a travaillé). `[C]` → [poser-serrure-verrou](../../professions/serrurerie-metallerie/cards/poser-serrure-verrou.md)
3. Cylindre usé / clé déformée. `[C]`

## Résolution
- Lubrifier (lubrifiant adapté serrure), réaligner la gâche, remplacer cylindre/serrure si usé ; extraire une clé cassée (ouverture fine). `[C]`

## Cadre
- **Normes** : menuiseries métalliques / ouvrages de métallerie **DTU 37.1** ; électricité (gâche / serrure électrique, **interface**) **NF C 15-100** ; garde-corps **NF P01-012**, serrures / cylindres / anti-effraction **EN 12209 / EN 1303 / EN 1627** et certification **A2P** (CNPP), issues de secours **EN 179 / EN 1125** ⟦en prose, à confirmer⟧ `[B]` ⟦référence exacte à confirmer⟧. `respecte-norme`
- **Relations** : `traite-diagnostic` → [poser-serrure-verrou](../../professions/serrurerie-metallerie/cards/poser-serrure-verrou.md).
- **Tags** : `metier:serrurerie-metallerie famille:specialises sous-famille:serrurerie probleme:blocage cluster:serrurerie cluster:diagnostic type:diagnostic securite:manutention`

## Historique
| Version | Date | Auteur | Validateur | Motif |
|---|---|---|---|---|
| v0.1 | 2026-08-05 | IA | ⟦—⟧ | proposition initiale (Brouillon) |
