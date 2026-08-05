# CHANGELOG — Blueprint Repository

> **Version** 1.0 — **Status** Frozen — **Owner** Architecture — **Last Update** 2026-08-02
> **Depends On:** — — **Used By:** gouvernance
> **Niveau documentaire:** 3 · Implémentation

## Objective
Journal des évolutions du Blueprint (le dépôt documentaire lui-même, pas le
produit). Politique de versionnement : voir [quality/VERSIONING.md](quality/VERSIONING.md).

## Historique
### 1.11 — 2026-08-02
- **business-intelligence/** — **Core Business Intelligence** : modèle officiel du raisonnement métier
  (15 documents : concept, raisonnement en 10 temps, 9 modèles de décision, résolution de problème,
  diagnostic, intervention, risques, priorisation, incertitude, exceptions, validation humaine,
  apprentissage, explicabilité). **Référence** appliquée par Decision + AI Companion ; ne décide pas,
  n'invente pas, ne persiste rien. 5 diagrammes Mermaid ; 53 liens (0 cassé). Aucun document figé modifié.

### 1.10 — 2026-08-02
- **engines/orchestration/** — Spécification détaillée de l'**Orchestration Engine** (13 documents :
  moteur, domaine, pipeline, états, événements, compensation, retry, intégrations, contrats,
  observabilité, stratégie de test, changelog). **Coordinateur** d'une décision validée (saga :
  décompose/déclenche/attend/retry/compense/trace). 5 diagrammes Mermaid ; 38 liens (0 cassé).
- **Réserves explicites** : moteur **nouveau** (hors ENGINE_MAP gelé) → enregistrement formel = **ADR** ;
  **aucun modèle persistant** créé (trace via `Event`/`History` + `app/tasks`). Aucun document figé modifié.

### 1.9 — 2026-08-02
- **engines/decision/** — Spécification détaillée du **Decision Engine** (16 documents : moteur,
  domaine + intentions, objets, graphe, pipeline, règles, événements, contrats, contexte, scoring,
  apprentissage, explicabilité, intégrations, stratégie de test, changelog). Approfondissement
  **documentaire** d'un moteur **read-side déjà nommé** dans le Domain Model gelé ; aucun document
  figé modifié, aucun objet/moteur créé, aucun code. 4 diagrammes Mermaid ; 56 liens (0 cassé).
  Invariant : propose/explique/attend la validation ; n'écrit/ne persiste/n'invente rien.

### 1.8 — 2026-08-02 — Phase d'intégration (référentiel vivant)
- **Navigation, aucun contenu métier modifié, aucune structure altérée.**
- Créés : [CARTOGRAPHY.md](CARTOGRAPHY.md) (carte vivante Vision→Code) + **5 README d'index**
  de dossiers-feuilles (`domain/objects`, `engines/engines`, `flows/flows`, `contracts/contracts`,
  `implementation/reports`).
- Navigation complétée : INDEX (cartographie + statut `Living` + approfondissement Knowledge),
  `implementation/README` (registre + rapports). Métadonnée du rapport vivant #8 homogénéisée.
- **Résultat mesuré** : 291 documents, 2123 liens (0 cassé), **0 dossier sans README, 0 orphelin,
  0 métadonnée manquante**. Aucun document déplacé/renommé/supprimé/fusionné.

### 1.7 — 2026-08-02
- **engines/knowledge/** — Spécification détaillée du **Knowledge Engine** (14 documents :
  README, ENGINE, DOMAIN, OBJECTS, GRAPH, RELATIONS, EVENTS, APIS, VIEWS, PERMISSIONS,
  GOVERNANCE, LEARNING, METRICS, TEST_STRATEGY). Approfondissement **documentaire** d'un moteur
  déjà gelé : aucun objet/moteur/étape créé, aucun document figé modifié. Knowledge Card = objet
  `Knowledge` existant. 3 diagrammes Mermaid ; 83 liens internes vérifiés (0 cassé).

### 1.6 — 2026-08-02
- **audit/** (STEP 7 — audit global) : 15 documents (README, GLOBAL_AUDIT,
  CONSISTENCY_REPORT, DEPENDENCY_REPORT, TRACEABILITY_REPORT, DOCUMENT_COVERAGE,
  GLOSSARY_VALIDATION, ENGINE/DOMAIN/FLOW/CONTRACT_VALIDATION, QUALITY_SCORECARD,
  TECHNICAL_DEBT, OPEN_DECISIONS, ACTION_PLAN). Contrôle mesuré : 268 fichiers,
  1836 liens internes (0 cassé), 0 métadonnée manquante. Score global 8,7/10.
- **Consolidations exécutées** : ajout de `engines/engines/_TEMPLATE.md`
  (symétrie avec objets, A1) ; alignement d'un libellé de lien (A2).
- Registre de 7 décisions différées (OD-1..7) — aucune suppression/invention
  de moteur ou d'objet (périmètre gelé). Section Audit ajoutée à l'INDEX (16).

### 1.5 — 2026-08-02
- **implementation/** (Constitution technique) : 20 documents-cœur (guide
  d'ingénierie, coding standards, règles d'architecture & de dépendances,
  structure projet, stratégie de tests, qualité, revue, CI/CD, branching,
  documentation, sécurité, observabilité, performance, gestion d'erreurs,
  migrations, release, Definition of Done) + ANTI_PATTERNS + CHECKLISTS
  (8 listes) + `templates/` (13 modèles de développement + index).
- **contracts/** : 14 documents-cadre + 26 fiches de catégorie (contrat = référence).
- **flows/** : 10 documents-cadre + 40 fiches de flux (diagrammes de séquence).
- **engines/** : 9 documents-cadre + 40 fiches de moteur (diagrammes Mermaid).
- **domain/** : 8 documents-cadre + 39 fiches d'objet (modèle métier canonique).

### 1.0 — 2026-08-02
- Création du Blueprint Repository : arborescence complète (15 sections),
  README racine + INDEX, README de chaque section, 10 templates officiels +
  modèle de document, conventions, versionnement, règles qualité, glossaire
  initial, système ADR (README + template + ADR-0000).

## Changelog
- 1.0 (2026-08-02) — Entrée initiale.
