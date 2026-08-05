# Command Contracts — Commandes (écritures)

> **Version** 1.0 — **Status** Frozen — **Owner** Architecture — **Last Update** 2026-08-02
> **Depends On:** [API_CONTRACTS.md](API_CONTRACTS.md) — **Used By:** contracts/commands, engines — **Niveau:** 2 · Architecture

## Objective
Décrire toute **écriture** (intention de changer l'état). Une commande = une intention validée par l'artisan (Loi 7).

## Forme d'une commande
| Élément | Règle |
|---|---|
| **Qui peut lancer** | acteur autorisé ([SECURITY_CONTRACTS.md](SECURITY_CONTRACTS.md), [../flows/FLOW_PERMISSIONS.md](../flows/FLOW_PERMISSIONS.md)) |
| **Préconditions** | invariants du Domain Model + état attendu |
| **Validation** | syntaxe → métier → permissions → relations → unicité ([VALIDATION_RULES.md](VALIDATION_RULES.md)) |
| **Résultat attendu** | un DTO de réponse + une transition d'état |
| **Événements** | publie ses événements de domaine |
| **Rollback** | compensation tracée ; jamais de destruction d'une donnée capitalisée (Loi 5) |
| **Effets de bord** | déclarés (envoi, stockage) ; jamais cachés |
| **Idempotence** | protégée contre la double-création |

## Exemples de commandes
`CreateQuote`, `SendQuote`, `AcceptQuote`, `IssueInvoice`, `ScheduleSlot`, `ArchiveObject`, `DeleteDraft` (confirmation requise).

## Rules
Une commande ne décide jamais à la place de l'artisan ; elle exécute une intention **déjà confirmée**. Toute action irréversible exige une confirmation.

## Acceptance Criteria
Chaque commande a : lanceur, préconditions, validation, résultat, événements, rollback, effets de bord.

## Related Documents
[QUERY_CONTRACTS.md](QUERY_CONTRACTS.md) · [../flows/FLOW_PRINCIPLES.md](../flows/FLOW_PRINCIPLES.md)

## Next Reading
[QUERY_CONTRACTS.md](QUERY_CONTRACTS.md)

## Changelog
- 1.0 (2026-08-02) — Conventions commandes initiales.
