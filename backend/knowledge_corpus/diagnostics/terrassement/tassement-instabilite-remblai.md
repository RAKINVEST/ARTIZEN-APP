# Tassement / instabilité de remblai

> **Brouillon (v0) — proposé par IA, en attente de validation métier** (Loi 7/18). Modèle : [../../cards/CARD_TEMPLATE.md](../../cards/CARD_TEMPLATE.md).
> Niveaux de confiance : A normes/fabricant · B technique · C terrain validé · D hypothèse.

## Métadonnées
| Champ | Valeur |
|---|---|
| Identifiant | `tassement-instabilite-remblai` |
| Titre | Tassement / instabilité de remblai |
| Profession | `metier:terrassement` |
| Famille | `famille:gros-oeuvre` |
| Sous-famille | `sous-famille:terrassement` |
| Version | v0.1 |
| Auteur | IA (proposition) |
| Validateur | ⟦à valider métier⟧ |
| Statut | Brouillon |
| Indice de confiance | **C** |

## Symptôme
- **Tassement** d'un remblai/plateforme, affaissement localisé, portance insuffisante. `[C]`

## Causes probables
1. **Compactage insuffisant** (couches trop épaisses / mauvaise teneur en eau). `[C]` → [remblayer-compacter](../../professions/terrassement/cards/remblayer-compacter.md)
2. Matériau inadapté / présence d'eau. `[C]`
3. Sol support de mauvaise portance (étude). `[C]` → [diagnostiquer-controler-terrassement](../../professions/terrassement/cards/diagnostiquer-controler-terrassement.md)

## Résolution
- Purger/reprendre le remblai par couches compactées ; traiter l'eau ; contrôler la portance. `[C]`

## Cadre
- **Normes** : terrassements pour le bâtiment **DTU 12** ; fondations superficielles **DTU 13.11 / 13.12** ; réglementation réseaux (**DICT** / guichet unique, **AIPR**) et géotechnique **Eurocode 7 (NF EN 1997)** ⟦en prose, à confirmer⟧ `[B]` ⟦référence exacte à confirmer⟧. `respecte-norme`
- **Relations** : `traite-diagnostic` → [remblayer-compacter](../../professions/terrassement/cards/remblayer-compacter.md).
- **Tags** : `metier:terrassement famille:gros-oeuvre sous-famille:terrassement probleme:tassement cluster:remblai cluster:compactage cluster:diagnostic type:diagnostic securite:effondrement`

## Historique
| Version | Date | Auteur | Validateur | Motif |
|---|---|---|---|---|
| v0.1 | 2026-08-05 | IA | ⟦—⟧ | proposition initiale (Brouillon) |
