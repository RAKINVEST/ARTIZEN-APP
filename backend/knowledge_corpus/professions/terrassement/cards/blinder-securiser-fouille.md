# Blinder / sécuriser une fouille

> **Brouillon (v0) — proposé par IA, en attente de validation métier** (Loi 7/18). Modèle : [../../../cards/CARD_TEMPLATE.md](../../../cards/CARD_TEMPLATE.md).
> Niveaux de confiance : A normes/fabricant · B technique · C terrain validé · D hypothèse. Rien n'est publié comme certitude.

## Métadonnées
| Champ | Valeur |
|---|---|
| Identifiant | `blinder-securiser-fouille` |
| Titre | Blinder / sécuriser une fouille |
| Profession | `metier:terrassement` |
| Famille | `famille:gros-oeuvre` |
| Sous-famille | `sous-famille:securite` |
| Version | v0.1 |
| Auteur | IA (proposition) |
| Validateur | ⟦à valider métier⟧ |
| Statut | Brouillon |
| Indice de confiance | **B** |

## Cadrage
- **Objectif** : sécuriser une fouille contre l'effondrement par **blindage** ou **talutage** — opération vitale. `[B]`
- **Résumé** : choisir la protection selon la profondeur et la nature du sol : **blindage** (caisson, panneaux, boisage) ou **talutage** (pente stable), mettre en place depuis la surface (jamais dans une fouille non protégée), et maintenir jusqu'au remblaiement. `[B]` ⟦type/dimensionnement selon sol et Code du travail à confirmer⟧

## Réalisation
- **Étapes** :
  1. Évaluer profondeur et **nature du sol** (étude). `[A]`
  2. Choisir **blindage** (caisson/panneaux) ou **talutage** (pente). `[A]` ⟦seuils Code du travail à confirmer⟧
  3. Mettre en place **depuis la surface** ; blindage jointif. `[A]`
  4. Maintenir jusqu'au remblaiement ; contrôler après pluie. `[B]`
- **Points critiques** : protection **avant** toute présence en fond de fouille ; blindage dimensionné ; surveiller après pluie/vibrations.
- **Sécurité** : **ensevelissement** (mortel) ; mise en place depuis la surface ; météo. **Fouilles** : risque d'**effondrement / ensevelissement** (mortel) — **blindage** obligatoire selon profondeur/nature du sol (Code du travail), **stabilité des talus** (angle/purge), **jamais descendre dans une fouille non protégée**. **Réseaux enterrés** : **DICT** obligatoire **avant** tout terrassement (repérage gaz/élec/eau — risque explosion/électrocution) + **AIPR**. **Engins / levage** : zones d'évolution balisées, angles morts, personne dans le rayon. **Proximité d'ouvrages** existants. **Météo** (pluie = déstabilisation des parois). **Arrêt immédiat en cas de danger.** Ces opérations exigent compétences, **autorisations (AIPR)** et moyens adaptés.** `[A]`

## Cadre & suites
- **Normes** : terrassements pour le bâtiment **DTU 12** ; fondations superficielles **DTU 13.11 / 13.12** ; réglementation réseaux (**DICT** / guichet unique, **AIPR**) et géotechnique **Eurocode 7 (NF EN 1997)** ⟦en prose, à confirmer⟧ `[B]` ⟦références/versions exactes à confirmer par le validateur⟧. `respecte-norme`
- **Diagnostic** : `traite-diagnostic` → [effondrement-paroi-fouille](../../../diagnostics/terrassement/effondrement-paroi-fouille.md)

## Relations & tags
- **Tags** : `metier:terrassement famille:gros-oeuvre sous-famille:securite intervention:securiser cluster:blindage cluster:talus cluster:fouilles complexite:expert type:securite securite:effondrement`

## Historique
| Version | Date | Auteur | Validateur | Motif |
|---|---|---|---|---|
| v0.1 | 2026-08-05 | IA | ⟦—⟧ | proposition initiale (Brouillon) |
