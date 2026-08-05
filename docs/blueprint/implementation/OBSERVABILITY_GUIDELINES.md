# Observability Guidelines — Observabilité

> **Version** 1.0 — **Status** Frozen — **Owner** Exploitation — **Last Update** 2026-08-02
> **Depends On:** [CODING_STANDARDS.md](CODING_STANDARDS.md) — **Used By:** tout code — **Niveau:** 3 · Implémentation

## Objective
Rendre le système diagnosticable sans exposer de données sensibles.

## Règles
| Sujet | Règle |
|---|---|
| **Logs** | `logging` centralisé ; niveaux justes (INFO/WARNING/ERROR) ; message actionnable ; **jamais de secret/PII** |
| **Métriques** | usage et santé exposés ; remontés au moteur Performance par événements |
| **Traces** | corrélation par id (mission/requête) |
| **Journalisation métier** | History append-only pour toute action significative (Loi 4/5) |
| **Audit** | trace de sécurité séparée (Audit Engine) |
| **Alertes** | échecs silencieux **supervisés** (ex. e-mail de reset avalé, envoi de devis) — remontés, jamais ignorés |
| **Diagnostics** | `/health` = `SELECT 1` (DB) + état Redis ; santé pilotée par la DB |

## Règle d'or (échecs silencieux)
Un échec avalé (e-mail, envoi) reste **journalisé et supervisé** : aucune fonctionnalité ne peut échouer sans laisser de trace exploitable.

## Forbidden
Log parasite · secret/PII en log · métrique non explicable.

## Acceptance Criteria
Chaque action significative est traçable ; les échecs silencieux sont supervisés.

## Related Documents
[PERFORMANCE_GUIDELINES.md](PERFORMANCE_GUIDELINES.md) · [ERROR_HANDLING.md](ERROR_HANDLING.md)

## Next Reading
[PERFORMANCE_GUIDELINES.md](PERFORMANCE_GUIDELINES.md)

## Changelog
- 1.0 (2026-08-02) — Règles initiales.
