# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

Artizen est un SaaS de devis pour artisans du bâtiment : backend FastAPI + client Flutter.
La documentation du dépôt est en français, les commentaires de code en anglais — garder cette convention.

Le `README.md` racine (77 Ko) et `frontend/README.md` documentent chaque décision d'architecture
étape par étape et **justifient** les choix. Les consulter avant de proposer un changement structurel :
la plupart des « anomalies » apparentes y sont des choix assumés et expliqués.

## Commandes

### Backend

```bash
cp .env.example .env          # requis avant le premier démarrage
docker compose up             # db + migrations Alembic + API sur :8000
docker compose down -v        # réinitialise aussi le volume PostgreSQL

docker compose exec backend pytest
docker compose exec backend pytest app/tests/test_quotes.py::test_calculator_rounding_uses_half_up
docker compose exec backend alembic revision --autogenerate -m "message"
```

Swagger : http://localhost:8000/docs — `/health` fait un vrai `SELECT 1` et renvoie `degraded` si la DB est injoignable.

### Frontend

```bash
cd frontend
flutter pub get
dart run build_runner build --delete-conflicting-outputs   # après toute modif de modèle Freezed
flutter analyze
flutter test
flutter test test/features/quotes/quote_models_test.dart

flutter run -d web-server --web-port 3000
```

Le port **3000** est imposé par `CORS_ORIGINS`, qui vaut `http://localhost:3000` — la valeur vient
de `.env` (recopié depuis `.env.example`), que `docker-compose.yml` charge via `env_file`, et **non**
du compose lui-même. Servir le frontend sur un autre port exige donc de modifier `.env`.

## Invariants du produit

Ces règles traversent tout le code. Les enfreindre casse la promesse du produit, pas seulement un test.

1. **L'IA ne choisit aucun prix, aucune TVA, aucun montant, et ne persiste rien.**
   `quote_assistant` ne fait que *sélectionner* des articles du catalogue existant. Il ne crée
   jamais de `Quote` — la création reste un geste explicite de l'utilisateur via `POST /quotes`.
   Ce module n'a ni modèle, ni table, ni migration.
   Nuance exacte : la **quantité** est bien inférée par l'IA (seule valeur numérique qu'elle
   produise). Bornée par le schéma et relue par l'artisan — ne pas étendre « l'IA n'invente rien »
   aux quantités, ce serait faux.
2. **Un devis ne se modifie pas — il se supprime et se recrée (V2).** Seul un `draft` est
   supprimable ; `sent`/`accepted`/`refused` sont figés (409). Il n'existe **ni `PUT` ni `PATCH`**
   sur `/quotes` : `QuoteCalculator` n'a aucune entrée de recalcul pour un devis existant, donc
   toute route d'écriture pourrait laisser un total qui ne correspond plus à ses lignes. La
   recréation repasse par `create`, seul endroit où un total est calculé.
   `PUT /quotes/{id}/status` ne touche jamais un montant. Les transitions vivent dans
   `QUOTE_TRANSITIONS` (models.py) ; rien ne revient jamais à `draft`.
   Le numéro (`DEV-2026-0001`) vient de `QuoteCounter`, verrouillé `FOR UPDATE` — **jamais un
   `SELECT MAX+1`**, qui donnerait deux fois le même numéro sur deux créations simultanées.
   `change_status` et `delete` verrouillent aussi la ligne du devis : ce sont des
   read-decide-write, et sans verrou une transition perdue répond quand même 200.

3. **`quotes/calculator.py` est le seul endroit où un montant est calculé.** Tout en `Decimal`,
   jamais `float`. Arrondi `ROUND_HALF_UP` **par ligne**, puis somme des lignes (convention française).
   Ne jamais recalculer un montant ailleurs, ni côté Flutter — le client affiche ce que le backend renvoie.
4. **Une réponse d'IA n'est jamais crue sur parole.** `match_validator.py` re-valide chaque article
   proposé contre le vrai catalogue (existe / bonne entreprise / actif / non-doublon), même si le prompt
   restreignait déjà Claude. Un article invalide est écarté sans faire échouer la suggestion entière,
   et chaque rejet est journalisé avec sa raison.
5. **`company_id` vient toujours du JWT, jamais du client.** Les routeurs écrasent la valeur reçue
   (`model_copy(update=...)`) et les `GET` de collection n'acceptent aucun `company_id` en query param.
6. **Un mismatch de tenant renvoie 404, jamais 403** (`core/authorization.py::ensure_same_company`) —
   un 403 confirmerait à une entreprise l'existence d'une ressource d'une autre.
7. **Rien n'est appliqué sans confirmation explicite.** `template_import` propose une configuration
   d'identité relue et validée par l'artisan ; il ne l'applique jamais automatiquement.

## Architecture

### Backend — monolithe modulaire à modules verticaux

Chaque domaine métier est un package auto-contenu qui reproduit les mêmes rôles en interne :
`models.py`, `schemas.py`, `repository.py`, `service.py`, `deps.py`, `router.py`.

Modules : `users`, `branding`, `document_analysis`, `document_detection`, `catalog`, `clients`,
`quotes`, `quote_assistant`, `template_import`.

**La règle réelle n'est pas « aucune dépendance entre modules métier » — c'est « à sens unique
et justifiée ».** (Le README l'énonce correctement ; ne pas la durcir en absolu, le code la
contredirait aussitôt.) Dépendances légitimes et documentées, vérifiées dans le code :

- `quotes → catalog`, `quotes → clients` : un devis ne peut exister sans référencer de vrais
  articles et un vrai client. `catalog` et `clients` s'ignorent mutuellement.
- `document_detection → document_analysis` : exigé par l'énoncé.
- `template_import → branding`, `document_analysis`, `document_detection` : ce module n'est
  qu'un orchestrateur de capacités déjà construites.
- `quote_assistant → catalog`, `quotes`, `branding` : lectures seules (catalogue, historique
  d'usage, nom de l'entreprise). Il ne persiste rien.
- **Tous les modules → `users.deps.CurrentUserDep`** : c'est de l'infrastructure d'auth de fait,
  pas une dépendance métier — les 8 modules l'importent.

Le reste de l'infrastructure transverse : `core/`, `database/`, `auth/`, `ai/`, `utils/`,
`repositories/base.py`, `storage.py`. `app/models/__init__.py` importe les modèles de chaque
module pour Alembic — c'est `models/` qui dépend des modules, jamais l'inverse.

**Divergence connue, non corrigée : `users ↔ branding` est un cycle.** `users` importe
`branding.repository.CompanyRepository` (l'inscription crée une `Company`, qui vit dans
`branding`) et `branding/router.py` importe `users.deps.CurrentUserDep`. Aucun cycle à l'import
— l'app démarre, 142 tests le prouvent — mais c'est la seule entorse réelle au « sens unique ».
La cause est que `Company` appartient à `branding` alors que l'inscription en crée une. La
déplacer serait un refactoring : à traiter en V2, pas avant. Voir `docs/release/`.

Un nouveau module s'ajoute en suivant ce patron puis en l'enregistrant dans `api/router.py`
et `models/__init__.py`. Tout est monté sous `API_PREFIX` (`/api`) sauf `/health`.

### Règle d'extraction : « deuxième consommateur = signal d'infrastructure »

Un helper reste dans son module d'origine jusqu'à ce qu'un **deuxième** module en ait besoin ;
il est extrait vers le transverse à ce moment-là, pas avant. C'est l'histoire de `storage.py`,
de la validation d'upload et de `core/authorization.py`. Ne pas généraliser par anticipation.

### Abstractions de fournisseur

`ai/factory.py` bascule automatiquement sur `MockAIProvider` (hors-ligne, déterministe) si la clé
API du fournisseur configuré est absente. **L'application doit toujours démarrer et toute fonctionnalité
IA toujours renvoyer une réponse utilisable, sans configuration.** Une clé manquante n'est jamais une
erreur. Ajouter une vraie clé + redémarrer suffit à passer en réel : aucun code dépendant de `AIProvider`
ne change. Même logique pour `storage.py` (local aujourd'hui).

### Frontend — feature-first

`lib/features/<domaine>/` avec `data/` (modèles Freezed + repository impl), `domain/` (interface de
repository), `presentation/` (providers Riverpod + écrans). Miroir des modules backend.

- `core/api/` est la **seule** couche qui connaît Dio. Une feature n'importe jamais Dio directement.
- Modèles en Freezed + json_serializable ; toute modif exige `build_runner`.
- État serveur en `AsyncNotifier`, état de formulaire pur en `Notifier`/`StateProvider`.
- `core/widgets/` fournit un mécanisme unique pour les 4 états (loading / error / empty / data).
- Navigation : `StatefulShellRoute` pour la barre du bas, routes racine pour le reste.

## État de la V1

[docs/AUDIT-V1.md](docs/AUDIT-V1.md) est le point d'entrée : ce qui a été corrigé, ce qui reste
(5 items bloquants, dont l'absence totale de rate limiting), et **quelles portes de validation
n'ont jamais été exécutées**. À lire avant de déclarer quoi que ce soit prêt.

## Pièges connus

- **Tests backend sans isolation.** Ils tournent contre la vraie base PostgreSQL configurée : pas de
  base de test dédiée ni de rollback par test, les lignes créées persistent entre exécutions.
  Limite assumée, documentée dans le README.
- **Fixtures asyncio.** `asyncio_default_fixture_loop_scope` doit rester sur `function` : l'engine
  SQLAlchemy async est un singleton dont le pool se lie à la boucle qui l'a créé. La fixture autouse
  `_dispose_engine_after_test` (`conftest.py`) vide le pool après chaque test. Voir les commentaires
  de `pytest.ini` avant d'y toucher.
- **Les tests ne prouvent pas le contrat HTTP réel.** Un bug réel (`company_id` resté obligatoire dans
  5 schémas → 422 pour le vrai client Flutter) a survécu à 95 tests, dont les fixtures historiques
  envoyaient encore le champ. Valider les changements de schéma avec une requête `curl` réaliste,
  pas seulement avec la suite de tests.
- **Aucun test Flutter n'appelle le vrai backend** (fakes/mocks partout) — la validation bout-en-bout
  est manuelle.
- **`bcrypt==4.0.1` est épinglé** volontairement (incompatibilité avec l'auto-test de passlib 1.7.4).
  Ne pas mettre à jour sans lire le commentaire de `requirements.txt`.
