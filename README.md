# Artizen

> **Bêta privée / déploiement** — ARTIZEN se déploie sur un domaine public via Docker + reverse-proxy
> HTTPS. Guides : [docs/GUIDE-DEPLOIEMENT-PRODUCTION.md](docs/GUIDE-DEPLOIEMENT-PRODUCTION.md) (pas à pas),
> [docs/DEPLOIEMENT.md](docs/DEPLOIEMENT.md), kit de bêta dans [docs/beta/](docs/beta/). L'URL de l'API
> Flutter est centralisée dans `frontend/lib/core/api/api_config.dart` (défaut prod
> `https://artizenapp.com/api`, override dev via `--dart-define=API_BASE_URL=…`). ⚠️ Le reverse-proxy
> doit **préserver** le préfixe `/api` (voir le guide) — pas de `rewrite` qui le retire.

Artizen est le copilote IA des artisans (plombiers, chauffagistes,
électriciens, climaticiens, ...). Ce dépôt contient les **fondations
techniques** du SaaS (Étape 1), le module **branding** (Étape 2 :
identité graphique de l'entreprise, préservée plutôt qu'imposée par un
gabarit générique), le module **document_analysis** (Étape 3 : pipeline
local et déterministe qui prépare l'analyse d'un devis/facture importé —
hash, métadonnées, texte, structure normalisée), et le module
**document_detection** (Étape 4 : analyse lisible d'un devis/facture
importé — "✔ Logo détecté", "✔ SIRET détecté", ... — par heuristiques
locales), et le cœur métier du produit (Étape 5) : **catalog**
(le catalogue de prestations/fournitures propre à chaque artisan),
**clients** (carnet de clients), et **quotes** (moteur de devis). À
partir de cette étape, un artisan peut créer son catalogue, ses clients,
et un devis dont les montants (HT, TVA, TTC) sont calculés de façon
entièrement déterministe — jamais par une IA, qui ne fera plus tard que
*sélectionner* des lignes de catalogue existantes, jamais inventer un
prix. L'**Étape 6** ajoute le premier client **Flutter** (`frontend/`) :
un artisan peut désormais ouvrir une vraie application, gérer ses
clients et son catalogue, créer un devis, et voir les montants HT/TVA/TTC
tels que calculés par le backend — Flutter n'effectue lui-même aucun
calcul financier. Voir [frontend/README.md](frontend/README.md) pour le
détail de son architecture. L'**Étape 7** ajoute la première
fonctionnalité IA du produit : **quote_assistant** transforme une
description libre ("Remplacement d'un chauffe-eau Atlantic 200 litres
avec groupe de sécurité et deux heures de main-d'œuvre") en une
proposition de lignes de devis, en ne faisant jamais que *sélectionner*
des articles déjà existants du catalogue de l'entreprise — l'IA ne
choisit **aucun prix, aucune TVA, aucun montant**, et ne crée jamais rien
en base ; `QuoteCalculator` reste le seul endroit où un montant est
calculé, et la création du devis reste un choix explicite de
l'utilisateur via l'écran "Assistant IA". Une nuance, à énoncer plutôt
qu'à laisser croire : la *quantité* proposée, elle, est bien inférée par
l'IA à partir de la description — c'est la seule valeur numérique qu'elle
produise. Elle est bornée par le schéma, relue par l'artisan, et ne
devient une ligne de devis que s'il la valide ; mais « l'IA n'invente
rien » serait faux si on l'étendait aux quantités.
L'**Étape 8** ajoute **template_import** : un artisan peut importer un
ancien devis PDF, qu'Artizen analyse (pipeline `document_analysis` +
heuristiques `document_detection`, réutilisés tels quels) pour proposer
automatiquement une configuration de son identité (raison sociale,
SIRET, TVA, coordonnées, couleurs) et enregistrer le PDF importé comme
le nouveau modèle de devis actif de l'entreprise — après relecture et
validation explicite de l'artisan, jamais appliqué automatiquement sans
confirmation. Aucune nouvelle table, aucune nouvelle logique
d'extraction : ce module orchestre uniquement des capacités déjà
construites aux étapes 2 à 4. L'**Étape 9** complète **quote_assistant**
(introduit à l'étape 7) pour en faire le cœur du produit : le prompt
tient désormais compte du contexte de l'entreprise et de la fréquence
d'utilisation réelle de chaque article, le score de confiance distingue
et pénalise les réponses ambiguës (articles proposés en double), chaque
rejet est journalisé avec sa raison précise, et l'écran Flutter
("Copilote IA") permet en plus d'ajouter une ligne manuellement et
distingue visuellement confiance faible/modérée/forte — toujours sans
qu'aucun prix, aucune TVA ni aucun devis ne soit jamais généré par l'IA.

L'**Étape 10** remplace l'entreprise unique implicite par une
authentification réelle et un multi-tenant complet : un nouveau module
**users** (`app/users/`) fournit l'inscription, la connexion et un JWT
réel (`POST /auth/register`, `POST /auth/login`, `GET /auth/me`), et
chacun des huit modules métier existants est retrofité pour dériver
systématiquement `company_id` de l'utilisateur authentifié plutôt que de
faire confiance à une valeur envoyée par le client — jamais un gros
refactoring, toujours le même patron minimal (`ensure_same_company` +
`CurrentUserDep.company_id`) appliqué module par module. Le client
Flutter passe du login simulé (Étape 6) à une vraie inscription/connexion
contre le backend, avec persistance du JWT réel.

Les futurs modules métier (factures, planning, photos, notifications,
paiements, statistiques) s'ajouteront selon le même patron vertical
décrit plus bas.

## Stack technique

| Domaine        | Choix                                            |
|-----------------|--------------------------------------------------|
| Langage         | Python 3.13                                      |
| API             | FastAPI                                          |
| Base de données | PostgreSQL 16                                    |
| ORM             | SQLAlchemy 2.x (async, `asyncpg`)                |
| Migrations      | Alembic                                          |
| Validation      | Pydantic v2                                      |
| Auth            | JWT réel — `POST /auth/register`, `POST /auth/login`, `GET /auth/me` ; multi-tenant appliqué sur tous les modules (Étape 10) |
| IA              | Couche d'abstraction multi-fournisseurs — premier fournisseur actif : Anthropic Claude (`ai/providers/anthropic_provider.py`) |
| Stockage        | Couche d'abstraction multi-fournisseurs (local aujourd'hui) |
| Conteneurisation| Docker / Docker Compose                          |
| Frontend        | Flutter (Riverpod, GoRouter, Dio, Freezed) — voir [frontend/README.md](frontend/README.md) |

## Démarrage rapide

Prérequis : Docker et Docker Compose installés.

```bash
cd artizen
cp .env.example .env   # déjà fait pour cette première installation
docker compose up
```

Une seule commande suffit. Au premier démarrage :

1. Le service `db` (PostgreSQL) démarre et attend d'être "healthy".
2. Le service `backend` attend que la base soit disponible, applique les
   migrations Alembic (`alembic upgrade head`), puis lance l'API avec
   rechargement à chaud (`--reload`).

### Vérifier que tout fonctionne

- Racine de l'API : http://localhost:8000/
- Health check : http://localhost:8000/health
- Documentation Swagger : http://localhost:8000/docs
- Documentation ReDoc : http://localhost:8000/redoc
- API branding : http://localhost:8000/api/branding/profile
- API document-analysis : http://localhost:8000/api/document-analysis
- API document-detection : http://localhost:8000/api/document-analysis/{id}/detection
- API catalogue : http://localhost:8000/api/catalog/items
- API clients : http://localhost:8000/api/clients
- API devis : http://localhost:8000/api/quotes
- API assistant IA : http://localhost:8000/api/quote-assistant/suggest (POST)
- API import de devis : http://localhost:8000/api/template-import/{id}/preview (GET),
  http://localhost:8000/api/template-import/{id}/validate (POST)
- API profil entreprise éditable : http://localhost:8000/api/branding/company (PUT),
  http://localhost:8000/api/branding/brand (PUT)

`/health` interroge réellement la base de données (`SELECT 1`) et renvoie
`"status": "degraded"` si celle-ci est injoignable, ce qui permet de
distinguer un problème applicatif d'un problème de connectivité base de
données.

Tous les endpoints métier (branding, et les futurs modules) sont montés
sous le préfixe `API_PREFIX` (`/api` par défaut) ; seul `/health` reste
hors préfixe, car il est consommé par des outils d'infrastructure
(orchestrateur, load balancer) plutôt que par des clients métier.

### Fins de ligne : pourquoi `.gitattributes` n'est pas cosmétique

`backend/entrypoint.sh` est exécuté par bash **dans le conteneur Linux**,
mais il est checkouté sur des postes Windows où Git for Windows active
`core.autocrlf=true` par défaut. Sans garde, le script arrive en CRLF et
bash lit le `` comme faisant partie de chaque commande :

```
entrypoint.sh: line 3: $'': command not found
entrypoint.sh: line 26: syntax error: unexpected end of file
```

Le conteneur redémarre en boucle et `docker compose up` — la commande
unique promise plus haut — ne fonctionne tout simplement pas. Le bug est
invisible sur macOS/Linux, ce qui est précisément pourquoi il a survécu.

`.gitattributes` (`*.sh text eol=lf`) force le LF quelle que soit la
configuration Git du développeur. **Ne pas le supprimer.**

### Utilisateur non-root : le conteneur se répare lui-même

L'application tourne en `artizen` (uid 1000), jamais en root. Mais Docker
n'applique l'appartenance du répertoire de l'image à un volume nommé qu'à
son initialisation **à vide** : un volume `artizen_storage_data` créé par
une version antérieure reste détenu par root, et tous les uploads
échoueraient en `EACCES` — alors que le conteneur se déclare *healthy*,
puisque `/health` ne fait qu'un `SELECT 1` et ne touche jamais au stockage.

`entrypoint.sh` traite ce cas : il démarre en root, corrige
l'appartenance **uniquement si elle est fausse**, puis abandonne ses
privilèges via `setpriv` et se ré-exécute en `artizen`. Aucune action
manuelle n'est requise, ni sur une installation neuve, ni sur une
existante. C'est pourquoi le `Dockerfile` n'a **pas** de directive `USER` :
la bascule doit avoir lieu après la réparation, pas avant.

### Arrêter / réinitialiser

```bash
docker compose down          # arrête les conteneurs, conserve les données
docker compose down -v       # arrête les conteneurs ET supprime le volume PostgreSQL
```

## Arborescence

```text
artizen/
├── backend/
│   ├── app/
│   │   ├── api/            # Routage HTTP transverse : dépendances communes, agrégation des routers métier
│   │   ├── core/           # Configuration, logging, gestion des erreurs (transverse)
│   │   ├── database/       # Base déclarative SQLAlchemy, session async, mixins communs
│   │   ├── models/         # Point d'enregistrement Alembic (importe les modèles de chaque module métier)
│   │   ├── schemas/        # Schémas Pydantic transverses (aucun schéma métier ici, voir les modules)
│   │   ├── repositories/   # BaseRepository générique, réutilisé par les modules métier
│   │   ├── services/       # Réservé aux services transverses (aucun service métier ici)
│   │   ├── auth/           # Utilitaires JWT / hachage de mot de passe
│   │   ├── ai/             # Couche d'abstraction multi-fournisseurs IA
│   │   ├── pdf/            # Génération de PDF (devis, factures) — à venir
│   │   ├── utils/          # Fonctions utilitaires transverses (dont la validation d'upload générique)
│   │   ├── storage.py      # StorageProvider (abstraction) + LocalStorageProvider — infra transverse
│   │   ├── branding/       # Module métier : identité graphique
│   │   ├── document_analysis/  # Module métier : pipeline d'analyse locale de documents
│   │   ├── document_detection/  # Module métier : détection heuristique (logo, SIRET, TVA, ...)
│   │   ├── catalog/        # Module métier : catalogue de prestations/fournitures — voir ci-dessous
│   │   ├── clients/        # Module métier : carnet de clients — voir ci-dessous
│   │   ├── quotes/         # Module métier : moteur de devis (QuoteCalculator) — voir ci-dessous
│   │   ├── quote_assistant/  # Module métier : suggestion de devis par IA (Étape 7) — voir ci-dessous
│   │   ├── template_import/  # Module métier : import d'un ancien devis PDF (Étape 8) — voir ci-dessous
│   │   ├── tests/          # Tests pytest (tous modules confondus)
│   │   └── main.py         # Point d'entrée FastAPI
│   ├── alembic/            # Migrations de base de données
│   ├── Dockerfile
│   ├── entrypoint.sh       # Attend la DB, applique les migrations, démarre uvicorn
│   ├── requirements.txt
│   └── pytest.ini
├── frontend/                # Application Flutter (Étape 6) — voir frontend/README.md
├── docs/                     # Documentation technique
├── docker-compose.yml
├── .env.example
└── README.md
```

### Le module `branding/`

```text
app/branding/
├── models.py         # Company, BrandProfile, DocumentTemplate (SQLAlchemy)
├── schemas.py         # Schémas Pydantic exposés par l'API
├── repository.py       # CompanyRepository, BrandProfileRepository, DocumentTemplateRepository
├── service.py            # BrandingService — toute la logique métier
├── interfaces.py           # Contrats futurs : LogoExtractor, PDFAnalyzer, TemplateAnalyzer, DocumentRenderer
├── deps.py                   # Dépendances FastAPI (injection du service)
└── router.py                  # Endpoints HTTP, très courts
```

`storage.py`, `validation.py` et les exceptions d'upload (`UnsupportedFileTypeError`,
`FileTooLargeError`) vivaient ici à l'étape 2 ; ils ont été extraits vers
l'infrastructure transverse à l'étape 3 dès qu'un second module
(`document_analysis/`) en a eu besoin — voir "Deuxième consommateur =
signal d'infrastructure" plus bas.

### Le module `document_analysis/`

```text
app/document_analysis/
├── models.py             # DocumentAnalysis, DocumentType, DocumentStatus (SQLAlchemy)
├── schemas.py             # DocumentAnalysisRead — un seul schéma, réutilisé par les 4 endpoints
├── exceptions.py            # InvalidDocumentError, basée sur AppException
├── hashing.py                 # sha256_hex() — hash SHA-256 du fichier importé
├── loader.py                    # DocumentLoader — étape 1 du pipeline
├── pdf_renderer.py                # PDFRenderer — étape 2 : compte les pages, valide le PDF
├── text_extractor.py                # TextExtractor — étape 3 : extraction de texte brut
├── metadata_extractor.py              # MetadataExtractor — étape 4 : assemble les métadonnées
├── layout_analyzer.py                   # LayoutAnalyzer — étape 5 : placeholder déterministe
├── blueprint_builder.py                   # BlueprintBuilder — étape 6 : structure JSON normalisée
├── pipeline.py                              # DocumentPipeline — orchestrateur + logging par étape
├── repository.py                              # DocumentAnalysisRepository
├── service.py                                   # DocumentAnalysisService — upload/get/list/process
├── deps.py                                        # Dépendances FastAPI
└── router.py                                        # Endpoints HTTP, très courts
```

### Le module `document_detection/`

```text
app/document_detection/
├── interfaces.py              # DetectorResult, TextDetector, VisualDetector
├── models.py                    # DocumentDetectionResult (SQLAlchemy) — toutes les propriétés documentées
├── schemas.py                     # DocumentDetectionResultRead
├── exceptions.py                    # DocumentNotProcessedError
├── siret_detector.py                  # SiretDetector — regex + Luhn
├── vat_detector.py                      # VatDetector — regex FR + UE
├── contact_detector.py                    # ContactDetector — adresse/téléphone/email/site/nom
├── legal_notice_detector.py                 # LegalNoticeDetector — mots-clés
├── table_detector.py                          # TableDetector — lignes alignées
├── header_detector.py                           # HeaderDetector — zone de tête
├── footer_detector.py                             # FooterDetector — zone de pied de page
├── logo_detector.py                                 # LogoDetector — première image, position, taille
├── color_detector.py                                  # ColorDetector — couleurs dominantes
├── aggregator.py                                        # DetectionAggregator — orchestration + logging + score
├── repository.py                                          # DocumentDetectionResultRepository
├── service.py                                               # DocumentDetectionService — calcul paresseux + cache
├── deps.py                                                    # Dépendances FastAPI
└── router.py                                                    # GET /document-analysis/{id}/detection
```

### Le module `catalog/`

```text
app/catalog/
├── models.py         # CatalogCategory, CatalogItem, ItemType
├── schemas.py         # Schémas Pydantic (Create/Update/Read pour les deux entités)
├── interfaces.py        # CatalogMatcher — contrat futur, sans implémentation
├── repository.py           # CatalogCategoryRepository, CatalogItemRepository
├── service.py                 # CatalogService — catégories + articles
├── deps.py                       # Dépendances FastAPI
└── router.py                        # CRUD catégories + articles, désactivation
```

### Le module `clients/`

```text
app/clients/
├── models.py       # Client
├── schemas.py        # ClientCreate/Update/Read
├── repository.py       # ClientRepository — dont la recherche simple (nom/société/téléphone/email)
├── service.py             # ClientService
├── deps.py                  # Dépendances FastAPI
└── router.py                   # CRUD complet
```

### Le module `quotes/`

```text
app/quotes/
├── models.py           # Quote, QuoteLine
├── schemas.py            # QuoteCreate/QuoteLineCreate (aucun champ de prix), QuoteRead/QuoteLineRead
├── exceptions.py            # InactiveCatalogItemError
├── calculator.py               # QuoteCalculator — HT/TVA/TTC/arrondis, pur, sans accès DB
├── repository.py                  # QuoteRepository, QuoteLineRepository
├── service.py                        # QuoteService — dépend de catalog/ et clients/ (sens unique)
├── deps.py                              # Dépendances FastAPI
└── router.py                               # POST/GET /quotes, GET /quotes/{id}
```

## Choix d'architecture

### Clean Architecture / séparation des responsabilités

Ce découpage en couches (`api/`, `services/`, `repositories/`, `models/`,
`core/`) reste la référence pour l'**infrastructure transverse**. Depuis
l'étape 2, les domaines métier eux-mêmes ne l'utilisent plus directement
— voir "Modules métier verticaux vs couches transverses" juste après —
mais chaque module métier reproduit ces mêmes responsabilités *à
l'intérieur* de son propre package (`branding/router.py` joue le rôle de
la couche `api/`, `branding/service.py` celui de `services/`, etc.). Le
principe ne change pas, seul le découpage physique des fichiers change.

Chaque couche a une responsabilité unique et ne dépend que des couches
qu'elle est censée utiliser :

- **`api/`** ne contient aucune logique métier : elle valide la requête
  (via `schemas/`), délègue à `services/`, et sérialise la réponse.
- **`services/`** contient la logique métier et orchestre un ou plusieurs
  `repositories/`. C'est la seule couche qui a le droit de prendre des
  décisions métier.
- **`repositories/`** encapsule l'accès aux données. `BaseRepository`
  (générique, typé) fournit le CRUD standard ; les repositories
  spécialisés n'ajoutent que les requêtes qui en sortent.
- **`models/`** définit uniquement la structure des tables (SQLAlchemy).
- **`core/`** regroupe la configuration, le logging et la gestion des
  erreurs : rien ici ne dépend du reste de l'application, tout le reste
  peut en dépendre.

Cette séparation permet d'ajouter un module métier complet (ex: "devis")
en ajoutant un modèle, un schéma, un repository, un service et un
endpoint — sans toucher aux fondations.

### Modules métier verticaux vs couches transverses (pivot à l'étape 2)

L'étape 1 organisait tout le code par couche horizontale (`models/`,
`schemas/`, `repositories/`, `services/`, `api/endpoints/`). Avec l'arrivée
du premier vrai module métier, ce patron change pour les domaines métier
spécifiquement : **`branding/` est un module vertical auto-contenu**
(modèles, schémas, repositories, service, routes du domaine regroupés
dans un seul package), plutôt que dispersé dans les dossiers transverses.

Deux raisons à ce choix :

1. **L'énoncé l'exige explicitement** : "Il ne devra dépendre ni du
   module IA ni du futur module Devis." Une indépendance de *module* n'a
   de sens que si le code du module est effectivement regroupé — huit
   fichiers épars dans `models/`, `services/`, etc. ne peuvent pas être
   "indépendants" les uns des autres de façon vérifiable.
2. **Ça anticipe la taille du produit visé** ("des milliers d'artisans",
   de nombreux modules métier : devis, factures, planning, paiements...).
   Une architecture en couches horizontales devient difficile à naviguer
   passé une poignée de domaines ; un monolithe modulaire (un package par
   domaine métier) reste lisible même avec beaucoup de modules, et
   prépare une éventuelle extraction en service séparé si le besoin s'en
   fait sentir un jour.

La distinction qui reste : `core/`, `database/`, `auth/`, `ai/`, `pdf/`,
`utils/` sont de l'**infrastructure transverse**, partagée par tous les
modules métier (ce n'est pas la dépendance interdite par l'énoncé — seule
une dépendance vers un *autre module métier*, comme `ai/` en tant que
fournisseur de fonctionnalités, ou un futur `devis/`, le serait). Les
domaines métier eux-mêmes (`branding/`, et demain `devis/`, `planning/`,
...) sont des **modules verticaux**, chacun résponsable de bout en bout
d'un domaine, ne dépendant que de l'infrastructure transverse.

`app/models/__init__.py` reste le point d'enregistrement central pour
Alembic (`import app.branding.models`), sans que cela ne crée de
dépendance : c'est `models/` qui dépend de `branding/`, jamais l'inverse.

### Le module `branding/` en détail

**Modèles** (`branding/models.py`) : `Company` (identité légale),
`BrandProfile` (identité graphique, relation 1-1 avec `Company`),
`DocumentTemplate` (un devis/facture importé, avec `type`, `version` et
`is_active`). Les relations sont de simples clés étrangères, interrogées
explicitement dans `repository.py`, plutôt que des `relationship()`
SQLAlchemy : le lazy-loading async lève une erreur si la relation n'a pas
été chargée explicitement (`selectinload`), et rien ici n'a besoin de
navigation ORM pour l'instant — l'ajouter sans un besoin réel aurait été
de la sur-ingénierie.

**Simplification assumée : une seule entreprise.** Aucun modèle
`User`/compte n'existe encore et aucune route n'est protégée par
authentification (voir la section JWT plus bas). `BrandingService`
travaille donc sur une unique `Company` implicite, créée automatiquement
au premier upload (`_get_or_create_company`). C'est le seul endroit à
modifier quand le multi-tenant arrivera (filtrer par utilisateur/compte
courant au lieu de prendre "la première entreprise").

**Stockage (`app/storage.py`, infrastructure transverse).**
`StorageProvider` est une interface à trois méthodes (`save`, `load`,
`delete`) ; seule `LocalStorageProvider` est implémentée aujourd'hui, sur
un volume Docker dédié (`artizen_storage_data`, monté sur
`/data/storage`). S3, Azure Blob et Google Cloud Storage s'ajouteront
comme nouvelles classes derrière la même interface, sélectionnées via
`STORAGE_PROVIDER` — même patron que `ai/factory.py`. Les clés de
stockage sont générées (`uuid4`), jamais dérivées du nom de fichier
fourni par l'utilisateur.

**Validation des uploads (`app/utils/upload_validation.py`,
infrastructure transverse).** Type et taille sont vérifiés avant toute
écriture : logos limités à PNG/JPEG/SVG (5 Mo), modèles de devis/factures
et documents à analyser limités à des PDF (15 Mo). La taille est
vérifiée incrémentalement pendant la lecture (par blocs de 1 Mo) plutôt
qu'après avoir chargé tout le fichier en mémoire, pour rejeter un fichier
trop volumineux sans le bufferiser entièrement.

**Versionnement des modèles de documents.** Chaque upload sur
`/branding/template/{quote,invoice}` crée une nouvelle ligne
`DocumentTemplate` avec un numéro de version incrémenté, et désactive
l'ancienne version active du même type (`is_active = False`) plutôt que
de l'écraser — l'historique est conservé.

**Interfaces pour l'analyse IA future (`branding/interfaces.py`).**
`LogoExtractor`, `PDFAnalyzer`, `TemplateAnalyzer` et `DocumentRenderer`
sont des classes abstraites pures, non implémentées et non appelées par
`BrandingService`. Elles fixent uniquement le contrat que prendra la
future intégration IA (probablement via `ai/`), sans en présumer le
fonctionnement interne — leurs méthodes renvoient des `dict[str, object]`
volontairement génériques tant que la forme réelle d'une "analyse" n'est
pas décidée.

### Deuxième consommateur = signal d'infrastructure (pivot à l'étape 3)

À l'étape 2, `StorageProvider` et la validation d'upload (type/taille)
vivaient dans `branding/` : c'était le seul module à en avoir besoin.
L'étape 3 a introduit `document_analysis/`, qui a besoin exactement des
mêmes capacités (stocker un fichier, le relire, valider son type/sa
taille) pour des raisons totalement différentes (analyser un document,
pas gérer une identité de marque).

Plutôt que dupliquer ce code dans `document_analysis/`, ou pire, faire
dépendre `document_analysis/` de `branding/` pour l'emprunter (ce qui
aurait violé l'indépendance entre modules métier explicitement exigée),
ces deux capacités ont été extraites vers l'infrastructure transverse :

- `app/branding/storage.py` → `app/storage.py`
- `app/branding/validation.py` → `app/utils/upload_validation.py`
- `app/branding/exceptions.py` (`UnsupportedFileTypeError`,
  `FileTooLargeError`) → fusionnées dans `app/core/exceptions.py`, aux
  côtés de `NotFoundError`, `ConflictError`, etc.

C'est une règle pragmatique plutôt qu'un principe appliqué par
anticipation : tant qu'une seule chose en a besoin, ça reste dans son
module (pas d'over-engineering à deviner ce qui sera "générique" plus
tard) ; dès qu'une **deuxième** chose en a réellement besoin, c'est le
signal concret que ce n'était pas de la logique métier — et c'est
seulement à ce moment-là que ça migre vers `core/`, `database/`, `auth/`,
`ai/`, `pdf/`, `utils/` ou un nouveau module transverse comme
`storage.py`. `branding/` n'a rien perdu au passage : ses imports ont
juste changé de `app.branding.storage` vers `app.storage`, etc.

### Le module `document_analysis/` en détail

**Indépendance du module.** `document_analysis/` ne dépend ni du futur
module Devis ni du futur module IA générative, exactement comme demandé.
Il référence les tables de `branding/` (`companies`, `document_templates`)
par simple clé étrangère (dépendance de *données*, au niveau SQL), mais
n'importe aucun code Python de `branding/` — `DocumentType` y est
d'ailleurs redéfini localement plutôt qu'importé de
`branding.models.TemplateType`, aux valeurs identiques aujourd'hui mais
volontairement non partagées : rien n'oblige les deux modules à faire
évoluer ce vocabulaire ensemble (`document_analysis` pourrait un jour
avoir besoin d'un type "autre" qui n'aurait aucun sens comme emplacement
de template `branding`).

**`company_id` explicite plutôt qu'une entreprise implicite.**
`branding/` suppose une entreprise unique créée à la volée
(`_get_or_create_company`) parce qu'il *possède* la création des
entreprises. `document_analysis/` ne possède pas cette responsabilité :
il se contente de *référencer* une entreprise existante. Reproduire la
même astuce ici (deviner "l'" entreprise courante) aurait été une
dépendance cachée sur la logique interne de `branding/`. `POST
/document-analysis/upload` demande donc explicitement `company_id` en
paramètre — ce qui est aussi la forme la plus proche de ce dont on aura
besoin plus tard avec l'authentification (le `company_id` viendra alors
de l'utilisateur connecté, pas d'une supposition).

**Le pipeline (`DocumentPipeline` + 6 étapes).** Chaque étape est une
classe indépendante avec une seule méthode publique, injectée dans
`DocumentPipeline` par le constructeur — pas d'interface abstraite, pas
de factory : remplacer une étape signifie simplement passer une autre
instance au constructeur. Les étapes n'échangent que des types simples
(`bytes`, `str`, `int`, `dict`) entre elles, jamais l'objet interne
d'une autre étape (`PDFRenderer` et `TextExtractor` re-parsent chacun le
PDF indépendamment plutôt que de partager un objet `pypdf.PdfReader`) :
c'est ce qui rend chaque étape réellement remplaçable sans toucher aux
autres, y compris par un futur composant IA (Vision, OCR, LLM).

`DocumentPipeline` ne fait que séquencer les étapes et journaliser :
début, fin, durée et erreur de chaque étape, via le logger existant
(`logging.getLogger(__name__)`, aucune configuration nouvelle). Il ne
connaît rien du concept de statut ou de persistance — c'est
`DocumentAnalysisService.process()` qui gère les transitions
`PROCESSING` → `COMPLETED`/`FAILED` et la sauvegarde, en encadrant
l'appel au pipeline dans un `try/except` : une erreur de pipeline (PDF
invalide, par exemple) ne fait jamais planter la requête HTTP, elle
aboutit à un enregistrement `FAILED` propre (`POST
.../{id}/process` répond toujours `200`, le champ `status` du corps
indique le résultat réel).

**Le format Blueprint.** Documenté en détail dans le docstring de
`blueprint_builder.py` : une structure JSON stable (`version`,
`page_count`, `logo`, `text_zones`, `main_table`, `footer`, `variables`,
`company_coordinates`), où chaque section existe déjà mais reste vide
tant qu'aucun analyseur intelligent n'est branché. L'objectif est que ce
schéma ne change plus : un futur analyseur Vision/OCR/LLM remplira ces
champs, il n'aura pas à en inventer de nouveaux.

**Hash SHA-256 et index.** `file_hash` est calculé à l'upload
(`hashing.sha256_hex`) et indexé, prêt pour la détection de doublons/
le versionnement mentionnés dans l'énoncé — mais cette logique elle-même
(que faire en cas de doublon détecté) n'est pas construite maintenant,
volontairement : l'énoncé dit explicitement "servira **plus tard**".
`company_id` et `status` sont également indexés (filtrage par entreprise,
par statut — les deux requêtes les plus probables une fois
l'authentification et un tableau de bord en place).

**Un champ ajouté au-delà de la liste de l'énoncé : `storage_key`.** La
liste de champs de `DocumentAnalysis` dans l'énoncé est introduite par
"notamment" (non exhaustive). `/process` doit pouvoir relire le fichier
précédemment uploadé, ce qui exige de connaître sa clé de stockage —
`storage_key` a donc été ajouté, par nécessité fonctionnelle plutôt que
par choix.

### Le module `document_detection/` en détail (Étape 4)

**Une exception assumée à la règle d'indépendance.** Contrairement à
`document_analysis/` (qui ne doit dépendre ni du module Devis ni du
module IA générative, mais reste sinon isolé), l'énoncé de l'étape 4 dit
explicitement que `document_detection/` "peut utiliser le pipeline
`document_analysis`". C'est la première dépendance directe entre deux
modules métier du projet — mais elle reste **unidirectionnelle** :
`document_detection` importe `document_analysis.repository` et
`document_analysis.models.DocumentStatus`, jamais l'inverse.
`document_analysis/` n'a pas été modifié du tout pour cette étape (pas
un seul fichier) : il ignore totalement que `document_detection/`
existe. C'est ce qui rend la dépendance sûre — un module "aval" qui lit
un module "amont" ne crée pas de couplage cyclique.

**Un routeur qui partage l'URL d'un autre module.** L'énoncé demande
`GET /document-analysis/{id}/detection` — un chemin dans l'espace de
`document_analysis`, pas de `document_detection`. Plutôt que d'inverser
la dépendance (ce qui aurait obligé `document_analysis/router.py` à
connaître `document_detection/`), `document_detection/router.py` déclare
son propre `APIRouter(prefix="/document-analysis")` et n'y ajoute qu'une
seule route (`/{analysis_id}/detection`). Les deux routers sont montés
côte à côte dans `api_router` (`app/api/router.py`) ; FastAPI n'a aucun
souci à voir deux routers partager un préfixe tant que leurs chemins ne
se recouvrent pas littéralement, ce qui est le cas ici.

**Calcul paresseux et mise en cache, pas une septième étape de
pipeline.** L'énoncé dit "le pipeline devra maintenant produire ...
detection_result", mais `DocumentPipeline` (dans `document_analysis/`)
n'a pas été modifié pour autant — cela aurait exigé qu'il importe
`document_detection/`, la dépendance interdite. À la place,
`GET .../{id}/detection` calcule la détection **à la demande**, la
première fois qu'elle est demandée pour une analyse `COMPLETED`, et la
persiste dans sa propre table (`document_detection_results`, 1-1 avec
`document_analyses` via `document_analysis_id`). Les appels suivants
renvoient directement la ligne déjà calculée — les détecteurs sont
déterministes sur le même texte/PDF, donc recalculer à chaque requête
serait du travail perdu (voir la section Performance de l'énoncé).
Résultat produit par le "pipeline complet" du point de vue utilisateur
(upload → process → detection) : `metadata`, `extracted_text`,
`blueprint` et `detection_result` sont bien tous les quatre disponibles
— juste calculés par deux endpoints distincts plutôt qu'un seul appel.

Si l'analyse sous-jacente n'est pas encore `COMPLETED`,
`GET .../{id}/detection` répond `409 Conflict`
(`DocumentNotProcessedError`) plutôt que de déclencher `process()`
lui-même : un `GET` qui lance implicitement un traitement lourd aurait
été surprenant et peu conforme aux conventions REST.

**Table dédiée plutôt qu'une colonne JSON sur `document_analyses`.**
`DocumentDetectionResult` a sa propre table avec sa propre migration,
suivant le même patron que les autres modules (`branding/` possède
`companies`/`brand_profiles`/`document_templates`, `document_analysis/`
possède `document_analyses`) plutôt que d'ajouter une colonne
`detection_result` JSONB à la table d'un autre module — ce qui aurait
demandé de modifier `document_analysis/models.py` pour une donnée que ce
module ne possède pas conceptuellement.

**Mutualisation des données déjà extraites — sans recharger le PDF
plusieurs fois.** Sur les neuf détecteurs, seuls deux
(`LogoDetector`, `ColorDetector`) ont réellement besoin des octets bruts
du PDF (pour accéder aux images intégrées) ; les sept autres
(`HeaderDetector`, `FooterDetector`, `ContactDetector`, `SiretDetector`,
`VatDetector`, `LegalNoticeDetector`, `TableDetector`) fonctionnent
uniquement sur `analysis.extracted_text`, déjà calculé et stocké par
`document_analysis` — zéro accès au stockage ou au PDF pour ces
sept-là. `DocumentDetectionService.get_or_run` charge le PDF **une seule
fois** (`storage.load`) et transmet les mêmes octets aux deux détecteurs
visuels ; aucun détecteur ne recharge indépendamment le fichier. Pour un
devis de 1 à 3 pages, l'ensemble de la détection s'exécute en quelques
millisecondes (les opérations sont des regex sur du texte déjà en
mémoire, plus une miniature 50×50 pour la couleur).

**Deux interfaces, pas dix.** L'énoncé demande de prévoir des interfaces
pour qu'un détecteur soit "remplaçable plus tard par une implémentation
basée sur un modèle de vision", sans dépendance vers une IA. Plutôt
qu'une interface abstraite par détecteur (dix classes pour dix
contrats — de la sur-ingénierie), `interfaces.py` définit exactement
**deux** contrats selon le type de donnée consommée :
`TextDetector.detect(text: str)` et `VisualDetector.detect(content: bytes)`,
tous deux retournant un `DetectorResult` (`detected`, `confidence`,
`data`) uniforme. Un futur `LogoDetector` basé sur un modèle de vision
n'a qu'à implémenter `VisualDetector` avec la même signature ;
`DetectionAggregator` n'a rien à changer.

**Journalisation centralisée plutôt que répétée neuf fois.** Chaque
détecteur doit journaliser début/fin/durée/confiance, mais ce code de
mesure de temps ne vit qu'à un seul endroit :
`DetectionAggregator._run()` enveloppe l'appel à chaque détecteur (log
`detector.start` / `detector.completed` avec `duration_ms` et
`confidence`, ou `detector.failed` avec la trace complète en cas
d'exception). Un détecteur qui échoue n'interrompt jamais l'agrégation
globale — il est simplement compté comme `detected=False,
confidence=0.0`, et les huit autres continuent.

**Score de confiance global.** `confidence_score` est la moyenne simple
des neuf scores de confiance individuels, arrondie à deux décimales.
L'énoncé ne prescrit pas de formule ("l'objectif n'est pas une précision
parfaite") ; une moyenne simple est le choix le plus lisible et le plus
facile à faire évoluer (pondération par détecteur, par exemple) sans
changer la structure du résultat.

**SIRET et Luhn : là où l'heuristique simple vaut la peine d'être un peu
moins simple.** Le SIRET français a un vrai algorithme de validation
(la clé de Luhn). Le vérifier coûte quelques lignes et transforme un
"il y a une suite de 14 chiffres" en un signal nettement plus fiable
(`confidence` augmente si la clé est valide) — un des rares endroits où
sortir légèrement du "simple" apporte un vrai gain, sans complexifier
l'architecture.

### Le cœur métier — `catalog/`, `clients/`, `quotes/` (Étape 5)

**Artizen n'invente jamais les prix.** C'est la règle qui gouverne tout
ce module : `quotes/` ne calcule jamais un montant à partir de rien — il
ne peut que référencer un `CatalogItem` déjà existant, avec son prix, sa
TVA et son unité déjà définis dans le catalogue de l'artisan.
`QuoteLineCreate` (le schéma d'entrée d'une ligne de devis) n'a d'ailleurs
même pas de champ prix : structurellement, impossible de soumettre un
prix libre.

**`catalog/` et `clients/` sont des modules pairs, indépendants l'un de
l'autre.** Aucun des deux ne connaît l'existence de l'autre ni de
`quotes/`. C'est `quotes/` qui dépend d'eux, jamais l'inverse — même
patron de dépendance à sens unique que `document_detection → document_analysis`
à l'étape 4 : un devis ne peut pas exister sans référencer un client et
des articles de catalogue réels, donc `quotes/` est naturellement "en
aval" des deux.

**Prix figé à la création de la ligne ("snapshot").** Quand une
`QuoteLine` est créée, `designation`, `unit`, `unit_price_ht` et
`vat_rate` sont copiés depuis le `CatalogItem` référencé, plutôt que
recalculés à chaque lecture du devis. Si l'artisan change un prix dans
son catalogue plus tard, les devis déjà émis doivent continuer à
afficher les montants qu'ils avaient réellement au moment de l'émission
— exactement comme une vraie facture ne se met pas à jour toute seule.
`catalog_item_id` reste néanmoins stocké sur la ligne (traçabilité), avec
une contrainte `ON DELETE RESTRICT` : un article référencé par un devis
ne peut plus être supprimé, seulement désactivé.

**Désactivation plutôt que suppression pour `CatalogItem`.**
`DELETE /catalog/items/{id}` ne supprime pas la ligne : il met
`active=False` (voir `CatalogService.deactivate_item`). Une vraie
suppression casserait l'intégrité référentielle avec les devis existants
et l'historique. `QuoteService.create` vérifie explicitement `item.active`
avant d'accepter une ligne et lève `InactiveCatalogItemError` (409) sinon
— un article désactivé ne peut plus servir à faire de nouveaux devis,
mais les anciens devis qui le référencent restent inchangés et lisibles.

**`QuoteCalculator` : un seul endroit qui a le droit de calculer un
montant.** Ni le router ni le service ne font le moindre calcul HT/TVA/TTC
directement — `QuoteService` appelle `QuoteCalculator.calculate_line`
pour chaque ligne, puis `calculate_quote` pour les sous-totaux du devis.
Toutes les sommes sont des `Decimal`, jamais des `float` (les erreurs
d'arrondi flottant sont inacceptables pour de l'argent). L'arrondi
appliqué est le "arrondi commercial" (`ROUND_HALF_UP`, à la ligne) plutôt
que l'arrondi bancaire par défaut de Python (`ROUND_HALF_EVEN`) — un
choix documenté et testé explicitement (`0.67 × 1.50 = 1.0050` doit
arrondir à `1.01`, pas `1.00`).

**`company_id` explicite, comme `document_analysis`.** `catalog/`,
`clients/` et `quotes/` suivent le même principe que `document_analysis`
à l'étape 3 : pas d'entreprise implicite devinée, `company_id` est un
champ explicite de chaque `Create` — ces modules ne possèdent pas la
création d'entreprises (`branding/` seul la possède), donc ils ne
doivent pas deviner "la" bonne entreprise.

**`CatalogMatcher` : le contrat pour la future IA, sans logique.**
`catalog/interfaces.py` définit `CatalogMatcher.match(description, *,
company_id) -> list[CatalogItem]` — non implémenté, non appelé nulle
part. Son rôle futur : transformer une description libre (dictée ou
tapée par l'artisan, ou extraite d'un document importé) en une liste
d'articles de catalogue *existants*. Même une IA branchée dessus plus
tard ne pourra que **sélectionner** parmi des `CatalogItem` déjà créés
par l'artisan — jamais inventer une ligne ou un prix. C'est la seule
préparation à l'IA faite dans ce module : aucune dépendance vers `ai/`
n'existe encore.

### Le module `quote_assistant/` en détail (Étape 7)

```text
app/quote_assistant/
├── schemas.py                # QuoteSuggestionRequest/Read (API) + RawSuggestionItem/Response (JSON brut IA)
├── exceptions.py               # InvalidAIResponseError (502)
├── prompt_builder.py             # PromptBuilder — construit les messages envoyés à l'IA
├── catalog_matcher_claude.py        # CatalogMatcherClaude — appelle AIProvider, parse le JSON strict
├── match_validator.py                 # MatchValidator — existence / appartenance / activité de chaque article
├── suggestion_scorer.py                  # SuggestionScorer — score de confiance final
├── service.py                               # QuoteAssistantService — orchestrateur
├── deps.py                                     # Dépendances FastAPI
└── router.py                                      # POST /quote-assistant/suggest
```

**Aucune migration, aucune persistance.** Ce module ne définit aucun
modèle SQLAlchemy : il transforme une description en *proposition* et ne
stocke rien. Le seul état qu'il produit vit dans la réponse HTTP ;
rien n'est en base après un appel à `/suggest`, et un même appel peut
être répété indéfiniment sans effet de bord.

**L'IA ne fait qu'associer, jamais calculer ni créer.** C'est la règle
qui gouverne toute l'implémentation, testée explicitement (voir
`app/tests/test_quote_assistant.py::test_suggest_never_creates_a_quote`) :
`QuoteAssistantService.suggest()` ne touche jamais `QuoteService` ni la
table `quotes` ; il ne fait que lire le catalogue (lecture seule) et
renvoyer une proposition. Créer le devis reste un choix explicite de
l'utilisateur, via l'endpoint `POST /quotes` existant depuis l'étape 5,
inchangé.

**Ne réutilise pas `catalog.interfaces.CatalogMatcher`.** Ce contrat
placeholder (créé à l'étape 5 pour "une future fonctionnalité IA")
renvoie une simple `list[CatalogItem]` — insuffisant pour porter la
quantité, la justification par article, le score de confiance global et
le commentaire que cette fonctionnalité doit réellement exposer. Plutôt
que de forcer ce contrat jamais implémenté à posteriori,
`quote_assistant` définit sa propre forme adaptée
(`RawSuggestionResponse` / `QuoteSuggestionRead`). Voir le commentaire
mis à jour dans `catalog/interfaces.py` : le placeholder reste
disponible pour un futur matcher plus simple, à unifier seulement si un
second cas d'usage réel en a besoin.

**Le flux en 5 étapes, chacune un composant séparé et testable
isolément :**

1. **`PromptBuilder`** — fonction pure (aucun I/O), construit les
   messages système/utilisateur à partir de la description et du
   catalogue actif de l'entreprise. Le prompt système interdit
   explicitement d'inventer un article ou un prix, et exige une réponse
   JSON stricte conforme au schéma `{"items": [...], "confidence": ...,
   "comment": ...}`.
2. **`CatalogMatcherClaude`** — appelle `AIProvider.complete()` (jamais
   le SDK Anthropic directement : voir "Couche IA multi-fournisseurs"
   plus bas) avec les messages du `PromptBuilder`, puis parse la réponse
   en `RawSuggestionResponse` (Pydantic). Tolère que Claude enveloppe sa
   réponse dans une balise de code ` ```json ` malgré la consigne stricte
   (comportement réel occasionnellement observé chez les LLM) en la
   retirant avant le parsing. Toute réponse qui ne correspond pas au
   schéma (JSON invalide, champ manquant, `catalog_item_id` qui n'est
   pas un UUID, `quantity` ≤ 0, `confidence` hors `[0, 1]`) lève
   `InvalidAIResponseError` (502) — le défaut est chez le fournisseur IA
   amont, pas dans la requête de l'appelant.
3. **`MatchValidator`** — **ne fait jamais confiance à la réponse de
   l'IA**, même si le prompt limitait déjà Claude aux articles actifs de
   l'entreprise : chaque `catalog_item_id` proposé est revérifié en base
   (existe ? appartient à cette entreprise ? toujours actif ?). Un
   article qui échoue une vérification est simplement retiré de la
   liste plutôt que de faire échouer toute la suggestion — même
   principe que `DetectionAggregator` à l'étape 4, où l'échec d'un
   détecteur n'empêche pas les huit autres de contribuer.
4. **`SuggestionScorer`** — centralise le calcul du score de confiance
   final, à l'image de `QuoteCalculator` pour les montants : le score
   auto-déclaré par Claude est pondéré par la proportion d'articles
   réellement valides (`valid_count / total_count`). Une réponse où la
   moitié des articles proposés s'avèrent invalides doit être moins
   crédible que la confiance brute de Claude ne le suggérait, même si
   Claude était sûr de lui.
5. **`QuoteAssistantService`** — orchestre les quatre composants
   ci-dessus et assemble `QuoteSuggestionRead` (articles validés,
   score, commentaire).

### `quote_assistant/` complété — le copilote IA (Étape 9)

L'étape 9 ne change rien à l'architecture ci-dessus : elle enrichit
chacun des 5 composants avec ce qu'un vrai copilote a besoin de savoir
en plus d'un simple appariement mot-à-mot.

**Contexte de l'entreprise et fréquence d'utilisation, dans le
prompt.** `PromptBuilder.build()` accepte désormais `company_name`
(récupéré via `BrandingService.get_company_name()`, une méthode
volontairement plus légère que `get_profile()` puisque
`quote_assistant` n'a besoin que du nom, pas du profil de marque ni de
l'historique des modèles) et `usage_counts` — un
`dict[catalog_item_id, int]` produit par la nouvelle
`QuoteLineRepository.get_usage_counts_by_company()` (nombre de lignes
de devis passées référençant chaque article). Chaque article du
catalogue envoyé au prompt porte désormais un champ
`times_used_previously` : un indice de désambiguïsation explicitement
présenté comme tel dans les règles du prompt système ("un indice,
jamais une certitude"), jamais une préférence imposée après coup par le
backend — c'est toujours l'IA (ou l'heuristique de secours) qui décide.

**Justification plus précise, exigée par le prompt.** Le prompt système
demande maintenant explicitement que chaque `reason` cite les mots ou
le passage exact de la description qui justifient le choix, plutôt
qu'une formule générique — et `MockAIProvider` (voir plus bas) applique
la même exigence en citant réellement les mots-clés qui ont fait
matcher chaque article, y compris pour les termes composés français
("chauffe-eau") grâce à une tokenisation qui préserve les traits d'union
internes.

**Gestion des réponses ambiguës — trois composants coopèrent :**
- `MatchValidator` **déduplique** : si l'IA propose deux fois le même
  `catalog_item_id`, la seconde occurrence est rejetée avec la raison
  `"duplicate"` plutôt que d'être acceptée deux fois. Chaque rejet
  (`"duplicate"`, `"not_found"`, `"wrong_company"`, `"inactive"`) est
  désormais conservé dans `ValidationResult.rejected_items` — avant
  l'étape 9, un article invalide était simplement supprimé sans laisser
  de trace.
- `SuggestionScorer` **pénalise les doublons** : `duplicate_count`
  réduit le score final (`-0.05` par doublon, jamais sous 0), et la
  confiance brute reçue est désormais explicitement bornée à `[0, 1]`
  avant tout calcul — une défense minimale contre une réponse IA mal
  formée qui indiquerait, par exemple, `confidence: 1.5`.
- `MockAIProvider` **détecte l'ambiguïté lui-même** : quand les deux
  meilleurs candidats obtiennent le même score de recoupement de
  mots-clés (aucun ne se distingue clairement), la confiance renvoyée
  descend à `0.35` au lieu de `0.6` — la même logique que celle
  demandée à Claude dans le prompt système, appliquée cette fois de
  façon déterministe. Un vrai catalogue de démonstration contenant des
  dizaines d'articles au même intitulé ("Chauffe-eau Atlantic 200 L",
  créés au fil des tests précédents) reproduit ce cas exactement : la
  confiance renvoyée est `0.35`, jamais un score artificiellement élevé
  masquant l'ambiguïté réelle.

**Journalisation détaillée des décisions.** `QuoteAssistantService.suggest()`
journalise maintenant trois étapes distinctes plutôt qu'un seul résumé
final : `quote_assistant.start` (longueur de la description),
`quote_assistant.raw_response` (nombre d'articles proposés et
confiance brute de l'IA, avant toute validation), une ligne
`quote_assistant.rejected` par article rejeté (avec sa raison précise),
puis `quote_assistant.completed` (compte final, doublons, score). Un
incident de production ("pourquoi cet article n'a-t-il pas été
proposé ?") se diagnostique directement dans les logs, sans avoir à
reproduire l'appel.

**Le fournisseur IA (`AnthropicProvider`) est le premier appel réseau
réel de la couche `ai/`.** Jusqu'à cette étape, `AIProvider` et ses
implémentations (`ai/providers/*.py`) étaient des squelettes qui levaient
`NotImplementedError` — la couche d'abstraction existait mais rien ne
l'utilisait. `AnthropicProvider.complete()` est maintenant implémenté :
il traduit les `AIMessage` génériques (rôle `system`/`user`/`assistant`)
vers l'API Messages d'Anthropic (qui attend le `system` comme paramètre
séparé, pas comme un message), et retourne un `AIResponse` neutre.
`CatalogMatcherClaude` ne connaît que `AIProvider` — passer à OpenAI,
Mistral ou Gemini plus tard ne changera pas une ligne de
`quote_assistant/`, seulement `DEFAULT_AI_PROVIDER` dans `.env`.

**`app/ai/deps.py` rend le fournisseur IA testable sans clé API réelle.**
`get_ai_provider()` (la factory) accepte un nom de fournisseur optionnel,
incompatible avec l'injection FastAPI (`Depends()` n'appelle ses
dépendances sans argument). `get_default_ai_provider()` l'enveloppe pour
l'injection, et les tests substituent
`app.dependency_overrides[get_default_ai_provider]` par un
`FakeAIProvider` renvoyant un JSON préparé — aucun test n'a besoin d'une
vraie `ANTHROPIC_API_KEY`, exactement comme `client` (fixture HTTPX) n'a
jamais eu besoin d'un vrai navigateur.

**Absence de clé API = jamais une panne, jamais une question.** Une
clé manquante ne doit jamais empêcher de développer, compiler, tester
ou démontrer l'application. `get_ai_provider()` (`ai/factory.py`) est
entièrement automatique et déterminé par la seule présence de la clé :
si `ANTHROPIC_API_KEY` (ou la clé du fournisseur actif) est présente,
le vrai fournisseur est utilisé ; si elle est absente, la factory
bascule elle-même sur `MockAIProvider` — jamais d'exception au
démarrage, jamais d'erreur sur `POST /quote-assistant/suggest`, et
personne (développeur ou utilisateur final) n'a de choix à faire. Ce
choix est décidé une seule fois, au démarrage du processus (`@lru_cache`
sur `get_ai_provider`) ; ajouter une vraie clé à `.env` puis redémarrer
le backend suffit à rebasculer sur le vrai fournisseur, sans toucher un
seul fichier de code.

**`MockAIProvider` (`ai/providers/mock_provider.py`) : un faux
fournisseur générique, pas une spécificité de `quote_assistant`.** Il ne
connaît que le contrat `AIMessage`/`AIResponse` — comme tout `AIProvider`
— et reste donc réutilisable par une future fonctionnalité IA sans rien
lui apprendre de nouveau. Pour rester utile en démonstration plutôt que
de toujours renvoyer une réponse vide, il repère un tableau JSON de
candidats dans le dernier message `user` (le catalogue, tel que
`PromptBuilder` le sérialise) et fait un simple recoupement de
mots-clés, insensible à la casse, entre la description et chaque
candidat — déterministe, sans appel réseau, sans dépendance ajoutée
(uniquement `json`/`re` de la bibliothèque standard). Un catalogue vide
ou une description sans recoupement produit une réponse toujours
*valide* (`items: []`, `confidence: 0.0`) plutôt qu'une erreur.

### Le module `template_import/` en détail (Étape 8)

```text
app/template_import/
├── schemas.py       # TemplateImportPreviewRead, TemplateImportValidateRequest
├── exceptions.py       # InvalidDocumentTypeForTemplateError (409)
├── service.py             # TemplateImportService — preview() + validate()
├── deps.py                  # Compose branding + document_analysis + document_detection
└── router.py                   # GET .../preview, POST .../validate
```

**Zéro nouvelle table, zéro nouvelle migration, zéro nouvelle logique
d'extraction.** Ce module ne fait qu'orchestrer trois services déjà
construits et déjà testés :

1. **Upload + analyse** — `POST /document-analysis/upload` puis
   `POST /document-analysis/{id}/process` (Étape 3, inchangés). C'est
   volontairement `document_analysis` qui possède l'upload, pas
   `template_import` : la responsabilité "stocker et parser un PDF
   importé" existait déjà et n'a aucune raison d'être dupliquée.
2. **Détection (l'étape "Extraction des informations")** —
   `TemplateImportService.preview()` appelle directement
   `DocumentDetectionService.get_or_run()` (Étape 4, inchangé) : logo,
   couleurs dominantes, en-tête/pied de page/tableau, SIRET (Luhn), TVA,
   coordonnées de contact. Toutes ces valeurs existaient déjà dans
   `DocumentDetectionResult` — il ne manquait qu'un écran/endpoint pour
   les relier à la configuration de l'entreprise.
3. **Prévisualisation** — `GET /template-import/{id}/preview` renvoie
   *à la fois* les valeurs détectées et les valeurs actuelles de
   `Company`/`BrandProfile`, côte à côte : l'utilisateur doit pouvoir
   comparer avant de décider quoi garder, exactement comme les
   suggestions modifiables de `quote_assistant` (Étape 7) — un même
   principe d'IA/heuristique-propose-l'utilisateur-décide appliqué à un
   second cas d'usage.
4. **Validation** — `POST /template-import/{id}/validate` reçoit les
   valeurs *finales* que l'utilisateur a confirmées (conservées telles
   que détectées, ou corrigées) — pas un diff. Applique les champs
   fournis à `Company`/`BrandProfile` (voir "Édition de l'identité
   entreprise" ci-dessous), enregistre le PDF déjà stocké par
   `document_analysis` comme nouvelle version active du modèle de devis
   (`BrandingService.create_template_from_existing_file`, sans le
   téléverser une seconde fois), puis relie `DocumentAnalysis.document_template_id`
   au nouveau modèle — le champ existait depuis l'étape 3
   ("nothing links an analysis to a specific template yet"), c'est
   exactement l'étape qui le renseigne enfin.
5. **"Tous les futurs devis utilisent ce modèle"** — garanti
   structurellement : `DocumentTemplate.is_active` (Étape 2) désigne
   déjà un unique modèle actif par entreprise et par type, et
   `create_template_from_existing_file` désactive systématiquement
   l'ancien actif avant d'activer le nouveau. Un futur générateur de PDF
   de devis (`app/pdf/`, toujours "à venir") n'aura qu'à lire ce même
   modèle actif — aucune logique de sélection de modèle à construire
   séparément.

**Rejet explicite des documents qui ne sont pas des devis.**
`InvalidDocumentTypeForTemplateError` (409) empêche qu'une facture
importée par erreur (`document_type=invoice`) ne devienne le modèle de
*devis* — cette fonctionnalité est explicitement "importer un ancien
**devis**", pas un import de document générique.

**Édition de l'identité entreprise (`branding/` étendu, pas un nouveau
module).** Avant l'étape 8, rien ne permettait de modifier `Company`/
`BrandProfile` après leur création implicite — seul l'upload de logo/
modèle existait. `template_import/validate()` a besoin d'appliquer des
champs (SIRET, TVA, couleurs, ...), donc `BrandingService` gagne
`update_company()`/`update_profile()` (mise à jour partielle,
`exclude_unset=True`, même patron que `CatalogService.update_item`),
exposées aussi comme `PUT /branding/company` et `PUT /branding/brand` :
une capacité générale et réutilisable, pas un chemin à usage unique
réservé à l'import PDF — un artisan pourra un jour corriger son SIRET
directement depuis les Paramètres, sans jamais ré-importer un PDF.

### Le client Flutter — `frontend/` (Étape 6)

Premier client applicatif d'Artizen : un artisan peut ouvrir
l'application, gérer ses clients et son catalogue, créer un devis en
n'y référençant que des articles de catalogue existants, et voir les
totaux HT/TVA/TTC. Architecture Feature-First (Riverpod, GoRouter, Dio,
Freezed) — voir [frontend/README.md](frontend/README.md) pour le détail
complet des choix d'architecture, l'arborescence, les commandes
d'installation et de test.

**Une seule règle gouverne toute l'intégration avec le backend :**
Flutter n'effectue jamais de calcul financier. `QuoteLineInput` (l'objet
envoyé à `POST /quotes`) ne porte qu'un `catalogItemId` et une
`quantity` — aucun champ prix n'existe côté client, à l'image de
`QuoteLineCreate` côté backend (voir "Artizen n'invente jamais les
prix" plus haut). Les montants affichés (`QuoteTotalsCard`) sont
exactement ceux renvoyés par `QuoteCalculator` côté serveur, passés à
`intl` pour le seul formatage d'affichage.

**Étape 7 ajoute l'écran "Assistant IA"** (accessible depuis l'icône
✨ de l'AppBar de l'onglet Devis) : saisie libre → `POST
/quote-assistant/suggest` → articles suggérés (modifiables : quantité,
suppression) → "Créer le devis". Ce dernier bouton ne crée rien
lui-même : il pré-remplit `quoteDraftLinesProvider` (le même brouillon
que `QuoteFormScreen` utilise déjà depuis l'étape 6) avec les articles
acceptés, puis navigue vers l'écran de création de devis existant — la
création reste `POST /quotes`, inchangé. Voir
[frontend/README.md](frontend/README.md) pour le détail.

**Étape 8 ajoute l'écran "Importer un ancien devis"** (accessible
depuis Paramètres) : sélection d'un PDF (`file_picker`, compatible Web)
→ upload + analyse → aperçu modifiable (valeurs détectées vs valeurs
actuelles) → validation → confirmation que "tous les futurs devis
utilisent ce modèle". Deux nouvelles features Flutter : `branding/`
(modèles `Company`/`BrandProfile`/`DocumentTemplate` + le profil
complet, réutilisable par tout futur écran ayant besoin de l'identité
de l'entreprise) et `template_import/` (le pipeline propre à cet
écran). Voir [frontend/README.md](frontend/README.md) pour le détail.

**Étape 9 renomme l'écran "Assistant IA" en "Copilote IA"** (même route
`/quote-assistant`, même icône ✨) et le complète : un bouton "Ajouter
un article" permet de compléter manuellement la proposition de l'IA
avec un article du catalogue, et le score de confiance s'affiche
désormais comme un bandeau coloré distinct — "Confiance forte" (≥ 70 %),
"Confiance modérée" (40-70 %), "Confiance faible — vérifiez les
suggestions" (< 40 %) — plutôt qu'un simple pourcentage, pour que les
états UX explicitement demandés (faible/forte confiance) soient
reconnaissables au premier coup d'œil. Voir
[frontend/README.md](frontend/README.md) pour le détail.

### Base de données et migrations

- `database/base.py` définit une `Base` déclarative unique avec une
  convention de nommage explicite (`NAMING_CONVENTION`) pour que les noms
  de contraintes/index générés par Alembic soient stables et prévisibles.
- `UUIDMixin` et `TimestampMixin` fournissent l'identifiant et les
  colonnes d'horodatage standard que tous les futurs modèles métier
  réutiliseront.
- `alembic/env.py` construit l'URL de connexion et les métadonnées cibles
  directement depuis l'application (`settings` et `Base.metadata`) : il
  n'y a qu'un seul endroit où l'URL de la base de données est définie.

### Gestion des erreurs

`core/exceptions.py` définit une hiérarchie d'exceptions applicatives
(`AppException`, `NotFoundError`, `ConflictError`, `UnauthorizedError`,
`ForbiddenError`) et enregistre des handlers FastAPI qui garantissent un
format de réponse d'erreur unique et stable :

```json
{ "error": { "code": "not_found", "message": "..." } }
```

Les erreurs de validation Pydantic et les exceptions non prévues sont
également interceptées pour ne jamais laisser fuir une stack trace brute
au client.

### Authentification (JWT) et multi-tenant réel (Étape 10)

`auth/security.py` fournit le hachage de mot de passe (bcrypt) et la
création/décodage de tokens JWT depuis l'étape 1 ; l'**Étape 10** lui
donne enfin un vrai consommateur métier.

**Le module `users/`.** Suit exactement le patron vertical des autres
modules métier (`models.py`, `schemas.py`, `repository.py`, `service.py`,
`deps.py`, `router.py`) :

- `POST /auth/register` — crée une nouvelle `Company` (nom fourni ou
  placeholder) *et* un nouveau `User` dans la même transaction, puis
  renvoie un JWT. Chaque inscription obtient sa propre entreprise ; il
  n'existe plus d'entreprise "singleton" créée implicitement au premier
  appel.
- `POST /auth/login` — vérifie l'email/mot de passe, renvoie un JWT.
- `GET /auth/me` — renvoie l'utilisateur authentifié (utile pour
  vérifier qu'un token est encore valide).
- `CurrentUserDep` (`users/deps.py`) décode le token via
  `HTTPBearer(auto_error=True)`, charge le `User`, et devient la
  dépendance FastAPI que **tous** les routeurs protégés utilisent.

**Le retrofit multi-tenant.** Avant l'étape 10, chaque endpoint acceptait
un `company_id` fourni par le client (query param ou corps JSON) — une
entreprise pouvait donc lire ou modifier les données d'une autre en
changeant simplement cette valeur. La consigne du projet était explicite :
*pas de gros refactoring, réutiliser l'existant*. Plutôt que de
restructurer chaque service/schéma pour supprimer `company_id`, le
retrofit ajoute une couche de garde fine et uniforme au niveau des
routeurs :

- `app/core/authorization.py` expose `ensure_same_company(resource_company_id, resource_id, current_company_id)`,
  qui lève un `NotFoundError` (404, jamais 403 — pour ne pas confirmer à
  une entreprise l'existence d'une ressource qui ne lui appartient pas) en
  cas de mismatch. Extrait après son premier usage dans
  `catalog/router.py`, selon le patron "deuxième consommateur = signal
  d'infrastructure" déjà établi à l'étape 3.
- **Création** (`POST`) : le routeur ignore la valeur envoyée et écrase
  `company_id` avec celle de l'utilisateur authentifié —
  `payload.model_copy(update={"company_id": current_user.company_id})`
  pour les corps JSON, suppression pure et simple du paramètre pour les
  cas `Form(...)` (upload de documents).
- **Liste** (`GET` collection) : le paramètre de requête optionnel
  `company_id` est supprimé — la liste est toujours filtrée sur
  l'entreprise de l'utilisateur authentifié, jamais sur une valeur
  arbitraire.
- **Lecture/modification par id** (`GET`/`PUT`/`DELETE` unitaires) :
  récupérer la ressource, puis `ensure_same_company(...)` avant de la
  renvoyer ou de la modifier.

Ce patron a été appliqué sans aucune réécriture de schéma ou de service
dans six des huit modules (`branding`, `catalog`, `clients`, `quotes`,
`document_analysis`, `template_import`) ; seuls `branding/service.py`,
`document_detection/service.py` et `template_import/service.py` ont reçu
un paramètre `company_id` explicite supplémentaire (changement additif,
pas une restructuration) là où la logique interne en avait besoin pour
appeler un autre service.

**Un bug réel trouvé par la démonstration manuelle, pas par les tests.**
Les schémas `ClientCreate`, `CatalogCategoryCreate`, `CatalogItemCreate`,
`QuoteCreate` et `QuoteSuggestionRequest` déclaraient encore
`company_id: uuid.UUID` comme champ **obligatoire**, même si sa valeur
est désormais toujours ignorée et écrasée côté routeur. Les 95 tests
backend ne l'ont jamais détecté car leurs fixtures historiques
continuaient d'envoyer un `company_id` (devenu inutile, mais toujours
présent) dans le corps de leurs requêtes. Une démonstration manuelle
via `curl`, envoyant un corps de requête réaliste sans ce champ
désormais superflu, a révélé un `422 Unprocessable Entity` — et ce même
bug aurait cassé l'application Flutter réelle, dont les modèles de
saisie (`ClientInput`, `CatalogCategoryInput`, ...) n'ont jamais inclus
`company_id`. Corrigé en rendant le champ optionnel
(`uuid.UUID | None = None`) dans les cinq schémas : la valeur reste
ignorée si elle est fournie, mais n'est plus jamais exigée.

**Deux incompatibilités de dépendances,** rencontrées en ajoutant le
hachage de mot de passe réel pour la première fois :

1. `passlib==1.7.4` (sa dernière version, non maintenue) échoue avec
   `bcrypt>=4.1` : son auto-test interne `detect_wrap_bug()` utilise un
   secret de plus de 72 octets, que les versions récentes de `bcrypt`
   rejettent désormais correctement (`ValueError: password cannot be
   longer than 72 bytes`). Corrigé en épinglant `bcrypt==4.0.1` dans
   `requirements.txt`.
2. `pydantic.EmailStr` (via `email-validator`) rejette les domaines
   réservés RFC 2606 (`.test`, `.example`, `example.com`, ...) même en
   validation de syntaxe pure, sans aucun appel réseau. Les fixtures de
   test utilisent donc `@artizen-qa.io` plutôt que `@artizen.test`.

**`conftest.py` : l'authentification devient transparente pour ~85 tests
existants.** La fixture partagée `client` s'inscrit désormais
automatiquement (email UUID unique + mot de passe fixe) et attache le
JWT obtenu comme en-tête `Authorization` par défaut. Comme chaque test
préexistant amorçait déjà son `company_id` via
`GET /api/branding/profile` (patron établi depuis l'étape 2), aucun test
individuel n'a eu besoin d'être modifié pour devenir authentifié — et
chaque test obtient au passage sa propre entreprise réelle, une
isolation que l'ancienne "entreprise singleton" ne permettait pas. Une
fixture `second_client`, indépendamment inscrite, permet en plus des
tests de non-isolation croisée entre entreprises (`test_users.py`,
et les nouveaux tests cross-tenant de `test_catalog.py` /
`test_quote_assistant.py`).

**`StarletteHTTPException` et le format d'erreur unique.** Les
dépendances de sécurité intégrées à FastAPI (`HTTPBearer.auto_error`)
lèvent une `starlette.exceptions.HTTPException`, qui contourne les
handlers `AppException` personnalisés. Un handler dédié dans
`core/exceptions.py` mappe les codes de statut standards vers le
vocabulaire d'erreur existant (401 → `unauthorized`, 403 → `forbidden`,
404 → `not_found`) pour que **toutes** les erreurs, y compris celles
levées par FastAPI lui-même, gardent le même format
`{"error": {"code": ..., "message": ...}}`.

**Côté Flutter** (voir [frontend/README.md](frontend/README.md) pour le
détail), `AuthRepository` appelle désormais réellement
`POST /auth/register` / `POST /auth/login` et persiste le JWT obtenu ;
un nouvel écran `RegisterScreen` complète `LoginScreen` (devenu un vrai
formulaire email/mot de passe), et `AuthInterceptor`/
`currentCompanyIdProvider` — construits à l'étape 6 précisément pour ce
jour — fonctionnent sans aucune modification dès qu'un vrai token existe.

### Couche IA multi-fournisseurs

Artizen doit pouvoir combiner plusieurs fournisseurs d'IA (OpenAI,
Anthropic, Mistral, ...) sans que la logique métier ne dépende d'un
fournisseur particulier :

- `ai/base.py` définit le contrat `AIProvider` (méthode `complete`).
- `ai/schemas.py` définit des structures neutres (`AIMessage`,
  `AIResponse`) communes à tous les fournisseurs.
- `ai/providers/` contient une implémentation par fournisseur (squelette
  pour l'instant, l'appel réseau réel sera ajouté avec la première
  fonctionnalité IA).
- `ai/factory.py` sélectionne le fournisseur actif via
  `DEFAULT_AI_PROVIDER` (variable d'environnement) : changer de
  fournisseur, ou en ajouter un nouveau, ne nécessite aucune modification
  du code métier qui consomme `AIProvider`.

### Configuration centralisée

`core/config.py` est le seul point d'accès aux variables d'environnement
(via `pydantic-settings`). Aucun autre module ne doit lire `os.environ`
directement.

### Logging

`core/logging.py` configure un format de log unique pour toute
l'application (y compris SQLAlchemy et uvicorn), avec un niveau
paramétrable via `LOG_LEVEL`.

## Variables d'environnement

Voir [.env.example](.env.example) pour la liste complète et commentée.
Points d'attention :

- `POSTGRES_HOST` est forcé à `db` par `docker-compose.yml` (réseau
  interne Docker) ; ne le changer que pour un usage hors Docker.
- `SECRET_KEY` et `POSTGRES_PASSWORD` doivent être remplacés par des
  valeurs fortes avant tout déploiement en production.
- Les clés `OPENAI_API_KEY` / `ANTHROPIC_API_KEY` / `MISTRAL_API_KEY` sont
  **toujours optionnelles**, y compris pour utiliser `quote_assistant/` :
  si la clé du fournisseur configuré (`DEFAULT_AI_PROVIDER`) est absente,
  `ai/factory.py` bascule automatiquement sur `MockAIProvider` (hors
  ligne, déterministe) — jamais d'erreur au démarrage, jamais d'erreur
  sur `/quote-assistant/suggest`, aucune question posée à personne.
  Ajouter une vraie clé plus tard puis redémarrer le backend suffit à
  basculer sur le vrai fournisseur, sans changer une ligne de code. Voir
  "Le module `quote_assistant/` en détail", section fournisseur IA.
- `STORAGE_LOCAL_ROOT` (`/data/storage`) est un chemin **dans le
  conteneur**, persistant grâce au volume `artizen_storage_data`. Hors
  Docker, pointez-le vers un dossier local (ex: `./storage`).

## Développement local (sans Docker)

```bash
cd backend
python -m venv .venv
source .venv/bin/activate        # ou .venv\Scripts\activate sous Windows
pip install -r requirements.txt
# Démarrer un PostgreSQL local, puis dans .env : POSTGRES_HOST=localhost
alembic upgrade head
uvicorn app.main:app --reload
```

## Tests

```bash
docker compose exec backend pytest
```

ou, hors Docker, depuis `backend/` avec l'environnement virtuel activé :

```bash
pytest
```

**Limite connue :** les tests s'exécutent contre la vraie base
PostgreSQL configurée (même patron que `test_health.py` à l'étape 1) —
il n'y a pas encore de base de test dédiée ni de rollback automatique par
test. Les lignes créées par les tests `branding` et `document_analysis`
(une `Company`, des fichiers dans le volume de stockage local) persistent
donc entre les exécutions. Une vraie isolation (base de test séparée,
transaction annulée après chaque test) serait la prochaine amélioration
naturelle, volontairement non construite ici tant qu'elle n'est pas
nécessaire.

`app/tests/test_document_analysis.py` génère ses PDF de test avec
`pypdf.PdfWriter` (déjà une dépendance du pipeline, pas besoin d'en
ajouter une nouvelle juste pour les tests) plutôt qu'avec des octets
PDF écrits à la main, plus robuste et plus lisible.

`app/tests/test_document_detection.py` teste les détecteurs texte
(SIRET, TVA, contact, mentions légales, tableau) unitairement, en
appelant directement `detect()` sur du texte français réaliste écrit à
la main — rapide, précis, sans avoir besoin de générer un PDF contenant
du texte réel (`pypdf.PdfWriter` seul ne sait pas dessiner de texte, et
ajouter une dépendance comme `reportlab` uniquement pour les tests
aurait été disproportionné). Les tests de bout en bout (upload →
process → detection) utilisent eux des PDF vides générés par
`pypdf.PdfWriter`, ce qui sert aussi de cas "document sans coordonnées"
pour le flux HTTP complet.

`app/tests/test_quotes.py::test_calculator_rounding_uses_half_up` teste
`QuoteCalculator` directement (fonction pure, pas de DB/HTTP nécessaire)
sur un cas de rondage volontairement choisi pour être une vraie
égalité : `0.67 × 1.50 = 1.0050` exactement. C'est le seul cas qui
distingue réellement `ROUND_HALF_UP` (1.01, notre choix) de l'arrondi
bancaire par défaut de Python (1.00) — un cas comme `33.33 × 0.05` ne
suffit pas à le prouver, car les deux méthodes d'arrondi seraient
d'accord.

Deux subtilités asyncio, déjà résolues dans `app/tests/conftest.py` et
`pytest.ini` :

1. L'engine SQLAlchemy async est un singleton dont le pool de connexions
   se lie à la boucle d'événements qui l'a créé, alors que
   `pytest-asyncio` donne par défaut une boucle différente à chaque test.
   Une fixture `autouse` (`_dispose_engine_after_test`) vide le pool
   après chaque test pour forcer une connexion fraîche sous la bonne
   boucle.
2. `asyncio_default_fixture_loop_scope` doit rester sur `function` (et
   non `session`) : dès qu'un test dépend d'une fixture qui fait elle
   aussi de l'I/O asynchrone (ex: la fixture `company_id`, qui appelle
   `GET /api/branding/profile`), une fixture en portée "session" et un
   corps de test en portée "function" utiliseraient deux boucles
   différentes **au sein du même test**, cassant l'engine partagé de la
   même façon. Les deux fixtures/tests doivent rester sur la même
   portée.

## Ajouter un nouveau module métier

Depuis l'étape 2, chaque domaine métier suit le patron vertical illustré
par `branding/` (voir "Modules métier verticaux vs couches transverses"
plus haut) plutôt que d'éparpiller ses fichiers dans `models/`,
`schemas/`, etc. Exemple pour un futur module "Devis" :

1. `app/devis/models.py` — modèles SQLAlchemy (`Base`, `UUIDMixin`,
   `TimestampMixin`).
2. `app/devis/schemas.py` — schémas Pydantic exposés par l'API.
3. `app/devis/repository.py` — repositories, basés sur
   `app.repositories.base.BaseRepository`.
4. `app/devis/service.py` — `DevisService`, toute la logique métier ;
   c'est la seule classe que les routes appellent.
5. `app/devis/router.py` + `app/devis/deps.py` — endpoints très courts,
   dépendances injectées.
6. `app/models/__init__.py` — ajouter `from app.devis import models as devis_models`
   pour qu'Alembic détecte les nouvelles tables.
7. `app/api/router.py` — `api_router.include_router(devis_router)`.
8. `alembic revision --autogenerate -m "add devis tables"` puis
   `alembic upgrade head`.

Le nouveau module ne doit dépendre que de l'infrastructure transverse
(`core/`, `database/`, `auth/`, `ai/` en tant que fournisseur de
fonctionnalités, `pdf/`, `utils/`, `storage.py`) — jamais directement
d'un autre module métier comme `branding/` ou `document_analysis/`. Si un
module a besoin de données d'un autre domaine, ce besoin passe par une
clé étrangère (dépendance de données) et/ou une interface explicite (voir
`branding/interfaces.py` pour l'exemple), pas par un import direct.

Si le nouveau module a besoin d'une capacité qui existe déjà dans un
module métier existant (stockage, validation d'upload, ...), c'est le
signal pour l'extraire vers l'infrastructure transverse plutôt que de la
dupliquer ou d'importer l'autre module métier — voir "Deuxième
consommateur = signal d'infrastructure" plus haut, qui documente
exactement ce cas pour `storage.py`.

**Exception :** un énoncé peut explicitement autoriser un module à
dépendre d'un autre module métier (`document_detection/` sur
`document_analysis/` à l'étape 4 en est le premier exemple). Dans ce
cas, la dépendance doit rester à sens unique et clairement justifiée —
voir "Le module `document_detection/` en détail" plus haut pour le
raisonnement complet (routeur partagé, calcul paresseux, table dédiée).
