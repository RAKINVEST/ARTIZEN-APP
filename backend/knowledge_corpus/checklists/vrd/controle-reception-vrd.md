# Contrôle de réception VRD

> **Brouillon (v0) — proposé par IA, en attente de validation métier** (Loi 7/18). Modèle : [../../cards/CARD_TEMPLATE.md](../../cards/CARD_TEMPLATE.md).
> Niveaux de confiance : A normes/fabricant · B technique · C terrain validé · D hypothèse.

## Métadonnées
| Champ | Valeur |
|---|---|
| Identifiant | `controle-reception-vrd` |
| Titre | Contrôle de réception VRD |
| Profession | `metier:vrd` |
| Famille | `famille:gros-oeuvre` |
| Sous-famille | `sous-famille:vrd` |
| Version | v0.1 |
| Auteur | IA (proposition) |
| Validateur | ⟦à valider métier⟧ |
| Statut | Brouillon |
| Indice de confiance | **C** |

## Points à vérifier
- [ ] **Cotes / altimétrie / pentes** conformes (écoulement). `[C]`
- [ ] **Compactage** des remblais de tranchée (essais). `[C]`
- [ ] **Essais réseaux** (étanchéité/écoulement) OK. `[C]`
- [ ] **Grillage avertisseur** + distances entre réseaux respectés. `[C]`
- [ ] **Regards/tampons** à niveau, classe de trafic adaptée. `[C]`
- [ ] **Récolement** (plan des réseaux) établi. `[C]`

> Tant que la tranchée est ouverte : **blindage**, **signalisation**, DICT.

## Cadre
- **Normes** : terrassement des tranchées **DTU 12** ; branchements/réseaux électriques **NF C 15-100** ; ouverture/réfection de tranchées **NF P 98-331**, assainissement **NF EN 1610**, réglementation réseaux (**DICT/AIPR**) et signalisation temporaire ⟦en prose, à confirmer⟧ `[B]` ⟦référence exacte à confirmer⟧. `respecte-norme`
- **Relations** : `verifie` → [controler-receptionner-vrd](../../professions/vrd/cards/controler-receptionner-vrd.md).
- **Tags** : `metier:vrd famille:gros-oeuvre sous-famille:vrd type:checklist cluster:controle cluster:nivellement cluster:raccordements securite:reseaux`

## Historique
| Version | Date | Auteur | Validateur | Motif |
|---|---|---|---|---|
| v0.1 | 2026-08-05 | IA | ⟦—⟧ | proposition initiale (Brouillon) |
