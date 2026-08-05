# Migration Guidelines — Migrations de base

> **Version** 1.0 — **Status** Frozen — **Owner** Architecture — **Last Update** 2026-08-02
> **Depends On:** [../contracts/COMPATIBILITY_RULES.md](../contracts/COMPATIBILITY_RULES.md) — **Used By:** tout changement de schéma DB — **Niveau:** 3 · Implémentation

## Objective
Encadrer les évolutions de schéma (Alembic) sans perte ni rupture.

## Règles
| Sujet | Règle |
|---|---|
| **Outil** | Alembic ; `alembic revision --autogenerate -m "message"` puis **relecture** du script généré |
| **Relecture** | l'autogenerate se vérifie : types, index, contraintes, données existantes |
| **Application** | `alembic upgrade head` (entrypoint + postdeploy Scalingo) ; jamais à la main en prod |
| **Compatibilité** | privilégier l'additif ; changement destructif en plusieurs étapes (expand → migrate → contract) |
| **Données** | **jamais de destruction** de donnée métier (Loi 5) ; archiver plutôt que supprimer |
| **Réversibilité** | `downgrade` renseigné quand c'est raisonnable |
| **Enregistrement** | tout modèle importé dans `models/__init__.py` pour être vu par l'autogenerate |
| **Test** | migration testée sur base de dev avant livraison |

## Forbidden
Éditer une table à la main en prod · migration destructive en une étape · perte de donnée métier · script autogenerate non relu.

## Acceptance Criteria
Toute migration est relue, réversible si possible, sans perte de donnée.

## Related Documents
[CI_CD_POLICY.md](CI_CD_POLICY.md) · [RELEASE_PROCESS.md](RELEASE_PROCESS.md)

## Next Reading
[RELEASE_PROCESS.md](RELEASE_PROCESS.md)

## Changelog
- 1.0 (2026-08-02) — Règles initiales.
