# Principe du terrassement (déblai, remblai, fouilles)

> **Brouillon (v0) — proposé par IA, en attente de validation métier** (Loi 7/18). Modèle : [../../../cards/CARD_TEMPLATE.md](../../../cards/CARD_TEMPLATE.md).
> Niveaux de confiance : A normes/fabricant · B technique · C terrain validé · D hypothèse. Rien n'est publié comme certitude.

## Métadonnées
| Champ | Valeur |
|---|---|
| Identifiant | `principe-terrassement` |
| Titre | Principe du terrassement (déblai, remblai, fouilles) |
| Profession | `metier:terrassement` |
| Famille | `famille:gros-oeuvre` |
| Sous-famille | `sous-famille:terrassement` |
| Version | v0.1 |
| Auteur | IA (proposition) |
| Validateur | ⟦à valider métier⟧ |
| Statut | Brouillon |
| Indice de confiance | **C** |

## Cadrage
- **Objectif** : comprendre le terrassement (modéler le terrain : déblai/remblai, fouilles, plateformes) et ses préalables (étude de sol, DICT). `[C]`
- **Résumé** : le terrassement modèle le terrain — **déblai** (excavation) et **remblai** (apport) — pour créer **fouilles**, **tranchées** et **plateformes** ; il prépare l'assise des ouvrages (fondations de la **maçonnerie**) et exige une **étude de sol** et une **DICT** préalables. `[C]` ⟦nature du sol / méthode selon étude géotechnique à confirmer⟧

## Réalisation
- **Étapes** :
  1. **Étude de sol** + **DICT** préalables (obligatoire). `[A]` → [dict-avant-terrassement](../../../procedures/terrassement/dict-avant-terrassement.md)
  2. **Fouilles / tranchées** (avec blindage). `[C]` → [realiser-fouille-tranchee](realiser-fouille-tranchee.md)
  3. **Plateforme / nivellement** (altimétrie). `[C]` → [niveler-plateforme](niveler-plateforme.md)
  4. **Assise** des ouvrages (fondation de la maçonnerie). `[C]` → [monter-mur-cloison](../../../professions/maconnerie/cards/monter-mur-cloison.md)
- **Points critiques** : **DICT et étude de sol avant tout** ; blindage des fouilles ; nature du sol (portance/stabilité) ; gestion de l'eau.
- **Sécurité** : effondrement/ensevelissement ; réseaux enterrés ; engins. **Fouilles** : risque d'**effondrement / ensevelissement** (mortel) — **blindage** obligatoire selon profondeur/nature du sol (Code du travail), **stabilité des talus** (angle/purge), **jamais descendre dans une fouille non protégée**. **Réseaux enterrés** : **DICT** obligatoire **avant** tout terrassement (repérage gaz/élec/eau — risque explosion/électrocution) + **AIPR**. **Engins / levage** : zones d'évolution balisées, angles morts, personne dans le rayon. **Proximité d'ouvrages** existants. **Météo** (pluie = déstabilisation des parois). **Arrêt immédiat en cas de danger.** Ces opérations exigent compétences, **autorisations (AIPR)** et moyens adaptés.** `[A]`

## Cadre & suites
- **Normes** : terrassements pour le bâtiment **DTU 12** ; fondations superficielles **DTU 13.11 / 13.12** ; réglementation réseaux (**DICT** / guichet unique, **AIPR**) et géotechnique **Eurocode 7 (NF EN 1997)** ⟦en prose, à confirmer⟧ `[B]` ⟦références/versions exactes à confirmer par le validateur⟧. `respecte-norme`
- **Diagnostic / contrôle** : `cite-carte` → [diagnostiquer-controler-terrassement](diagnostiquer-controler-terrassement.md)

## Relations & tags
- **Tags** : `metier:terrassement famille:gros-oeuvre sous-famille:terrassement intervention:comprendre cluster:fouilles cluster:tranchees cluster:deblai cluster:remblai cluster:plateformes type:principe securite:effondrement relation:maconnerie`

## Historique
| Version | Date | Auteur | Validateur | Motif |
|---|---|---|---|---|
| v0.1 | 2026-08-05 | IA | ⟦—⟧ | proposition initiale (Brouillon) |
