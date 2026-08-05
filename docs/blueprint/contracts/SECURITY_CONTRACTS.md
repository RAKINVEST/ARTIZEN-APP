# Security Contracts — Contrats de sécurité

> **Version** 1.0 — **Status** Frozen — **Owner** RSSI — **Last Update** 2026-08-02
> **Depends On:** [../engines/engines/Authorization.md](../engines/engines/Authorization.md) — **Used By:** tous les contrats — **Niveau:** 2 · Architecture

## Objective
Fixer les invariants de sécurité de tout échange : authentification, autorisation, scopes, jetons, secrets, audit.

## Règles
| Domaine | Règle |
|---|---|
| **Authentification** | JWT porteur ; en-tête `Authorization: Bearer` ; token absent → 403, token invalide/expiré → 401 |
| **Autorisation** | décision par l'Authorization Engine ; `company_id` du **contexte**, jamais du client |
| **Permissions / Scopes** | droit vérifié par action ; scoping tenant strict ; mismatch → **404** (ne confirme pas l'existence) |
| **Secrets** | jamais dans un DTO, un événement, un log ou une ressource partagée |
| **Audit** | actions sensibles tracées (append-only) — [contracts/audit.md](contracts/audit.md) |
| **Traçabilité** | chaque échange journalisé (History) ; corrélation par id |
| **Partage** | ressources partagées : **aucune donnée client** (prix, adresses, coordonnées) |
| **Transport** | HTTPS ; en-têtes de sécurité (nosniff, frame-deny) ; HSTS au routeur |

## Forbidden
Exposer un secret · accepter `company_id` du client · confirmer l'existence d'une ressource d'un autre tenant.

## Acceptance Criteria
Auth, autorisation, scopes, secrets, audit et traçabilité couverts pour tout contrat.

## Related Documents
[COMPATIBILITY_RULES.md](COMPATIBILITY_RULES.md) · [../ai/README.md](../ai/README.md)

## Next Reading
[COMPATIBILITY_RULES.md](COMPATIBILITY_RULES.md)

## Changelog
- 1.0 (2026-08-02) — Contrats de sécurité initiaux.
