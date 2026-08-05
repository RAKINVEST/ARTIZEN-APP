# Réseau enterré touché / endommagé

> **Brouillon (v0) — proposé par IA, en attente de validation métier** (Loi 7/18). Modèle : [../../cards/CARD_TEMPLATE.md](../../cards/CARD_TEMPLATE.md).
> Niveaux de confiance : A normes/fabricant · B technique · C terrain validé · D hypothèse.

## Métadonnées
| Champ | Valeur |
|---|---|
| Identifiant | `reseau-touche-endommage` |
| Titre | Réseau enterré touché / endommagé |
| Profession | `metier:terrassement` |
| Famille | `famille:gros-oeuvre` |
| Sous-famille | `sous-famille:terrassement` |
| Version | v0.1 |
| Auteur | IA (proposition) |
| Validateur | ⟦à valider métier⟧ |
| Statut | Brouillon |
| Indice de confiance | **C** |

## Symptôme
- Un **réseau enterré** (gaz, électricité, eau, télécom) est **heurté ou endommagé** pendant le terrassement. `[C]`

> **URGENCE.** **Gaz** : arrêt, évacuation/périmètre, pas de flamme/étincelle, appeler l'exploitant/secours. **Électricité** : ne pas toucher, couper si possible, exploitant/secours. `[A]`

## Causes probables
1. **DICT** absente / marquage non respecté. `[C]` → [dict-avant-terrassement](../../procedures/terrassement/dict-avant-terrassement.md)
2. Terrassement mécanique en zone de servitude (au lieu de manuel). `[C]` → [terrasser-reseaux-dict](../../professions/terrassement/cards/terrasser-reseaux-dict.md)

## Résolution
- Appliquer la **procédure d'urgence** de l'exploitant ; ne pas remblayer avant contrôle/réparation par le concessionnaire. `[A]`

## Cadre
- **Normes** : terrassements pour le bâtiment **DTU 12** ; fondations superficielles **DTU 13.11 / 13.12** ; réglementation réseaux (**DICT** / guichet unique, **AIPR**) et géotechnique **Eurocode 7 (NF EN 1997)** ⟦en prose, à confirmer⟧ `[B]` ⟦référence exacte à confirmer⟧. `respecte-norme`
- **Relations** : `traite-diagnostic` → [terrasser-reseaux-dict](../../professions/terrassement/cards/terrasser-reseaux-dict.md).
- **Tags** : `metier:terrassement famille:gros-oeuvre sous-famille:terrassement probleme:reseau cluster:reseaux-enterres cluster:dict cluster:diagnostic type:diagnostic securite:reseaux relation:assainissement`

## Historique
| Version | Date | Auteur | Validateur | Motif |
|---|---|---|---|---|
| v0.1 | 2026-08-05 | IA | ⟦—⟧ | proposition initiale (Brouillon) |
