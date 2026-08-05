# Knowledge Engine — Spécification détaillée

> **Version** 1.0 — **Status** Validated — **Owner** Knowledge — **Last Update** 2026-08-02
> **Depends On:** [../engines/Knowledge.md](../engines/Knowledge.md), [../../domain/objects/Knowledge.md](../../domain/objects/Knowledge.md) — **Used By:** implémentation future — **Niveau:** 2 · Architecture

## Objective
Rendre le **Knowledge Engine entièrement implémentable** en approfondissant, sans jamais les
modifier, les documents gelés des STEP 1 à 8. Ce dossier **ne crée aucun objet, aucun moteur,
aucune étape** et **ne contient aucun code**. Il précise, organise et relie ce qui existe déjà.

## Principe de non-régression (règle absolue)
- Le **Domain Model** (STEP 2), les **Engine Specifications** (STEP 3), les **Business Flows**
  (STEP 4), les **Contracts** (STEP 5) et les **Engineering Standards** (STEP 6) sont **figés**.
- Toute contradiction est interdite. Toute création/renommage/déplacement d'objet exigerait un **ADR**.
- La **Knowledge Card = l'objet `Knowledge` existant** (fiche d'expérience). Aucun objet nouveau.

## Documents
| Document | Rôle |
|---|---|
| [KNOWLEDGE_ENGINE.md](KNOWLEDGE_ENGINE.md) | responsabilité, frontières, couche, services |
| [KNOWLEDGE_DOMAIN.md](KNOWLEDGE_DOMAIN.md) | le domaine « savoir capitalisé » (Loi 10) |
| [KNOWLEDGE_OBJECTS.md](KNOWLEDGE_OBJECTS.md) | objets propriétaires / utilisés / référencés |
| [KNOWLEDGE_GRAPH.md](KNOWLEDGE_GRAPH.md) | graphe métier (relations entre objets existants) |
| [KNOWLEDGE_RELATIONS.md](KNOWLEDGE_RELATIONS.md) | chaque relation, cardinalité, sens |
| [KNOWLEDGE_EVENTS.md](KNOWLEDGE_EVENTS.md) | événements publiés / consommés |
| [KNOWLEDGE_APIS.md](KNOWLEDGE_APIS.md) | contrats documentaires exposés |
| [KNOWLEDGE_VIEWS.md](KNOWLEDGE_VIEWS.md) | vues = projections, contenu unique |
| [KNOWLEDGE_PERMISSIONS.md](KNOWLEDGE_PERMISSIONS.md) | tenant, visibilité, gardes |
| [KNOWLEDGE_GOVERNANCE.md](KNOWLEDGE_GOVERNANCE.md) | propriété, versionnement, autorité de validation |
| [KNOWLEDGE_LEARNING.md](KNOWLEDGE_LEARNING.md) | apprentissage (jamais de modification silencieuse) |
| [KNOWLEDGE_METRICS.md](KNOWLEDGE_METRICS.md) | métriques d'usage (vers Performance) |
| [KNOWLEDGE_TEST_STRATEGY.md](KNOWLEDGE_TEST_STRATEGY.md) | stratégie de test documentaire |

## Ordre de lecture
ENGINE → DOMAIN → OBJECTS → GRAPH → RELATIONS → EVENTS → APIS → VIEWS → PERMISSIONS →
GOVERNANCE → LEARNING → METRICS → TEST_STRATEGY.

## Conformité
Chaque document porte une section **Conformité** listant les vérifications vis-à-vis des STEP 1–8.
Statut `Validated` = spécification officielle ; promotion en `Frozen` après revue standard.

## Changelog
- 1.0 (2026-08-02) — Spécification initiale du Knowledge Engine (documentaire).
