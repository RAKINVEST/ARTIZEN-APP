# 04 — Dossier de livraison — Artizen V1

> ⚠️ **Artefact de certification V1**, figé à la date du tag `v1.0.0-rc1` (2026-07-17).
> Ce document décrit la **V1**, pas l'état courant de la branche `v2`. Pour la V2, voir
> `CHANGELOG.md`, `docs/ROADMAP.md` et `docs/release/07_V2_CERTIFICATION.md`.


**Date : 2026-07-17.** Tag : `v1.0.0-rc1`.

## Verdict

**Release Candidate — sous une réserve nommée.**

Toutes les portes de validation ont été franchies avec succès. Mais une
distinction doit être faite, et elle est le cœur de ce document :

- **6 validations sont reproductibles aujourd'hui**, avec des artefacts
  dans `evidence/` (pytest, flutter analyze, flutter test, flutter build
  web, alembic upgrade, tests de casse).
- **6 validations Docker ont réussi mais ne sont pas rejouables** — leur
  seule trace est la console de session. Docker Desktop s'est arrêté après
  coup et ne redémarre pas sans un redémarrage de Windows.

**Ce que ça signifie concrètement : la V1 est une Release Candidate, mais
sa branche Docker n'est certifiée que par observation, pas par artefact.**
Un `docker compose up` après redémarrage lève cette réserve en 20 minutes.
Je ne la maquille pas.

## Validations réellement exécutées

| Validation | Résultat | Rejouable ? |
|---|---|---|
| `pytest` (local, deps épinglées) | **142 passed** | ✅ `evidence/pytest.txt` |
| `pytest` (dans le conteneur) | **142 passed** | ❌ Docker arrêté |
| `flutter analyze` | **No issues found!** | ✅ `evidence/flutter_analyze.txt` |
| `flutter test` | **53 passed** | ✅ `evidence/flutter_test.txt` |
| `flutter build web --release` | **✓ Built build\web** | ✅ `evidence/flutter_build_web.txt` |
| `alembic upgrade head` | 5 migrations, exit 0 | ✅ `evidence/alembic_upgrade.txt` |
| Casse volontaire | **24/24** | ✅ `evidence/break_attempt.txt` |
| `docker compose build/up/down/restart` | OK, 14/14 scénarios | ❌ |
| QA fonctionnelle HTTP Docker | **32/32** | ❌ (script fourni) |
| Rollback Alembic | 4 ENUM → 0 → upgrade OK | ❌ |

**Total : 219 vérifications automatisées** (142 + 53 + 24).

## Validations impossibles — et pourquoi

1. **Docker, aujourd'hui.** Noyau WSL 2 installé avec `/norestart` ;
   Windows n'a jamais redémarré. La distribution `docker-desktop` retombe
   en `Stopped`. Ni `wsl --shutdown` ni la relance de Docker Desktop n'y
   changent rien. **Ce n'est pas le produit, c'est la machine.**
2. **Le parcours manuel bout en bout.** Aucun test Flutter n'appelle le
   vrai backend (fakes/mocks partout, limite documentée depuis l'origine).
   `flutter build web` compile, mais personne n'a cliqué dans
   l'application contre un backend réel. **C'est le trou de validation le
   plus important qui reste, et aucune automatisation ne le comble.**
3. **La montée en charge.** Aucun test de performance sous concurrence
   réelle. Les correctifs de disponibilité (bombe PDF, `to_thread`,
   corps borné) sont raisonnés et testés unitairement, pas éprouvés sous
   charge.

## Risques résiduels

| Risque | Gravité | Atténuation en place |
|---|---|---|
| **Rate limiter en mémoire par worker** — la production lance 4 workers, le plafond réel est donc ~4× celui configuré ; il fait aussi confiance à l'IP du socket, donc inopérant derrière un proxy sans `X-Forwarded-For` | Moyenne | Il ferme le trou béant (énumération illimitée). Un store partagé (Redis) est la forme V2. |
| **Corps chunké non borné** — le garde lit `Content-Length` ; une requête chunkée passe outre | Faible | La limite par endpoint s'applique quand même (après buffering). Un reverse proxy la ferme. |
| **JWT en localStorage sur le web** — `flutter_secure_storage` y retombe ; tout XSS lit le token | Moyenne | Documenté dans le code. Cookie `HttpOnly` = V2. |
| **`python-jose` non maintenu** (dernière version 2021) — 219 avertissements de dépréciation | Moyenne | Fonctionne, crypto vérifiée (`alg=none` rejeté, expiration gérée). Migrer vers PyJWT. |
| **`users ↔ branding` : cycle de modules** | Faible | Aucun cycle à l'import (prouvé). Entorse réelle au « sens unique » du README. |
| **Devis ni numéroté ni statué** | Moyenne (produit) | `DELETE` couvre la correction. L'absence de `PUT` est ce qui garantit la cohérence des totaux — voir ci-dessous. |
| **Docker Desktop instable sur WSL2 fraîche** | Faible | Redémarrage de Windows. |

## Le risque qu'il faut comprendre avant de toucher aux devis

L'absence de route d'écriture sur `/quotes` **n'est pas un oubli : c'est
aujourd'hui la seule garantie** que les totaux persistés restent cohérents
avec les lignes. `QuoteCalculator` n'a aucune fonction de recalcul sur un
devis existant, et rien dans l'architecture n'obligerait un futur
`PUT /quotes/{id}` à repasser par lui.

**Ajouter `status` (seul un `draft` modifiable) doit précéder toute route
de modification.** Dans l'ordre inverse, on ouvre la porte à des devis dont
le total ne correspond plus aux lignes — le pire défaut possible pour ce
produit.

## Check-list de mise en production

### Bloquant

- [ ] **Redémarrer Windows**, puis `docker compose up -d` et vérifier
      `/health` → `{"database":"ok"}`.
- [ ] **Générer un vrai `SECRET_KEY`** :
      `python -c "import secrets; print(secrets.token_urlsafe(64))"`.
      *(Le code refuse déjà de démarrer en production sur le placeholder —
      vérifié par exécution.)*
- [ ] **`ENVIRONMENT=production`** et **`DEBUG=false`** dans `.env`.
      *(Le code refuse `DEBUG=true` en production — vérifié.)*
- [ ] **Changer `POSTGRES_PASSWORD`** (`change_me` par défaut).
- [ ] **Reverse proxy devant uvicorn** avec une limite de corps et TLS.
      uvicorn est aujourd'hui exposé en direct sur `:8000`.
- [ ] **Ne pas déployer `docker-compose.yml` tel quel** : c'est la pile de
      *développement* (`--reload`, bind mount). L'image, elle, est déjà en
      production par défaut (`--workers 4`, non-root).

### Fortement recommandé

- [ ] Sauvegarde de `artizen_postgres_data` et `artizen_storage_data`.
      **Aucune stratégie de sauvegarde n'existe.**
- [ ] `CORS_ORIGINS` sur le vrai domaine (vient de `.env`, **pas** du
      compose — erreur corrigée dans les trois documents).
- [ ] Clé `ANTHROPIC_API_KEY` si le copilote doit être réel. Sans elle,
      `MockAIProvider` prend le relais : l'app démarre et le copilote
      répond — mais avec un appariement par mots-clés, pas une IA.
- [ ] Parcours manuel complet dans un navigateur contre le backend réel.

### À surveiller après mise en production

- [ ] `quote_assistant.catalog_truncated` dans les logs — apparaît si une
      entreprise dépasse 1000 articles actifs.
- [ ] `branding.previous_logo_delete_failed` — fuite de fichiers.
- [ ] `anthropic.request_failed` — indisponibilité du fournisseur (503).
- [ ] Taux de 429 sur `/auth/*` — un pic signale une attaque ou un
      plafond trop bas.

## Recommandations V2, par ordre de valeur

1. **Cycle de vie du devis** : `status` **avant** toute route d'écriture,
   puis `quote_number` unique **par entreprise garanti en base** (jamais un
   `SELECT MAX+1` applicatif). La numérotation séquentielle sans trou est
   une obligation légale pour les *factures* (art. 242 nonies A CGI) — elle
   le deviendra dès que ces devis se transformeront en factures.
2. **Endpoint de comptage** (`GET /clients/count`, …) : supprime le
   « 100+ » du dashboard au profit du vrai total.
3. **Cookie `HttpOnly` + `SameSite`** pour le web (`allow_credentials` est
   déjà actif).
4. **Remplacer `python-jose` par PyJWT** : projet non maintenu, 219
   avertissements.
5. **Rate limiting partagé** (Redis) + `X-Forwarded-For`.
6. **Parsing IA tolérant** : un article malformé ne doit pas faire perdre
   toute la réponse (502). Attention : la correction doit faire remonter
   les items rejetés jusqu'à `SuggestionScorer`, sinon le score de
   confiance devient trop optimiste.
7. **Scorer** : les doublons sont pénalisés deux fois (mesuré : 0.40 au
   lieu de 0.85 pour un article proposé deux fois). Arbitrage produit.
8. **`ApiClient` dans `core/api/`** : les 7 features importent Dio
   directement, contrairement au contrat.
9. **Casser le cycle `users ↔ branding`** : déplacer `Company` hors de
   `branding`, ou extraire un module `companies`.
10. **Isolation des tests backend** : ils tournent contre la vraie base,
    sans rollback par test. Limite assumée depuis l'origine.

## Ce que je certifie, et ce que je ne certifie pas

**Je certifie** que les 219 vérifications automatisées passent, que les
invariants monétaires tiennent (vérifiés mécaniquement : aucun calcul hors
`calculator.py`, aucun `float` sur un montant, aucune colonne `Float`,
`ROUND_HALF_UP` centralisé), que l'isolation multi-tenant tient sur les 36
routes métier, et que l'application résiste à 24 tentatives de casse
délibérées sans jamais renvoyer de 500.

**Je ne certifie pas** que Docker fonctionne aujourd'hui sur cette machine
— il a fonctionné, il ne fonctionne plus, et la cause est un redémarrage
Windows en attente. Ni qu'un artisan a cliqué dans l'application de bout en
bout : personne ne l'a fait.
