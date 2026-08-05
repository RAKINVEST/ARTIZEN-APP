# Security Guidelines — Règles de sécurité (dev)

> **Version** 1.0 — **Status** Frozen — **Owner** RSSI — **Last Update** 2026-08-02
> **Depends On:** [../contracts/SECURITY_CONTRACTS.md](../contracts/SECURITY_CONTRACTS.md) — **Used By:** tout code — **Niveau:** 3 · Implémentation

## Objective
Les pratiques de sécurité que tout code applique.

## Règles
| Sujet | Règle |
|---|---|
| **Secrets** | jamais en dur/commit/log ; variables d'environnement uniquement ; `.env` gitignoré |
| **JWT** | signé (`SECRET_KEY` ≥ 32) ; `Authorization: Bearer` ; token absent → 403, invalide → 401 |
| **Permissions** | `company_id` du contexte ; mismatch tenant → **404** ; rate-limit actif sur `/auth/*` |
| **Validation** | valider toute entrée (couches [../contracts/VALIDATION_RULES.md](../contracts/VALIDATION_RULES.md)) ; ne jamais faire confiance au client |
| **Injection** | requêtes paramétrées (SQLAlchemy) ; jamais de concaténation SQL |
| **Upload** | type + taille bornés (413/415) ; garde de corps avant parsing ; nom généré (uuid), jamais dérivé du nom client |
| **Téléchargement** | `Content-Disposition: attachment` + `nosniff` ; tenant-scopé ; pas d'URL publique de fichier privé |
| **Audit / Journalisation** | actions sensibles tracées (append-only) ; **jamais de secret/PII** en log |
| **Partage** | ressources partagées sans **aucune donnée client** |

## Forbidden
Secret en clair · SQL concaténé · `company_id` du client · fichier privé public · PII en log.

## Acceptance Criteria
La grille de revue sécurité passe ; aucun secret dans le diff.

## Related Documents
[OBSERVABILITY_GUIDELINES.md](OBSERVABILITY_GUIDELINES.md) · [../contracts/SECURITY_CONTRACTS.md](../contracts/SECURITY_CONTRACTS.md)

## Next Reading
[OBSERVABILITY_GUIDELINES.md](OBSERVABILITY_GUIDELINES.md)

## Changelog
- 1.0 (2026-08-02) — Règles initiales.
