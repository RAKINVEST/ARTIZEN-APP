# Error Handling — Gestion des erreurs

> **Version** 1.0 — **Status** Frozen — **Owner** Architecture — **Last Update** 2026-08-02
> **Depends On:** [../contracts/ERROR_CONTRACTS.md](../contracts/ERROR_CONTRACTS.md) — **Used By:** tout code — **Niveau:** 3 · Implémentation

## Objective
Uniformiser la façon dont les erreurs sont levées, propagées, présentées.

## Règles
| Sujet | Règle |
|---|---|
| **Enveloppe** | erreur HTTP = `{ "error": { "code", "message" } }` (contrat unique) |
| **Codes** | stables, en `SCREAMING_SNAKE_CASE` ; jamais changés sans compat |
| **Exceptions** | typées par domaine (ex. `QuoteExtractionError`) ; jamais `except:` nu ni `except Exception` fourre-tout |
| **Frontière** | l'exception de domaine est traduite en réponse de contrat à la frontière (router), pas au cœur |
| **Statuts** | 400 validation · 401 non authentifié · 403 non autorisé/token absent · **404 tenant mismatch** · 409 conflit d'état · 413/415 upload · 422 schéma · 429 rate-limit · 5xx interne |
| **Messages** | actionnables, langage artisan côté UI ; aucun détail technique ni secret exposé |
| **Silencieux** | un échec avalé est **journalisé et supervisé** (jamais ignoré) |
| **Frontend** | mécanisme unique 4 états (loading/error/empty/data) ; erreur → message clair + reprise |

## Forbidden
`except:` nu · avaler une erreur sans trace · fuite de détail technique/secret · code d'erreur instable.

## Acceptance Criteria
Toute erreur suit l'enveloppe et le bon statut ; aucun `except` fourre-tout dans le diff.

## Related Documents
[OBSERVABILITY_GUIDELINES.md](OBSERVABILITY_GUIDELINES.md) · [../contracts/ERROR_CONTRACTS.md](../contracts/ERROR_CONTRACTS.md)

## Next Reading
[MIGRATION_GUIDELINES.md](MIGRATION_GUIDELINES.md)

## Changelog
- 1.0 (2026-08-02) — Règles initiales.
