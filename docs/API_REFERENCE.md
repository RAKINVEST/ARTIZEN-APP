# Référence API — ARTIZEN V2 (`v2.0.0-rc1`)

Inventaire produit par lecture directe des `router.py` et `schemas.py` du
commit tagué. La source vivante et interactive reste **Swagger** :
`http://localhost:8000/docs` (et `GET /openapi.json`).

**44 endpoints HTTP** : 39 routes métier sous `/api` + 2 routes
d'infrastructure codées (`/`, `/health`) + 3 auto-générées par FastAPI
(`/docs`, `/redoc`, `/openapi.json`).

## Conventions transverses

- **Préfixe.** Tous les routers métier sont montés sous `API_PREFIX` = `/api`.
  Seuls `/` et `/health` y échappent.
- **Authentification.** JWT `Bearer` requis partout **sauf**
  `POST /api/auth/register` et `POST /api/auth/login`. En-tête
  `Authorization: Bearer <token>`.
  - **En-tête absent → 403** (`forbidden`, levé par `HTTPBearer`).
  - **Token présent mais invalide/expiré → 401** (`unauthorized`).
- **`company_id` vient toujours du JWT.** Sur les `POST`, le champ reçu est
  écrasé par celui du token (`model_copy`). Il est donc optionnel et ignoré
  dans les schémas d'entrée. Aucune route de collection n'accepte de
  `company_id` en query.
- **Isolation tenant → 404, jamais 403.** Un accès à une ressource d'une
  autre entreprise renvoie 404 (`ensure_same_company`).
- **Montants sérialisés en chaînes.** Tous les `Decimal` (`total_ht`,
  `unit_price_ht`, `vat_rate`, `quantity`…) sont du JSON **string** :
  `"200.00"`. Le client Flutter les affiche tels quels.
- **Enveloppe d'erreur** stable : `{"error": {"code": "<slug>", "message": "…"}}`.
  Les 422 ajoutent `details`.
- **Limite de corps globale** : > 20 Mo → **413** `file_too_large` avant tout
  parsing.

## Infrastructure

| Méthode + chemin | Auth | Réponse |
|---|---|---|
| `GET /` | Public | `{name, version, status, docs}` |
| `GET /health` | Public | `{status: "ok"\|"degraded", version, environment, database: "ok"\|"unavailable"}` — exécute un vrai `SELECT 1` ; **toujours HTTP 200** (le champ `status` porte l'état). |
| `GET /docs`, `/redoc`, `/openapi.json` | Public | Swagger UI / ReDoc / schéma OpenAPI |

## `auth` — `/api/auth`

| Méthode + chemin | Auth | Corps | Succès | Erreurs |
|---|---|---|---|---|
| `POST /api/auth/register` | Public | `{email, password (8–72), full_name?, company_name?}` | **201** `{access_token, token_type, user}` | 409 `email_already_registered` · 422 · 429 |
| `POST /api/auth/login` | Public | `{email, password}` | **200** `{access_token, token_type, user}` | 401 `unauthorized` (message identique email inconnu / mauvais mdp) · 429 |
| `GET /api/auth/me` | JWT | — | **200** `UserRead` | 401/403 |

**Rate limiting** (`login`/`register` seulement) : 10 requêtes / 60 s par IP,
dépassement → **429** + `Retry-After: 60`.

## `branding` — `/api/branding` (JWT)

| Méthode + chemin | Corps | Succès | Erreurs |
|---|---|---|---|
| `POST /api/branding/logo` | `multipart` `file` (PNG/JPEG/SVG, ≤ 5 Mo) | **201** `StoredFileInfo` (remplace l'ancien logo) | 415 `unsupported_file_type` · 413 |
| `POST /api/branding/template/quote` | `file` PDF ≤ 15 Mo | **201** `TemplateUploadResult` | 415 · 413 |
| `POST /api/branding/template/invoice` | idem | **201** | idem |
| `GET /api/branding/profile` | — | **200** `{company, brand, templates[]}` | 404 |
| `PUT /api/branding/company` | `CompanyUpdate` (name, legal_name, siret, vat_number, address_line, postal_code, city, country, phone, email, website — tous optionnels) | **200** `CompanyRead` | 404 |
| `PUT /api/branding/brand` | `{primary_color?, secondary_color?, font_family?, tagline?}` | **200** `BrandProfileRead` | 404 |

## `catalog` — `/api/catalog` (JWT)

| Méthode + chemin | Corps | Succès | Erreurs |
|---|---|---|---|
| `POST /api/catalog/categories` | `{name, description?}` | **201** | 422 |
| `GET /api/catalog/categories` | query `offset, limit` | **200** liste | — |
| `GET/PUT /api/catalog/categories/{id}` | — / `{name?, description?}` | **200** | 404 |
| `DELETE /api/catalog/categories/{id}` | — | **204** | 404 · **409** `conflict` si la catégorie a des items |
| `POST /api/catalog/items` | `{category_id, designation, item_type (service\|product), unit, unit_price_ht, vat_rate (0–100), code?, description?, estimated_duration_minutes?}` | **201** | 404 (catégorie autre tenant) · 422 |
| `GET /api/catalog/items` | query `active_only=false, offset, limit` | **200** liste | — |
| `GET/PUT /api/catalog/items/{id}` | — / `CatalogItemUpdate` (+`active?`) | **200** | 404 |
| `DELETE /api/catalog/items/{id}` | — | **200** `CatalogItemRead` (**soft-delete** : `active=false`) | 404 |

## `clients` — `/api/clients` (JWT)

| Méthode + chemin | Corps | Succès | Erreurs |
|---|---|---|---|
| `POST /api/clients` | `{last_name, first_name?, company_name?, address?, phone?, email?, notes?}` | **201** | 422 |
| `GET /api/clients` | query `q?` (recherche nom/société/tél/email), `offset, limit` | **200** liste | — |
| `GET/PUT /api/clients/{id}` | — / `ClientUpdate` | **200** | 404 |
| `DELETE /api/clients/{id}` | — | **204** | 404 · **409** `conflict` si le client a des devis |

## `quotes` — `/api/quotes` (JWT) — **cœur de la V2**

**Statuts** : `draft`, `sent`, `accepted`, `refused`.
**Transitions** (`QUOTE_TRANSITIONS`) : `draft→sent` ; `sent→accepted` ;
`sent→refused` ; `accepted`/`refused` terminaux. **Rien ne revient à
`draft`.** Une transition vers le même statut est **idempotente** (200). Une
transition interdite → **409** `invalid_quote_transition`. `change_status` et
`delete` verrouillent la ligne `FOR UPDATE`.

| Méthode + chemin | Corps | Succès | Erreurs |
|---|---|---|---|
| `POST /api/quotes` | `{client_id, lines: [{catalog_item_id, quantity (>0)}]}` — **aucun prix en entrée** (les montants viennent du catalogue via `QuoteCalculator`) | **201** `QuoteRead` (statut `draft`, numéro `DEV-2026-0001`) | 404 (client/item autre tenant) · **409** `inactive_catalog_item` · 422 |
| `GET /api/quotes` | query `offset, limit` | **200** liste (scopée tenant) | — |
| `GET /api/quotes/{id}` | — | **200** `QuoteRead` | 404 |
| `POST /api/quotes/{id}/duplicate` | — | **201** `QuoteRead` (nouveau `draft`, nouveau numéro ; lignes copiées verbatim, totaux recalculés). Tous statuts. | 404 |
| `GET /api/quotes/{id}/pdf` | — | **200** `application/pdf`, `Content-Disposition: attachment; filename="DEV-2026-0001.pdf"`. Tous statuts. Rendu à la volée. | 404 |
| `PUT /api/quotes/{id}/status` | `{status}` | **200** `QuoteRead` (**ne touche aucun montant**) | 404 · **409** `invalid_quote_transition` |
| `DELETE /api/quotes/{id}` | — | **204** (**hard-delete, brouillon uniquement** ; lignes cascadées) | 404 · **409** `quote_not_editable` si ≠ `draft` |

**Verbes volontairement absents.** Il n'existe **ni `PUT` ni `PATCH`** sur le
contenu d'un devis. La seule mutation est `PUT .../{id}/status`. Corriger un
devis = supprimer le brouillon (ou dupliquer) puis recréer via `POST`.

### `QuoteRead`

```json
{
  "id": "uuid", "company_id": "uuid", "client_id": "uuid",
  "quote_number": "DEV-2026-0001",
  "status": "draft|sent|accepted|refused",
  "total_ht": "200.00", "total_vat": "40.00", "total_ttc": "240.00",
  "lines": [{
    "id": "uuid", "catalog_item_id": "uuid", "designation": "…", "unit": "u",
    "quantity": "1.00", "unit_price_ht": "200.00", "vat_rate": "20.00",
    "total_ht": "200.00", "total_vat": "40.00", "total_ttc": "240.00"
  }],
  "created_at": "…", "updated_at": "…"
}
```

## `quote_assistant` — `/api/quote-assistant` (JWT)

| Méthode + chemin | Corps | Succès | Notes |
|---|---|---|---|
| `POST /api/quote-assistant/suggest` | `{description (1–5000)}` | **200** `{items: [{catalog_item_id, designation, quantity, reason}], confidence, comment}` | **Ne crée aucun devis, ne persiste rien.** `quantity` = seule valeur numérique inférée par l'IA. Fonctionne sans clé API (mock). |

## `document_analysis` — `/api/document-analysis` (JWT)

| Méthode + chemin | Corps | Succès | Erreurs |
|---|---|---|---|
| `POST /api/document-analysis/upload` | `multipart` : `document_type (quote\|invoice)`, `file` | **201** `DocumentAnalysisRead` | 415 · 413 · 422 |
| `GET /api/document-analysis` | query `offset, limit` | **200** liste | — |
| `GET /api/document-analysis/{id}` | — | **200** | 404 |
| `POST /api/document-analysis/{id}/process` | — | **200** (déclenche extraction/analyse) | 404 · 422 `invalid_document` |

## `document_detection` — `/api/document-analysis/{id}/detection` (JWT)

| Méthode + chemin | Succès | Erreurs |
|---|---|---|
| `GET /api/document-analysis/{id}/detection` | **200** `DocumentDetectionResultRead` (logo, couleurs, en-tête/pied, table, SIRET/TVA, mentions légales, score de confiance). Lazy : lance la détection si absente. | 404 · **409** `document_not_processed` si l'analyse n'a pas encore été traitée |

## `template_import` — `/api/template-import` (JWT)

| Méthode + chemin | Corps | Succès | Erreurs |
|---|---|---|---|
| `GET /api/template-import/{id}/preview` | — | **200** `{analysis, detection, current_company, current_brand}` (comparaison détecté vs actuel) | 404 |
| `POST /api/template-import/{id}/validate` | `{name?, legal_name?, siret?, vat_number?, address_line?, postal_code?, city?, phone?, email?, website?, primary_color?, secondary_color?}` — valeurs **finales** confirmées par l'artisan | **200** `BrandingProfileRead` | 404 · **409** `invalid_document_type_for_template` |

**N'applique rien sans confirmation** (invariant produit n°7).
