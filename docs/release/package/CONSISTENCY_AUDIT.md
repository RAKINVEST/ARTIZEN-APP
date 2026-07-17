# Audit final de cohérence — ARTIZEN V2.0.0-RC1

Dernière revue avant publication. Chaque dimension est vérifiée **contre le
code du commit tagué `v2.0.0-rc1`** (HEAD `7f68131`), pas déduite. Toute
anomalie est classée ; **bloquante/majeure → RC2**, **mineure → V2.x/V3**.
Le code de la RC n'a **pas** été modifié pendant cet audit.

## Verdict global

**Aucune anomalie bloquante ni majeure.** 11 dimensions vérifiées, **10
cohérentes**, 1 portant une incohérence **mineure** (numéros de version,
cosmétique). **Aucune RC2 n'est ouverte.** Les points mineurs sont
documentés (`docs/KNOWN_LIMITATIONS.md`) et reportés, non corrigés sur RC1.

## Les 11 dimensions

| # | Dimension | Verdict | Constat (preuve) |
|---|---|:---:|---|
| 1 | **Architecture** | ✅ | `app/pdf/` n'importe que `app.pdf.*` ; aucun calcul monétaire hors `calculator.py` ; dépendances inter-modules à sens unique. Divergence connue `users ↔ branding` (sans cycle à l'import) — documentée, V3. |
| 2 | **Documentation** | ✅ | Docs de release rédigées par lecture directe du code (routers, schémas, config, compose) + 2 inventaires d'agents. 3 inexactitudes trouvées et corrigées en certification. Reste un commentaire périmé dans `branding_providers.dart` (mineur, #15 des limitations). |
| 3 | **API** | ✅ | **44 endpoints** (39 métier + 2 infra + 3 auto), vérifiés route par route contre `router.py`/`schemas.py`. Ni `PUT` ni `PATCH` sur le contenu d'un devis. `docs/API_REFERENCE.md`. |
| 4 | **Flutter** | ✅ | 9 features, 5 onglets, écrans et actions vérifiés dans `lib/features/*`. Lacunes UI (édition identité, upload logo, détail client, catégories, mot de passe oublié) documentées honnêtement — mineures/V3. |
| 5 | **Docker** | ✅ | `docker-compose.yml` = dev (`--reload`, bind-mount) ; image = prod (`--workers 4`, non-root `artizen`). Volumes, healthchecks, réparation de propriété par l'entrypoint — cohérents avec les fichiers. |
| 6 | **PostgreSQL** | ✅ | **13 relations** mesurées par `pg_dump` (12 métier + `alembic_version`), dont `quote_counters` (V2). Correspond aux modèles. |
| 7 | **Migrations** | ✅ | **6 migrations**, chaîne linéaire, tête **`6cc7943bff6a`** (`alembic current`/`history`). Rollback complet testé en Docker. `docs/MIGRATION_GUIDE.md`. |
| 8 | **Dépendances** | ✅ | `requirements.txt` entièrement épinglé (`==`) ; `pubspec.yaml` + `pubspec.lock` versionnés. Nouveautés V2 : `reportlab`, `printing`, `integration_test`. Épinglages critiques (`bcrypt==4.0.1`) commentés. |
| 9 | **Git** | ✅ | Branche `v2`, HEAD `7f68131`. **Le code de la RC est intact** : seuls `CHANGELOG.md` et de nouveaux fichiers de documentation ajoutés — **aucun** changement sous `backend/app/` ou `frontend/lib/` (vérifié). Rien poussé sur `origin`. |
| 10 | **Tags** | ✅ | `v1.0.0-rc1` (V1, sur `main`) et `v2.0.0-rc1` (V2). **`v2.0.0-rc1` pointe exactement sur HEAD** (`7f68131`). |
| 11 | **Numéros de version** | 🟡 | **Incohérence mineure** : backend `settings.VERSION="0.1.0"`, frontend `pubspec` `1.0.0+1` / écran `"1.0.0 (MVP)"`, tag `2.0.0-rc1`. Purement métadonnée d'affichage (Swagger, écran Paramètres), **aucun impact comportemental**. → aligner sur `2.0.0` avant la publication finale. `KNOWN_LIMITATIONS.md` #8. |

## Anomalies découvertes pendant l'audit — classification

| Anomalie | Classe | Décision |
|---|---|---|
| Numéros de version divergents (métadonnée) | 🟢 Mineure | Documentée (#8), reportée V2.0 finale. Pas de RC2. |
| Commentaire périmé dans `branding_providers.dart` | 🟢 Mineure | Documentée (#15), reportée V2.x. Pas de RC2. |
| Lacunes UI (identité, logo, détail client, catégories, mdp oublié) | 🟢 Mineure | Documentées (#1–5), reportées V3. Fonctionnellement contournables (API / import). Pas de RC2. |
| Édition de devis en place absente | 🔵 Par conception | Aucune action. |

**Aucune anomalie 🔴 bloquante ni 🟠 majeure** n'a été trouvée. La condition
d'ouverture d'une RC2 n'est pas remplie.

## Conformité au gel de la RC

- Le code de la Release Candidate (`backend/app/`, `frontend/lib/`,
  migrations, Dockerfile, compose) **n'a pas été modifié** pendant la phase
  Release Manager.
- Les seuls changements sont **documentaires** : mise à jour du `CHANGELOG.md`
  (passage `[Non publié]` → `[v2.0.0-rc1]` + UAT + docs de release) et
  création des guides/package.
- Toute la documentation correspond au code tagué `v2.0.0-rc1`, ne décrit
  aucune fonctionnalité inexistante, et ne masque aucune fonctionnalité
  présente ni aucune limitation connue.
