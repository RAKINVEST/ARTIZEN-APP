# Capability Ledger — Registre d'exécution du Master Plan (STEP 8)

> **Version** 1.0 — **Status** Living — **Owner** Lead Engineer — **Last Update** 2026-08-02
> **Depends On:** [DONE_DEFINITION.md](DONE_DEFINITION.md), [../audit/](../audit/) — **Used By:** pilotage STEP 8 — **Niveau:** 3 · Implémentation

## Objective
Piloter le développement des **32 capacités** du Master Plan **sans jamais dupliquer** l'existant.
Ce registre applique le **CONTRÔLE SYSTÉMATIQUE** de la STEP 8 au niveau programme : avant de coder
une capacité, on lit ici son état réel dans le dépôt certifié.

> **Fait fondateur.** ARTIZEN **n'est pas un projet vierge** : la V1 est certifiée (`v1.0.0-rc1`),
> la V2 en RC, déployée (Scalingo + Scaleway). Une large part du Master Plan **existe déjà**.
> « Développer » une capacité existante = **vérifier sa conformité au Blueprint et la réutiliser**,
> jamais la reconstruire (interdiction de duplication, STEP 8).

## Légende
- **Existant** — implémenté et certifié ; action = conformité + réutilisation.
- **Partiel** — socle présent, incomplet ; action = compléter le manque uniquement.
- **À construire** — gap réel ; action = construction complète (backend + Flutter + tests + doc).
- Statuts « Partiel / À construire » = **provisoires**, à confirmer par le contrôle systématique à l'ouverture de la capacité.

## Registre
| # | Capacité | État | Preuve (code réel) | Action STEP 8 |
|---|---|---|---|---|
| 1 | Infrastructure | **Existant** | `core/`, `database/`, `auth/`, `ai/`, `storage.py`+`storage_s3.py`, `pdf/`, `email/`, `retention/`, `tasks/`, `api/` | ✅ **vérifié & clôturé** (ce document) |
| 2 | Authentification | **Existant** | `auth/`, `users/`, front `features/auth` ; JWT, rate-limit `/auth/*`, reset e-mail | conformité + réutilisation |
| 3 | Entreprises | **Existant** | `branding/` (Company y vit) | conformité |
| 4 | Utilisateurs | **Existant** | `users/` | conformité |
| 5 | Catalogue | **Existant** | `catalog/`, front `features/catalog` | conformité |
| 6 | Bibliothèque métier | **Existant** | `catalog/trades/taxonomy.py`, front `features/metiers` | conformité |
| 7 | Clients | **Existant** | `clients/`, front `features/clients` | conformité |
| 8 | Chantiers | **En cours** | **Backend** : module `sites/` + migration `f1a2b3c4d5e6` + 10 tests HTTP écrits · `py_compile` 🟢 · `ruff` 🟢. **Flutter** : couche données + providers (`features/sites/`) · `build_runner` 🟢 · `flutter analyze` 0 issue 🟢. **Bloqué (Docker/Postgres)** : migration + tests d'intégration. **Reste** : écrans Flutter, exécution Docker, Building | compléter |
| 9 | Missions | **À construire** | objet `Mission` défini ; couvert partiellement par `interventions` | construction |
| 10 | Interventions | **Partiel** | `interventions/` = cœur Phase 1 (schemas + composer + tests) ; **sans repo/router/migration** | compléter |
| 11 | Planning | **À construire** | objet `Schedule` défini ; aucun module | construction |
| 12 | Documents | **Existant** | `document_analysis/`, `document_detection/`, `document_clone/` | conformité |
| 13 | Photos | **À construire** | objet `Photo` défini ; fichiers via `storage` ; pas de module dédié | construction |
| 14 | Import PDF | **Existant** | `template_import/`, `document_detection/`, front `features/template_import` | conformité |
| 15 | OCR | **Existant** | capacité `document_analysis` (via abstraction IA) | conformité |
| 16 | Extraction IA | **Existant** | `quote_extraction/`, `quote_assistant/`, `voice_quote/`, `ai_conversations/` | conformité |
| 17 | Devis | **Existant** | `quotes/` (cycle de vie V2), front `features/quotes`+`quote_wizard` | conformité |
| 18 | Facturation | **À construire** | objet `Invoice` défini ; `pdf/` prêt pour factures | construction |
| 19 | Paiements | **À construire** | aucun module | construction |
| 20 | Workflow | **À construire** | objet `Workflow` défini ; aucun module | construction |
| 21 | Notifications | **À construire** | objet `Notification` défini ; `email/` couvre le transactionnel | construction |
| 22 | Tableaux de bord | **Partiel** | front `features/dashboard` ; agrégation backend à définir | compléter |
| 23 | Performance | **À construire** | moteur/​objet `Performance` défini ; aucun module | construction |
| 24 | Recherche | **À construire** | moteur `Search` défini ; aucun module | construction |
| 25 | Historique | **À construire** | objet `History` défini ; aucun module dédié | construction |
| 26 | Garanties | **À construire** | objet `Warranty` défini | construction |
| 27 | Maintenance | **À construire** | objet `Maintenance` défini | construction |
| 28 | Stock | **À construire** | objets `Stock`/`Warehouse` définis | construction |
| 29 | Fournisseurs | **À construire** | objet `Supplier` défini | construction |
| 30 | Reporting | **À construire** | moteur `Reporting` défini | construction |
| 31 | Administration | **À construire** | à cadrer | construction |
| 32 | Optimisation | **Transverse** | continu (perf, dette, revue) | continu |

## Rapports vivants (Living Report Policy)
Chaque capacité en cours/terminée tient un **rapport vivant** (toujours à jour, jamais différé) sous
[`reports/`](reports/) :
- #8 Chantiers → [reports/CAPABILITY-08-chantiers.md](reports/CAPABILITY-08-chantiers.md)

## Séquence par capacité (rappel STEP 8)
Étude → Architecture → Backend → Tests Backend → Flutter → Tests Flutter → Documentation → Validation → Audit → Clôture.
Pour une capacité **Existant**, l'étude prouve la conformité et la séquence se réduit à : conformité → (correctif de dérive éventuel) → clôture.

## Garde-fous (interdictions STEP 8)
Ne pas contourner le Blueprint · ne pas modifier le Domain Model sans ADR · ne pas créer un moteur
sans justification · **ne pas dupliquer** · ne pas contourner les contrats · rien hors Master Plan.

## Related Documents
[DONE_DEFINITION.md](DONE_DEFINITION.md) · [CHECKLISTS.md](CHECKLISTS.md) · [../audit/ACTION_PLAN.md](../audit/ACTION_PLAN.md)

## Changelog
- 1.0 (2026-08-02) — Registre initial ; contrôle systématique programme ; capacité #1 clôturée.
