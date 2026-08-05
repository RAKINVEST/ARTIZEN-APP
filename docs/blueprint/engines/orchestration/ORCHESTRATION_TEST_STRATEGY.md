# Orchestration Test Strategy — Stratégie de test (documentaire)

> **Version** 1.0 — **Status** Validated — **Owner** Orchestration — **Last Update** 2026-08-02
> **Depends On:** [../../implementation/TEST_STRATEGY.md](../../implementation/TEST_STRATEGY.md) — **Used By:** implémentation — **Niveau:** 3 · Implémentation

## Objective
Décrire **ce qu'il faudra tester** (aucun test écrit ici).

## Cas de test attendus (par invariant)
| # | Invariant | Test attendu |
|---|---|---|
| T1 | Déclencheur | ne démarre que sur une **décision validée** ; refuse sinon |
| T2 | Décomposition | une décision produit les bonnes étapes dans le bon **ordre** (dépendances) |
| T3 | Délégation | chaque étape est exécutée par **son** moteur propriétaire (Quote crée le `Quote`) |
| T4 | Idempotence | rejouer une étape ne double pas l'effet |
| T5 | Retry | erreur transitoire relancée (borné, backoff) ; erreur 422/409 **non** relancée |
| T6 | Compensation | échec après succès → compensation en **ordre inverse**, via opérations légitimes |
| T7 | Irréversible assumé | une étape irréversible (devis `sent`, e-mail) → **Partiellement réussi** tracé |
| T8 | Aucune destruction | aucune compensation ne détruit de donnée métier (Loi 5) |
| T9 | États | transitions conformes (À traiter→…→final) ; append-only |
| T10 | Observabilité | id de corrélation présent ; déroulé reconstituable ; aucun échec silencieux |
| T11 | Tenant / no-montant | tenant respecté (404) ; aucun montant calculé (ADR-023) |

## Niveaux
Unitaire (décomposition, machine à états, classification d'erreurs) · Intégration (délégation aux
moteurs, retry via `app/tasks`, compensation) · Non-régression. DB réelle sans isolation (limite connue).

## Conformité
S'appuie sur TEST_STRATEGY (STEP 6) ; couvre saga/retry/compensation/observabilité. ✅

## Changelog
- 1.0 (2026-08-02) — Stratégie initiale.
