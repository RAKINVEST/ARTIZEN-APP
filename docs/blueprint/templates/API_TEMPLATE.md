# API — <Nom>

> **Version** 0.1 — **Status** Draft — **Owner** <équipe> — **Last Update** AAAA-MM-JJ
> **Depends On:** [../contracts/](../contracts/README.md) — **Used By:** <clients de l'API> — **Niveau:** 2 · Architecture

## Objective
<Ce que cette API expose et pour qui.>

## Endpoint
`<MÉTHODE> /api/<chemin>`

## Auth & Tenant
JWT requis. `company_id` provient toujours du JWT, jamais du client. Mismatch tenant → 404.

## Request
| Champ | Type | Requis | Description |
|---|---|---|---|
| … | … | … | … |

## Response
<Forme de la réponse (schéma), code de succès.>

## Errors
| Code | Signification |
|---|---|
| 4xx/5xx | … (enveloppe d'erreur stable `{error:{code,message}}`) |

## Constraints
Aucune donnée métier privée exposée hors tenant. Aucune fabrication de donnée.

## Rules
## Forbidden
Accepter `company_id` en paramètre client.

## Acceptance Criteria
Endpoint, auth, requête, réponse et erreurs déclarés ; scoping tenant vérifié.

## Related Documents
## Next Reading
## Changelog
- 0.1 (AAAA-MM-JJ) — Création.
