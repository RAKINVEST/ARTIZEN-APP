# Effondrement de tranchée (VRD)

> **Brouillon (v0) — proposé par IA, en attente de validation métier** (Loi 7/18). Modèle : [../../cards/CARD_TEMPLATE.md](../../cards/CARD_TEMPLATE.md).
> Niveaux de confiance : A normes/fabricant · B technique · C terrain validé · D hypothèse.

## Métadonnées
| Champ | Valeur |
|---|---|
| Identifiant | `effondrement-tranchee-vrd` |
| Titre | Effondrement de tranchée (VRD) |
| Profession | `metier:vrd` |
| Famille | `famille:gros-oeuvre` |
| Sous-famille | `sous-famille:vrd` |
| Version | v0.1 |
| Auteur | IA (proposition) |
| Validateur | ⟦à valider métier⟧ |
| Statut | Brouillon |
| Indice de confiance | **C** |

## Symptôme
- Paroi de **tranchée** qui fissure/s'éboule ; fissures en bord ; venue d'eau. `[C]`

> **DANGER VITAL — ensevelissement.** Évacuer, interdire l'accès, **ne jamais** descendre pour « vérifier ». `[A]`

## Causes probables
1. **Blindage** absent/insuffisant. `[C]` → [blinder-securiser-fouille](../../professions/terrassement/cards/blinder-securiser-fouille.md)
2. **Eau/pluie** ou surcharge en bord (engin/déblais). `[C]`
3. Tranchée trop étroite/profonde sans protection. `[C]` → [ouvrir-tranchee-technique](../../professions/vrd/cards/ouvrir-tranchee-technique.md)

## Résolution
- **Évacuer + sécuriser** ; reprendre blindage/talutage depuis la surface ; éloigner les charges. `[A]`

## Cadre
- **Normes** : terrassement des tranchées **DTU 12** ; branchements/réseaux électriques **NF C 15-100** ; ouverture/réfection de tranchées **NF P 98-331**, assainissement **NF EN 1610**, réglementation réseaux (**DICT/AIPR**) et signalisation temporaire ⟦en prose, à confirmer⟧ `[B]` ⟦référence exacte à confirmer⟧. `respecte-norme`
- **Relations** : `traite-diagnostic` → [ouvrir-tranchee-technique](../../professions/vrd/cards/ouvrir-tranchee-technique.md).
- **Tags** : `metier:vrd famille:gros-oeuvre sous-famille:vrd probleme:effondrement cluster:tranchees-techniques cluster:diagnostic type:diagnostic securite:effondrement relation:terrassement`

## Historique
| Version | Date | Auteur | Validateur | Motif |
|---|---|---|---|---|
| v0.1 | 2026-08-05 | IA | ⟦—⟧ | proposition initiale (Brouillon) |
