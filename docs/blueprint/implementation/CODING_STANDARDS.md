# Coding Standards — Conventions de code

> **Version** 1.0 — **Status** Frozen — **Owner** Architecture — **Last Update** 2026-08-02
> **Depends On:** [PROJECT_STRUCTURE.md](PROJECT_STRUCTURE.md) — **Used By:** tout code — **Niveau:** 3 · Implémentation

## Objective
Un code prévisible : mêmes conventions pour tous. Ancrées sur le dépôt réel (FastAPI + Flutter).

## Conventions
| Sujet | Backend (Python) | Frontend (Flutter/Dart) |
|---|---|---|
| **Nommage** | `snake_case` (fonctions/vars), `PascalCase` (classes), `UPPER_SNAKE` (constantes) | `lowerCamelCase`, `PascalCase` (types) |
| **Fichiers** | `snake_case.py` | `snake_case.dart` |
| **Packages / dossiers** | modules verticaux : `models/schemas/repository/service/deps/router` | feature-first : `data/domain/presentation` |
| **Variables** | explicites, pas d'abréviation obscure | idem |
| **Constantes** | module-level, `UPPER_SNAKE` | `static const` |
| **Exceptions** | sous-classes d'`AppException` (code + HTTP stable) ; jamais d'`except` nu | `ApiException` mappé par l'intercepteur |
| **Logs** | `logging` centralisé ; niveaux justes ; **jamais de secret/PII** en clair | pas de `print` en prod |
| **Commentaires** | **en anglais** ; expliquent le *pourquoi*, pas le *quoi* | idem |
| **TODO** | interdits en permanence : un TODO = un ticket + référence ; sinon retiré | idem |
| **Argent** | **`Decimal`, jamais `float`** ; arrondi `ROUND_HALF_UP` par ligne ; calcul dans le seul calculateur | montants en `String` (fidélité) |
| **Modèles** | Pydantic v2 | Freezed + json_serializable → `build_runner` après toute modif |

## Règles
- Un seul endroit calcule un montant (ADR-023). Le client affiche ce que le backend renvoie.
- `company_id` du contexte d'auth, jamais du client.
- Fonctions courtes, une intention ; pas de méthode/classe géante ([QUALITY_STANDARD.md](QUALITY_STANDARD.md)).

## Forbidden
`float` pour un montant · `except:` nu · secret/PII en log · TODO permanent · commentaire qui paraphrase le code.

## Acceptance Criteria
Le code passe le formatage et l'analyse statique ([CI_CD_POLICY.md](CI_CD_POLICY.md)) sans exception.

## Related Documents
[ERROR_HANDLING.md](ERROR_HANDLING.md) · [OBSERVABILITY_GUIDELINES.md](OBSERVABILITY_GUIDELINES.md)

## Next Reading
[ARCHITECTURE_RULES.md](ARCHITECTURE_RULES.md)

## Changelog
- 1.0 (2026-08-02) — Conventions initiales.
