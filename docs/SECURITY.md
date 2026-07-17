# Sécurité — ARTIZEN V2

Ce document décrit le modèle de sécurité **réellement en place** au commit
`v2.0.0-rc1`, ses gardes vérifiées, et ses limites connues. Les affirmations
sont adossées au code ou à des tests exécutés (14/14 QA sécurité V2,
11/11 durcissements V1 rejoués — `docs/release/07_V2_CERTIFICATION.md`).

## Authentification

- **JWT `Bearer`**, signé `HS256` avec `SECRET_KEY`. Requis sur toutes les
  routes sauf `POST /api/auth/register` et `POST /api/auth/login`.
- **En-tête absent → 403** ; **jeton présent mais invalide/expiré/`sub`
  illisible → 401**. Distinction vérifiée par test.
- **`alg=none` rejeté**, expiration honorée (vérifié).
- Mots de passe **hachés** (passlib + bcrypt). `bcrypt==4.0.1` épinglé
  (compatibilité passlib 1.7.4).
- Login : message **identique** pour email inconnu et mauvais mot de passe
  (`"Invalid email or password."`) — pas d'oracle d'existence de compte.

## Secrets et configuration

- **`SECRET_KEY`** : le code **refuse de démarrer** en
  `ENVIRONMENT=production` si la clé est le placeholder de `.env.example` ou
  fait moins de 32 caractères (`config.py`). Générer :
  `python -c "import secrets; print(secrets.token_urlsafe(64))"`.
- **`DEBUG=true` refusé** en production (`config.py`).
- Aucune lecture de `os.environ` hors de `core/config.py` : toute la config
  passe par le singleton `settings`.

## Isolation multi-tenant

- **`company_id` vient toujours du JWT**, jamais du client : les `POST`
  écrasent la valeur reçue (`model_copy`), et aucune route de collection
  n'accepte de `company_id` en query.
- **Un mismatch de tenant renvoie 404, jamais 403** (`ensure_same_company`) —
  un 403 confirmerait l'existence d'une ressource d'une autre entreprise.
- Vérifié sur les routes V2 : un autre tenant obtient **404** sur
  `GET/PDF/status/duplicate` d'un devis, et une liste vide (UAT
  `08_USER_ACCEPTANCE_TEST.md`, QA `14/14`).

## Rate limiting

- Actif par défaut (`AUTH_RATE_LIMIT_ENABLED=true`) sur `login`/`register`,
  les seules routes sans JWT. 10 requêtes / 60 s par IP → **429** +
  `Retry-After: 60`. C'est ce qui empêche l'énumération illimitée de la base
  d'utilisateurs.
- **Limites connues** (reportées V3, `KNOWN_LIMITATIONS.md`) : le compteur
  vit **en mémoire par worker** (avec 4 workers, plafond réel ≈ 4× la
  valeur) et fait confiance à l'**IP du socket** (inopérant derrière un proxy
  sans `X-Forwarded-For`). Un store partagé (Redis) est la forme V3.

## Uploads

- Validation par **type MIME et magic-bytes** : logo (PNG/JPEG/SVG, ≤ 5 Mo),
  modèles PDF (≤ 15 Mo) → **415** `unsupported_file_type` / **413**
  `file_too_large` sinon.
- **Limite de corps globale** : > 20 Mo → **413** avant tout parsing
  (`MaxBodySizeMiddleware`). Limite : lit `Content-Length`, donc une requête
  **chunkée** passe outre — un reverse proxy ferme ce trou en production.
- Le PDF/branding est rendu/servi sans injection d'en-tête (vérifié 14/14).

## Surface réseau et transport

- uvicorn est exposé en direct sur `:8000` en dev. **En production : reverse
  proxy avec TLS + limite de corps** (`DEPLOYMENT_GUIDE.md`).
- CORS restreint à `CORS_ORIGINS` (défaut `http://localhost:3000`), à régler
  sur le domaine réel.

## Session côté client (web)

- Le JWT est stocké dans le **`localStorage`** du navigateur
  (`flutter_secure_storage` y retombe sur web) : **tout XSS pourrait le
  lire**. Un cookie `HttpOnly` + `SameSite` est la forme V3
  (`allow_credentials` est déjà actif côté backend).

## Dépendance de crypto à surveiller

- **`python-jose` n'est plus maintenu** (dernière version 2021). La crypto
  utilisée est vérifiée (`alg=none` rejeté, expiration gérée), mais la
  migration vers **PyJWT** est planifiée V3.

## Ce qui n'a pas été éprouvé

- **Charge sous concurrence réelle** : les chemins concurrents critiques
  (numérotation `FOR UPDATE`, transitions `get_for_update`) ont des tests
  `asyncio.gather` et ont tenu sous un rejeu réel double en UAT, mais aucune
  épreuve de charge n'a été menée.
- **Audit de sécurité externe** : non réalisé.

## Signalement d'une vulnérabilité

Ce dépôt ne définit pas encore de canal officiel de divulgation. En
attendant, signalez toute vulnérabilité en privé au responsable du dépôt
(ne pas ouvrir d'issue publique décrivant un exploit). Mettre en place un
contact de sécurité dédié est recommandé avant une exposition publique.
