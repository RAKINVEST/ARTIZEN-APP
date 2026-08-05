# Principe du VRD (voirie & réseaux divers)

> **Brouillon (v0) — proposé par IA, en attente de validation métier** (Loi 7/18). Modèle : [../../../cards/CARD_TEMPLATE.md](../../../cards/CARD_TEMPLATE.md).
> Niveaux de confiance : A normes/fabricant · B technique · C terrain validé · D hypothèse. Rien n'est publié comme certitude.

## Métadonnées
| Champ | Valeur |
|---|---|
| Identifiant | `principe-vrd` |
| Titre | Principe du VRD (voirie & réseaux divers) |
| Profession | `metier:vrd` |
| Famille | `famille:gros-oeuvre` |
| Sous-famille | `sous-famille:vrd` |
| Version | v0.1 |
| Auteur | IA (proposition) |
| Validateur | ⟦à valider métier⟧ |
| Statut | Brouillon |
| Indice de confiance | **C** |

## Cadrage
- **Objectif** : comprendre le VRD : réseaux secs/humides enterrés et voirie légère, et leurs préalables (DICT, nivellement). `[C]`
- **Résumé** : le VRD regroupe les **réseaux secs** (élec/télécom/gaz, en **fourreaux**), les **réseaux humides** (eau/EU/EP) et la **voirie légère** (plateformes, **bordures**, **caniveaux**) ; il s'appuie sur le **terrassement** des tranchées et exige **DICT** et nivellement préalables. `[C]` ⟦méthodes selon réseau/projet à confirmer⟧

## Réalisation
- **Étapes** :
  1. **Tranchées techniques** (terrassement + blindage + DICT). `[A]` → [ouvrir-tranchee-technique](ouvrir-tranchee-technique.md)
  2. **Réseaux secs** (fourreaux, chambres) / **humides** (canalisations). `[C]` → [poser-fourreaux-reseaux-secs](poser-fourreaux-reseaux-secs.md)
  3. **Branchements / raccordements** au réseau public. `[C]` → [realiser-branchement-raccordement](realiser-branchement-raccordement.md)
  4. **Voirie légère** (bordures, caniveaux, nivellement). `[C]` → [poser-bordures-caniveaux](poser-bordures-caniveaux.md)
- **Points critiques** : **DICT avant tout** ; blindage des tranchées ; pentes/nivellement (écoulement) ; séparation des réseaux (distances).
- **Sécurité** : réseaux enterrés ; effondrement de tranchée ; circulation routière. **Réseaux enterrés** : **DICT / AIPR** obligatoires avant ouverture — **proximité gaz** (explosion), **électrique** (électrocution), **eau / télécom** ; terrassement **manuel** à l'approche. **Tranchées** : **blindage** / talutage (risque d'**effondrement / ensevelissement**), **jamais** descendre dans une tranchée non protégée. **Circulation routière** : **signalisation temporaire** (balisage/déviation) conforme, protection des intervenants et des usagers. **Engins / levage** : zones balisées, angles morts. **Arrêt immédiat en cas de danger.** Ces opérations exigent compétences, **autorisations (AIPR)** et moyens adaptés.** `[A]`

## Cadre & suites
- **Normes** : terrassement des tranchées **DTU 12** ; branchements/réseaux électriques **NF C 15-100** ; ouverture/réfection de tranchées **NF P 98-331**, assainissement **NF EN 1610**, réglementation réseaux (**DICT/AIPR**) et signalisation temporaire ⟦en prose, à confirmer⟧ `[B]` ⟦références/versions exactes à confirmer par le validateur⟧. `respecte-norme`
- **DICT & signalisation** : `cite-procedure` → [dict-signalisation-vrd](../../../procedures/vrd/dict-signalisation-vrd.md)

## Relations & tags
- **Tags** : `metier:vrd famille:gros-oeuvre sous-famille:vrd intervention:comprendre cluster:reseaux-secs cluster:reseaux-humides cluster:tranchees-techniques cluster:voirie-legere cluster:nivellement type:principe securite:reseaux relation:terrassement`

## Historique
| Version | Date | Auteur | Validateur | Motif |
|---|---|---|---|---|
| v0.1 | 2026-08-05 | IA | ⟦—⟧ | proposition initiale (Brouillon) |
