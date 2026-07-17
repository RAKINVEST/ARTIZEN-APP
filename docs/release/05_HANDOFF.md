# 05 — Rapport de continuité (HANDOFF)

**Écrit le 2026-07-17.** Destiné à quelqu'un qui reprend le projet sans
avoir vu la conversation qui a produit cet état — humain ou agent.

Lis d'abord `04_RELEASE_PACKAGE.md` (verdict et check-list), puis ceci.

## Où en est le projet, en trois phrases

Artizen est un SaaS de devis pour artisans du bâtiment (FastAPI + Flutter),
construit en 10 étapes documentées dans `README.md`. Un audit complet a
fermé **48 anomalies**, dont 9 bloquantes, et posé le tag `v1.0.0-rc1`.
**219 vérifications automatisées passent** ; il reste une réserve nommée
sur Docker et un trou de validation manuelle.

## La seule chose à faire en priorité

**Redémarrer Windows.** Le noyau WSL 2 a été installé pendant l'audit avec
`/norestart` ; Docker Desktop a fonctionné, puis s'est arrêté et ne
redémarre plus (`docker-desktop` retombe en `Stopped`). Après redémarrage :

```bash
docker compose up -d
docker compose exec backend pytest -q                    # attendu : 142 passed
python docs/release/evidence/docker_qa.py                # attendu : 32/32 passed
```

Cela régénère les preuves Docker manquantes et lève la réserve du
`04_RELEASE_PACKAGE.md`. **C'est du rejeu, pas du développement.**

## Comment relancer l'environnement (il n'est pas standard)

L'audit a dû reconstruire l'outillage. Ce qui a été installé, et où :

| Outil | Emplacement | Note |
|---|---|---|
| Flutter 3.44.6 | `C:\Users\Utilisateur\flutter` | Ajouté au **PATH utilisateur**. Dart 3.12.2 = contrainte exacte du `pubspec.yaml`. |
| PostgreSQL 16.4 | `%LOCALAPPDATA%\artizen-pg\pgsql` | Binaires ZIP, sans installateur. Données : `%LOCALAPPDATA%\artizen-pg\data`. |
| Python 3.13.7 | `%LOCALAPPDATA%\Programs\Python\Python313` | Était déjà présent. |
| venv de validation | scratchpad de session | **Éphémère — à recréer.** |
| MSI noyau WSL 2 | `~\Downloads\wsl_update_x64.msi` | Déjà installé (a exigé l'UAC). |

**Le venv de validation vit dans un dossier temporaire de session et
disparaîtra.** Pour le recréer :

```bash
"%LOCALAPPDATA%\Programs\Python\Python313\python.exe" -m venv .venv
.venv/Scripts/python.exe -m pip install -r backend/requirements.txt
```

Python 3.14 **ne convient pas** : `pydantic==2.10.4` n'a pas de wheel pour
3.14 et sa compilation exige Rust. C'est pour cela que 3.13 est utilisé.

**PostgreSQL local (mode sans Docker, documenté dans le README) :**

```bash
# démarrer en processus détaché (sinon il meurt avec le shell)
%LOCALAPPDATA%\artizen-pg\pgsql\bin\pg_ctl.exe -D %LOCALAPPDATA%\artizen-pg\data -o "-p 5432" start
```
Nécessite `backend/.env` avec `POSTGRES_HOST=localhost` et un
`STORAGE_LOCAL_ROOT` **en chemin Windows** (le `/data/storage` par défaut
n'existe pas hors conteneur). Ce fichier est gitignoré — à recréer depuis
`.env.example`.

⚠️ **Le port 5432 est partagé** entre le PostgreSQL local et celui de
Docker. Arrêter l'un avant de lancer l'autre.

## Les pièges qui ont coûté le plus cher

Ceux-là ont été payés une fois. Les connaître évite de les repayer.

1. **CRLF et `.gitattributes`.** `entrypoint.sh` doit rester en **LF**.
   Sans `.gitattributes`, `core.autocrlf=true` (défaut de Git for Windows)
   le réécrit en CRLF au checkout et le conteneur redémarre en boucle avec
   `$'\r': command not found`. **Invisible sur macOS/Linux.** Ne pas
   supprimer `.gitattributes`.
2. **Le conteneur n'a pas de directive `USER`, et c'est voulu.** Il démarre
   en root, répare l'appartenance du volume si nécessaire, puis bascule en
   `artizen` via `setpriv`. Ajouter `USER artizen` au Dockerfile
   casserait la réparation d'un volume préexistant — et l'échec serait
   silencieux : le conteneur se déclare `healthy` alors que tout upload
   échoue en `EACCES` (`/health` ne fait qu'un `SELECT 1`).
3. **`setpriv` ne transmet pas `HOME`.** L'entrypoint fait
   `export HOME=/home/artizen`. Sans ça, asyncpg cherche
   `/root/.postgresql/postgresql.key` et meurt en `PermissionError` — une
   erreur d'apparence TLS sans aucun rapport avec TLS.
4. **`QuoteService` a une méthode `list`**, qui masque le type natif dans
   le corps de la classe. Toute annotation `list[...]` déclarée *après*
   elle doit être **citée** (`"list[QuoteLine]"`), sinon `TypeError` à
   l'import et l'app entière ne démarre plus. `compileall` ne le voit pas.
5. **Le rate limiter casserait la suite de tests.** `conftest.py` pose
   `AUTH_RATE_LIMIT_ENABLED=false` **avant** d'importer `app.main` — le
   stack de middlewares est figé à la création de l'app, une fixture serait
   trop tard. Sans ce garde : **85 tests sur 95 échouent**. Le limiteur est
   couvert séparément par `test_rate_limit.py`, hors stack HTTP.
6. **`@JsonSerializable` sur une classe freezed génère un `fromJson` en
   double** et casse la compilation. Pour configurer la sérialisation d'un
   champ, utiliser `@JsonKey` **par champ** (+ `invalid_annotation_target:
   ignore` dans `analysis_options.yaml`, workaround documenté par freezed).
7. **`CatalogItem.active` est NOT NULL.** `CatalogItemInput.active` doit
   rester exclu de `includeIfNull` : sinon une édition ordinaire envoie
   `"active": null`, `exclude_unset` l'applique, et c'est un 500 sur
   **chaque** modification d'article.
8. **Git Bash convertit les chemins.** `docker run -v vol:/data/storage`
   devient `C:/Program Files/Git/data/storage`. Préfixer par
   `export MSYS_NO_PATHCONV=1`.

## Décisions prises pendant l'audit — et pourquoi

Elles ont été délibérées. Les revisiter est possible ; les ignorer serait
refaire le raisonnement pour rien.

| Décision | Raison |
|---|---|
| **Devis : suppression-recréation, pas édition** | Un `PUT` devrait recalculer tous les totaux via `QuoteCalculator`, qui n'a **aucune** entrée de recalcul pour un devis existant — et rien n'obligerait un futur appelant à le faire. `DELETE` repasse par `create`, seul endroit où un total est calculé. |
| **Ni numéro ni statut de devis** | C'est une *fonctionnalité*, et la consigne était de ne plus en ajouter. `DELETE` couvre le besoin qui bloquait (corriger une faute de frappe). |
| **Parsing IA laissé tout-ou-nien (502)** | Comportement intentionnel **et testé**. Le corriger proprement suppose de faire remonter les items malformés jusqu'à `SuggestionScorer`, sinon le score devient trop optimiste. Changement de comportement testé sur le chemin IA = risque > gain. |
| **Double pénalité des doublons non corrigée** | Mesuré : 0.40 au lieu de 0.85. Deux tests figent le comportement actuel (dont un avec des entrées incohérentes qui donnerait une division par zéro). Trancher est un **arbitrage produit**, pas une réduction de risque. |
| **`updateCompany`/`updateBrandProfile` conservés** | Ce n'est **pas** du code mort : le backend expose les routes, le README les documente, les tests les couvrent. Il manque un écran. Les supprimer retirerait au produit la capacité de renseigner sa raison sociale et son SIRET — décision produit. |
| **`storage.delete()` utilisé, pas supprimé** | Il était mort, mais son absence *causait* une fuite disque (chaque ré-upload de logo abandonnait l'ancien fichier). |
| **`HTTP_413_REQUEST_ENTITY_TOO_LARGE` laissé tel quel** | Déprécié par Starlette **≥ 1.x** seulement. Le projet épingle `fastapi==0.115.6` (starlette ~0.41), où la constante n'est pas dépréciée et où `HTTP_413_CONTENT_TOO_LARGE` **n'existe pas** : « corriger » casserait le build. À traiter avec la montée de FastAPI. |
| **Rien n'a été poussé sur `origin`** | Publier n'était pas demandé et n'est pas réversible. |

## Ce qui reste ouvert

**Aucune anomalie bloquante. Aucune majeure.** 10 mineures, toutes dans
`docs/AUDIT-V1.md` (section « Reste à faire »), plus les 10 recommandations
V2 classées par valeur dans `04_RELEASE_PACKAGE.md`.

**Les deux trous de validation, nommés :**

1. **Docker n'est pas rejouable aujourd'hui** (redémarrage Windows en
   attente). Les validations ont réussi ; leur trace est la console de
   session, pas un artefact.
2. **Personne n'a cliqué dans l'application contre un vrai backend.** Aucun
   test Flutter n'appelle le backend réel (fakes partout — limite
   documentée depuis l'origine). `flutter build web` compile. Ce trou ne se
   comble pas par automatisation ; il demande vingt minutes d'un humain
   dans un navigateur.

## Documents, par ordre de lecture

| Document | Ce qu'il contient |
|---|---|
| `docs/release/04_RELEASE_PACKAGE.md` | **Commencer ici.** Verdict, risques, check-list de production. |
| `docs/release/01_PROOF_OF_VALIDATION.md` | Preuves, avec ce qui manque explicitement. |
| `docs/release/02_GIT_STATE.md` | État Git, tag, pourquoi rien n'est poussé. |
| `docs/release/03_PROJECT_INVENTORY.md` | Chiffres mesurés, 42 routes, modules. |
| `docs/release/05_HANDOFF.md` | Ce document. |
| `docs/AUDIT-V1.md` | Le registre complet : chaque anomalie, sa cause racine, son correctif. |
| `CLAUDE.md` | Contrat produit et pièges, pour un agent. |
| `README.md` (1358 l.) | L'architecture, étape par étape, **avec ses justifications**. |
| `frontend/README.md` (667 l.) | Idem côté Flutter. |

**Documents absents, et volontairement non créés** : `CHANGELOG`,
`INSTALLATION`, `ROADMAP`, `API`, `ARCHITECTURE`, `DEPLOYMENT`. La consigne
était de vérifier la cohérence des documents, pas d'en inventer. Une
`ROADMAP` serait une décision produit ; un `CHANGELOG` sur un dépôt à deux
commits n'apporterait rien de plus que `git log`. L'architecture et l'API
sont couvertes par `README.md` et `03_PROJECT_INVENTORY.md`.

## Le principe qui a gouverné cet audit

Chaque affirmation est classée : **validée par tests**, **validée par
exécution**, **validée par analyse statique**, ou **raisonnée sans preuve**.
Ces catégories ne sont jamais mélangées.

Ce n'est pas une posture. L'audit a produit trois démonstrations que le
raisonnement ne remplace pas l'exécution :

- Un correctif déclaré « validé par analyse statique » **empêchait
  l'application entière de démarrer** (le shadowing de `list`) — trouvé par
  le premier `pytest`, jamais par `compileall`.
- Le rate limiter, correct en lecture, **aurait fait échouer 85 tests sur
  95** — mesuré, pas déduit.
- `docker compose up`, promis par le README comme « une seule commande »,
  **n'a jamais fonctionné sur un poste Windows**.

Si tu reprends ce projet : ne comble pas les trous par du raisonnement.
Exécute, ou dis que tu n'as pas pu.
