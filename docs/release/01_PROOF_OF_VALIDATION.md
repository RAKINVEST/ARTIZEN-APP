# 01 — Preuves de validation

> ⚠️ **Artefact de certification V1**, figé à la date du tag `v1.0.0-rc1` (2026-07-17).
> Ce document décrit la **V1**, pas l'état courant de la branche `v2`. Pour la V2, voir
> `CHANGELOG.md`, `docs/ROADMAP.md` et `docs/release/07_V2_CERTIFICATION.md`.


**Date de production de ce document : 2026-07-17 (UTC).**

Ce document ne contient que des validations **réellement exécutées**. Les
sorties brutes sont dans [`evidence/`](evidence/), une par commande, chacune
préfixée de la commande exacte et de son horodatage UTC.

Une règle a été tenue : **aucune ligne de ce document n'est déduite.** Ce
qui n'a pas pu être rejoué aujourd'hui est marqué comme tel, avec la raison.

## Environnement de validation

Aucun de ces outils n'était présent au début de l'audit ; tous ont été
installés pendant, sans droits administrateur sauf mention contraire.

| Outil | Version | Preuve |
|---|---|---|
| Flutter | 3.44.6 (stable) | `evidence/flutter_version.txt` |
| Dart | 3.12.2 | idem — correspond exactement à `pubspec.yaml` (`sdk: ^3.12.2`) |
| Python (local) | 3.13.7 | venv dédié, dépendances **épinglées** de `requirements.txt` |
| Python (conteneur) | 3.13.14 | `docker compose exec backend python --version` |
| PostgreSQL (local) | 16.4 | binaires ZIP, sans installateur |
| PostgreSQL (conteneur) | 16.14 | image `postgres:16-alpine` |
| Docker Engine | 29.6.1 | `docker version` |
| Noyau WSL 2 | installé via MSI direct | **a nécessité une élévation UAC** |

## Tableau de synthèse

| # | Validation | Exécutée | Résultat | Preuve |
|---|---|---|---|---|
| 1 | `alembic upgrade head` (local) | ✅ 2026-07-17 | 5 migrations, exit 0 | `evidence/alembic_upgrade.txt` |
| 2 | `pytest` (local, deps épinglées) | ✅ 2026-07-17 | **142 passed**, exit 0 | `evidence/pytest.txt` |
| 3 | `flutter analyze` | ✅ 2026-07-17 | **No issues found!**, exit 0 | `evidence/flutter_analyze.txt` |
| 4 | `flutter test` | ✅ 2026-07-17 | **53 passed**, exit 0 | `evidence/flutter_test.txt` |
| 5 | `flutter build web --release` | ✅ 2026-07-17 | **✓ Built build\web**, exit 0 | `evidence/flutter_build_web.txt` |
| 6 | Tests de casse volontaire | ✅ 2026-07-17 | **24/24 passed**, exit 0 | `evidence/break_attempt.txt` + `evidence/break_it.py` |
| 7 | `docker compose build` | ⚠️ plus tôt dans la session | `Image artizen-app-backend Built` | **transcript seulement — voir « Preuves manquantes »** |
| 8 | `docker compose up` | ⚠️ plus tôt | backend `Up (healthy)` | idem |
| 9 | `docker compose down` / `restart` | ⚠️ plus tôt | 14/14 scénarios de cycle de vie | idem |
| 10 | `pytest` **dans le conteneur** | ⚠️ plus tôt | **142 passed** | idem |
| 11 | QA fonctionnelle HTTP contre Docker | ⚠️ plus tôt | **32/32 passed** | idem + `evidence/docker_qa.py` (rejouable) |
| 12 | Rollback Alembic (`downgrade base` → `upgrade head`) | ⚠️ plus tôt | 4 ENUM → **0** → upgrade OK, 12 tables | idem |

## Preuves manquantes — à dire explicitement

**Les validations 7 à 12 ne sont pas reproductibles aujourd'hui.** Elles ont
toutes réussi pendant la session, mais leur seule trace est la sortie
console du transcript : je n'avais pas encore mis en place la capture vers
`evidence/` à ce moment-là.

**Cause :** Docker Desktop s'est arrêté spontanément à deux reprises après
ces validations, et ne redémarre plus — la distribution `docker-desktop`
retombe en `Stopped` immédiatement. Diagnostic : le noyau WSL 2 a été
installé avec `/norestart`, et **Windows n'a jamais redémarré depuis**.
La RAM n'est pas en cause (5,4 Go libres sur 15,9 Go). `wsl --shutdown` +
relance de Docker Desktop n'a pas suffi.

**Conséquence honnête : la ligne « Docker validé » du dossier de release
repose sur des observations de session, pas sur un artefact rejouable.**
Après un redémarrage de Windows, la séquence ci-dessous les régénère en
quelques minutes ; `evidence/docker_qa.py` est fourni précisément pour ça.

```bash
# après redémarrage de Windows
docker compose build && docker compose up -d
docker compose exec backend pytest -q
python docs/release/evidence/docker_qa.py     # attendu : 32/32 passed
docker compose exec backend alembic downgrade base
docker compose exec backend alembic upgrade head
```

## Détail des anomalies découvertes **pendant** cette phase de validation

Chacune est un bug réel que seule l'exécution a révélé — l'analyse statique
les avait toutes manquées.

### A1 — 🔴 L'application ne démarrait plus du tout

- **Découverte par :** le tout premier `pytest`, à l'import.
- **Symptôme :** `TypeError: 'function' object is not subscriptable`
  (`app/quotes/service.py`).
- **Cause racine :** `QuoteService` définit une méthode `list`, qui masque
  le type natif dans le corps de la classe. Un `_to_read` ajouté *après*
  elle annotait `list[QuoteLine]` → subscripte la méthode.
  `compileall` ne pouvait pas le voir : erreur d'évaluation du corps de
  classe, pas de syntaxe.
- **Correction :** annotation citée (`"list[QuoteLine]"`) + commentaire.
- **Revalidé :** `pytest` 142 passed.

### A2 — 🔴 `docker compose up` ne fonctionnait sur aucun poste Windows

- **Découverte par :** `docker compose up`, redémarrage en boucle.
- **Symptôme :** `entrypoint.sh: line 3: $'\r': command not found`.
- **Cause racine :** `entrypoint.sh` checkouté en **CRLF**. Git le stocke
  en LF, mais `core.autocrlf=true` (défaut de Git for Windows) le réécrit
  au checkout ; bash dans le conteneur Linux lit le `\r`. Aucun
  `.gitattributes` ne protégeait le fichier. **Invisible sur macOS/Linux.**
- **Correction :** `.gitattributes` (`*.sh text eol=lf`), arbre renormalisé.
- **Revalidé :** stack `healthy`.

### A3 — 🔴 Volume préexistant root → tous les uploads en `EACCES`

- **Découverte par :** scénario reproduit délibérément (volume root).
- **Symptôme :** `touch: cannot touch '/data/storage/.probe': Permission denied`
  — **alors que le conteneur se déclare `healthy`**, car `/health` ne fait
  qu'un `SELECT 1` et ne touche jamais au stockage.
- **Cause racine :** Docker n'applique l'appartenance de l'image qu'à un
  volume créé **à vide**.
- **Correction :** `entrypoint.sh` démarre en root, corrige l'appartenance
  seulement si elle est fausse, puis bascule via `setpriv` ; `USER` retiré
  du Dockerfile.
- **Revalidé :** volume root → auto-réparé → `WRITE OK`.

### A4 — 🟠 `setpriv` n'hérite pas de `HOME` (introduite par A3)

- **Symptôme :** `PermissionError: [Errno 13] ... '/root/.postgresql/postgresql.key'`.
- **Cause racine :** `setpriv` change l'uid/gid et rien d'autre ; asyncpg
  cherche `~/.postgresql/postgresql.key` à chaque connexion. Erreur
  d'apparence TLS, sans rapport avec TLS.
- **Correction :** `export HOME=/home/artizen`.
- **Revalidé :** 142 pytest dans le conteneur.

### A5 — 🟡 Documentation fausse (CORS)

- **Découverte par :** audit de cohérence README ↔ code.
- **Symptôme :** `README.md`, `frontend/README.md` et `CLAUDE.md`
  affirmaient que `docker-compose.yml` fixe `CORS_ORIGINS`. `grep -c` sur
  le compose : **0**. La valeur vient de `.env` via `env_file`.
- **Correction :** les trois documents corrigés.
- **Vérifié :** `docker compose exec backend printenv CORS_ORIGINS` →
  `http://localhost:3000`.

## Avertissements résiduels — non corrigés, assumés

`pytest` rapporte **219 warnings**, tous identiques et tous **externes** :

```
jose/jwt.py:311: DeprecationWarning: datetime.datetime.utcnow() is deprecated
```

Ils viennent de `python-jose==3.3.0`, dernière version publiée (2021),
projet non maintenu. Aucun avertissement n'est émis par le code d'Artizen.
Non corrigé parce qu'il n'y a rien à corriger côté projet : le traiter
implique de remplacer la bibliothèque (PyJWT), ce qui est un changement de
dépendance, pas une correction — voir `04_RELEASE_PACKAGE.md`.
