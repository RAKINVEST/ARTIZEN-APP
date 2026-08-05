# Diagnostiquer / contrôler un terrassement

> **Brouillon (v0) — proposé par IA, en attente de validation métier** (Loi 7/18). Modèle : [../../../cards/CARD_TEMPLATE.md](../../../cards/CARD_TEMPLATE.md).
> Niveaux de confiance : A normes/fabricant · B technique · C terrain validé · D hypothèse. Rien n'est publié comme certitude.

## Métadonnées
| Champ | Valeur |
|---|---|
| Identifiant | `diagnostiquer-controler-terrassement` |
| Titre | Diagnostiquer / contrôler un terrassement |
| Profession | `metier:terrassement` |
| Famille | `famille:gros-oeuvre` |
| Sous-famille | `sous-famille:terrassement` |
| Version | v0.1 |
| Auteur | IA (proposition) |
| Validateur | ⟦à valider métier⟧ |
| Statut | Brouillon |
| Indice de confiance | **C** |

## Cadrage
- **Objectif** : diagnostiquer le sol et contrôler un terrassement (portance, compactage, stabilité, cotes). `[C]`
- **Résumé** : exploiter l'**étude de sol** (nature, portance, eau), contrôler le **compactage** et les **cotes** (implantation/altimétrie), repérer les désordres (tassement, instabilité de talus) et orienter la reprise. `[C]` ⟦essais (plaque/pénétromètre) selon projet à confirmer⟧

## Réalisation
- **Étapes** :
  1. Exploiter l'**étude de sol** (portance, eau, nature). `[C]` ⟦géotechnicien à confirmer⟧
  2. Contrôler **compactage/portance** (essais). `[C]` → [tassement-instabilite-remblai](../../../diagnostics/terrassement/tassement-instabilite-remblai.md)
  3. Vérifier **cotes** (implantation/altimétrie). `[C]`
  4. Repérer instabilités (talus/paroi). `[C]` → [effondrement-paroi-fouille](../../../diagnostics/terrassement/effondrement-paroi-fouille.md)
- **Points critiques** : s'appuyer sur l'étude géotechnique ; compactage/portance mesurés ; toute instabilité → sécurisation immédiate.
- **Sécurité** : stabilité (évaluer avant d'approcher) ; engins ; réseaux. **Fouilles** : risque d'**effondrement / ensevelissement** (mortel) — **blindage** obligatoire selon profondeur/nature du sol (Code du travail), **stabilité des talus** (angle/purge), **jamais descendre dans une fouille non protégée**. **Réseaux enterrés** : **DICT** obligatoire **avant** tout terrassement (repérage gaz/élec/eau — risque explosion/électrocution) + **AIPR**. **Engins / levage** : zones d'évolution balisées, angles morts, personne dans le rayon. **Proximité d'ouvrages** existants. **Météo** (pluie = déstabilisation des parois). **Arrêt immédiat en cas de danger.** Ces opérations exigent compétences, **autorisations (AIPR)** et moyens adaptés.** `[A]`

## Cadre & suites
- **Normes** : terrassements pour le bâtiment **DTU 12** ; fondations superficielles **DTU 13.11 / 13.12** ; réglementation réseaux (**DICT** / guichet unique, **AIPR**) et géotechnique **Eurocode 7 (NF EN 1997)** ⟦en prose, à confirmer⟧ `[B]` ⟦références/versions exactes à confirmer par le validateur⟧. `respecte-norme`
- **Contrôle réception** : `a-checklist` → [controle-reception-terrassement](../../../checklists/terrassement/controle-reception-terrassement.md)

## Relations & tags
- **Tags** : `metier:terrassement famille:gros-oeuvre sous-famille:terrassement intervention:diagnostiquer intervention:controler cluster:diagnostic cluster:controle cluster:nivellement complexite:avancee type:diagnostic securite:effondrement`

## Historique
| Version | Date | Auteur | Validateur | Motif |
|---|---|---|---|---|
| v0.1 | 2026-08-05 | IA | ⟦—⟧ | proposition initiale (Brouillon) |
