# Decision Objects — Objets lus & artefacts

> **Version** 1.0 — **Status** Validated — **Owner** Decision — **Last Update** 2026-08-02
> **Depends On:** [../../domain/OBJECT_CATALOG.md](../../domain/OBJECT_CATALOG.md) — **Used By:** DECISION_PIPELINE — **Niveau:** 2 · Architecture

## Objective
Lister les objets manipulés, **sans en créer aucun de persisté**.

## Objets propriétaires
**Aucun.** Le Decision Engine est read-side : il ne possède **aucun** objet du cœur (comme
`quote_assistant` : ni modèle, ni table, ni migration).

## Objets lus (lecture seule, par id, via événements/contrats)
| Objet du domaine | Pour |
|---|---|
| `Knowledge` | cartes de savoir (source des propositions) |
| `Article`, `Kit`, `Category` | catalogue (lignes proposées) |
| `Phrase` | textes réutilisables |
| `Customer`, `Site`, `Building` | contexte client/chantier |
| `Quote` (historique) | préférences/usage passés |
| `Company`, `Branding`, `User`, `Role` | tenant, identité, compétences |
| `Photo`, `Document`, `Stock` | contexte (médias, docs, stock) |

## Artefacts transitoires (non persistés — value objects)
| Artefact | Rôle | Persisté ? |
|---|---|---|
| **Intent** | l'intention comprise (verbe + cible + contexte) | non |
| **Context** | le contexte assemblé ([DECISION_CONTEXT.md](DECISION_CONTEXT.md)) | non |
| **Proposal** | le plan d'action proposé (devis pré-rempli, kits, phrases, contrôles…) | non |
| **Explanation** | la justification de chaque choix ([DECISION_EXPLAINABILITY.md](DECISION_EXPLAINABILITY.md)) | non |

> Ces artefacts vivent le temps d'un échange. En **persister** un (ex. journaliser une décision)
> relèverait d'un **ADR** ; ce serait un objet du domaine (candidat : `Event`/`History`), pas un objet Decision.

## Objets exposés
La **Proposal** + son **Explanation**, en lecture, à l'UI et à l'utilisateur (jamais une écriture du cœur).

## Conformité
Aucun objet créé ; read-side strict ; artefacts transitoires. ✅

## Changelog
- 1.0 (2026-08-02) — Objets initiaux.
