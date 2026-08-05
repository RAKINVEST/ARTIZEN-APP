# Orchestration Engine — Responsabilité & frontières

> **Version** 1.0 — **Status** Validated — **Owner** Orchestration — **Last Update** 2026-08-02
> **Depends On:** [README.md](README.md) — **Used By:** ORCHESTRATION_PIPELINE — **Niveau:** 2 · Architecture · **Couche:** coordination

## Objective
Préciser ce que fait — et ne fait jamais — le coordinateur.

## Responsabilité unique
**Coordonner l'exécution d'une décision validée** en une suite d'étapes fiables entre les moteurs
métier. Une seule question ; aucune autre (Loi 1).

## Les 8 responsabilités
1. **Recevoir** une décision **validée** (de Decision, après validation utilisateur).
2. **Décomposer** la décision en **étapes** (une étape = une action d'un moteur propriétaire).
3. **Déclencher** les moteurs concernés (via contrats/événements/tâches).
4. **Attendre** leurs réponses (synchrone ou asynchrone — `app/tasks`).
5. **Gérer les erreurs** ([ORCHESTRATION_RETRY.md](ORCHESTRATION_RETRY.md)).
6. **Gérer les reprises** (retry idempotent).
7. **Gérer les compensations** ([ORCHESTRATION_COMPENSATION.md](ORCHESTRATION_COMPENSATION.md)).
8. **Produire un historique** complet et traçable ([ORCHESTRATION_OBSERVABILITY.md](ORCHESTRATION_OBSERVABILITY.md)).

## Frontières (ne fait jamais)
- **Ne pense pas** : il n'invente/ne propose rien (c'est Decision). Il **exécute une séquence**.
- **N'écrit pas** les données d'un autre moteur : il **demande** au propriétaire d'agir ; le Quote
  Engine crée le `Quote`, le Planning pose le créneau, etc.
- **Ne détruit aucune** donnée métier (Loi 5) ; compensations via opérations légitimes des propriétaires.
- **Ne démarre jamais** sans décision **validée** (pas d'action automatique — Loi 7/18).
- **Ne calcule aucun montant** (ADR-023).

## Distinction avec le Workflow Engine
- **Orchestration** = coordination **technique** (saga) d'une décision **transverse** à plusieurs moteurs.
- **Workflow** = processus **métier** au sein d'un domaine (ex. étapes d'une mission).
Orchestration **déclenche** un Workflow comme l'un de ses moteurs coordonnés ; elle ne le remplace pas.
> Frontière à graver formellement par **ADR** lors de l'enregistrement dans l'ENGINE_MAP.

## Conformité (STEP 1–8)
- Coordonne, ne possède rien ; chaque moteur reste propriétaire. ✅
- Lois 1/5/7/18 ; ADR-023 ; nouveau moteur ⇒ ADR d'enregistrement (signalé). ✅

## Changelog
- 1.0 (2026-08-02) — Spécification initiale.
