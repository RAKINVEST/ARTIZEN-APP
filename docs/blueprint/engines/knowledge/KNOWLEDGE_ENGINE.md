# Knowledge Engine — Responsabilité & frontières

> **Version** 1.0 — **Status** Validated — **Owner** Knowledge — **Last Update** 2026-08-02
> **Depends On:** [../engines/Knowledge.md](../engines/Knowledge.md) — **Used By:** KNOWLEDGE_OBJECTS, KNOWLEDGE_EVENTS — **Niveau:** 2 · Architecture · **Couche:** L3 Cœur

## Objective
Préciser la responsabilité et les frontières du moteur **sans modifier** sa fiche gelée
([../engines/Knowledge.md](../engines/Knowledge.md)).

## Responsabilité unique (reprise de la fiche gelée)
**Capitaliser le savoir** — la fiche d'expérience, la bonne pratique, l'erreur à éviter, la variante
(Loi 10, *le patrimoine technique*). Une seule question ; aucune autre (Loi 1).

## Ce que le moteur EST
- Le **coffre du savoir métier** de l'entreprise : il détient, versionne et restitue des `Knowledge`.
- Un moteur de **couche L3 Cœur** : il possède une donnée métier propre et publie des événements.
- La **source officielle** que consultent (en lecture) l'IA, les devis, les missions, les workflows,
  les check-lists, les diagnostics et les statistiques.

## Ce que le moteur N'EST PAS (frontières)
- Il **n'écrit jamais** `Mission` (interdit explicite de la fiche) ni aucun objet d'un autre moteur.
- Il **ne décide jamais** à la place de l'artisan (Loi 7/18) : il propose, l'humain valide.
- Il **ne calcule aucun montant** (un seul lieu calcule — ADR-023) ; il n'est pas un catalogue de prix.
- Il **ne duplique pas** le Domain Model : le graphe et les vues sont des projections (voir GRAPH/VIEWS).
- Il ne franchit une frontière **que par événement ou contrat** ; jamais d'accès sauvage.

## Services exposés (repris de la fiche : `knowledge.search/capture`)
- `knowledge.capture` — capturer/proposer un savoir (crée un `Knowledge` en **Brouillon**).
- `knowledge.search` — rechercher/naviguer le savoir (lecture, projections).
- (détaillés, en contrats documentaires, dans [KNOWLEDGE_APIS.md](KNOWLEDGE_APIS.md)).

## Position dans la carte des moteurs
Voir [../ENGINE_MAP.md](../ENGINE_MAP.md), [../ENGINE_BOUNDARIES.md](../ENGINE_BOUNDARIES.md),
[../ENGINE_DEPENDENCIES.md](../ENGINE_DEPENDENCIES.md). Le présent dossier **n'altère pas** ces cartes.

## Conformité (STEP 1–8)
- STEP 2 : n'introduit aucun objet ; `Knowledge` inchangé. ✅
- STEP 3 : reprend mot pour mot la responsabilité, les objets et l'interdit de la fiche moteur. ✅
- STEP 6/Constitution : Lois 1, 5, 7/18, 10 respectées ; ADR-023 non enfreint. ✅

## Related Documents
[KNOWLEDGE_DOMAIN.md](KNOWLEDGE_DOMAIN.md) · [KNOWLEDGE_OBJECTS.md](KNOWLEDGE_OBJECTS.md)

## Next Reading
[KNOWLEDGE_DOMAIN.md](KNOWLEDGE_DOMAIN.md)

## Changelog
- 1.0 (2026-08-02) — Spécification initiale.
