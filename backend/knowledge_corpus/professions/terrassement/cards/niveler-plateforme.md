# Niveler / réaliser une plateforme

> **Brouillon (v0) — proposé par IA, en attente de validation métier** (Loi 7/18). Modèle : [../../../cards/CARD_TEMPLATE.md](../../../cards/CARD_TEMPLATE.md).
> Niveaux de confiance : A normes/fabricant · B technique · C terrain validé · D hypothèse. Rien n'est publié comme certitude.

## Métadonnées
| Champ | Valeur |
|---|---|
| Identifiant | `niveler-plateforme` |
| Titre | Niveler / réaliser une plateforme |
| Profession | `metier:terrassement` |
| Famille | `famille:gros-oeuvre` |
| Sous-famille | `sous-famille:terrassement` |
| Version | v0.1 |
| Auteur | IA (proposition) |
| Validateur | ⟦à valider métier⟧ |
| Statut | Brouillon |
| Indice de confiance | **C** |

## Cadrage
- **Objectif** : réaliser une plateforme (décapage, réglage altimétrique, forme) pour recevoir un ouvrage ou une voirie. `[C]`
- **Résumé** : décaper la terre végétale, régler l'**altimétrie** (implantation, pentes d'évacuation), mettre en forme et compacter la plateforme, en assurant la **portance** visée ; interface avec l'assise des ouvrages (maçonnerie/voirie). `[C]` ⟦cotes/pentes selon projet à confirmer⟧

## Réalisation
- **Étapes** :
  1. **Décaper** la terre végétale ; évacuer/stocker. `[C]`
  2. Régler l'**altimétrie** (implantation, **pentes** d'évacuation). `[C]`
  3. Mettre en forme et **compacter** la plateforme. `[C]` → [remblayer-compacter](remblayer-compacter.md)
  4. Contrôler cotes/portance. `[C]` → [controle-reception-terrassement](../../../checklists/terrassement/controle-reception-terrassement.md)
- **Points critiques** : altimétrie/pentes correctes (évacuation de l'eau) ; portance ; interface avec l'ouvrage (fondation/voirie).
- **Sécurité** : engins ; circulation de chantier ; stabilité des bords. **Fouilles** : risque d'**effondrement / ensevelissement** (mortel) — **blindage** obligatoire selon profondeur/nature du sol (Code du travail), **stabilité des talus** (angle/purge), **jamais descendre dans une fouille non protégée**. **Réseaux enterrés** : **DICT** obligatoire **avant** tout terrassement (repérage gaz/élec/eau — risque explosion/électrocution) + **AIPR**. **Engins / levage** : zones d'évolution balisées, angles morts, personne dans le rayon. **Proximité d'ouvrages** existants. **Météo** (pluie = déstabilisation des parois). **Arrêt immédiat en cas de danger.** Ces opérations exigent compétences, **autorisations (AIPR)** et moyens adaptés.** `[A]`

## Cadre & suites
- **Normes** : terrassements pour le bâtiment **DTU 12** ; fondations superficielles **DTU 13.11 / 13.12** ; réglementation réseaux (**DICT** / guichet unique, **AIPR**) et géotechnique **Eurocode 7 (NF EN 1997)** ⟦en prose, à confirmer⟧ `[B]` ⟦références/versions exactes à confirmer par le validateur⟧. `respecte-norme`
- **Assise maçonnerie** : `cite-carte` → [monter-mur-cloison](../../../professions/maconnerie/cards/monter-mur-cloison.md)

## Relations & tags
- **Tags** : `metier:terrassement famille:gros-oeuvre sous-famille:terrassement intervention:realiser cluster:plateformes cluster:nivellement cluster:deblai complexite:avancee type:realisation securite:effondrement relation:maconnerie`

## Historique
| Version | Date | Auteur | Validateur | Motif |
|---|---|---|---|---|
| v0.1 | 2026-08-05 | IA | ⟦—⟧ | proposition initiale (Brouillon) |
