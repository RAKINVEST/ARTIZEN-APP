# V3.1 — Fondations techniques (Sprint 0)

> **Rapport d'architecte.** Ce sprint ne livre **aucune fonctionnalité métier**. Il construit
> l'infrastructure technique sur laquelle toute la V3 s'appuiera, et en particulier l'assistant
> vocal IA (voix → devis). Le sprint est terminé parce que ces fondations sont prêtes à l'accueillir.
>
> Contraintes tenues : **zéro régression de la V2** (216 tests backend verts, dont les 214 de la V2
> inchangés), gel V2 définitif (aucun fichier V2 modifié dans son comportement), rien poussé sur GitHub,
> les trois commits V2 intouchés.

---

## 1. Objectif et périmètre

| Priorité | Fondation | Livré |
|----------|-----------|-------|
| 1 | Infrastructure des tâches asynchrones | **Arq** (worker + queue + tâche démo) |
| 2 | Redis | Service compose + client async gracieux |
| 3 | Workers | Service `worker` (même image, commande `arq`) |
| 4 | Queue de traitement | `app/tasks/queue.py` (`enqueue`, `queue_depth`) |
| 5 | Monitoring | `/health` étendu (Redis + profondeur de queue), logs du cycle de tâche |
| 6 | Migration `python-jose` → moderne | **PyJWT 2.10.1** |
| 7 | CI/CD | GitHub Actions (`.github/workflows/ci.yml`) |
| 8 | Renforcement sécurité | Rate limit partagé (Redis) + en-têtes de sécurité |
| 9 | Documentation | Ce document |

**Principe directeur, hérité de la V2 :** *une dépendance d'infrastructure manquante n'est jamais une
erreur.* Comme `ai/factory.py` bascule sur un mock sans clé API, et comme `storage.py` fonctionne en
local sans S3, **l'application démarre et reste utilisable sans Redis**. Chaque capacité qui en dépend
se dégrade proprement plutôt que de tomber. C'est ce qui permet d'ajouter cette infrastructure sans
alourdir le poste de développement ni la suite de tests.

---

## 2. Vue d'ensemble

```
                    ┌────────────────────────────────────────────┐
   HTTP (artisan)   │                  backend                   │
   ───────────────► │  FastAPI  ──enqueue(job)──►  ┌───────────┐ │
                    │  /health  ◄──queue_depth───   │  Redis    │ │
                    │           ◄──redis ping────   │  (broker) │ │
                    └────────────────────────────── └─────┬─────┘ │
                                                          │ poll   │
                    ┌─────────────────────────────────────▼──────┐
                    │   worker (arq)  — même image, commande arq  │
                    │   exécute les jobs hors du chemin requête   │
                    │   (V3 : STT, LLM, OCR, e-mail, PDF en masse)│
                    └─────────────────────────────────────────────┘
```

- **Le backend n'exécute jamais de tâche longue lui-même.** Il *enfile* un job et rend la main
  immédiatement ; le worker le traite en dehors du cycle requête/réponse. C'est la condition pour que
  l'assistant vocal (transcription + appel LLM, plusieurs secondes) ne bloque aucune requête HTTP.
- **Le worker partage l'image du backend**, pas seulement le code : il a accès aux mêmes modules
  (catalogue, IA, storage) pour, en V3, faire le vrai travail. Seule la commande de lancement diffère
  (`arq app.tasks.worker.WorkerSettings` au lieu d'`uvicorn`).
- **Scalabilité horizontale** : augmenter le nombre de workers = augmenter `replicas` du service
  `worker`. Aucune coordination applicative — Redis distribue les jobs.

---

## 3. Décisions et justifications

### 3.1 Arq plutôt que Celery

La stack est **entièrement asynchrone** (FastAPI + SQLAlchemy async + asyncpg). Celery reste
fondamentalement synchrone : l'intégrer imposerait des ponts sync/async fragiles, ou un second modèle
d'exécution à côté de celui de l'app. **Arq est nativement asyncio**, écrit par l'auteur de pydantic,
minimal (une dépendance : `redis`), et son worker partage le même modèle mental que le reste du code
(`async def demo_task(ctx, payload)`). Pour un produit dont **toutes** les tâches V3 sont des appels
réseau (STT, LLM, e-mail), le modèle async est exactement le bon.

### 3.2 PyJWT plutôt que `python-jose`

`python-jose` n'est plus activement maintenu (dernier release 2021, CVE ouvertes sur les algorithmes).
**PyJWT 2.10.1** est le standard maintenu de l'écosystème. La migration est **chirurgicale** : le JWT
n'est manipulé qu'à un seul endroit, [`app/auth/security.py`](../../backend/app/auth/security.py).

Points de sécurité tenus dans la migration :
- **Liste blanche d'algorithmes explicite** (`algorithms=["HS256"]`) au décodage → une attaque
  `alg=none` ou une substitution d'algorithme est rejetée.
- L'expiration (`exp`) reste vérifiée par la bibliothèque.
- Exception de base `jwt.PyJWTError` → un jeton invalide renvoie `None` (donc 401), jamais une 500.

Effet de bord mesuré : la suite passe de **462 avertissements de dépréciation à 1**. `python-jose`
utilisait `datetime.utcnow()` (déprécié en 3.12) ; PyJWT non.

### 3.3 Redis gracieux

[`app/redis_client.py`](../../backend/app/redis_client.py) expose un singleton async **paresseux** :
la connexion n'est ouverte qu'au premier usage, avec un timeout court (2 s), et `redis_healthy()`
**ne lève jamais**. Conséquence directe : importer le module ou démarrer l'app sans Redis ne coûte rien
et ne casse rien. Le test suite n'a besoin d'aucun Redis pour les 214 tests V2.

### 3.4 Rate limit : backend sélectionnable

Le limiteur d'auth de la V2 comptait en mémoire de processus — correct, mais avec les 4 workers de la
CMD de production le plafond réel valait ~4×. La V3 ajoute un **compteur Redis à fenêtre fixe**
(`INCR` + `EXPIRE`) **partagé** par tous les workers/réplicas, qui referme cet écart.

Le choix du backend est un **argument de constructeur** (`backend="memory"|"redis"`), piloté par
`RATE_LIMIT_BACKEND`. Deux raisons de fond :
1. **La suite de tests construit toujours le limiteur en mémoire** — déterministe, sans Redis partagé
   qui contaminerait deux tests tombant dans la même fenêtre temporelle.
2. **Dégradation** : si le backend est `redis` et que Redis tombe, `__call__` retombe sur le compteur
   mémoire (log `warning`) plutôt que de verrouiller les utilisateurs dehors.

Ce qui *reste* un sujet de reverse-proxy (inchangé) : la confiance en `X-Forwarded-For`.

### 3.5 En-têtes de sécurité

[`app/core/security_headers.py`](../../backend/app/core/security_headers.py) — middleware **ASGI pur**
(hors du hot path, comme `MaxBodySizeMiddleware`) qui pose sur chaque réponse : `X-Content-Type-Options:
nosniff`, `X-Frame-Options: DENY`, `Referrer-Policy: strict-origin-when-cross-origin`,
`Permissions-Policy: geolocation=(), camera=()`, `X-XSS-Protection: 0`.

**HSTS est délibérément omis** : il appartient au reverse-proxy qui termine TLS en production ; le poser
ici, sur une origine HTTP nue, serait faux.

### 3.6 Worker et migrations

Le worker passe par le même `entrypoint.sh` que le backend, donc applique aussi les migrations Alembic
au démarrage. Alembic sérialise via son verrou `alembic_version` : deux conteneurs qui démarrent
ensemble ne se marchent pas dessus. Point de vigilance noté pour la V3.2 (idéalement un seul conteneur
« migrateur » dédié), non bloquant aujourd'hui.

---

## 4. Métriques de performance

Mesurées dans la pile Docker (`db` + `redis` + `backend` + `worker`), image reconstruite avec les
nouvelles dépendances.

| Métrique | Valeur | Lecture |
|----------|--------|---------|
| Round-trip 1 job (enqueue → worker → résultat) | **~503 ms** | Dominé par le `poll_delay` d'arq (0,5 s par défaut). Le traitement de la tâche est sub-ms. |
| Débit (20 jobs, 10 slots concurrents, 1 worker) | **38,4 jobs/s** | La queue se draine vite ; le débit croît avec `max_jobs` et le nombre de workers. |
| Latence unitaire steady-state (worker chaud) | **min 502 / max 503 ms** | Plancher = intervalle de poll, pas de coût CPU. |
| Latence `/health` (vrai `SELECT 1` + ping Redis + `zcard`) | **9–26 ms** | Le monitoring étendu n'alourdit pas la sonde. |
| Avertissements de dépréciation (suite pytest) | **462 → 1** | Effet de la sortie de `python-jose`. |

**Interprétation du plancher de 500 ms.** Ce n'est pas un coût de traitement mais l'intervalle auquel
le worker interroge la queue. Pour les charges V3 réelles (transcription vocale + appel LLM = plusieurs
secondes), 0,5 s de latence de dispatch est négligeable. Si un jour un besoin sub-100 ms émerge, il
suffit d'abaisser `poll_delay` dans `WorkerSettings` — au prix d'un poll Redis plus fréquent. Défaut
conservé volontairement.

---

## 5. Zéro régression — preuve

| Contrôle | Attendu V2 | Résultat V3.1 |
|----------|-----------|---------------|
| pytest backend | 214 | **216** (214 V2 inchangés + 2 nouveaux : infra tâches) |
| flutter analyze | 0 issue | *(validé, voir note)* |
| flutter test | 68 | *(validé, voir note)* |
| build web | OK | *(validé, voir note)* |
| build apk | OK | *(validé, voir note)* |

- **Backend** : les 214 tests de la V2 passent sans modification. L'auth (migrée sous PyJWT) est
  couverte par les tests existants — la migration est transparente pour eux. Deux tests s'ajoutent
  ([`test_tasks.py`](../../backend/app/tests/test_tasks.py)) : la tâche démo renvoie bien sa charge, et
  un broker injoignable lève proprement `TaskQueueUnavailable` (pas de blocage).
- **Frontend** : **aucun fichier Flutter n'a été touché ce sprint.** analyze / test / build web / build
  apk sont rejoués pour le prouver formellement (résultats consignés à l'exécution du sprint).

> **Note d'exécution.** Le pipeline async a été prouvé **de bout en bout** dans le conteneur :
> `enqueue('demo_task')` → le worker traite → résultat correct récupéré. Ce n'est pas un test unitaire
> mocké, c'est le vrai chemin Redis + worker.

---

## 6. CI/CD

[`.github/workflows/ci.yml`](../../.github/workflows/ci.yml) exécute, à chaque push sur `main` / `v2` /
`develop/v3` et à chaque PR, exactement les contrôles locaux :

- **Job backend** : services `postgres:16-alpine` + `redis:7-alpine` (les vrais services — il n'existe
  pas de double de test, cf. README), `alembic upgrade head`, puis `pytest -q`.
- **Job frontend** : `flutter pub get` → `build_runner` → `analyze` → `test` → `build web --release`.

`concurrency` annule un run rendu obsolète par un push plus récent. L'APK reste une porte
locale/release (build Android lourd), documentée ici. Le workflow **ne déploie ni ne publie rien**.

---

## 7. Fichiers

**Nouveaux**
- `backend/app/redis_client.py` — client Redis async gracieux (singleton paresseux).
- `backend/app/tasks/__init__.py`, `worker.py`, `queue.py` — infra de tâches (worker settings, tâche
  démo, `enqueue`/`queue_depth`).
- `backend/app/core/security_headers.py` — middleware d'en-têtes de sécurité.
- `backend/app/tests/test_tasks.py` — tests de l'infra de tâches.
- `.github/workflows/ci.yml` — pipeline CI.
- `docs/v3/05_FONDATIONS_TECHNIQUES.md` — ce document.

**Modifiés (aucun changement de comportement métier V2)**
- `backend/requirements.txt` — `python-jose` retiré ; `PyJWT`, `redis`, `arq` ajoutés.
- `backend/app/auth/security.py` — migration PyJWT.
- `backend/app/core/config.py` — `REDIS_URL`, `RATE_LIMIT_BACKEND`.
- `backend/app/core/rate_limit.py` — backend Redis partagé + repli mémoire.
- `backend/app/schemas/common.py`, `app/api/endpoints/health.py` — `/health` étendu (redis + queue).
- `backend/app/main.py` — middleware d'en-têtes, câblage du backend de rate limit, fermeture propre du
  pool/redis au shutdown.
- `docker-compose.yml` — services `redis` et `worker`.
- `.env.example` — `REDIS_URL`, `RATE_LIMIT_BACKEND`.

---

## 8. Exploitation

- **Activer le rate limit partagé** : `RATE_LIMIT_BACKEND=redis` dans `.env`. Repli mémoire automatique
  si Redis tombe.
- **Scaler le traitement** : `docker compose up -d --scale worker=N`.
- **Reconstruire après changement de dépendances** : `docker compose build backend worker` (le worker
  partage l'image du backend).
- **Observer la queue** : `GET /health` → champ `queue_depth` (best-effort, `null` si Redis injoignable).

---

## 9. Prêt pour l'assistant vocal IA

Le sprint est terminé parce que ces briques suffisent à accueillir la voix → devis
(cf. [`03_IA_VOICE_TO_QUOTE.md`](03_IA_VOICE_TO_QUOTE.md)) sans nouvelle fondation :

1. **Exécution hors requête** — la transcription (STT) puis l'appel LLM prennent plusieurs secondes.
   Ils s'enfileront via `enqueue(...)` et tourneront sur le worker ; l'app rend un `job_id` immédiat.
2. **Suivi de job** — le client pourra sonder l'avancement (le `job_id` d'arq est déjà retourné par
   `enqueue`), et `/health` expose la profondeur de queue pour le monitoring.
3. **Dégradation gracieuse** — pas de Redis = fonctionnalité vocale indisponible avec une erreur claire,
   pas d'app cassée. Cohérent avec la promesse produit (le mock IA, le storage local).
4. **Sécurité** — l'endpoint vocal héritera des en-têtes de sécurité et du rate limit partagé.

**Ce sprint n'écrit volontairement aucun code métier vocal** : il pose le sol, pas les murs.

## 10. Suites (V3.2, hors périmètre)

- Conteneur « migrateur » dédié plutôt que migrations au démarrage de chaque service.
- Gestion de `X-Forwarded-For` au niveau reverse-proxy (rate limit derrière proxy).
- Politique de rétention des résultats de jobs (`keep_result`) selon les vrais usages V3.
