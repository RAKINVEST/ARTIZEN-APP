# Réseau enterré touché (VRD)

> **Brouillon (v0) — proposé par IA, en attente de validation métier** (Loi 7/18). Modèle : [../../cards/CARD_TEMPLATE.md](../../cards/CARD_TEMPLATE.md).
> Niveaux de confiance : A normes/fabricant · B technique · C terrain validé · D hypothèse.

## Métadonnées
| Champ | Valeur |
|---|---|
| Identifiant | `reseau-touche-vrd` |
| Titre | Réseau enterré touché (VRD) |
| Profession | `metier:vrd` |
| Famille | `famille:gros-oeuvre` |
| Sous-famille | `sous-famille:vrd` |
| Version | v0.1 |
| Auteur | IA (proposition) |
| Validateur | ⟦à valider métier⟧ |
| Statut | Brouillon |
| Indice de confiance | **C** |

## Symptôme
- Un **réseau enterré** (gaz, élec, eau, télécom) est heurté/endommagé pendant les travaux. `[C]`

> **URGENCE.** **Gaz** : arrêt, périmètre, pas de flamme, exploitant/secours. **Élec** : ne pas toucher, exploitant/secours. `[A]`

## Causes probables
1. **DICT** absente / marquage non respecté. `[C]` → [dict-signalisation-vrd](../../procedures/vrd/dict-signalisation-vrd.md)
2. Terrassement mécanique en zone de servitude (au lieu de manuel). `[C]` → [terrasser-reseaux-dict](../../professions/terrassement/cards/terrasser-reseaux-dict.md)

## Résolution
- **Procédure d'urgence** de l'exploitant ; ne pas remblayer avant contrôle/réparation par le concessionnaire. `[A]`

## Cadre
- **Normes** : terrassement des tranchées **DTU 12** ; branchements/réseaux électriques **NF C 15-100** ; ouverture/réfection de tranchées **NF P 98-331**, assainissement **NF EN 1610**, réglementation réseaux (**DICT/AIPR**) et signalisation temporaire ⟦en prose, à confirmer⟧ `[B]` ⟦référence exacte à confirmer⟧. `respecte-norme`
- **Relations** : `traite-diagnostic` → [dict-signalisation-vrd](../../procedures/vrd/dict-signalisation-vrd.md).
- **Tags** : `metier:vrd famille:gros-oeuvre sous-famille:vrd probleme:reseau cluster:reseaux-secs cluster:reseaux-humides cluster:diagnostic type:diagnostic securite:reseaux relation:terrassement`

## Historique
| Version | Date | Auteur | Validateur | Motif |
|---|---|---|---|---|
| v0.1 | 2026-08-05 | IA | ⟦—⟧ | proposition initiale (Brouillon) |
