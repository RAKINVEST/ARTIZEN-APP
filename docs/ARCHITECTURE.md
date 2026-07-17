# Architecture — ARTIZEN V2

Vue d'ensemble de l'architecture au commit `v2.0.0-rc1`. Le `README.md`
racine (~77 Ko) reste le récit détaillé, étape par étape, **avec ses
justifications** ; ce document en donne la carte. Les invariants produit qui
gouvernent le code sont dans `CLAUDE.md`.

## Vue macro

```
┌─────────────────────────┐        HTTP/JSON (JWT Bearer)        ┌──────────────────────────┐
│   Client Flutter (Web)  │  ─────────────────────────────────▶ │   Backend FastAPI        │
│   feature-first         │                                      │   monolithe modulaire    │
│   Riverpod · GoRouter   │  ◀───────────────────────────────── │   SQLAlchemy 2 async     │
│   Dio (core/api seul)   │        Decimal sérialisé en string   │   Alembic                │
└─────────────────────────┘                                      └───────────┬──────────────┘
                                                                              │ asyncpg
                                                                  ┌───────────▼──────────────┐
                                                                  │  PostgreSQL 16           │
                                                                  └──────────────────────────┘
        Abstractions de fournisseur : AIProvider (mock si pas de clé) · Storage (local)
```

## Backend — monolithe modulaire à modules verticaux

Chaque domaine métier est un package auto-contenu reproduisant les mêmes
rôles : `models.py`, `schemas.py`, `repository.py`, `service.py`, `deps.py`,
`router.py`.

**Modules métier (9)** : `users`, `branding`, `document_analysis`,
`document_detection`, `catalog`, `clients`, `quotes`, `quote_assistant`,
`template_import`.

**Infrastructure transverse** : `core/` (config, exceptions, logging,
authorization, rate_limit, body_size_limit), `database/`, `auth/`, `ai/`,
`pdf/`, `utils/`, `repositories/base.py`, `storage.py`, `api/` (montage),
`models/` (agrégation pour Alembic), `schemas/` (communs).

Tout est monté sous `API_PREFIX` (`/api`) sauf `/` et `/health`.

### Règle de dépendance : « à sens unique et justifiée »

Ce n'est **pas** « aucune dépendance entre modules », mais des dépendances
unidirectionnelles et documentées :

- `quotes → catalog`, `quotes → clients` : un devis référence de vrais
  articles et un vrai client. `catalog` et `clients` s'ignorent.
- `document_detection → document_analysis`.
- `template_import → branding, document_analysis, document_detection`
  (orchestrateur de capacités existantes).
- `quote_assistant → catalog, quotes, branding` (lectures seules ; ne
  persiste rien).
- **Tous → `users.deps.CurrentUserDep`** : infrastructure d'auth de fait.

**Divergence connue, non corrigée : `users ↔ branding` est un cycle**
(`Company` vit dans `branding`, mais l'inscription en crée une). Aucun cycle
à l'import — l'app démarre, la suite pytest le prouve. Seule entorse au « sens
unique », à traiter en V3 (extraire un module `companies`).

### Règle d'extraction transverse

Un helper reste dans son module d'origine jusqu'au **deuxième** consommateur ;
il monte au transverse à ce moment-là, pas avant. **Exception assumée :
`app/pdf/`**, transverse dès le premier consommateur car les suivants sont
déclarés (factures, avoirs, bons de commande).

## Le moteur PDF (V2) — réutilisable par construction

- **`app/pdf/` n'importe QUE `app.pdf.*`** — jamais un module métier. C'est
  ce qui le rend réutilisable pour tout document (devis, facture, avoir, bon
  de commande) sans branche par type ; le `title` est une chaîne, pas un
  enum. Vérifié mécaniquement.
- **Il ne calcule rien** : chaque montant arrive déjà calculé (y compris le
  récapitulatif de TVA via `QuoteCalculator.calculate_vat_breakdown`). La
  traduction Devis → Document vit dans `quotes/document_mapper.py`, **côté
  métier** (le flux de connaissance va du métier vers `pdf/`, jamais
  l'inverse).
- Rendu **à la demande, jamais stocké** ; exécuté **hors event loop**
  (`asyncio.to_thread`, reportlab est CPU-bound) ; **dégradation
  systématique** (logo/couleur/identité manquants → le document sort quand
  même).

## Cycle de vie du devis (V2)

- **Statuts** `draft → sent → accepted/refused`, transitions dans
  `QUOTE_TRANSITIONS` (table en code). Rien ne revient à `draft`.
  `change_status` et `delete` sont des **read-decide-write verrouillés**
  (`SELECT … FOR UPDATE`) — sans quoi une transition concurrente perdue
  répondrait quand même 200.
- **Numérotation `DEV-AAAA-NNNN`** par entreprise, via `quote_counters`
  verrouillé `FOR UPDATE` (jamais `SELECT MAX+1`), unicité garantie en base
  par `UNIQUE (company_id, quote_number)`.
- **Aucune route d'écriture de contenu** (`PUT`/`PATCH`) : c'est la garantie
  que les totaux persistés restent cohérents avec les lignes, puisque
  `QuoteCalculator` ne calcule qu'à la création.

## Invariant monétaire

`quotes/calculator.py` est le **seul** endroit où un montant se calcule : tout
en `Decimal`, jamais `float`, arrondi `ROUND_HALF_UP` **par ligne** puis somme
(convention française). Le client Flutter **affiche** ce que le backend
renvoie (montants sérialisés en chaînes JSON), il ne recalcule rien.

## Abstractions de fournisseur

- **`ai/factory.py`** bascule sur `MockAIProvider` (hors-ligne, déterministe)
  si la clé du fournisseur configuré est absente. L'app démarre et toute
  fonctionnalité IA répond, sans configuration. Une vraie clé + redémarrage
  suffit à passer en réel — aucun code dépendant de `AIProvider` ne change.
- **`storage.py`** : local aujourd'hui, même logique d'abstraction.

## Frontend — feature-first

`lib/features/<domaine>/` avec `data/` (modèles Freezed + repository impl),
`domain/` (interface de repository), `presentation/` (providers Riverpod +
écrans). Miroir des modules backend.

- **`core/api/` est la seule couche qui connaît Dio.**
- Modèles en **Freezed + json_serializable** ; toute modif exige
  `build_runner`.
- État serveur en `AsyncNotifier`, formulaire pur en `Notifier`/`StateProvider`.
- Navigation : `StatefulShellRoute` (5 onglets : Tableau de bord, Clients,
  Catalogue, Devis, Paramètres) + routes racines poussées (détail devis,
  formulaires, copilote, import).

## Persistance

- **PostgreSQL 16**, SQLAlchemy 2 async + asyncpg. **13 relations**
  (12 tables métier + `alembic_version`), dont `quote_counters` (V2).
- **6 migrations Alembic**, chaîne linéaire, tête `6cc7943bff6a`. Voir
  `docs/MIGRATION_GUIDE.md`.
- Deux volumes d'état : `artizen_postgres_data`, `artizen_storage_data`.

## Déploiement

- **Image = production par défaut** (`--workers 4`, non-root `artizen`,
  bascule via `setpriv` avec réparation de la propriété du volume).
- **`docker-compose.yml` = pile de développement** (`--reload`, bind-mount).
  Ne pas déployer tel quel. Voir `docs/DEPLOYMENT_GUIDE.md` et
  `docs/DOCKER_GUIDE.md`.

## Pour aller plus loin

- `README.md` (racine) — le récit complet avec justifications.
- `CLAUDE.md` — invariants produit et pièges.
- `docs/API_REFERENCE.md` — les 44 endpoints.
- `docs/release/07_V2_CERTIFICATION.md` — les 9 axes d'audit V2.
