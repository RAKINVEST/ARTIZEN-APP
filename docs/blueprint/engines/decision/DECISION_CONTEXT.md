# Decision Context — Modèle de contexte

> **Version** 1.0 — **Status** Validated — **Owner** Decision — **Last Update** 2026-08-02
> **Depends On:** [DECISION_OBJECTS.md](DECISION_OBJECTS.md) — **Used By:** DECISION_PIPELINE, DECISION_SCORING — **Niveau:** 2 · Architecture

## Objective
Définir **toutes** les informations que le moteur prend en compte pour proposer — assemblées en
lecture, jamais persistées.

## Dimensions du contexte
| Dimension | Source (lecture) | Usage |
|---|---|---|
| **Profession / activité** | `Company`/`User` + taxonomie gelée | restreint les connaissances au métier |
| **Compétences / qualifications** | `User`/`Company` (qualifs d'exercice) | débloque/masque certains gestes |
| **Historique** | `Quote`/`Mission` passés | préférences, gestes fréquents |
| **Client** | `Customer`/`Contact` | type de client (`client:`), attentes |
| **Chantier** | `Site`/`Building` | localisation, contraintes |
| **Équipements** | contexte/`Photo`/`Document` | cible du geste (`equipement:`) |
| **Photos / Documents** | `Photo`/`Media`/`Document` | indices sur l'état/le besoin |
| **Saison** | date (contexte) | pertinence saisonnière (`saison:`) |
| **Urgence** | intention/UI | priorité (`urgence:`) |
| **Temps disponible** | UI/planning | dimensionne la proposition |
| **Stock** | `Stock`/`Warehouse` | disponibilité des articles/kits |
| **Préférences utilisateur** | historique + réglages | classement personnalisé |

## Règles
- Le contexte est **assemblé en lecture** (aucune écriture) et **transitoire** (non persisté).
- **Tenant** : uniquement des données du `company_id` du contexte (mismatch → introuvable).
- **Aucune donnée inventée** : une dimension absente reste **vide** (et le signale), jamais devinée comme certitude.
- Le contexte **pondère** le classement ([DECISION_SCORING.md](DECISION_SCORING.md)), il ne **décide** pas seul.

## Conformité
Lecture seule, tenant, aucune invention, transitoire. ✅

## Changelog
- 1.0 (2026-08-02) — Modèle de contexte initial.
