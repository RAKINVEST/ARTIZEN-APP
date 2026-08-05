# Réaliser une fouille / une tranchée

> **Brouillon (v0) — proposé par IA, en attente de validation métier** (Loi 7/18). Modèle : [../../../cards/CARD_TEMPLATE.md](../../../cards/CARD_TEMPLATE.md).
> Niveaux de confiance : A normes/fabricant · B technique · C terrain validé · D hypothèse. Rien n'est publié comme certitude.

## Métadonnées
| Champ | Valeur |
|---|---|
| Identifiant | `realiser-fouille-tranchee` |
| Titre | Réaliser une fouille / une tranchée |
| Profession | `metier:terrassement` |
| Famille | `famille:gros-oeuvre` |
| Sous-famille | `sous-famille:terrassement` |
| Version | v0.1 |
| Auteur | IA (proposition) |
| Validateur | ⟦à valider métier⟧ |
| Statut | Brouillon |
| Indice de confiance | **C** |

## Cadrage
- **Objectif** : excaver une fouille ou une tranchée en sécurité (DICT, blindage, talus) selon le **DTU 12**. `[C]`
- **Résumé** : après **DICT/AIPR** et repérage des réseaux, excaver à la profondeur prévue en **blindant** ou en **talutant** selon la nature du sol et la profondeur, évacuer les déblais et gérer les eaux ; **ne jamais descendre dans une fouille non protégée** (>1,30 m). `[C]` ⟦blindage/pente selon sol et Code du travail à confirmer⟧

## Réalisation
- **Étapes** :
  1. **DICT/AIPR** + repérage réseaux **avant** d'excaver. `[A]` → [dict-avant-terrassement](../../../procedures/terrassement/dict-avant-terrassement.md)
  2. Excaver ; **blinder** ou **taluter** selon sol/profondeur. `[A]` → [blinder-securiser-fouille](blinder-securiser-fouille.md)
  3. Évacuer les déblais ; gérer les **eaux** (pompage/drainage). `[C]` → [gerer-eaux-drainage-talus](gerer-eaux-drainage-talus.md)
  4. Contrôler fond de fouille (portance) avant ouvrage. `[C]`
- **Points critiques** : **blindage obligatoire** au-delà des seuils ; jamais de personnel dans une fouille non protégée ; DICT respectée ; eaux gérées.
- **Sécurité** : **effondrement / ensevelissement** ; réseaux enterrés ; engins. **Fouilles** : risque d'**effondrement / ensevelissement** (mortel) — **blindage** obligatoire selon profondeur/nature du sol (Code du travail), **stabilité des talus** (angle/purge), **jamais descendre dans une fouille non protégée**. **Réseaux enterrés** : **DICT** obligatoire **avant** tout terrassement (repérage gaz/élec/eau — risque explosion/électrocution) + **AIPR**. **Engins / levage** : zones d'évolution balisées, angles morts, personne dans le rayon. **Proximité d'ouvrages** existants. **Météo** (pluie = déstabilisation des parois). **Arrêt immédiat en cas de danger.** Ces opérations exigent compétences, **autorisations (AIPR)** et moyens adaptés.** `[A]`

## Cadre & suites
- **Normes** : terrassements pour le bâtiment **DTU 12** ; fondations superficielles **DTU 13.11 / 13.12** ; réglementation réseaux (**DICT** / guichet unique, **AIPR**) et géotechnique **Eurocode 7 (NF EN 1997)** ⟦en prose, à confirmer⟧ `[B]` ⟦références/versions exactes à confirmer par le validateur⟧. `respecte-norme`
- **Désordre** : `traite-diagnostic` → [effondrement-paroi-fouille](../../../diagnostics/terrassement/effondrement-paroi-fouille.md)

## Relations & tags
- **Tags** : `metier:terrassement famille:gros-oeuvre sous-famille:terrassement intervention:realiser cluster:fouilles cluster:tranchees cluster:blindage complexite:expert type:realisation securite:effondrement securite:reseaux`

## Historique
| Version | Date | Auteur | Validateur | Motif |
|---|---|---|---|---|
| v0.1 | 2026-08-05 | IA | ⟦—⟧ | proposition initiale (Brouillon) |
