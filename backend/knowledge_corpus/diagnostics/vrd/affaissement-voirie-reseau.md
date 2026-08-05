# Affaissement de voirie au-dessus d'un réseau

> **Brouillon (v0) — proposé par IA, en attente de validation métier** (Loi 7/18). Modèle : [../../cards/CARD_TEMPLATE.md](../../cards/CARD_TEMPLATE.md).
> Niveaux de confiance : A normes/fabricant · B technique · C terrain validé · D hypothèse.

## Métadonnées
| Champ | Valeur |
|---|---|
| Identifiant | `affaissement-voirie-reseau` |
| Titre | Affaissement de voirie au-dessus d'un réseau |
| Profession | `metier:vrd` |
| Famille | `famille:gros-oeuvre` |
| Sous-famille | `sous-famille:vrd` |
| Version | v0.1 |
| Auteur | IA (proposition) |
| Validateur | ⟦à valider métier⟧ |
| Statut | Brouillon |
| Indice de confiance | **C** |

## Symptôme
- **Affaissement** / cuvette de voirie, souvent au droit d'une **tranchée** rebouchée. `[C]`

## Causes probables
1. **Compactage insuffisant** du remblai de tranchée. `[C]` → [ouvrir-tranchee-technique](../../professions/vrd/cards/ouvrir-tranchee-technique.md)
2. Fuite d'un **réseau humide** (lessivage des fines). `[C]` → [poser-reseau-humide](../../professions/vrd/cards/poser-reseau-humide.md)
3. Matériau de remblai inadapté. `[C]`

## Résolution
- Purger/reprendre le remblai par couches compactées ; contrôler l'étanchéité du réseau ; rétablir la voirie. `[C]`

## Cadre
- **Normes** : terrassement des tranchées **DTU 12** ; branchements/réseaux électriques **NF C 15-100** ; ouverture/réfection de tranchées **NF P 98-331**, assainissement **NF EN 1610**, réglementation réseaux (**DICT/AIPR**) et signalisation temporaire ⟦en prose, à confirmer⟧ `[B]` ⟦référence exacte à confirmer⟧. `respecte-norme`
- **Relations** : `traite-diagnostic` → [controler-receptionner-vrd](../../professions/vrd/cards/controler-receptionner-vrd.md).
- **Tags** : `metier:vrd famille:gros-oeuvre sous-famille:vrd probleme:affaissement cluster:voirie-legere cluster:diagnostic type:diagnostic securite:reseaux`

## Historique
| Version | Date | Auteur | Validateur | Motif |
|---|---|---|---|---|
| v0.1 | 2026-08-05 | IA | ⟦—⟧ | proposition initiale (Brouillon) |
