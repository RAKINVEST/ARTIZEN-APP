# Effondrement / éboulement de paroi de fouille

> **Brouillon (v0) — proposé par IA, en attente de validation métier** (Loi 7/18). Modèle : [../../cards/CARD_TEMPLATE.md](../../cards/CARD_TEMPLATE.md).
> Niveaux de confiance : A normes/fabricant · B technique · C terrain validé · D hypothèse.

## Métadonnées
| Champ | Valeur |
|---|---|
| Identifiant | `effondrement-paroi-fouille` |
| Titre | Effondrement / éboulement de paroi de fouille |
| Profession | `metier:terrassement` |
| Famille | `famille:gros-oeuvre` |
| Sous-famille | `sous-famille:terrassement` |
| Version | v0.1 |
| Auteur | IA (proposition) |
| Validateur | ⟦à valider métier⟧ |
| Statut | Brouillon |
| Indice de confiance | **C** |

## Symptôme
- Paroi de fouille qui **fissure**, se détache, ou **éboule** ; fissures en surface en bord de fouille. `[C]`

> **DANGER VITAL — ensevelissement.** Évacuer immédiatement la fouille, interdire l'accès, **ne jamais** y descendre pour « vérifier ». `[A]`

## Causes probables
1. **Absence/insuffisance de blindage** ou talutage. `[C]` → [blinder-securiser-fouille](../../professions/terrassement/cards/blinder-securiser-fouille.md)
2. **Eau / pluie** ayant déstabilisé le sol. `[C]` → [gerer-eaux-drainage-talus](../../professions/terrassement/cards/gerer-eaux-drainage-talus.md)
3. Surcharge en bord (engin/déblais) ou vibrations. `[C]`

## Résolution
- **Évacuer + sécuriser** ; reprendre le blindage/talutage depuis la surface ; éloigner les charges. `[A]`

## Cadre
- **Normes** : terrassements pour le bâtiment **DTU 12** ; fondations superficielles **DTU 13.11 / 13.12** ; réglementation réseaux (**DICT** / guichet unique, **AIPR**) et géotechnique **Eurocode 7 (NF EN 1997)** ⟦en prose, à confirmer⟧ `[B]` ⟦référence exacte à confirmer⟧. `respecte-norme`
- **Relations** : `traite-diagnostic` → [blinder-securiser-fouille](../../professions/terrassement/cards/blinder-securiser-fouille.md).
- **Tags** : `metier:terrassement famille:gros-oeuvre sous-famille:terrassement probleme:effondrement cluster:fouilles cluster:blindage cluster:diagnostic type:diagnostic securite:effondrement`

## Historique
| Version | Date | Auteur | Validateur | Motif |
|---|---|---|---|---|
| v0.1 | 2026-08-05 | IA | ⟦—⟧ | proposition initiale (Brouillon) |
