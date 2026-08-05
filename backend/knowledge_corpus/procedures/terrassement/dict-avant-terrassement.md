# DICT / AIPR avant terrassement

> **Brouillon (v0) — proposé par IA, en attente de validation métier** (Loi 7/18). Modèle : [../../cards/CARD_TEMPLATE.md](../../cards/CARD_TEMPLATE.md).
> Niveaux de confiance : A normes/fabricant · B technique · C terrain validé · D hypothèse.

## Métadonnées
| Champ | Valeur |
|---|---|
| Identifiant | `dict-avant-terrassement` |
| Titre | DICT / AIPR avant terrassement |
| Profession | `metier:terrassement` |
| Famille | `famille:gros-oeuvre` |
| Sous-famille | `sous-famille:securite` |
| Version | v0.1 |
| Auteur | IA (proposition) |
| Validateur | ⟦à valider métier⟧ |
| Statut | Brouillon |
| Indice de confiance | **B** |

## But
- S'assurer que les réseaux enterrés sont identifiés **avant** tout terrassement (réglementaire). `[A]`

## Étapes
1. **DT/DICT** via le **guichet unique** ; obtenir les réponses des exploitants. `[A]` ⟦procédure exacte à confirmer⟧
2. **Marquage-piquetage** au sol des réseaux repérés. `[A]`
3. Opérateur/encadrant titulaires de l'**AIPR**. `[A]`
4. À l'approche des réseaux : **terrassement manuel** (zone de servitude). `[A]` → [terrasser-reseaux-dict](../../professions/terrassement/cards/terrasser-reseaux-dict.md)

> Terrasser **sans DICT** = infraction + danger grave (gaz/élec). Tout doute → **arrêt**. `[A]`

## Cadre
- **Normes** : terrassements pour le bâtiment **DTU 12** ; fondations superficielles **DTU 13.11 / 13.12** ; réglementation réseaux (**DICT** / guichet unique, **AIPR**) et géotechnique **Eurocode 7 (NF EN 1997)** ⟦en prose, à confirmer⟧ `[B]` ⟦référence exacte à confirmer⟧. `respecte-norme`
- **Relations** : `cite-carte` → [realiser-fouille-tranchee](../../professions/terrassement/cards/realiser-fouille-tranchee.md).
- **Tags** : `metier:terrassement famille:gros-oeuvre sous-famille:securite intervention:controler cluster:dict cluster:reseaux-enterres cluster:reglementation type:procedure securite:reseaux relation:vrd`

## Historique
| Version | Date | Auteur | Validateur | Motif |
|---|---|---|---|---|
| v0.1 | 2026-08-05 | IA | ⟦—⟧ | proposition initiale (Brouillon) |
