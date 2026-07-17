# Audit V1 — état réel, correctifs appliqués, reste à faire

Audit complet du backend, du pipeline documentaire et du client Flutter.
Ce document liste ce qui a été corrigé, comment chaque correctif a été
vérifié, et ce qui a été **volontairement** laissé de côté pour la V2.

## État au terme de l'audit

**Toutes les portes de validation ont été franchies, y compris Docker.**

L'environnement a été reconstruit intégralement : le noyau WSL 2 était
absent (`wsl --update` sortait en code 0 sans rien installer — les mises à
jour automatiques étaient bloquées par les paramètres Windows Update), il a
fallu télécharger et installer le MSI directement. Flutter 3.44.6
(Dart 3.12.2, exactement la contrainte du `pubspec.yaml`) et PostgreSQL 16.4
ont été installés sans droits administrateur.

| Porte | Résultat |
|---|---|
| `docker compose build` | ✅ |
| `docker compose up` / `down` / `restart` | ✅ |
| `pytest` **dans le conteneur** | ✅ **142 passed** |
| `pytest` en local (Python 3.13, deps épinglées) | ✅ **142 passed** |
| `flutter analyze` | ✅ **No issues found!** |
| `flutter test` | ✅ **53 passed** |
| QA fonctionnelle HTTP contre Docker | ✅ **32/32** |
| Casse volontaire | ✅ **24/24** |
| Scénarios de cycle de vie Docker | ✅ **14/14** |
| Rollback Alembic (`downgrade base` → `upgrade head`) | ✅ |

**Scénarios Docker réellement exercés** : installation neuve, redémarrage
du conteneur, `down`+`up` volumes conservés, reconstruction complète,
`down -v` (destruction), volume préexistant détenu par root, migrations
rejouées à vide (5) et idempotentes au 2ᵉ démarrage (0), `uvicorn` en PID 1
sous `uid 1000`, volume détenu par `artizen` et écrivable.

**Limitation connue de l'environnement, sans rapport avec l'application** :
Docker Desktop s'est arrêté spontanément à deux reprises sur cette
installation WSL 2 fraîche (la distribution `docker-desktop` passe en
`Stopped`, RAM non saturée). Toutes les validations ci-dessus étaient déjà
passées ; un `wsl --shutdown` puis un redémarrage de Docker Desktop le
remet en route. À surveiller sur les postes de développement Windows Home.

## Niveau de preuve — à lire avant tout le reste

Chaque affirmation de ce document relève d'une de ces catégories, jamais
mélangées :

| Niveau | Ce que ça veut dire | Portée ici |
|---|---|---|
| **Validée par tests** | Les suites du dépôt ont tourné contre un vrai PostgreSQL | `pytest` **142 passed** ; `flutter test` **53 passed** |
| **Validée par exécution** | Le vrai code exercé contre l'app réelle, hors suites | Tentative de casse : **24/24** ; ~70 cas ciblés (rate limiting, taille de corps, config, schémas, TVA, SIRET, octets d'upload) |
| **Validée par analyse statique** | `compileall`, `flutter analyze`, vérification des appelants | Backend compile ; `flutter analyze` : **No issues found!** |
| **Raisonnée, non exécutable ici** | Correct par raisonnement, jamais exécuté | Le passage du conteneur en non-root (réserve volume), et `docker compose up` |

Ce qui a **changé** depuis les premières passes : tout ce qui était
« raisonné » côté Python et Dart est désormais exécuté. Seul Docker
reste hors de portée.

## Ce qui reste non vérifié

- **`docker compose up`** — voir ci-dessus : noyau WSL 2 absent, Hyper-V
  indisponible sur Windows 11 Home. Le reste de la pile a été validé
  nativement, ce que le README prévoit explicitement.
- **Le parcours manuel bout en bout** (application web lancée contre le
  backend) : les tests couvrent modèles, notifiers, repositories et un
  smoke test d'écran, mais aucun test Flutter n'appelle le vrai backend.

## Correctifs appliqués

### Critiques

| Zone | Problème | Correctif |
|---|---|---|
| `quotes/schemas.py` | `quantity` non bornée face à une colonne `Numeric(10,2)` : le calculateur travaillait en précision pleine, PostgreSQL arrondissait la quantité stockée. `0.333 × 300,00` était persisté en `0.33 × 300,00 = 99,90` — une ligne injustifiable devant un client. Pire, `0.004` passait `gt=0` puis devenait `0.00` : une quantité nulle facturée 0,40 €. | `max_digits=10, decimal_places=2` → 422 au lieu d'une corruption silencieuse |
| `quote_assistant/service.py` | Le catalogue envoyé à l'IA héritait du `limit=100` de pagination du repository. Au-delà de 100 articles, l'artisan ne voyait jamais les siens dans le prompt : l'IA ne trouvait rien, sans erreur ni log. Le copilote paraissait mauvais alors qu'il était aveugle. | `limit` explicite à 1000 + `logger.warning` si le plafond est atteint |
| `catalog/presentation/item_form_screen.dart` | La virgule décimale d'un clavier français était normalisée **pour la validation** mais le texte **brut** était envoyé : `45,50` → champ vert → 422. Saisir un prix à décimales était impossible sur un téléphone FR. | `DecimalInput.normalize()` à l'envoi (+ `quote_form_screen`, `quote_assistant_screen`, qui n'avaient aucun validateur) |

### Majeurs

| Zone | Problème | Correctif |
|---|---|---|
| `users/schemas.py` | `password` non borné : au-delà de 4096 octets, passlib lève, mais **seulement si l'email existe** (court-circuit `or`) → 500 vs 401 = oracle d'énumération déterministe. Aggravé par l'absence totale de rate limiting. | `max_length=72` sur `UserRegister` et `UserLogin` (ferme aussi la troncature silencieuse bcrypt) |
| `catalog/schemas.py` | `vat_rate` sans borne haute : `500 %` accepté et envoyé au client final ; `1000` dépassait `Numeric(5,2)` → 500 brut | `ge=0, le=100` + `max_digits`/`decimal_places` alignés sur les colonnes |
| `clients/service.py` | Supprimer un client ayant des devis (`ondelete="RESTRICT"`) laissait remonter `IntegrityError` → **500**. `catalog/service.py` traduisait déjà ce cas en 409 ; le commentaire de `quotes/models.py` l'affirmait à tort pour les clients. | `try/except IntegrityError` → `ConflictError` (409) |
| `ai/providers/anthropic_provider.py` | Aucun timeout (défauts SDK : 10 min × 3 = **30 min** sur une requête synchrone) et aucune gestion d'erreur : 429/5xx/timeout → **500 brut** pour l'artisan | `timeout=30s`, et `APIError` traduite en `AIProviderUnavailableError` (503) via le nouveau `ai/exceptions.py` — le SDK reste confiné au provider |
| `ai/providers/mock_provider.py` | Regex glouton `\[.*\]` : toute description contenant `]` (« chauffe-eau [urgent] ») cassait l'extraction du catalogue → « aucune correspondance », en silence. Le mode démo est le **seul** mode sans clé API. | `json.JSONDecoder().raw_decode()` — borne exactement le tableau, gère les crochets dans les chaînes |
| `document_detection/vat_detector.py` | `\b([A-Z]{2})([0-9A-Z]{6,10})\b` n'exigeait aucun chiffre : `DESIGNATION` = DE + SIGNATION. Or c'est l'en-tête de colonne de quasiment tout devis français → faux positif quasi systématique, validable dans `Company.vat_number`. | Plancher de 6 chiffres dans le corps ; borne élargie à 12 pour les formats longs (NL) |
| `document_detection/{logo,color}_detector.py` | Bombe PDF : 1,85 Mo → image 121 Mpx → ~350 Mo de RSS, **décodée deux fois**, sur l'event loop. Le garde Pillow n'émet qu'un *warning* sous 2× la limite — invisible pour `except Exception`. | `image_limits.py` : `MAX_IMAGE_PIXELS = 40 Mpx` + warning transformé en erreur ; `page.images[0]` au lieu de `list(page.images)` |
| `utils/upload_validation.py` | Seul le `Content-Type` **déclaré par le client** était vérifié : n'importe quoi passait en « application/pdf » | Vérification des octets (`%PDF-` dans les 1024 premiers — tolérance des lecteurs réels ; signatures strictes PNG/JPEG) |
| `quote_assistant/schemas.py` | `description` sans `max_length` (prompt de plusieurs Mo facturé) ; `items` sans borne (amplification N+1) ; `quantity` sans borne haute | `max_length=5000` / `max_length=50` / `max_digits=10` |
| `branding/service.py` | `profile.logo_path = stored.key` écrasait la référence **sans supprimer l'ancien fichier** : chaque ré-upload de logo abandonnait jusqu'à 5 Mo dans un volume sans purge. `StorageProvider.delete()` n'avait aucun appelant. | L'ancien fichier est supprimé après le flush ; un échec est journalisé sans faire échouer la requête de l'artisan |
| `core/logging.py` | `setup_logging` ne fixait que `sqlalchemy.engine` : avec `LOG_LEVEL=DEBUG`, les loggers `anthropic`/`httpx` propagent vers le root et peuvent émettre l'en-tête `x-api-key` | Ces trois loggers épinglés à `WARNING` |
| `document_detection/service.py` | Cache jamais invalidé : `POST /process` est rejouable sans garde d'état, mais `get_or_run` renvoyait éternellement l'ancien résultat, incohérent avec la nouvelle analyse | Comparaison `detection.created_at` / `analysis.updated_at` (le sens des dépendances interdit d'invalider depuis `document_analysis`) ; ligne rafraîchie sur place |
| `document_detection/service.py` | Race SELECT-puis-INSERT sur une contrainte `unique` : deux `GET /detection` concurrents → `IntegrityError` → **500**. Déclenché par le front, qui lance preview et detection ensemble. | `IntegrityError` capturée → relecture de la ligne gagnante |
| `quotes/repository.py` + `service.py` | N+1 sur la liste des devis : 100 devis = 101 requêtes, sur l'écran d'accueil | `list_by_quote_ids()` — une seule requête groupée |

### Bloquantes fermées (2ᵉ passe)

| Anomalie | Correctif | Vérification |
|---|---|---|
| **Aucun rate limiting** sur `/auth/*` : base d'utilisateurs entièrement énumérable, `login` brute-forçable | `core/rate_limit.py` — compteur à fenêtre glissante par IP sur `login`/`register` uniquement, 429 + `Retry-After`, éviction des clés inactives. Sans nouvelle dépendance. Réglable via `AUTH_RATE_LIMIT_*` | **7 tests exécutés, tous verts** (`test_rate_limit.py`, sans base) |
| **Corps de requête non borné avant parsing** : 2 Go écrits sur disque avant le 413 | `core/body_size_limit.py` — middleware ASGI pur sur `Content-Length`, monté en premier | **Exécuté** : 413 rendu et l'application ne parse jamais le corps |
| **Pipeline pypdf synchrone** : ~2 s d'event loop gelé pour tous | `asyncio.to_thread` sur `PDFRenderer`, `TextExtractor`, `LogoDetector`, `ColorDetector` + plafond `MAX_PAGES = 2000` | Statique uniquement |
| **`SECRET_KEY` placeholder / `DEBUG` en production** | Validateurs `config.py` : refus de démarrer en production sur un secret d'exemple, trop court, ou avec `DEBUG=true`. Dev et staging inchangés | **Exécuté** : 7 cas, dont l'ordre des champs dont dépendent les validateurs |
| **Conteneur root + `--reload` en production** | `Dockerfile` : utilisateur `artizen` non-root, CMD de production (`--workers 4`). `docker-compose.yml` surcharge avec `--reload` pour le dev | Statique uniquement — **voir la réserve volume ci-dessous** |

**⚠ Réserve sur le passage non-root.** Docker n'applique l'appartenance du
répertoire de l'image à un volume nommé qu'à son initialisation **à vide**.
Un `artizen_storage_data` déjà existant reste root et fera échouer les
uploads en `EACCES`. Sur une installation existante : `docker compose down -v`
(détruit les fichiers) ou un `chown` unique — la commande est dans
`docker-compose.yml`. **Non vérifiable sans Docker.**

**⚠ Régression évitée de justesse.** Le rate limiter aurait fait échouer
**85 des 95 tests** : `conftest` enregistre un compte par test, depuis une
seule adresse — exactement le trafic que le limiteur refuse. Mesuré, pas
supposé. D'où `AUTH_RATE_LIMIT_ENABLED=false` posé dans `conftest` avant
l'import de `app.main` (le stack de middlewares est figé à la création de
l'app : une fixture serait trop tard), et une suite dédiée qui couvre le
limiteur hors du stack HTTP.

### Fermées (3ᵉ passe)

| # | Anomalie | Correctif |
|---|---|---|
| 🔴 B6a | **Un devis n'était pas supprimable** : ni `PUT`, ni `PATCH`, ni `DELETE`. Une faute de frappe était définitive, et le seul recours de l'artisan était un second devis à côté du mauvais. | `DELETE /quotes/{id}` — suppression franche (les lignes cascadent, l'article de catalogue est protégé par RESTRICT), avec `ensure_same_company`. **Suppression-recréation plutôt qu'édition**, délibérément : la recréation repasse par `create`, seul endroit où un total est calculé. 4 tests ajoutés, dont l'isolation inter-entreprises. |
| 🟠 M4a | **`category_id` jamais vérifié contre le tenant** (create *et* update). Un item pouvait être rattaché à la catégorie d'une autre entreprise, laquelle — `category_id` étant RESTRICT — ne pouvait alors plus jamais supprimer sa propre catégorie : un 409 permanent, inexplicable pour la victime. | `_ensure_category_belongs_to()` sur les deux chemins. 3 tests, dont un vérifiant que le déplacement **légitime** d'un article entre ses propres catégories fonctionne toujours. |
| 🟠 M4b | **`document_template_id` accepté du client sans contrôle de tenant.** | **Paramètre supprimé.** Personne ne l'envoyait (vérifié : zéro appelant frontend) et le seul écrivain légitime est `TemplateImportService`, côté serveur : c'était de la surface d'attaque pure. Le valider aurait forcé `document_analysis` à lire les tables de `branding` — dépendance inter-modules que l'architecture interdit. |
| 🟠 M11 | **Canal temporel au login** : le court-circuit `user is None or ...` fait que bcrypt n'est jamais exécuté pour un email inconnu → écart de latence mesurable, qui défait le message volontairement uniforme. | `spend_dummy_verify()` — même travail sur les deux chemins. |
| 🟠 M10 | **Énumération au register** (409 vs 201). | Atténuée par le rate limiting (B1) : l'oracle demeure, mais 10 essais/min le rendent impraticable à l'échelle. Le supprimer vraiment (register asynchrone par email) est un changement de parcours produit → V2. |

### Audit de dérive migrations ↔ modèles — RÉSULTAT PROPRE

Angle jamais audité jusqu'ici, et qui pouvait casser le démarrage
(`entrypoint.sh` fait `alembic upgrade head`). Les 11 tables ont été
comparées colonne par colonne aux 5 migrations. **Aucune dérive.**
Vérifié : présence des colonnes (1:1 dans les deux sens, aucun résidu),
les **12 déclarations `Numeric`** (`Numeric(10,2)` sur tous les montants,
`Numeric(5,2)` sur `vat_rate` — identiques des deux côtés), la
nullabilité, **tous les `ondelete`** (CASCADE / RESTRICT / SET NULL), les
contraintes `unique` et index, les **4 types ENUM** valeur par valeur, les
`server_default`, la chaîne des révisions (linéaire, une seule tête, pas de
cycle), et l'enregistrement des 7 modules de modèles.
*Analyse statique uniquement* — `alembic check` exige une base.

### Fermée — rollback impossible

| # | Anomalie | Correctif |
|---|---|---|
| 🟠 | **Les `downgrade()` ne suppriment jamais les types ENUM.** En PostgreSQL, `DROP TABLE` ne supprime pas un type créé par `CREATE TYPE`. Un `downgrade` puis `upgrade` échouait donc sur `type "document_template_type" already exists` : **aucun rollback n'était possible**, ce qui compte le jour d'un déploiement raté. Sans effet sur le démarrage normal, qui ne va jamais qu'en avant. | `sa.Enum(name=...).drop(op.get_bind(), checkfirst=True)` ajouté aux 3 `downgrade()` concernés, pour les 4 types. **Vérifié statiquement** : les 4 noms créés correspondent exactement aux 4 supprimés, `sa` est importé dans les 3 fichiers, tout compile. Modifier des migrations déjà écrites est acceptable ici parce qu'aucun déploiement n'existe : rien n'a jamais été appliqué ailleurs qu'en local. |

**Signalé, non corrigé** — un nom de contrainte dépasse la limite des
63 octets de PostgreSQL :
`fk_document_detection_results_document_analysis_id_document_analyses`
(68 caractères). **Ce n'est pas une dérive** : SQLAlchemy tronque
silencieusement et de façon identique des deux côtés (`conv()` /
`op.f()`), la contrainte existe donc bien en base sous un nom raccourci.
À savoir uniquement si quelqu'un écrit un jour un `op.drop_constraint()`
avec le nom complet **en chaîne littérale** : il lèverait alors une
`IdentifierError`, les chaînes brutes n'étant pas tronquées.

### Fermées (4ᵉ passe — mineures backend)

| # | Anomalie | Correctif |
|---|---|---|
| 🟡 m8 | **Faux positif SIRET** : `_BARE_PATTERN` acceptait n'importe quelle suite de 14 chiffres, et le Luhn ne modulait que la confiance sans jamais conditionner `detected`. `"Facture N 20240101120000"` — un horodatage — était publié comme SIRET. | Le Luhn devient **obligatoire** sur le repli non étiqueté ; un SIRET *étiqueté* reste accepté même si le Luhn échoue (le mot « SIRET » est une preuve forte : un checksum faux à côté est plutôt une coquille ou un ratage d'OCR). `finditer` au lieu de `search` : une date précédant le vrai SIRET ne le masque plus. **Validé par exécution** (10 cas) + 5 tests ajoutés. |
| 🟡 m6 | **Fichier de 0 octet accepté**, stocké, puis `FAILED`. | **Déjà fermée** par la vérification des octets (`%PDF-` absent d'un fichier vide → 415). **Confirmé par exécution**, aucun code ajouté. |

**Non traitées, délibérément :**

- **`get_ai_provider` crée 3 instances de cache** (`get_ai_provider()`,
  `(None)`, `("anthropic")` sont trois clés `lru_cache` distinctes). Sans
  effet en production : un seul appelant, sans argument. Le paramètre est
  utilisé par 4 tests — le retirer les casserait pour zéro gain réel.
- **Déduplication par hash absente** : `file_hash` est calculé et indexé
  mais jamais relu. Assumé et documenté dans `hashing.py`.

### Tests ajoutés

Tous **purs** (ni base ni HTTP), donc exécutables dès que pytest tourne :
faux positifs TVA (paramétré) et vrais numéros EU ; bornes de `quantity`
(scénarios `0.333` / `0.004` / débordement) ; bornes de `vat_rate` (taux
légaux FR acceptés, impossibles rejetés) ; devis sans ligne ; upload
non-PDF rejeté vs PDF réellement tronqué qui échoue au `/process`.

## Nettoyage et documentation

- **Code mort supprimé :** `ItemsNotifier.setActiveOnly` (aucun appelant, et
  redondant — `_activeOnly` valait déjà `false`, donc rien n'était filtré).
  `_activeOnly` devient une constante documentée, ce qui évite au passage
  un `prefer_final_fields`.
- **Code mort *conservé*, délibérément :** `StorageProvider.delete()` est
  désormais **appelé** (voir la fuite de logos) plutôt que supprimé ; les
  providers `OpenAI`/`Mistral` non implémentés font partie de l'abstraction
  documentée et sont couverts par `test_ai_factory` ; le chemin d'édition
  du branding est une fonctionnalité inachevée, pas un déchet (item 10).
- **Commentaires faux corrigés** — ils sont plus nuisibles qu'absents,
  parce qu'ils sont crus :
  - `auth_interceptor.dart` affirmait *« No backend route checks it yet »*
    et parlait d'un JWT *« simulated »*. Les deux sont faux depuis
    l'étape 10 ; un lecteur en concluait que l'auth était un mock.
  - `current_company_provider.dart` affirmait *« Le backend n'a pas encore
    d'auth multi-tenant »*.
  - `auth_token_storage.dart` : *« once real authentication exists »*, et
    aucune mention du fait que « Secure » ne tient **pas** sur le web
    (localStorage, donc lisible par tout XSS).
  - `aggregator.py` affirmait *« nothing here re-fetches or re-parses the
    PDF more than once per detector category »* — factuellement faux, logo
    et couleurs le re-parsent chacun.
  - `quotes/models.py` affirmait une traduction 409 côté clients qui
    n'existait pas (c'est ce qui produisait le 500).
  - `upload_validation.py` affirmait qu'un fichier surdimensionné était
    rejeté *« au lieu d'être entièrement bufferisé »* — Starlette l'a déjà
    bufferisé avant que la fonction ne s'exécute.
  - `README.md` : « Auth : JWT (utilitaires prêts, endpoints à venir) »
    alors que l'étape 10 les a livrés ; et le contrat « l'IA n'invente
    rien », désormais énoncé avec sa nuance exacte (les *quantités* sont
    bien inférées).
- **Prompt renforcé :** consigne explicite de quantités à 2 décimales
  maximum, pour aligner la sortie de l'IA sur ce que la colonne accepte.

## Changement de comportement assumé

`test_invalid_pdf_handling` a été **remplacé** par deux tests. L'ancien
affirmait qu'un contenu arbitraire déclaré `application/pdf` devait être
accepté (201) et n'échouer qu'au `/process`. Ce n'est plus vrai : la
vérification des octets le rejette en 415. Le chemin de dégradation
gracieuse reste couvert par un PDF réellement tronqué (bonne signature,
structure cassée).

### Fermées (6ᵉ passe — Docker, une fois le noyau WSL installé)

| # | Anomalie | Correctif | Preuve |
|---|---|---|---|
| 🔴 | **`docker compose up` ne fonctionnait sur aucun poste Windows.** `entrypoint.sh` arrivait en **CRLF** : Git le stocke en LF, mais `core.autocrlf=true` (le défaut de Git for Windows) le réécrit au checkout, et bash dans le conteneur lit le `` comme partie de chaque commande → `$'': command not found`, redémarrage en boucle. Aucun `.gitattributes` ne protégeait le fichier. Invisible sur macOS/Linux — d'où sa survie. La commande unique promise par le README ne marchait pas. | `.gitattributes` avec `*.sh text eol=lf` (+ Dockerfile, compose), qui l'emporte sur la config Git de chacun. Arbre de travail renormalisé. | `docker compose up` → healthy |
| 🔴 | **Volume préexistant détenu par root → tous les uploads en `EACCES`.** Docker n'applique l'appartenance de l'image qu'à un volume créé **à vide** : un volume issu d'une version antérieure (conteneur root) restait root. Pire, **le conteneur se déclarait `healthy`** — `/health` ne fait qu'un `SELECT 1` et ne touche jamais au stockage. Rien ne semblait cassé jusqu'au premier logo envoyé par un artisan. | `entrypoint.sh` démarre en root, corrige l'appartenance **seulement si elle est fausse**, puis abandonne ses privilèges via `setpriv` et se ré-exécute en `artizen`. `USER` retiré du Dockerfile : la bascule doit suivre la réparation. Aucune action manuelle. | Scénario reproduit puis rejoué : volume root → auto-réparé, `WRITE OK` |
| 🟠 | **`setpriv` ne réinitialise pas `HOME`** (introduite par le correctif ci-dessus) : le processus `artizen` héritait de `HOME=/root`, et asyncpg cherche `~/.postgresql/postgresql.key` à chaque connexion → `PermissionError` sur `/root/.postgresql`, redémarrage en boucle avec une erreur d'apparence TLS sans rapport avec TLS. | `export HOME=/home/artizen` avant la bascule. | stack healthy, 142 pytest dans le conteneur |
| 🟡 | **Documentation fausse** : `README.md` et `frontend/README.md` affirmaient que `docker-compose.yml` fixe `CORS_ORIGINS`. Il ne le fait pas — la valeur vient de `.env` via `env_file`. J'avais propagé l'erreur dans `CLAUDE.md`. | Les trois corrigés. | `printenv CORS_ORIGINS` dans le conteneur |

**Vérifié à l'exécution, pour la première fois : le rollback Alembic.**
Le correctif ENUM des `downgrade()` avait été écrit sans base de données.
Confirmé : 4 types ENUM avant, `downgrade base` → **0 type restant**,
puis `upgrade head` réussit (il échouait auparavant sur
`type "document_template_type" already exists`) et restaure les 12 tables.

### Fermées (5ᵉ passe — majeures frontend, une fois Flutter disponible)

| # | Anomalie | Correctif | Preuve |
|---|---|---|---|
| 🔴 régression | **Introduite par moi** : `QuoteService` définit une méthode `list`, qui masque le type natif dans le corps de la classe. Mon `_to_read`, ajouté *après* elle, faisait `list[QuoteLine]` → `TypeError` à l'import. **L'app entière ne démarrait plus.** `compileall` ne pouvait pas le voir : c'est une erreur d'évaluation du corps de classe, pas de syntaxe. | Annotation citée (`"list[QuoteLine]"`) + commentaire expliquant le piège | pytest |
| 🟠 M1 | **Vider un champ optionnel était impossible.** `include_if_null: false` (global) supprimait les nulls du `toJson`, le backend voyait la clé absente et ne touchait à rien : l'artisan effaçait un email erroné, il revenait. Le commentaire de `build.yaml` justifiait ce réglage par les « mises à jour partielles » — mais `ClientInput` est un **instantané complet du formulaire**, pas une mise à jour partielle : « champ non touché » n'existe pas ici. | `@JsonKey(includeIfNull: true)` sur chaque champ nullable de `ClientInput` et `CatalogItemInput`. Par champ et non au niveau classe : un `@JsonSerializable` sur une classe freezed génère un second `fromJson` et entre en collision. | `flutter test` |
| 🟠 M2 | **Un article désactivé ne pouvait jamais être réactivé.** Le backend l'a toujours permis ; le client n'envoyait jamais `active`, et `ItemTile` n'affichait aucune action sur un article inactif — porte à sens unique. | `reactivateItem()` (repository + notifier + bouton « Réactiver »), corps `{"active": true}` seul pour ne rien écraser d'autre. **`active` reste exclu de `includeIfNull`** : la colonne est NOT NULL, un null l'aurait mise à NULL → 500 sur toute édition d'article. | `flutter test` (3 tests) |
| 🟠 M3 | **Compteurs du dashboard faux au-delà de 100** : ils comptaient la longueur de listes paginées. 250 clients → « 100 », définitivement. Un chiffre métier faux calculé côté client, contraire au contrat. | `ApproximateCount` : une page pleine s'affiche « 100+ », qui est vrai, là où « 100 » ne l'était pas. Un vrai endpoint de comptage reste la réponse V2. | `flutter test` (3 tests) |
| 🟠 M8 | **Écrans sans « Réessayer »** : une erreur réseau à l'ouverture d'une fiche donnait un écran mort, sans autre issue que le retour. | `onRetry` câblé sur les 4 `AsyncValueView` concernés. | `flutter analyze` |

### Reclassée

- **L'aller-retour `company_id` mort** (un `GET /branding/profile` par écran
  pour une valeur que chaque route backend écrase) passe de 🟠 à 🟡 : c'est
  une **optimisation**, pas un comportement incorrect. Je l'avais
  sur-classée. Le supprimer touche les 7 repositories — V2.

## Reste à faire — documenté, non implémenté

Volontairement écarté : le risque de régression dépasse le gain, et rien
de tout cela ne peut être validé sans pytest.

**🔴 Bloquantes : aucune ouverte.**

**Fonctionnalités V2 — documentées, volontairement hors V1** (« ne plus
ajouter de fonctionnalités ; éliminer ce qui empêche l'usage
professionnel ») :

1. **Cycle de vie du devis : numéro + statut.** Un devis n'est identifiable
   que par un UUID, et n'a pas d'état (brouillon / envoyé / accepté).
   `DELETE /quotes/{id}` couvre désormais le besoin qui *bloquait* —
   corriger une erreur — par suppression et recréation ; le reste est une
   fonctionnalité.
   **À traiter avant d'ouvrir la moindre route de modification** :
   l'absence de chemin d'écriture est aujourd'hui la seule chose qui
   garantisse la cohérence des totaux persistés. Rien n'obligera un futur
   `PUT /quotes/{id}` à repasser par `QuoteCalculator`, qui n'a d'ailleurs
   aucune fonction de recalcul sur un devis existant. Ajouter `status`
   (seul un `draft` modifiable), puis un `quote_number` **unique par
   entreprise garanti en base** (jamais un `SELECT MAX+1` applicatif, qui
   créerait la race). La numérotation séquentielle sans trou est une
   obligation légale pour les *factures* (art. 242 nonies A CGI), pas pour
   les devis — mais elle le deviendra dès que ces devis se transformeront
   en factures.

2. **Le scorer pénalise les doublons deux fois.** `total_count` inclut les
   doublons, qui écrasent donc déjà `validity_ratio` (ils sont rejetés,
   donc absents de `valid_count`), **puis** subissent `_DUPLICATE_PENALTY`.
   Mesuré : un article proposé deux fois avec `raw=0.9` donne **0.40** au
   lieu de 0.85 — soit −56 % pour une déduplication cosmétique, alors que
   l'article retenu est parfaitement valide.
   Correctif : diviser par `total_count - duplicate_count` (les proposals
   *distincts*), la pénalité restant alors le seul coût du doublon.
   **Non traité délibérément** : deux tests existants figent le
   comportement actuel (dont un avec des entrées incohérentes —
   `total=1, valid=1, duplicate=1` — qui donnerait une division par zéro
   avec la nouvelle formule), et la pénalité double est documentée comme
   intentionnelle (étape 9). Trancher entre 0.40 et 0.85 est un arbitrage
   produit sur le score de confiance, pas une réduction de risque.

3. **Parsing IA tolérant aux réponses partielles.** Un seul article
   malformé fait perdre toute la réponse (502), ce qui contredit l'esprit
   de `MatchValidator` (« une réponse partiellement bonne doit surfacer ce
   qui est valide »). **Non traité délibérément** : ce 502 est un
   comportement intentionnel et couvert par un test existant
   (`test_quote_assistant.py`), et le corriger proprement suppose de faire
   remonter les articles malformés jusqu'à `SuggestionScorer` — sinon
   `total_count` rétrécit et le score devient trop optimiste. Changer un
   comportement testé sur le chemin IA, avec un effet de bord sur le score
   de confiance, sans pouvoir exécuter les tests IA, serait précisément le
   risque que cet audit cherche à réduire.

**Piège pour la future montée de version de FastAPI** (constaté, mais **pas
sur les versions du projet** — à ne pas corriger aujourd'hui) :

`core/exceptions.py:72` utilise `status.HTTP_413_REQUEST_ENTITY_TOO_LARGE`,
que Starlette **≥ 1.x** déprécie au profit de `HTTP_413_CONTENT_TOO_LARGE`.
Observé en exécutant du code du dépôt sous starlette 1.3.1 / fastapi 0.139.2
— alors que `requirements.txt` épingle `fastapi==0.115.6` (starlette ~0.41),
où la constante n'est **pas** dépréciée. Aucune alerte aujourd'hui.
**Ne pas « corriger » maintenant** : `HTTP_413_CONTENT_TOO_LARGE` n'existe
pas dans la starlette épinglée, le changement casserait le build. À traiter
en même temps que la montée de FastAPI. Idem pour
`HTTP_422_UNPROCESSABLE_ENTITY` (`:108`).

**Dette produit :**

6. **Un devis n'a ni numéro ni statut, et n'est ni modifiable ni
   supprimable.** Une faute de frappe est définitive. L'absence de route
   d'écriture est ce qui garantit aujourd'hui la cohérence des totaux —
   garantie fragile : le jour où un `PUT /quotes/{id}` arrive, rien
   n'oblige à repasser par `QuoteCalculator`. Ajouter `status` **avant**
   toute route d'écriture, et un `quote_number` unique **par entreprise**
   garanti en base (jamais un `SELECT MAX+1` applicatif).
7. **Vider un champ optionnel est impossible côté Flutter**
   (`include_if_null: false` + `exclude_unset=True` : « non touché » et
   « vidé » deviennent indistinguables). L'artisan efface un email erroné,
   il revient. Correctif = régénération Freezed, impossible sans le SDK.
8. **Un article désactivé ne peut pas être réactivé.** Nuance importante
   par rapport au premier constat : l'article **reste visible** dans le
   catalogue, grisé et marqué « · désactivé » (`ItemTile`) — `_activeOnly`
   vaut `false`, donc rien n'est masqué. Ce qui manque est le champ
   `active` dans `CatalogItemInput`, donc un `build_runner` — impossible
   sans le SDK Flutter.
9. **Compteurs du dashboard faux au-delà de 100** : ils comptent la
   longueur de listes plafonnées côté backend. 250 clients → « 100 ».
   C'est un chiffre métier calculé côté client — contraire au contrat.
   Demande un vrai endpoint de comptage.
10. **Le chemin d'édition du branding existe sans écran.**
    `updateCompany`/`updateBrandProfile` sont implémentés, testés, et
    correspondent à de vraies routes (`PUT /branding/company`,
    `PUT /branding/brand`), mais aucun écran ne les appelle —
    `settings_screen` n'édite rien. **Volontairement non supprimé** : ce
    n'est pas du code mort, c'est une fonctionnalité inachevée. La retirer
    ôterait au produit la possibilité de renseigner sa raison sociale et
    son SIRET. À finir (un écran) ou à retirer sciemment.
11. **`category_id` / `document_template_id` non vérifiés contre le tenant.**
    Non exploitable de l'extérieur (aucune route ne divulgue les UUID
    d'une autre entreprise), mais c'est une brèche réelle du contrat.
12. **Un aller-retour HTTP mort par écran.** `currentCompanyIdProvider`
    appelle `GET /branding/profile` pour un `company_id` que **chaque
    route backend écrase** avec celui du JWT, et que `POST /auth/login`
    renvoie déjà gratuitement dans `user.company_id`. Le retirer touche
    les 7 repositories.
13. **7 features sur 7 importent Dio directement**, contrairement au
    contrat « `core/api/` est la seule couche qui connaît Dio ».
14. **Parsing IA tout-ou-rien** : un seul article malformé fait perdre
    toute la réponse (502), ce qui contredit l'esprit de `MatchValidator`
    (« une réponse partiellement bonne doit surfacer ce qui est valide »).
15. **Logo et couleurs décodent deux fois la même image** (deux `PdfReader`
    distincts). Plus dangereux depuis qu'`image_limits` borne le décodage,
    mais toujours du gaspillage à mutualiser.
16. **Écrans sans bouton « Réessayer »** (`client_form_screen`,
    `item_form_screen`, `quote_form_screen`) : une erreur réseau à
    l'ouverture donne un écran mort, sans autre issue que le retour.
