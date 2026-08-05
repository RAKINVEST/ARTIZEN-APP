# DICT / AIPR & signalisation temporaire (VRD)

> **Brouillon (v0) — proposé par IA, en attente de validation métier** (Loi 7/18). Modèle : [../../cards/CARD_TEMPLATE.md](../../cards/CARD_TEMPLATE.md).
> Niveaux de confiance : A normes/fabricant · B technique · C terrain validé · D hypothèse.

## Métadonnées
| Champ | Valeur |
|---|---|
| Identifiant | `dict-signalisation-vrd` |
| Titre | DICT / AIPR & signalisation temporaire (VRD) |
| Profession | `metier:vrd` |
| Famille | `famille:gros-oeuvre` |
| Sous-famille | `sous-famille:securite` |
| Version | v0.1 |
| Auteur | IA (proposition) |
| Validateur | ⟦à valider métier⟧ |
| Statut | Brouillon |
| Indice de confiance | **B** |

## But
- Sécuriser une intervention VRD : réseaux identifiés **et** chantier signalé. `[A]`

## Étapes
1. **DT/DICT** (guichet unique) ; réponses exploitants ; **marquage-piquetage**. `[A]` → [terrasser-reseaux-dict](../../professions/terrassement/cards/terrasser-reseaux-dict.md)
2. Opérateur/encadrant **AIPR**. `[A]`
3. **Signalisation temporaire** (approche/position/fin) selon la réglementation routière. `[A]` ⟦schéma selon voie/arrêté à confirmer⟧
4. Autorisation de voirie / arrêté de circulation si besoin. `[A]`

> Sans DICT ni signalisation : danger grave (réseaux + circulation). Doute → **arrêt**. `[A]`

## Cadre
- **Normes** : terrassement des tranchées **DTU 12** ; branchements/réseaux électriques **NF C 15-100** ; ouverture/réfection de tranchées **NF P 98-331**, assainissement **NF EN 1610**, réglementation réseaux (**DICT/AIPR**) et signalisation temporaire ⟦en prose, à confirmer⟧ `[B]` ⟦référence exacte à confirmer⟧. `respecte-norme`
- **Relations** : `cite-carte` → [ouvrir-tranchee-technique](../../professions/vrd/cards/ouvrir-tranchee-technique.md).
- **Tags** : `metier:vrd famille:gros-oeuvre sous-famille:securite intervention:controler cluster:reglementation cluster:reseaux-secs type:procedure securite:reseaux relation:terrassement`

## Historique
| Version | Date | Auteur | Validateur | Motif |
|---|---|---|---|---|
| v0.1 | 2026-08-05 | IA | ⟦—⟧ | proposition initiale (Brouillon) |
