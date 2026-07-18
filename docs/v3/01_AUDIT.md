# V3 — Audit complet du projet (Phase 3)

**Date : 2026-07-18.** Branche `develop/v3`. Base auditée : V2 figée (`v2.0.0`,
commit `a978eb0`). Cet audit précède toute décision d'architecture V3 ; rien
n'est ajouté tant qu'il n'est pas partagé.

## 0. Métriques mesurées

| Élément | Valeur |
|---|---|
| Backend Python (hors tests) | **7 444 LOC** |
| Tests backend | **3 471 LOC** — 214 tests |
| Frontend Dart (hors généré) | **6 233 LOC** — 68 tests |
| Modules métier backend | **9** (verticaux) |
| Features Flutter | **9** (miroir) |
| Endpoints API | **44** (39 métier + 5 infra/auto) |
| Tables PostgreSQL | **12** (+ `alembic_version`) |
| Migrations Alembic | **6** (chaîne linéaire) |
| Dépendances backend / frontend | 20 / 27 |

## 1. Backend

**Stack** : FastAPI 0.115 · SQLAlchemy 2 async · asyncpg · Alembic ·
Pydantic 2 · PostgreSQL 16 · Python 3.13.

**Architecture** : monolithe modulaire à **modules verticaux** — chaque
domaine (`users`, `branding`, `catalog`, `clients`, `quotes`,
`quote_assistant`, `document_analysis`, `document_detection`,
`template_import`) reproduit `models / schemas / repository / service / deps /
router`. Infrastructure transverse isolée (`core`, `database`, `auth`, `ai`,
`pdf`, `utils`, `storage`, `repositories/base`).

**Points forts**
- **Séparation nette des responsabilités** ; les routeurs ne touchent jamais
  les repositories ni le calcul.
- **Invariant monétaire fort** : `quotes/calculator.py` est le seul endroit
  où un montant est calculé (Decimal, `ROUND_HALF_UP` par ligne). Aucune
  arithmétique monétaire ailleurs, vérifié mécaniquement.
- **Abstractions de fournisseur** : `ai/factory.py` (mock si pas de clé) et
  `storage.py` (local) — l'app démarre et fonctionne sans configuration.
- **Concurrence maîtrisée** : numérotation `DEV-AAAA-NNNN` via compteur
  `SELECT … FOR UPDATE`, transitions de statut en read-decide-write verrouillé.
- **Moteur PDF réutilisable** (`app/pdf/` n'importe que `app.pdf.*`) — prêt
  pour factures/avoirs/bons de commande.
- **Sécurité de base solide** : JWT, tenant → 404, rate limiting sur `/auth`,
  validation d'upload (magic bytes), refus de démarrage sur secret placeholder
  en production.

**Dette technique**
- **Cycle de modules `users ↔ branding`** : `Company` vit dans `branding`
  alors que l'inscription en crée une. Aucun cycle à l'import, mais entorse au
  « sens unique ». → extraire un module `companies`.
- **`python-jose` non maintenu** (2021) → migrer vers **PyJWT**.
- **Rate limiting en mémoire par worker** (plafond ≈ 4× avec 4 workers, IP du
  socket) → **Redis** partagé + `X-Forwarded-For`.
- **Tests sans isolation** : tournent contre la vraie base, sans rollback par
  test → base de test dédiée / transaction par test.
- **Corps chunké non borné** (le garde lit `Content-Length`) → reverse proxy.
- **Parsing IA tout-ou-rien (502)** sur réponse malformée ; la correction
  tolérante doit remonter les items rejetés au scorer.

## 2. Frontend (Flutter)

**Stack** : Flutter 3.44 · Riverpod · GoRouter · Dio · Freezed · **Exo 2 /
Orbitron** · Design System centralisé.

**Architecture** : **feature-first** (`data / domain / presentation`), miroir
des modules backend. `core/api/` seule couche connaissant Dio.

**Points forts**
- **Design System unique** (`core/theme/app_theme.dart`) : palette officielle
  en jetons, **aucune couleur codée en dur dans les widgets**, composants
  réutilisables (`AppTextField`, `AppPrimaryButton`, …).
- État serveur en `AsyncNotifier`, formulaire en `Notifier` ; 4 états
  (loading/error/empty/data) mutualisés.
- Modèles typés Freezed, montants `Decimal` reçus en `String` (jamais
  recalculés côté client).

**Dette technique**
- **Quelques champs en label-flottant** dans des flux secondaires (aperçu
  d'import, feuilles modales) pas encore convertis à `AppTextField` (cohérents
  via le thème, mais pas au motif label-au-dessus).
- **Pas d'écran d'édition directe de l'identité** (hors flux d'import PDF) ;
  pas d'upload de logo dans l'app (l'API le permet).
- **Aucun test end-to-end fiable sur appareil** : l'IME du téléphone de test
  bloque l'automatisation ; validation manuelle.
- **Chaînes de version** historiquement divergentes (alignées en RC2).

## 3. Base de données

12 tables : `companies`, `brand_profiles`, `document_templates`,
`catalog_categories`, `catalog_items`, `clients`, `quotes`, `quote_lines`,
`quote_counters`, `document_analyses`, `document_detection_results`, `users`.

**Points forts** : contraintes réelles (`UNIQUE(company_id, quote_number)`,
FK RESTRICT/CASCADE cohérents), `Numeric` pour tous les montants (jamais
`Float`), migrations relues à la main (backfill, drop des enums).

**Risques scalabilité** : pas encore d'index métier explicites au-delà des
clés ; `document_analyses.extracted_text`/`blueprint` en colonnes JSON/texte
volumineuses (à surveiller) ; multi-tenant par `company_id` sans partitionnement
(suffisant à moyen terme).

## 4. Docker & exploitation

**Points forts** : image de prod par défaut (non-root, `--workers 4`),
compose de dev distinct, entrypoint réparant la propriété du volume, `/health`
avec vrai `SELECT 1`, `.gitattributes` (LF) pour Windows.

**Dette / risques** : pas de stratégie de sauvegarde automatisée (procédures
manuelles testées documentées) ; Docker Desktop instable sur l'environnement
WSL 2 de dev (proxy de ports intermittent) ; pas d'orchestration prod définie
(K8s/ECS) ni de CI/CD.

## 5. Design System

**Excellent** : source unique, palette officielle (bleu nuit #10233F, or
#D4AF37, bleu secondaire #1C355E, fond #F8FAFC, textes #1E293B/#64748B,
succès/erreur/info/warning), typographie ENR (Exo 2 + Orbitron), composants,
espacements 8px, PDF aligné. **À conserver strictement en V3.**

## 6. Tests

214 pytest + 68 flutter test + suites de casse (cycle de vie, PDF) + QA HTTP.
**Trou** : pas d'isolation des tests backend, pas d'E2E device fiable, pas de
test de charge. Couverture fonctionnelle bonne, couverture non-fonctionnelle
(perf/charge) inexistante.

## 7. Sécurité (synthèse)

Solide au niveau applicatif (JWT, tenant 404, rate limit, uploads, secrets).
**À durcir en V3** : PyJWT, cookie HttpOnly (web), rate limit partagé, audit
externe, RGPD (données clients, droit à l'effacement, chiffrement au repos des
uploads sensibles), journalisation d'audit.

## 8. Performance & scalabilité

- **Bon** : opérations CPU-bound (PDF, pypdf) déportées hors event loop
  (`asyncio.to_thread`) ; requêtes groupées (lignes de devis).
- **À prévoir V3** : cache (Redis) ; pagination systématique ; index métier ;
  file de tâches asynchrones (OCR, IA lourde, emails) — aujourd'hui tout est
  synchrone dans la requête ; stockage objet (S3) pour les pièces jointes.

## 9. Synthèse — forces / dettes / à refactorer

| Forces | Dettes | À refactorer (V3) |
|---|---|---|
| Modules verticaux nets | Cycle users↔branding | Extraire `companies` |
| Invariant monétaire | python-jose non maintenu | Auth → PyJWT + cookie HttpOnly |
| Moteur PDF réutilisable | Rate limit par worker | Redis (rate limit + cache + broker) |
| Design System unique | Tests sans isolation | Base de test + transaction par test |
| Abstractions provider | Pas de file async | File de tâches (Celery/Arq) |
| Multi-tenant 404 | Pas de CI/CD | CI (analyze/test/build) + CD |

## 10. Composants réutilisables identifiés (à capitaliser en V3)

- **Backend** : `app/pdf/` (documents), `ai/factory` + `AIProvider` (tout
  module IA), `storage` (pièces jointes), `repositories/base`,
  `core/authorization` (tenant), `quotes/calculator` (tout calcul monétaire :
  factures, avoirs).
- **Frontend** : le Design System complet (`ArtizenColors`, composants), les 4
  états mutualisés, `core/api` (Dio + intercepteurs), le motif AsyncNotifier.

## 11. Risques futurs

1. **Explosion du périmètre IA** sans architecture de tâches asynchrones →
   requêtes qui gèlent (à traiter AVANT le module IA — voir `03_IA…`).
2. **Conformité légale facturation** (numérotation sans trou, art. 242 nonies A
   CGI ; e-invoicing / Factur-X 2026-2027) → structurante pour le module
   Facturation.
3. **RGPD** (données clients) → chiffrement, effacement, export.
4. **Dette d'auth** (python-jose) → bloquante si audit sécurité.
5. **Absence de CI/CD** → régressions non détectées à mesure que l'équipe/les
   modules croissent.
