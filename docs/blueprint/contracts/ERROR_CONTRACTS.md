# Error Contracts — Bibliothèque d'erreurs

> **Version** 1.0 — **Status** Frozen — **Owner** Architecture — **Last Update** 2026-08-02
> **Depends On:** [API_CONTRACTS.md](API_CONTRACTS.md) — **Used By:** contracts/errors, tous les endpoints — **Niveau:** 2 · Architecture

## Objective
Normaliser toutes les erreurs sous une **enveloppe unique** et un catalogue de codes stables. Jamais d'erreur générique.

## Enveloppe
`{ "error": { "code": "<snake_case>", "message": "<lisible>", "details": [ … ] } }`

## Catalogue (extrait normalisé)
| Code | HTTP | Cause | Message utilisateur | Message technique |
|---|---|---|---|---|
| `validation_error` | 422 | données invalides | « Vérifiez les champs signalés. » | liste des champs |
| `unauthorized` | 401 | non authentifié | « Veuillez vous reconnecter. » | jeton absent/expiré |
| `forbidden` | 403 | droit manquant | « Action non autorisée. » | permission refusée |
| `not_found` | 404 | ressource absente **ou** autre tenant | « Introuvable. » | ne confirme jamais l'existence cross-tenant |
| `conflict` | 409 | état incompatible / édition concurrente | « Cet élément a changé. » | version attendue ≠ courante |
| `unsupported_file_type` | 415 | type de fichier refusé | « Format non pris en charge. » | mime rejeté |
| `file_too_large` | 413 | fichier trop volumineux | « Fichier trop lourd. » | > limite |
| `too_many_requests` | 429 | rate-limit | « Trop de tentatives, patientez. » | fenêtre/quota |
| `extraction_provider_unavailable` | 503 | pas d'IA réelle | « Extraction indisponible. » | mock refusé (jamais d'invention) |
| `extraction_incomplete` | 422 | champ requis non lu | « Complétez les champs manquants. » | liste des manquants |
| `internal_server_error` | 500 | inattendu | « Une erreur est survenue. » | trace journalisée |

## Règles
- Chaque erreur : **code, nom, description, cause, solution, HTTP, journalisation, message utilisateur, message technique**.
- Message utilisateur en **langage artisan** (jamais de terme d'ingénierie).
- Toute erreur est journalisée ; les 5xx portent une trace.

## Acceptance Criteria
Toutes les erreurs sont normalisées sous l'enveloppe unique et cataloguées.

## Related Documents
[VALIDATION_RULES.md](VALIDATION_RULES.md) · [../flows/FLOW_ERRORS.md](../flows/FLOW_ERRORS.md)

## Next Reading
[VALIDATION_RULES.md](VALIDATION_RULES.md)

## Changelog
- 1.0 (2026-08-02) — Enveloppe + catalogue initiaux.
