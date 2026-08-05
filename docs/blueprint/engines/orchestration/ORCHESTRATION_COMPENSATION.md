# Orchestration Compensation — Compensations (saga)

> **Version** 1.0 — **Status** Validated — **Owner** Orchestration — **Last Update** 2026-08-02
> **Depends On:** [ORCHESTRATION_STATES.md](ORCHESTRATION_STATES.md) — **Used By:** implémentation — **Niveau:** 2 · Architecture

## Objective
Définir quoi faire lorsqu'une étape échoue **après** que d'autres ont réussi — sans jamais détruire
de donnée métier (Loi 5).

## Principe (saga, compensation par action légitime)
Chaque étape déclare, si possible, une **action de compensation** confiée à **son moteur propriétaire** :
une **opération légitime** qui annule l'effet, **jamais** une suppression sauvage.

## Table de compensation (exemples)
| Étape réussie | Compensation | Limite (invariant du moteur) |
|---|---|---|
| Devis créé en **brouillon** | supprimer le brouillon (opération autorisée) | possible **tant que `draft`** |
| Devis **envoyé** (`sent`) | **non compensable** par suppression | `sent` figé (409) → marquer, notifier |
| Créneau planifié | libérer/annuler le créneau (Planning) | selon règles Planning |
| Notification envoyée | **non rétractable** | émettre une notification corrective |
| Tâche créée | annuler/clore la tâche | selon état |

## Règles
- **Ordre inverse** : compenser les étapes réussies en ordre inverse de leur exécution.
- **Bornée par les invariants** : une action irréversible (devis envoyé, e-mail parti) **n'est pas**
  défaite ; l'orchestration bascule en **Partiellement réussi** et **trace** l'écart, avec action corrective.
- **Aucune destruction** de donnée métier (Loi 5) : compensation = transition d'état/opération légitime.
- **Idempotence** : une compensation rejouée n'aggrave rien.
- **Traçabilité** : chaque compensation publie `StepCompensated` et est historisée.

## Conformité
Compensation par opérations légitimes des propriétaires ; irréversible assumé et tracé ; Loi 5. ✅

## Changelog
- 1.0 (2026-08-02) — Compensations initiales.
