# Gérer les eaux et stabiliser les talus

> **Brouillon (v0) — proposé par IA, en attente de validation métier** (Loi 7/18). Modèle : [../../../cards/CARD_TEMPLATE.md](../../../cards/CARD_TEMPLATE.md).
> Niveaux de confiance : A normes/fabricant · B technique · C terrain validé · D hypothèse. Rien n'est publié comme certitude.

## Métadonnées
| Champ | Valeur |
|---|---|
| Identifiant | `gerer-eaux-drainage-talus` |
| Titre | Gérer les eaux et stabiliser les talus |
| Profession | `metier:terrassement` |
| Famille | `famille:gros-oeuvre` |
| Sous-famille | `sous-famille:terrassement` |
| Version | v0.1 |
| Auteur | IA (proposition) |
| Validateur | ⟦à valider métier⟧ |
| Statut | Brouillon |
| Indice de confiance | **C** |

## Cadrage
- **Objectif** : gérer les eaux (pompage/drainage) et assurer la stabilité des talus d'une fouille ou d'un terrassement. `[C]`
- **Résumé** : évacuer les eaux (pompage de fond de fouille, drainage périphérique), régler la **pente des talus** selon la nature du sol pour éviter les glissements, et protéger les parois contre l'érosion (bâchage) ; la pluie **déstabilise** fortement les parois. `[C]` ⟦angle de talus selon sol à confirmer⟧

## Réalisation
- **Étapes** :
  1. Évacuer les eaux (**pompage** fond de fouille, **drainage**). `[C]`
  2. Régler la **pente de talus** stable (nature du sol). `[B]` ⟦à confirmer⟧
  3. Protéger les parois (bâchage anti-érosion) ; **purger** les blocs instables. `[C]`
  4. Surveiller après **pluie** (déstabilisation). `[B]`
- **Points critiques** : eau = ennemi n° 1 de la stabilité ; pente de talus adaptée ; surveillance renforcée après pluie.
- **Sécurité** : glissement de talus / **ensevelissement** ; météo ; engins. **Fouilles** : risque d'**effondrement / ensevelissement** (mortel) — **blindage** obligatoire selon profondeur/nature du sol (Code du travail), **stabilité des talus** (angle/purge), **jamais descendre dans une fouille non protégée**. **Réseaux enterrés** : **DICT** obligatoire **avant** tout terrassement (repérage gaz/élec/eau — risque explosion/électrocution) + **AIPR**. **Engins / levage** : zones d'évolution balisées, angles morts, personne dans le rayon. **Proximité d'ouvrages** existants. **Météo** (pluie = déstabilisation des parois). **Arrêt immédiat en cas de danger.** Ces opérations exigent compétences, **autorisations (AIPR)** et moyens adaptés.** `[A]`

## Cadre & suites
- **Normes** : terrassements pour le bâtiment **DTU 12** ; fondations superficielles **DTU 13.11 / 13.12** ; réglementation réseaux (**DICT** / guichet unique, **AIPR**) et géotechnique **Eurocode 7 (NF EN 1997)** ⟦en prose, à confirmer⟧ `[B]` ⟦références/versions exactes à confirmer par le validateur⟧. `respecte-norme`
- **Blindage** : `cite-carte` → [blinder-securiser-fouille](blinder-securiser-fouille.md)

## Relations & tags
- **Tags** : `metier:terrassement famille:gros-oeuvre sous-famille:terrassement intervention:realiser cluster:talus cluster:drainage cluster:fouilles complexite:avancee type:realisation securite:effondrement`

## Historique
| Version | Date | Auteur | Validateur | Motif |
|---|---|---|---|---|
| v0.1 | 2026-08-05 | IA | ⟦—⟧ | proposition initiale (Brouillon) |
