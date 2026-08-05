# Implementation — Engineering Standards & Development Governance

> **Version** 2.0 — **Status** Frozen — **Owner** Architecture — **Last Update** 2026-08-02
> **Depends On:** [../architecture/README.md](../architecture/README.md), [../contracts/README.md](../contracts/README.md) — **Used By:** toute l'équipe de développement — **Niveau:** 3 · Implémentation

## Objective
**Constitution Technique** d'Artizen : comment le logiciel doit être développé. À partir d'ici, aucun code, écran, API, test, migration ou Pull Request n'est accepté sans respecter ces règles. Le code **applique** l'architecture, il ne la crée jamais.

## Contains
| Document | Rôle |
|---|---|
| [ENGINEERING_GUIDE.md](ENGINEERING_GUIDE.md) | vue d'ensemble + règle de réutilisation |
| [CODING_STANDARDS.md](CODING_STANDARDS.md) | nommage, fichiers, exceptions, logs, commentaires, TODO |
| [ARCHITECTURE_RULES.md](ARCHITECTURE_RULES.md) | responsabilité unique, pas de cycle, contrats only |
| [PROJECT_STRUCTURE.md](PROJECT_STRUCTURE.md) | structure officielle (backend, Flutter, tests, scripts…) |
| [DEPENDENCY_RULES.md](DEPENDENCY_RULES.md) | dépendances autorisées/interdites |
| [TEST_STRATEGY.md](TEST_STRATEGY.md) | unitaires/intégration/fonctionnels/non-régression |
| [QUALITY_STANDARD.md](QUALITY_STANDARD.md) | seuils qualité, complexité |
| [REVIEW_PROCESS.md](REVIEW_PROCESS.md) | revue de code officielle |
| [CI_CD_POLICY.md](CI_CD_POLICY.md) | lint, tests, build, déploiement |
| [BRANCHING_STRATEGY.md](BRANCHING_STRATEGY.md) | main/develop/feature/hotfix/release |
| [DOCUMENTATION_RULES.md](DOCUMENTATION_RULES.md) | doc technique/utilisateur/Blueprint |
| [SECURITY_GUIDELINES.md](SECURITY_GUIDELINES.md) | secrets, JWT, validation, upload |
| [OBSERVABILITY_GUIDELINES.md](OBSERVABILITY_GUIDELINES.md) | logs, métriques, traces, audit |
| [PERFORMANCE_GUIDELINES.md](PERFORMANCE_GUIDELINES.md) | objectifs (DB, cache, Flutter, PDF, OCR, IA) |
| [ERROR_HANDLING.md](ERROR_HANDLING.md) | exceptions, retry, rollback, timeout |
| [MIGRATION_GUIDELINES.md](MIGRATION_GUIDELINES.md) | Alembic : quand, test, rollback |
| [RELEASE_PROCESS.md](RELEASE_PROCESS.md) | du merge au déploiement |
| [DONE_DEFINITION.md](DONE_DEFINITION.md) | Definition of Done |
| [CHECKLISTS.md](CHECKLISTS.md) | 8 checklists de contribution |
| [templates/](templates/) | modèles de développement (Feature, Engine, API…) |
| [CAPABILITY_LEDGER.md](CAPABILITY_LEDGER.md) | registre d'exécution des 32 capacités (STEP 8) |
| [reports/](reports/README.md) | rapports d'exécution vivants (par capacité) |

## Navigation
**Pourquoi :** un même niveau de qualité pour tous (humains et IA). **Public :** dev, lead, IA. **Avant :** [../contracts/README.md](../contracts/README.md). **Après :** [DONE_DEFINITION.md](DONE_DEFINITION.md). **Dépendants :** —.

## Rules
Tout développement respecte le Blueprint (Domain Model, Engine Specs, Business Flows, Contracts). Réutiliser avant de créer (Loi 1/11).

## Forbidden
Contourner le Blueprint · dupliquer · créer sa propre architecture.

## Acceptance Criteria
Conventions, checklists, templates, stratégies (tests/Git/CI/revue) et Definition of Done présents.

## Related Documents
[../quality/QUALITY_RULES.md](../quality/QUALITY_RULES.md) · [../../CLAUDE.md](../../../CLAUDE.md)

## Next Reading
[ENGINEERING_GUIDE.md](ENGINEERING_GUIDE.md)

## Changelog
- 2.1 (2026-08-02) — Navigation (mission d'intégration) : index complété avec CAPABILITY_LEDGER + reports/. Aucun contenu métier modifié.
- 2.0 (2026-08-02) — Constitution Technique figée (Step 6).
- 1.0 (2026-08-02) — Section créée (Step 1).
