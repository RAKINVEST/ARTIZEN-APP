# 07 — Certification Release Candidate V2

**Date : 2026-07-17.** Branche `v2`. La V1 reste figée sur `main`
(tag `v1.0.0-rc1`) — aucun commit de la V2 ne l'a touchée.

Ce document rassemble les preuves **réellement exécutées** de l'audit final
V2. Règle tenue : rien n'est déduit ; chaque affirmation est adossée à une
commande, un test, ou une lecture croisée de code. Ce qui n'a pas pu être
prouvé est nommé comme tel.

## Verdict

Les neuf axes d'audit exigés ont été vérifiés. Chaque **faiblesse réelle**
découverte a été corrigée (couverture monétaire, documentation fausse) ;
les améliorations non critiques sont documentées et reportées V3
(`06_V2_SCOPE_TRIAGE.md`). Aucune anomalie 🔴 bloquante ni 🟠 majeure
ouverte.

## Les 9 axes d'audit

| Axe | Méthode | Résultat |
|---|---|---|
| **Architecture ↔ implémentation** | grep exécuté | `app/pdf/` n'importe QUE `app.pdf.schemas` ; aucune arithmétique monétaire hors `calculator.py` ; mapper et renderer ne calculent rien. **Cohérent.** |
| **Code ↔ documentation** | 2 agents de lecture croisée + corrections | Invariants fidèlement décrits. 3 inexactitudes trouvées et **corrigées** (voir plus bas). |
| **API ↔ Flutter** | lecture croisée champ par champ | 6 axes cohérents (champs, noms snake, montants `Decimal`↔`String`, enum `QuoteStatus`, routes, transitions). 1 lacune **mineure** → V3. |
| **Couverture des tests** | agent + ajout de tests | 3 trous trouvés ; le monétaire (critique) et le mapper (majeur) **fermés** ; +7 tests. |
| **Absence de régression V1** | QA HTTP sur v2 | Surface de durcissement V1 : **11/11** (troncature, TVA, oracle, JWT `alg=none`, magic bytes, tenant, rate limit). |
| **Cohérence migrations** | Docker | 6 migrations à vide ; rollback `downgrade base` → `upgrade head` complet ; head `6cc7943bff6a`. |
| **Validation Docker** | conteneur | build (reportlab), up healthy, **208 pytest conteneur**, non-root uid 1000, volume auto-réparé, logs sans erreur non gérée. |
| **Multi-tenant** | QA HTTP | Les 3 routes V2 → 404 (jamais 403) inter-tenant, sans effet de bord ni fuite. |
| **Sécurité des fonctionnalités V2** | QA HTTP | **14/14** — JWT requis, jetons forgés rejetés, isolation, entrées client ignorées, en-tête PDF sans injection. |

## Preuves exécutées — chiffres

| Validation | Résultat | Rejouable |
|---|---|---|
| `pytest` dans le conteneur | **208 passed** | `docker compose exec backend pytest` |
| `flutter analyze` | **No issues found!** | |
| `flutter test` | **63 passed** | |
| `flutter build web --release` | **✓ Built build\web** | |
| Migrations : installation neuve + rollback (Docker) | 6 migrations, aller-retour propre | |
| QA HTTP — parcours artisan V2.1 | **21/21** | `evidence/docker_qa_v2.py` |
| QA HTTP — duplication | **19/19** | `evidence/break_duplicate.py` |
| QA HTTP — sécurité V2 | **14/14** | `evidence/cert_security.py` |
| QA HTTP — uploads V2 | vérifié | `evidence/cert_uploads.py` |
| QA HTTP — durcissements V1 sur v2 | **11/11** | `evidence/break_v1_http.py` |

## Faiblesses réelles trouvées **pendant** cet audit, et corrigées

### 🔴 Couverture — le récapitulatif de TVA n'avait aucune assertion
`QuoteCalculator.calculate_vat_breakdown` (ajout V2) était le **seul code
monétaire de la V2 sans test direct** : regroupement par taux et fusion de
taux identiques jamais exercés. 4 tests unitaires ajoutés
(`test_vat_breakdown_*`). **Résultat : le code était correct** — les tests
l'ont prouvé, et ont au passage attrapé une faute de frappe dans *mon
propre* test (640 au lieu de 690). Le monétaire V2 est maintenant certifié
par assertion.

### 🟠 Couverture — le mapper de document non testé en direct
`quote_to_document` n'était couvert qu'indirectement, sur un seul profil.
Branches non exercées : client entreprise, identité émetteur (SIRET/TVA),
dégradation `_load_logo` (fichier disparu). 3 tests ajoutés — dont la preuve
qu'un devis reste **envoyable même si le logo a disparu du storage**.

### 🔴 Documentation — affirmation fausse dans le document contrat
`CLAUDE.md` affirmait « 5 items bloquants, dont l'absence totale de rate
limiting ». **Doublement faux** : `AUDIT-V1.md` dit « aucune bloquante », et
le rate limiting existe et est actif par défaut (`core/rate_limit.py`).
Corrigé — c'est précisément l'« affirmation fausse qu'on croit » que la
culture du dépôt proscrit.

### 🟠 Documentation — contradiction de chiffres + renvoi trompeur
CHANGELOG annonçait à la fois 201 et 194 pour le même run conteneur (aligné
sur **208**, le compte courant). `06_V2_SCOPE_TRIAGE` renvoyait à
`01_PROOF_OF_VALIDATION` (preuve **V1**) comme preuve V2 — pointeur corrigé.
Bandeau « artefact V1 » ajouté aux documents `docs/release/01`–`05` pour
qu'ils cessent d'induire en erreur sur la branche v2.

## Faiblesses non critiques — documentées, reportées V3

- **`country` non éditable côté Flutter** (`CompanyUpdateInput` l'omet) :
  lisible, pas modifiable. Sans impact runtime. V3.
- **`changeStatus` sérialise via `status.name`** plutôt que le map généré :
  correct tant que nom == valeur wire. Cosmétique.
- **`company_id` en query param** sur les GET de collection : ignoré par le
  backend (dead param). Cosmétique.
- Les items du **triage de périmètre** (`06_V2_SCOPE_TRIAGE.md`) : PyJWT,
  cookie HttpOnly, rate limit partagé, qualité IA, refactors — tous V3.

## Ce qui n'a **pas** été prouvé

- **Le parcours manuel bout en bout dans un navigateur** contre le backend
  réel. Aucun test Flutter n'appelle le backend (fakes/mocks — limite
  documentée depuis l'origine). `flutter build web` compile ; personne n'a
  cliqué. C'est le trou de validation le plus important qui subsiste, et
  aucune automatisation ne le comble.
- **La montée en charge sous concurrence réelle** : les comportements
  concurrents critiques (numérotation, transitions) ont des tests
  `asyncio.gather`, mais pas d'épreuve de charge.

## Stabilité de l'environnement

Docker Desktop a été instable sur cette installation WSL 2 fraîche
(arrêts spontanés, redémarrage Windows en attente pour le stabiliser
durablement). La fenêtre disponible a néanmoins suffi à exécuter **toute**
la validation Docker ci-dessus. Les scripts de `evidence/` la régénèrent.
