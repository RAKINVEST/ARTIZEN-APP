# Decision Rules — Règles & priorités

> **Version** 1.0 — **Status** Validated — **Owner** Decision — **Last Update** 2026-08-02
> **Depends On:** [../../../knowledge/factory/CONFIDENCE_MODEL.md](../../../knowledge/factory/CONFIDENCE_MODEL.md) — **Used By:** DECISION_SCORING, DECISION_PIPELINE — **Niveau:** 2 · Architecture

## Objective
Fixer les priorités de sélection. **Le moteur ne doit jamais inventer** : il choisit parmi l'existant.

## Ordre de priorité (du plus fort au plus faible)
1. **Connaissances validées** (statut Validé) avant tout Brouillon.
2. **Niveau de confiance élevé** (A > B > C > D — [CONFIDENCE_MODEL](../../../knowledge/factory/CONFIDENCE_MODEL.md)).
3. **Procédures officielles** et **normes** (sécurité/réglementaire priment).
4. **Préférences utilisateur** (habitudes, choix passés — [DECISION_CONTEXT.md](DECISION_CONTEXT.md)).
5. **Retours terrain validés** (savoir éprouvé).

## Règles dures (non négociables)
- **Ne jamais inventer** un article, une phrase, une norme, un montant : uniquement **sélectionner**.
- **Rien de non validé** n'est proposé comme certitude ; un contenu Brouillon/D est **signalé** (« à confirmer »).
- **Sécurité/normes** : une carte de niveau C/D en sécurité ne peut être proposée sans **avertissement**.
- **Tenant** : ne proposer que des connaissances/données du `company_id` du contexte.
- **Aucun montant** calculé ici (ADR-023) ; Decision propose des **lignes**, le calcul reste unique.

## Départage
À priorité égale : préférence utilisateur, puis fraîcheur, puis couverture (voir [DECISION_SCORING.md](DECISION_SCORING.md)).

## Conformité
Aligné invariants IA (ne persiste/invente rien), Knowledge (validé + confiance), Loi 7/18. ✅

## Changelog
- 1.0 (2026-08-02) — Règles initiales.
