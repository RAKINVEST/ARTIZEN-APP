# Rapport final de release — ARTIZEN V2.0.0-RC2

**Date : 2026-07-17.** Branche `v2`. Tags : **`v2.0.0-rc1`** (photographie
certifiée, figée) et **`v2.0.0-rc2`** (alignement des versions sur `2.0.0`).
Rôle : Release Manager. Ce rapport unique synthétise l'état de la Release
Candidate V2 et renvoie aux documents détaillés du package. Sauf la version,
tout ce qui suit décrit un code strictement identique entre RC1 et RC2 (la
RC2 ne touche que des métadonnées de version).

---

## 1. Résumé exécutif

Artizen est un SaaS de devis pour artisans du bâtiment (backend FastAPI +
client Flutter). La **V2 donne au devis une vie après sa composition** :
numéro, statut, PDF, duplication, et l'interface Flutter correspondante.

La V2 est **une Release Candidate gelée** (`v2.0.0-rc1`). Son périmètre est
figé, certifié sur 9 axes d'audit, et **validé en conditions proches de la
production** : le parcours artisan complet a été piloté dans un vrai
navigateur Chrome contre la pile Docker réelle (UAT), et vérifié en base,
dans les logs et sous l'angle multi-tenant.

**Verdict : aucune anomalie bloquante ni majeure ouverte.** Les limitations
subsistantes sont mineures ou assumées par conception, documentées et
reportées V2.x/V3. Aucune ne modifie le code de la RC.

## 2. Architecture finale

Détail : `docs/ARCHITECTURE.md`.

- **Backend** : monolithe modulaire à modules verticaux (9 modules métier),
  SQLAlchemy 2 async + PostgreSQL 16, Alembic. Dépendances inter-modules « à
  sens unique et justifiées » (une divergence connue : cycle
  `users ↔ branding`, sans cycle à l'import, reportée V3).
- **Moteur PDF (V2)** : `app/pdf/` transverse, n'important **que** `app.pdf.*`
  — réutilisable pour factures/avoirs/bons de commande sans réécriture. Ne
  calcule rien ; la traduction Devis → Document vit côté métier
  (`quotes/document_mapper.py`).
- **Invariant monétaire** : `quotes/calculator.py` est le seul endroit où un
  montant se calcule (`Decimal`, `ROUND_HALF_UP` par ligne). Le client
  affiche, ne recalcule pas.
- **Cycle de vie du devis** : statuts + transitions verrouillées
  (`FOR UPDATE`), numérotation `DEV-AAAA-NNNN` par entreprise via compteur
  verrouillé, unicité garantie en base.
- **Frontend** : feature-first (Riverpod, GoRouter, Freezed) ; `core/api/`
  seule couche connaissant Dio ; 5 onglets + routes poussées.
- **Abstractions de fournisseur** : IA (mock si pas de clé) et stockage
  (local) — l'app démarre et fonctionne sans configuration.

## 3. Fonctionnalités livrées (V2)

Détail : `docs/RELEASE_NOTES.md`, `CHANGELOG.md`.

1. **Cycle de vie du devis** — numéro + statuts `draft/sent/accepted/refused`,
   transitions unidirectionnelles, protection des transitions concurrentes.
2. **Moteur PDF** + `GET /api/quotes/{id}/pdf` (rendu à la demande, hors event
   loop, dégradation systématique).
3. **Duplication** — `POST /api/quotes/{id}/duplicate` : le chemin d'édition
   qu'un devis n'a pas (copie de l'instantané, totaux recalculés, numéro neuf).
4. **Interface Flutter** — numéro partout, `QuoteStatusChip`, actions
   pilotées par les transitions, confirmation sur l'étape irréversible, garde
   anti-double-clic, PDF via `printing`.

**Invariants tenus** : IA sans prix/persistance, calcul centralisé, pas de
`PUT`/`PATCH` de devis, `company_id` du JWT, tenant → 404.

## 4. Validations exécutées

Matrice complète : `docs/release/package/VALIDATION_MATRIX.md`.

- `pytest` **208 passed** (local **et** conteneur Docker).
- `flutter analyze` **No issues found!** · `flutter test` **63 passed** ·
  `flutter build web --release` **construit**.
- Migrations : installation neuve (6) + rollback complet, en Docker.
- Tentatives de casse : cycle de vie **18/18**, PDF **14/14**.
- QA HTTP Docker : parcours V2.1 **21/21**, duplication **19/19**, sécurité
  **14/14**, durcissements V1 rejoués **11/11**.
- **UAT** : parcours artisan **17 étapes dans un vrai navigateur** — franchi ;
  **13/13** vérifications d'invariants backend
  (`docs/release/08_USER_ACCEPTANCE_TEST.md`).

## 5. Couverture de tests

- **208** tests backend (`pytest`), dont le monétaire V2
  (`calculate_vat_breakdown`) et le mapper de document désormais couverts par
  assertion (+7 tests pendant la certification).
- **63** tests Flutter (`flutter test`) — unitaires/widget, avec fakes (aucun
  n'appelle le vrai backend, limite documentée).
- **32** tentatives de casse (cycle de vie + PDF).
- **UAT** : couvre le trou que les tests ne comblent pas — le contrat HTTP
  réel bout en bout dans un navigateur.

## 6. Environnement validé

- **Docker** : `postgres:16-alpine` + backend `python:3.13-slim`, build
  (reportlab, wheel universelle), up *healthy*, pytest 208 en conteneur,
  non-root uid 1000, volume auto-réparé.
- **Frontend** : Flutter (Dart 3.12.2), build web release, pilotage Chrome
  réel (UAT).
- **Poste de validation** : Windows 11 + WSL 2. Docker Desktop a connu des
  instabilités (documentées) ; la fenêtre disponible a suffi à rejouer toute
  la validation. Versions : `docs/release/package/VERSIONS.md` ; dépendances :
  `DEPENDENCIES.md`.

## 7. Limitations connues

Liste classée : `docs/KNOWN_LIMITATIONS.md`. Aucune bloquante/majeure. En
bref :

- **UI** : pas d'écran d'édition directe de l'identité d'entreprise (hors
  import PDF), pas d'upload de logo dans l'app, pas d'écran de détail client,
  catégories non éditables en UI, pas de « mot de passe oublié ».
- **Par conception** : pas d'édition de devis en place.
- **Versions** : la divergence de métadonnée relevée au RC1 (backend `0.1.0`,
  frontend `1.0.0`, tag `2.0.0-rc1`) est **corrigée en RC2** — tout aligné
  sur `2.0.0`.
- **Sécurité** : rate limiting en mémoire par worker, JWT en localStorage,
  `python-jose` non maintenu, corps chunké non borné (→ reverse proxy).

## 8. Risques résiduels

| Risque | Gravité | Atténuation |
|---|---|---|
| Rate limiting par worker (≈ 4× le plafond ; IP du socket) | Moyenne | Ferme l'énumération ; Redis en V3 ; `X-Forwarded-For` derrière proxy |
| JWT en localStorage (XSS) | Moyenne | Documenté ; cookie HttpOnly en V3 |
| `python-jose` non maintenu | Moyenne | Crypto vérifiée ; migration PyJWT V3 |
| Corps chunké non borné | Faible | Reverse proxy avec limite de corps |
| Montée en charge non éprouvée | Moyenne | Tests concurrents unitaires + rejeu réel UAT ; pas de test de charge |
| Docker Desktop instable (WSL 2) | Faible | Machine, pas produit ; redémarrage |
| Cycle `users ↔ branding` | Faible | Aucun cycle à l'import ; refactor V3 |

## 9. Recommandations pour la production

Check-list complète : `docs/DEPLOYMENT_GUIDE.md`. Points bloquants :

- Générer un vrai `SECRET_KEY` (le code refuse le placeholder en production).
- `ENVIRONMENT=production`, `DEBUG=false`, changer `POSTGRES_PASSWORD`.
- Reverse proxy avec **TLS** et limite de corps devant uvicorn.
- `CORS_ORIGINS` sur le domaine réel.
- **Déployer l'image** (prod par défaut), **pas** `docker-compose.yml` (dev).
- Mettre en place une **stratégie de sauvegarde** des deux volumes
  (procédures testées : `docs/BACKUP_RESTORE.md`) — aucune n'existe par
  défaut.

## 10. Feuille de route V3

Source : `docs/ROADMAP.md`, `docs/release/06_V2_SCOPE_TRIAGE.md`.

- **Factures** (`FAC-AAAA-NNNN`) : candidat naturel, une fois le rendu PDF
  mutualisable — l'architecture V2 (moteur PDF réutilisable, statuts
  extensibles) est déjà prête à les accueillir.
- **Sécurité** : PyJWT à la place de python-jose ; cookie HttpOnly ; rate
  limiting partagé (Redis) + `X-Forwarded-For`.
- **Architecture** : casser le cycle `users ↔ branding` (module `companies`) ;
  `ApiClient` centralisé côté Flutter.
- **UI** : écran d'édition de l'identité d'entreprise, upload de logo,
  détail client, gestion des catégories, « mot de passe oublié ».
- **Qualité** : isolation des tests backend ; parsing IA tolérant.
- ~~Aligner les numéros de version sur `2.0.0`~~ — **fait en RC2**
  (`v2.0.0-rc2`).

---

## Déclaration

Tous les livrables de release sont produits et vérifiés. La **RC2**
(`v2.0.0-rc2`) aligne les numéros de version sur `2.0.0` — son unique objet —
sans aucun changement fonctionnel, de comportement ou d'architecture ; la
RC1 (`v2.0.0-rc1`) reste la photographie certifiée. Aucune anomalie
bloquante ni majeure n'est ouverte.

**ARTIZEN V2.0.0-RC2 est prête pour publication.**

> Aucun commit, aucun tag, aucun artefact n'est poussé sur le dépôt distant.
> La publication attend l'autorisation explicite du propriétaire.
