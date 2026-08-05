# Remblayer et compacter

> **Brouillon (v0) — proposé par IA, en attente de validation métier** (Loi 7/18). Modèle : [../../../cards/CARD_TEMPLATE.md](../../../cards/CARD_TEMPLATE.md).
> Niveaux de confiance : A normes/fabricant · B technique · C terrain validé · D hypothèse. Rien n'est publié comme certitude.

## Métadonnées
| Champ | Valeur |
|---|---|
| Identifiant | `remblayer-compacter` |
| Titre | Remblayer et compacter |
| Profession | `metier:terrassement` |
| Famille | `famille:gros-oeuvre` |
| Sous-famille | `sous-famille:terrassement` |
| Version | v0.1 |
| Auteur | IA (proposition) |
| Validateur | ⟦à valider métier⟧ |
| Statut | Brouillon |
| Indice de confiance | **C** |

## Cadrage
- **Objectif** : remblayer une fouille/plateforme par couches et **compacter** pour atteindre la portance visée. `[C]`
- **Résumé** : remblayer par **couches successives** de matériau adapté, **compacter** chaque couche (énergie/teneur en eau maîtrisées) pour la portance, protéger les réseaux (lit de pose/grillage avertisseur) et contrôler le compactage. `[C]` ⟦matériau/épaisseur de couche/objectif de compactage à confirmer⟧

## Réalisation
- **Étapes** :
  1. Remblayer par **couches** (épaisseur maîtrisée). `[C]` ⟦à confirmer⟧
  2. Protéger les **réseaux** (lit de pose, **grillage avertisseur**). `[C]` → [terrasser-reseaux-dict](terrasser-reseaux-dict.md)
  3. **Compacter** chaque couche (teneur en eau/énergie). `[C]`
  4. Contrôler le **compactage/portance**. `[C]` → [controle-reception-terrassement](../../../checklists/terrassement/controle-reception-terrassement.md)
- **Points critiques** : compactage **par couches** (sinon tassements) ; teneur en eau ; protection des réseaux ; portance atteinte.
- **Sécurité** : engins (compactage) ; ensevelissement (bord de fouille) ; poussières. **Fouilles** : risque d'**effondrement / ensevelissement** (mortel) — **blindage** obligatoire selon profondeur/nature du sol (Code du travail), **stabilité des talus** (angle/purge), **jamais descendre dans une fouille non protégée**. **Réseaux enterrés** : **DICT** obligatoire **avant** tout terrassement (repérage gaz/élec/eau — risque explosion/électrocution) + **AIPR**. **Engins / levage** : zones d'évolution balisées, angles morts, personne dans le rayon. **Proximité d'ouvrages** existants. **Météo** (pluie = déstabilisation des parois). **Arrêt immédiat en cas de danger.** Ces opérations exigent compétences, **autorisations (AIPR)** et moyens adaptés.** `[A]`

## Cadre & suites
- **Normes** : terrassements pour le bâtiment **DTU 12** ; fondations superficielles **DTU 13.11 / 13.12** ; réglementation réseaux (**DICT** / guichet unique, **AIPR**) et géotechnique **Eurocode 7 (NF EN 1997)** ⟦en prose, à confirmer⟧ `[B]` ⟦références/versions exactes à confirmer par le validateur⟧. `respecte-norme`
- **Tassement** : `traite-diagnostic` → [tassement-instabilite-remblai](../../../diagnostics/terrassement/tassement-instabilite-remblai.md)

## Relations & tags
- **Tags** : `metier:terrassement famille:gros-oeuvre sous-famille:terrassement intervention:realiser cluster:remblai cluster:compactage complexite:avancee type:realisation securite:effondrement`

## Historique
| Version | Date | Auteur | Validateur | Motif |
|---|---|---|---|---|
| v0.1 | 2026-08-05 | IA | ⟦—⟧ | proposition initiale (Brouillon) |
