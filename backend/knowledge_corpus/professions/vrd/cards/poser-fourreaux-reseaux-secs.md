# Poser fourreaux et réseaux secs

> **Brouillon (v0) — proposé par IA, en attente de validation métier** (Loi 7/18). Modèle : [../../../cards/CARD_TEMPLATE.md](../../../cards/CARD_TEMPLATE.md).
> Niveaux de confiance : A normes/fabricant · B technique · C terrain validé · D hypothèse. Rien n'est publié comme certitude.

## Métadonnées
| Champ | Valeur |
|---|---|
| Identifiant | `poser-fourreaux-reseaux-secs` |
| Titre | Poser fourreaux et réseaux secs |
| Profession | `metier:vrd` |
| Famille | `famille:gros-oeuvre` |
| Sous-famille | `sous-famille:vrd` |
| Version | v0.1 |
| Auteur | IA (proposition) |
| Validateur | ⟦à valider métier⟧ |
| Statut | Brouillon |
| Indice de confiance | **C** |

## Cadrage
- **Objectif** : poser les **fourreaux** et réseaux secs (électricité, télécom) avec chambres de tirage et grillage avertisseur. `[C]`
- **Résumé** : dérouler et poser les **fourreaux** (couleur normalisée par réseau) sur le lit de pose, ménager les **chambres de tirage**, poser le **grillage avertisseur** à la bonne hauteur, aiguiller, puis remblayer/compacter par couches ; le **branchement électrique** relève d'un professionnel. `[C]` ⟦couleurs/hauteurs/distances selon réseau à confirmer⟧

## Réalisation
- **Étapes** :
  1. Poser les **fourreaux** (couleur par réseau) sur lit de pose. `[C]`
  2. Ménager les **chambres de tirage** ; aiguiller. `[C]` → [poser-regard-chambre](poser-regard-chambre.md)
  3. Poser le **grillage avertisseur** (hauteur normalisée). `[C]` ⟦à confirmer⟧
  4. Branchement/raccordement élec = **professionnel**. `[C]` → [controler-tableau-electrique](../../../professions/electricite-generale/cards/controler-tableau-electrique.md)
- **Points critiques** : couleurs/distances de réseaux respectées ; **grillage avertisseur** ; chambres accessibles ; raccordement élec réservé.
- **Sécurité** : réseaux (électrique) ; tranchée (effondrement) ; manutention. **Réseaux enterrés** : **DICT / AIPR** obligatoires avant ouverture — **proximité gaz** (explosion), **électrique** (électrocution), **eau / télécom** ; terrassement **manuel** à l'approche. **Tranchées** : **blindage** / talutage (risque d'**effondrement / ensevelissement**), **jamais** descendre dans une tranchée non protégée. **Circulation routière** : **signalisation temporaire** (balisage/déviation) conforme, protection des intervenants et des usagers. **Engins / levage** : zones balisées, angles morts. **Arrêt immédiat en cas de danger.** Ces opérations exigent compétences, **autorisations (AIPR)** et moyens adaptés.** `[A]`

## Cadre & suites
- **Normes** : terrassement des tranchées **DTU 12** ; branchements/réseaux électriques **NF C 15-100** ; ouverture/réfection de tranchées **NF P 98-331**, assainissement **NF EN 1610**, réglementation réseaux (**DICT/AIPR**) et signalisation temporaire ⟦en prose, à confirmer⟧ `[B]` ⟦références/versions exactes à confirmer par le validateur⟧. `respecte-norme`
- **Remblayer** : `cite-carte` → [ouvrir-tranchee-technique](ouvrir-tranchee-technique.md)

## Relations & tags
- **Tags** : `metier:vrd famille:gros-oeuvre sous-famille:vrd intervention:poser cluster:reseaux-secs cluster:fourreaux cluster:chambres-de-tirage complexite:avancee type:installation securite:reseaux relation:electricite-generale`

## Historique
| Version | Date | Auteur | Validateur | Motif |
|---|---|---|---|---|
| v0.1 | 2026-08-05 | IA | ⟦—⟧ | proposition initiale (Brouillon) |
