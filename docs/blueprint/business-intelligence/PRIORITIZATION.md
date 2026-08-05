# Prioritization — Priorisation

> **Version** 1.0 — **Status** Validated — **Owner** Business Intelligence — **Last Update** 2026-08-02
> **Depends On:** [RISK_ANALYSIS.md](RISK_ANALYSIS.md) — **Used By:** Decision, AI Companion — **Niveau:** 2 · Architecture

## Objective
Décrire l'ordre dans lequel un artisan **traite** ce qui compte.

## Ordre de priorité (du plus fort au plus faible)
1. **Sécurité** (personnes, bien) — jamais négociée.
2. **Conformité** (normes, réglementaire).
3. **Urgence** (rétablir un service vital : eau, chauffage, électricité).
4. **Durabilité** (solution qui tient dans le temps).
5. **Valeur pour le client** (coût global, confort).
6. **Préférences** de l'artisan / du client.

## Règles
- La priorité **haute écrase** la basse en cas de conflit (sécurité > conformité > urgence > …).
- Une intervention urgente **ne dispense pas** de la sécurité/conformité.
- La priorisation **ordonne** les propositions ; elle ne **décide** pas seule (l'artisan tranche).
- Cohérente avec les priorités du Decision Engine ([../engines/decision/DECISION_RULES.md](../engines/decision/DECISION_RULES.md)).

## Changelog
- 1.0 (2026-08-02) — Priorisation initiale.
