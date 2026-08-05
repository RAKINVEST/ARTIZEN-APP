# Architecture Rules — Règles d'architecture

> **Version** 1.0 — **Status** Frozen — **Owner** Architecture — **Last Update** 2026-08-02
> **Depends On:** [../engines/README.md](../engines/README.md) — **Used By:** tout code — **Niveau:** 3 · Implémentation

## Objective
Les règles structurelles que tout code respecte, dérivées des Steps 2-5.

## Règles
1. **Une responsabilité par Engine** (Step 3) et **par objet** (Step 2).
2. **Aucune dépendance circulaire** ; dépendances à sens unique et justifiées.
3. **Communication uniquement par contrats officiels** (Step 5) : REST/événement/contrat.
4. **Aucun accès direct** aux données internes d'un autre moteur (référence par id / événement).
5. **Tous les événements et API sont documentés** (Steps 4-5) avant implémentation.
6. **Moteur read-side** ne mute jamais le cœur (Loi 7).
7. **Monolithe modulaire** (pas de microservices) + bus d'événements interne.
8. **`app/pdf/` exception** : transverse, n'importe que `app.pdf.*` (jamais un module métier).

## Ajout d'un module (rappel du patron réel)
Nouveau module vertical = `models/schemas/repository/service/deps/router` + enregistrement dans `api/router.py` et `models/__init__.py`. Feature Flutter = `data/domain/presentation`.

## Forbidden
Contourner l'architecture · créer une dépendance montante ou circulaire · accès sauvage · moteur fourre-tout.

## Acceptance Criteria
Toute PR démontre l'absence de cycle et le passage par contrats.

## Related Documents
[DEPENDENCY_RULES.md](DEPENDENCY_RULES.md) · [../engines/ENGINE_DEPENDENCIES.md](../engines/ENGINE_DEPENDENCIES.md)

## Next Reading
[DEPENDENCY_RULES.md](DEPENDENCY_RULES.md)

## Changelog
- 1.0 (2026-08-02) — Règles initiales.
