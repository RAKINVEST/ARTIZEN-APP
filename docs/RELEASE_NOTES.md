# Release Notes — ARTIZEN V2.0.0-RC1

**Date : 2026-07-17.** Tag : `v2.0.0-rc1`. Branche : `v2`.
Statut : **Release Candidate** (gelée — aucune modification de code au-delà
de ce tag).

Artizen est un SaaS de devis pour artisans du bâtiment : backend FastAPI +
client Flutter. La V1 (`v1.0.0-rc1`) posait le catalogue, les clients, la
composition d'un devis et le copilote IA. **La V2 donne au devis une vie
après sa composition** : un numéro, un statut, un PDF, et la duplication.

## Nouveautés V2

### Cycle de vie du devis — numéro + statut

- **Numérotation `DEV-2026-0001`** : préfixe, année, séquence remise à zéro
  chaque année, **unique par entreprise** (garantie en base par
  `UNIQUE (company_id, quote_number)`). Le numéro vient d'une table
  `quote_counters` verrouillée `SELECT … FOR UPDATE` — jamais un
  `SELECT MAX+1`, qui donnerait le même numéro à deux créations simultanées.
- **Statuts `draft` → `sent` → `accepted` / `refused`** via
  `PUT /api/quotes/{id}/status`. Les transitions vivent dans une table
  (`QUOTE_TRANSITIONS`) ; **rien ne revient jamais à `draft`**. Les
  transitions concurrentes sont protégées par un verrou de ligne
  (`FOR UPDATE`) dans `change_status` et `delete`.

### Moteur PDF réutilisable

- `GET /api/quotes/{id}/pdf` rend un PDF (reportlab, pur Python — aucune
  bibliothèque système). `app/pdf/` n'importe que `app.pdf.*` : il ne sait
  pas ce qu'est un devis, ce qui le rend réutilisable pour factures, avoirs
  et bons de commande sans branche par type.
- **Il ne calcule rien** : chaque montant arrive déjà calculé par
  `QuoteCalculator`. Rendu à la demande, jamais stocké. Exécuté hors event
  loop (`asyncio.to_thread`). Dégradation systématique : logo illisible ou
  identité absente → l'artisan perd le logo, jamais son document.

### Duplication

- `POST /api/quotes/{id}/duplicate` crée un nouveau brouillon copiant les
  lignes d'un devis existant (l'instantané, pas une re-tarification depuis le
  catalogue courant — robuste même si un article a été désactivé depuis).
  Les totaux sont recalculés par `QuoteCalculator` ; le numéro est neuf via
  le même compteur verrouillé. Disponible dans tous les statuts.
- C'est **le chemin d'édition qu'un devis n'a pas** : puisqu'un devis ne se
  modifie pas en place, on le corrige/réutilise en le dupliquant.

### Interface Flutter du cycle de vie et du PDF

- Le numéro `DEV-2026-0042` remplace le décompte de lignes partout (liste,
  détail, dashboard). `QuoteStatusChip` : couleur **et** libellé. Actions
  pilotées par `QuoteStatus.nextStates`, miroir des transitions backend.
  Confirmation sur « Marquer comme envoyé » seulement (l'étape
  irréversible). Garde anti-double-clic. PDF via le package `printing`
  (aperçu / impression / partage), octets transitant par Dio car l'endpoint
  exige l'en-tête `Authorization`.

## Ce qui n'a PAS changé (invariants tenus)

- **L'IA ne choisit aucun prix, aucune TVA, ne persiste rien.**
- **`quotes/calculator.py` reste le seul endroit où un montant se calcule**
  (tout en `Decimal`, `ROUND_HALF_UP` par ligne).
- **Il n'y a toujours ni `PUT` ni `PATCH` sur le contenu d'un devis** :
  modification = suppression-recréation ou duplication. C'est ce qui garantit
  que les totaux persistés restent cohérents avec les lignes.
- **`company_id` vient toujours du JWT** ; un mismatch de tenant renvoie
  **404, jamais 403**.
- **`DELETE /api/quotes/{id}` n'accepte plus que les brouillons** (409 sinon).

## Validations exécutées

| Porte | Résultat |
|---|---|
| `pytest` (local et **conteneur Docker**) | **208 passed** |
| `flutter analyze` | No issues found! |
| `flutter test` | **63 passed** |
| `flutter build web --release` | construit (avec `printing`) |
| Migration + rollback (Docker) | 6 migrations, aller-retour propre |
| Tentative de casse — cycle de vie | 18/18 |
| Tentative de casse — moteur PDF | 14/14 |
| QA HTTP Docker — parcours V2.1 | 21/21 |
| QA HTTP Docker — duplication | 19/19 |
| QA HTTP — sécurité V2 | 14/14 |
| Durcissements V1 rejoués sur v2 | 11/11 |
| **UAT — parcours artisan 17 étapes dans un vrai navigateur** | **franchie** ; 13/13 vérifications d'invariants backend |

Détail : `docs/release/07_V2_CERTIFICATION.md` (certification) et
`docs/release/08_USER_ACCEPTANCE_TEST.md` (UAT).

## Limitations connues (V2.x / V3)

Voir `docs/KNOWN_LIMITATIONS.md`. En bref : rate limiting en mémoire par
worker (Redis en V3), JWT en `localStorage` sur le web (cookie HttpOnly en
V3), `python-jose` non maintenu (migration PyJWT en V3), pas d'édition en
place du devis (par conception), cycle `users ↔ branding` (refactor V3).
*(La divergence de métadonnée de version relevée au RC1 est corrigée en
RC2 : backend, frontend et documentation alignés sur `2.0.0`.)*

## Périmètre volontairement hors V2

Aucune facture, aucun avoir, aucun bon de commande **implémentés** — mais le
moteur PDF et l'architecture de statuts sont conçus pour les accueillir sans
réécriture. Feuille de route : `docs/ROADMAP.md`.
