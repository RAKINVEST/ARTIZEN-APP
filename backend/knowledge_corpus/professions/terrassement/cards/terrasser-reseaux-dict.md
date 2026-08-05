# Terrasser à proximité de réseaux enterrés

> **Brouillon (v0) — proposé par IA, en attente de validation métier** (Loi 7/18). Modèle : [../../../cards/CARD_TEMPLATE.md](../../../cards/CARD_TEMPLATE.md).
> Niveaux de confiance : A normes/fabricant · B technique · C terrain validé · D hypothèse. Rien n'est publié comme certitude.

## Métadonnées
| Champ | Valeur |
|---|---|
| Identifiant | `terrasser-reseaux-dict` |
| Titre | Terrasser à proximité de réseaux enterrés |
| Profession | `metier:terrassement` |
| Famille | `famille:gros-oeuvre` |
| Sous-famille | `sous-famille:terrassement` |
| Version | v0.1 |
| Auteur | IA (proposition) |
| Validateur | ⟦à valider métier⟧ |
| Statut | Brouillon |
| Indice de confiance | **C** |

## Cadrage
- **Objectif** : terrasser à proximité de réseaux enterrés (gaz/élec/eau/telecom) en sécurité, après DICT. `[C]`
- **Résumé** : après **DICT** et marquage-piquetage, repérer les réseaux, terrasser **manuellement** à l'approche (zone de servitude), respecter les distances, poser lit de pose + **grillage avertisseur** pour un réseau neuf ; tout réseau touché = **arrêt + procédure d'urgence**. `[C]` ⟦distances/classe de précision selon DICT à confirmer⟧

## Réalisation
- **Étapes** :
  1. **DICT** + marquage-piquetage ; **AIPR** de l'opérateur. `[A]` → [dict-avant-terrassement](../../../procedures/terrassement/dict-avant-terrassement.md)
  2. À l'approche : **terrassement manuel** (zone de servitude). `[A]`
  3. Respecter distances ; **grillage avertisseur** (réseau neuf). `[C]`
  4. Réseau **touché** → arrêt + urgence. `[A]` → [reseau-touche-endommage](../../../diagnostics/terrassement/reseau-touche-endommage.md)
- **Points critiques** : **DICT obligatoire** ; terrassement manuel à l'approche ; distances de sécurité ; grillage avertisseur ; arrêt si réseau touché.
- **Sécurité** : **réseaux** (explosion gaz / électrocution) ; engins ; ensevelissement. **Fouilles** : risque d'**effondrement / ensevelissement** (mortel) — **blindage** obligatoire selon profondeur/nature du sol (Code du travail), **stabilité des talus** (angle/purge), **jamais descendre dans une fouille non protégée**. **Réseaux enterrés** : **DICT** obligatoire **avant** tout terrassement (repérage gaz/élec/eau — risque explosion/électrocution) + **AIPR**. **Engins / levage** : zones d'évolution balisées, angles morts, personne dans le rayon. **Proximité d'ouvrages** existants. **Météo** (pluie = déstabilisation des parois). **Arrêt immédiat en cas de danger.** Ces opérations exigent compétences, **autorisations (AIPR)** et moyens adaptés.** `[A]`

## Cadre & suites
- **Normes** : terrassements pour le bâtiment **DTU 12** ; fondations superficielles **DTU 13.11 / 13.12** ; réglementation réseaux (**DICT** / guichet unique, **AIPR**) et géotechnique **Eurocode 7 (NF EN 1997)** ⟦en prose, à confirmer⟧ `[B]` ⟦références/versions exactes à confirmer par le validateur⟧. `respecte-norme`
- **Assainissement/VRD (réseaux)** : `relation:assainissement` (futurs Livres Gros Œuvre)

## Relations & tags
- **Tags** : `metier:terrassement famille:gros-oeuvre sous-famille:terrassement intervention:realiser cluster:reseaux-enterres cluster:dict cluster:tranchees complexite:expert type:realisation securite:reseaux relation:assainissement relation:vrd`

## Historique
| Version | Date | Auteur | Validateur | Motif |
|---|---|---|---|---|
| v0.1 | 2026-08-05 | IA | ⟦—⟧ | proposition initiale (Brouillon) |
