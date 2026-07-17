# Matrice de validation — ARTIZEN V2.0.0-RC1

Toutes les portes de validation exécutées pour la V2, leur résultat, et leur
rejouabilité. Principe du dépôt : chaque ligne est **validée par exécution,
par tests, ou par analyse statique** — jamais « raisonnée sans preuve ».

## Portes automatisées

| # | Validation | Résultat | Méthode | Rejeu |
|---|---|---|---|---|
| 1 | `pytest` (local, deps épinglées) | **208 passed** | exécution | `pytest` |
| 2 | `pytest` (**conteneur Docker**) | **208 passed** | exécution | `docker compose exec backend pytest` |
| 3 | `flutter analyze` | **No issues found!** | analyse statique | `flutter analyze` |
| 4 | `flutter test` | **63 passed** | exécution | `flutter test` |
| 5 | `flutter build web --release` | **construit** (avec `printing`) | exécution | `flutter build web --release` |
| 6 | Migrations : installation neuve (Docker) | **6 migrations, exit 0** | exécution | `alembic upgrade head` |
| 7 | Migrations : rollback (Docker) | **aller-retour propre** | exécution | `alembic downgrade base && upgrade head` |
| 8 | Tentative de casse — cycle de vie | **18/18** | exécution | `evidence/break_duplicate.py` / lifecycle |
| 9 | Tentative de casse — moteur PDF | **14/14** | exécution | `evidence/break_pdf.py` |
| 10 | QA HTTP Docker — parcours V2.1 | **21/21** | exécution | `evidence/docker_qa_v2.py` |
| 11 | QA HTTP Docker — duplication | **19/19** | exécution | `evidence/break_duplicate.py` |
| 12 | QA HTTP — sécurité V2 | **14/14** | exécution | `evidence/cert_security.py` |
| 13 | QA HTTP — uploads V2 | **vérifié** | exécution | `evidence/cert_uploads.py` |
| 14 | Durcissements V1 rejoués sur v2 | **11/11** | exécution | `evidence/break_v1_http.py` |
| 15 | **UAT — parcours artisan 17 étapes (vrai navigateur)** | **franchie** | exécution (flutter drive) | `frontend/integration_test/uat_test.dart` |
| 16 | **UAT — vérification d'invariants backend** | **13/13** | exécution | `uat_backend_checks.py` |

## Couverture des 9 axes d'audit V2

Détail : `docs/release/07_V2_CERTIFICATION.md`.

| Axe | Résultat |
|---|---|
| Architecture ↔ implémentation | Cohérent (`app/pdf/` n'importe que `app.pdf.*` ; aucune arithmétique monétaire hors `calculator.py`) |
| Code ↔ documentation | Fidèle ; 3 inexactitudes trouvées et corrigées |
| API ↔ Flutter | 6 axes cohérents ; 1 lacune mineure → V3 |
| Couverture des tests | 3 trous trouvés ; monétaire (critique) et mapper (majeur) fermés ; +7 tests |
| Absence de régression V1 | 11/11 durcissements tiennent sur v2 |
| Cohérence migrations | 6 migrations à vide ; rollback complet |
| Validation Docker | build, up healthy, 208 pytest conteneur, non-root, volume auto-réparé |
| Multi-tenant | 404 (jamais 403) inter-tenant, sans fuite |
| Sécurité V2 | 14/14 |

## Ce qui n'a PAS été prouvé (nommé honnêtement)

| Sujet | État |
|---|---|
| Montée en charge sous concurrence réelle | Tests `asyncio.gather` + rejeu réel double en UAT ; **pas d'épreuve de charge** |
| Multi-navigateur | UAT sur **Chrome** ; Firefox/Safari non exercés |
| Audit de sécurité externe | **non réalisé** |
| Édition de devis en place | **inexistante par conception** (rien à prouver) |

## Traçabilité des preuves

Les scripts et sorties sont dans `docs/release/evidence/` :
`pytest.txt`, `flutter_analyze.txt`, `flutter_test.txt`, `flutter_build_web.txt`,
`alembic_upgrade.txt`, `break_it.py`, `break_pdf.py`, `break_duplicate.py`,
`break_v1_http.py`, `cert_security.py`, `cert_uploads.py`, `docker_qa.py`,
`docker_qa_v2.py`. Le harnais UAT est dans `frontend/integration_test/` et
`frontend/test_driver/`.
