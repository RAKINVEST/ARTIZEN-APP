# Dependency Rules — Règles de dépendances

> **Version** 1.0 — **Status** Frozen — **Owner** Architecture — **Last Update** 2026-08-02
> **Depends On:** [ARCHITECTURE_RULES.md](ARCHITECTURE_RULES.md) — **Used By:** tout code — **Niveau:** 3 · Implémentation

## Objective
Fixer les dépendances autorisées entre modules/paquets et vers l'extérieur.

## Règles internes
- Dépendances **à sens unique et justifiées** (ex. `quotes → catalog/clients` ; `interventions → catalog`).
- Aucune dépendance montante ni **cycle**. *(Divergence connue et bornée : `users ↔ branding` — à traiter en V2, pas ailleurs.)*
- `app/pdf/` n'importe que `app.pdf.*`. `models/__init__.py` dépend des modules, jamais l'inverse.
- Tous les modules → `users.deps.CurrentUserDep` = infrastructure d'auth (autorisé).

## Règles externes
- Une nouvelle dépendance (pip/pub) exige : justification, licence compatible, maintenance active, revue.
- **`bcrypt==4.0.1` épinglé** volontairement (incompatibilité passlib) — ne pas mettre à jour sans lire le commentaire.
- Provider-abstraction : dépendre de l'interface (`AIProvider`, `StorageProvider`, `EmailProvider`), jamais du SDK concret dans le code métier.

## Forbidden
Cycle · dépendance montante · import d'un SDK vendeur hors couche provider · dépendance non justifiée.

## Acceptance Criteria
Le graphe de dépendances reste acyclique ; toute nouvelle dépendance externe est justifiée.

## Related Documents
[../engines/ENGINE_DEPENDENCIES.md](../engines/ENGINE_DEPENDENCIES.md)

## Next Reading
[TEST_STRATEGY.md](TEST_STRATEGY.md)

## Changelog
- 1.0 (2026-08-02) — Règles initiales.
