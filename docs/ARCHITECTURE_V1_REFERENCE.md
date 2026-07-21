# ARCHITECTURE V1 — Référence (Constitution technique)

> **Ce document est la Constitution technique du projet.** Il regroupe, en un seul
> endroit, les règles **gelées** qui gouvernent tout le reste : décisions d'architecture,
> moteur, taxonomie, catalogues, packs, brouillon vs devis, calcul, wizard, authentification,
> multi-tenant, API, règles de développement.
>
> **Autorité et non-duplication.** Quand une règle a une source vivante, ce document la
> **cite et pointe** vers elle plutôt que de la recopier (une constitution qui recopie tout
> se périme). Sources faisant autorité, par ordre :
> 1. [`CLAUDE.md`](../CLAUDE.md) — invariants produit + pièges.
> 2. [`docs/DECISIONS.md`](DECISIONS.md) — les 7 décisions gelées.
> 3. [`docs/ARCHITECTURE.md`](ARCHITECTURE.md) — carte macro.
> 4. [`docs/TAXONOMIE-METIERS.md`](TAXONOMIE-METIERS.md) — taxonomie des métiers.
> 5. [`docs/API_REFERENCE.md`](API_REFERENCE.md) — inventaire des endpoints.
> 6. [`docs/release/07_FREEZE_METIERS_CATALOGUES.md`](release/07_FREEZE_METIERS_CATALOGUES.md) — gel de la couche Métiers & Catalogues.
>
> **Portée.** Ces règles sont **intouchables sans validation explicite du propriétaire**.
> Tout le reste (écrans, libellés, prix, contenus, nouveaux métiers) évolue librement.

---

## 0. Règle d'or

> **Si une fonctionnalité ne fait pas gagner du temps à l'artisan ou ne rend pas son travail
> plus simple, elle n'a pas sa place dans Artizen.** (`DECISIONS.md`, fil rouge.)

Artizen est un **assistant métier** dont le devis est la conséquence, pas un simple logiciel
de devis.

---

## 1. Les 7 décisions d'architecture gelées

Détail et *pourquoi* dans [`DECISIONS.md`](DECISIONS.md). En résumé, **non rediscutables** :

1. **Le catalogue appartient à l'artisan.** Les catalogues métiers sont un point de départ
   **copié** à l'import ; aucun catalogue partagé.
2. **Le métier est une propriété de l'entreprise, pas une étape du devis.** Les activités sont
   déclarées une fois ; le parcours de devis ne demande jamais « quel métier ? ».
3. **Le backend est l'unique source de vérité.** Montants, taxes, arrondis, transitions =
   serveur. Le client **affiche**, ne calcule jamais.
4. **Brouillon et devis sont deux objets métier différents.** Le brouillon se modifie ; le
   devis émis est figé. « Créer le devis » = transformer le brouillon en document officiel.
5. **Chaque ligne est une photographie autonome.** Désignation, unité, quantité, prix, TVA
   sont copiés ; la ligne ne dépend plus du catalogue.
6. **En ligne requis en V1.** Pas de mode hors-ligne complet ; mais une coupure passagère ne
   détruit jamais le travail en cours.
7. **Activités vs qualifications.** Activités → grands catalogues ; qualifications → dossiers
   réservés + mentions légales du PDF. Import versionné « comme un store ».

Ce que ces décisions **excluent volontairement** : catalogue partagé, étape « choisir le
métier », calcul côté client, modification d'un devis émis, ligne dépendante du catalogue,
hors-ligne complet V1, dossier réservé chargé par défaut.

---

## 2. Principes du moteur

- **Monolithe modulaire à modules verticaux.** Chaque domaine est un package auto-contenu :
  `models.py`, `schemas.py`, `repository.py`, `service.py`, `deps.py`, `router.py`.
- **Dépendances « à sens unique et justifiées »** (pas « aucune dépendance ») :
  `quotes → catalog, clients` ; `document_detection → document_analysis` ;
  `template_import → branding, document_analysis, document_detection` ;
  `quote_assistant → catalog, quotes, branding` (lectures seules) ; tous → `users.deps.CurrentUserDep`.
- **Divergence connue, non corrigée** : `users ↔ branding` est un cycle (`Company` vit dans
  `branding`, l'inscription en crée une). Aucun cycle à l'import. À traiter en V3 (extraire un
  module `companies`) — **pas avant**.
- **Règle d'extraction transverse** : un helper monte au transverse au **deuxième**
  consommateur, jamais par anticipation. Exception assumée : `app/pdf/` (transverse dès le 1er).
- **`app/pdf/` n'importe QUE `app.pdf.*`** — jamais un module métier ; c'est ce qui le rend
  réutilisable (devis, facture, avoir…). La traduction Devis → Document vit dans
  `quotes/document_mapper.py`, côté métier.
- **Abstractions de fournisseur** : `ai/factory.py` bascule sur `MockAIProvider` si la clé est
  absente (l'app démarre et l'IA répond sans configuration) ; `storage.py` local, même logique.
  **Une clé manquante n'est jamais une erreur.**

Détail : [`ARCHITECTURE.md`](ARCHITECTURE.md).

---

## 3. Taxonomie des métiers (GELÉE)

- **Référence unique** de toute l'app : `catalog/trades/taxonomy.py` (miroir humain :
  [`TAXONOMIE-METIERS.md`](TAXONOMIE-METIERS.md), API : `GET /catalog/taxonomy`).
- **Familles → activités → qualifications d'exercice**, + **certifications d'entreprise**
  transverses. **Slugs gelés** (jamais renommés) — un slug identifie une chose, pour toujours.
- **Deux concepts jamais mélangés** : qualification d'**exercice** (réserve un pack, influence
  le moteur, dans une famille) vs certification d'**entreprise** (administrative, aucun impact
  catalogue, transverse).
- **Statuts** : `implemented` · `planned` · `deferred_v2` · `deprecated`, filtrables par l'API.
- **État gelé** : 6 familles, 54 activités implémentées, 4 qualifications d'exercice, 7
  certifications d'entreprise. Voir [`07_FREEZE_METIERS_CATALOGUES.md`](release/07_FREEZE_METIERS_CATALOGUES.md).

---

## 4. Règles des catalogues

- **Un métier = un fichier de données `catalog/trades/*.py` + une ligne au registre. Zéro
  moteur.** Aucune ligne du moteur ne connaît un métier (prouvé par `test_trades_generic.py`).
- **Import = copie** des packs dans les `CatalogCategory`/`CatalogItem` de l'entreprise
  (décision 1). Jamais un catalogue parent vivant.
- **Prix = ordres de grandeur du marché**, faits pour être corrigés — jamais une recommandation.
- **Mise à jour par version** (`Activity.version` / `Qualification.version`), additive : n'ajoute
  que les articles absents, ne touche jamais un prix personnalisé. Détecter par version, jamais
  par diff d'articles (décision 7).
- **Intégrité métier (test)** : chaque activité expose ≥1 dossier de matériel/équipement garni
  **et** un dossier `Prestations` garni. Règle agnostique aux libellés.

---

## 5. Règles des packs

- **L'unité de composition est le pack, pas le métier** (supprime l'explosion combinatoire).
- **Un pack est auto-contenu** : il porte les produits *et* les services associés.
- **Trois niveaux, et seulement trois** : (1) service spécifique dans le pack produit ;
  (2) pack `Prestations` transverse à l'activité ; (3) pack `Chantier` commun à tout métier
  (déplacement, dépose, évacuation, essais), **ajouté automatiquement à chaque import**.
- **Deux packs de même nom fusionnent** en un dossier (merge par nom exact). L'artisan voit
  **un** catalogue unifié (décision 2).
- **Ossature homogène** : matériel(s) → consommables → accessoires/finitions → `Prestations`.
- Source : `catalog/trades/definitions.py` (`Activity`, `Qualification`, `CatalogPack`,
  `PackItem`, `merge_packs`, helpers `produit`/`prestation`).

---

## 6. Brouillon vs Devis (séparation)

| | Brouillon | Devis |
|---|---|---|
| Modifiable | ✅ librement | ❌ jamais |
| Numéroté | ❌ | ✅ `DEV-2026-0001` |
| Supprimable | ✅ | uniquement avant envoi |
| Valeur juridique | aucune | document contractuel |

- **« Créer le devis » = transformer le brouillon** en document officiel (décision 4).
- **Ni `PUT` ni `PATCH`** sur le contenu d'un devis : garantit que les totaux persistés
  restent cohérents avec les lignes (le calculateur ne calcule qu'à la création).
- **Numéro** attribué **à la transformation** (jamais à la création du brouillon) → un
  brouillon supprimé ne laisse aucun trou. `quote_counters` verrouillé `FOR UPDATE`, **jamais
  `SELECT MAX+1`**.
- **Cycle de vie** `draft → sent → accepted/refused` (`QUOTE_TRANSITIONS`) ; rien ne revient
  à `draft`. `change_status` et `delete` sont des **read-decide-write verrouillés**.

### QuoteDraft (frontend) — l'objet métier partagé du wizard

- `features/quote_wizard/data/quote_draft.dart` : porte `clientId`, `clientLabel`, `lines`,
  `calculation`. C'est l'état construit pas-à-pas par l'assistant.
- **La sélection de dossier est volontairement HORS du brouillon** (`selectedFolderProvider`,
  pur état de navigation) : ouvrir un dossier n'est pas une donnée persistable du devis.
- **Complétude d'étape pilotée par le brouillon** (`stepCompleteProvider`) : on n'avance que
  si le brouillon déclare l'étape courante complète. Le devis n'existe qu'à l'étape « Créer ».

---

## 7. Moteur de calcul (invariant monétaire)

- **`quotes/calculator.py` est le SEUL endroit où un montant se calcule.**
- **Tout en `Decimal`, jamais `float`.** Arrondi **`ROUND_HALF_UP` par ligne**, puis somme des
  lignes (convention française).
- **`POST /quotes/calculate`** chiffre un brouillon en direct **sans rien persister**.
- Montants **sérialisés en chaînes JSON** ; le client Flutter les **affiche**, ne recalcule
  rien (décision 3). Toute surface future (facture, avoir, bon de commande) passe par ce
  calculateur. Le récap TVA vient de `QuoteCalculator.calculate_vat_breakdown`.

---

## 8. Wizard (assistant de devis) — état & contrat

- **Structure feature-first** : `features/quote_wizard/{data,presentation}`.
- **7 étapes** (`WizardStep`) : `client → dossier → articles → personnaliser → recap → creer → envoyer`.
- **Gating** (`stepCompleteProvider`) : `client`=client choisi ; `dossier`=dossier ouvert ;
  `articles`=au moins une ligne ; `personnaliser`=lignes présentes ; `recap`=calcul valide ;
  `creer`=prêt à créer ; `envoyer`=libre. **Marche arrière toujours libre**, marche avant
  seulement à travers les étapes complètes.
- **Navigation & sortie** : le wizard est poussé sur la route `/assistant`. Toute sortie
  (retour système via `PopScope`, « Quitter », destination du menu latéral) passe par une
  **garde de confirmation** dès que le brouillon a un client ou une ligne ; un abandon confirmé
  **réinitialise** le brouillon, si bien que « quitter » et « repartir à neuf » sont le même
  geste (décision 6 : ne jamais détruire le travail en cours sans le vouloir).
- **Deux flux de création coexistent** en V1 : le wizard (`/assistant`) et l'ancien
  `QuoteFormScreen` (`/quotes/new`, flux principal « Nouveau devis »). Tant que les étapes
  3→7 du wizard sont en mock, `QuoteFormScreen` reste le flux principal ; le basculement du
  point d'entrée « Nouveau devis » vers le wizard est prévu **en fin de P4** (P4.7), pas avant.
- **État de câblage (P4)** : structure, navigation et **garde de sortie** faites (P4.1) ;
  étape **Client de production** finalisée (P4.2 : recherche débounce, création inline +
  auto-sélection, changement/retrait du client, états chargement/erreur/vide distincts) ;
  étape **Dossier de production** finalisée (P4.3 : lisibilité nom + nombre d'articles +
  aperçu du contenu, catalogue vide actionnable → « Mes métiers », erreur/retry, dossier
  ouvert conservé dans `selectedFolderProvider`) ; étape **Articles de production** finalisée
  (P4.4 : recherche serveur instantanée dans le dossier, ajout/retrait avec retour visuel
  immédiat « ✔ Ajouté (× N) », doublon = incrément de quantité, borne à une page ⇒ scalable) ;
  **Personnaliser → Envoyer** restent à câbler (revue :
  [`08_WIZARD_READINESS.md`](release/08_WIZARD_READINESS.md)).
  - **Ajout backend additif (P4.4)** : `GET /catalog/items` accepte `?category_id=` (filtre
    **serveur**, rétro-compatible) pour lister les articles d'un dossier — le filtrage reste
    côté backend (décision 3), rien n'est filtré dans Flutter.
- **Le wizard ne calcule ni ne persiste rien lui-même** : il lit les endpoints existants et
  délègue tout montant au backend.

---

## 9. Authentification

- **JWT `Bearer`** requis partout **sauf** `POST /api/auth/register` et `POST /api/auth/login`.
- **PyJWT** (HS256), `exp` validé, `alg=none` rejeté (allow-list explicite au décodage).
  `python-jose` volontairement abandonné (non maintenu).
- **Mots de passe** : `passlib[bcrypt]`, `bcrypt==4.0.1` **épinglé** (incompat. auto-test
  passlib 1.7.4 — ne pas mettre à jour sans lire le commentaire de `requirements.txt`).
- **Rate limiting actif par défaut** sur `/auth/*` (`core/rate_limit.py`,
  `AUTH_RATE_LIMIT_ENABLED=True`).
- **Codes** : en-tête absent → **403** (`HTTPBearer`) ; token présent mais invalide/expiré → **401**.

---

## 10. Multi-tenant

- **`company_id` vient TOUJOURS du JWT, jamais du client.** Les routeurs écrasent la valeur
  reçue (`model_copy(update=...)`) ; les `GET` de collection n'acceptent aucun `company_id` en
  query.
- **Un mismatch de tenant renvoie 404, jamais 403** (`core/authorization.py::ensure_same_company`)
  — un 403 confirmerait l'existence d'une ressource d'une autre entreprise.
- **Toutes les données métier sont scopées `company_id`** (`CatalogCategory`, `CatalogItem`,
  `Client`, `Quote`, `quote_counters`…).

---

## 11. API

- **Préfixe `/api`** pour tous les routers métier ; seuls `/` et `/health` y échappent.
- **`/health`** fait un vrai `SELECT 1` et renvoie `degraded` si la DB est injoignable.
- **Source vivante** : Swagger (`/docs`, `/openapi.json`). Inventaire figé (V2) :
  [`API_REFERENCE.md`](API_REFERENCE.md).
- **CORS** piloté par `.env` (`CORS_ORIGINS`, `http://localhost:3000` en dev) — pas par le
  compose.
- **Aucune route d'écriture de contenu de devis** (`PUT`/`PATCH`) — invariant, pas un oubli.

---

## 12. Règles de développement

- **Langues** : documentation en **français**, commentaires de code en **anglais**. Constant,
  à garder.
- **Portes à faire passer avant une PR** :
  - Backend : `docker compose exec backend pytest` doit rester **vert**.
  - Frontend : `flutter analyze` (« No issues found! ») + `flutter test` verts ;
    `dart run build_runner build --delete-conflicting-outputs` après toute modif de modèle Freezed.
- **Les tests ne prouvent pas le contrat HTTP réel** : valider un changement de schéma Pydantic
  avec un `curl` réaliste (un `company_id` resté requis avait passé 95 tests puis cassé le vrai
  client).
- **Migrations** : `alembic revision --autogenerate` est un point de départ, jamais un livrable
  (relire `NOT NULL` sur table peuplée, backfill, `DROP TYPE` enum en `downgrade`).
- **Commits** : messages en français, à l'impératif, expliquant le **pourquoi**. Ne pas pousser
  sans autorisation explicite.
- **Pièges connus** (coûteux) : `.gitattributes`/CRLF, volume détenu par root, `MSYS_NO_PATHCONV`,
  Python 3.13 (pas 3.14), `bcrypt` épinglé, shadowing de `list`, `@JsonSerializable` sur Freezed,
  fixtures asyncio `function` scope, tests backend sans isolation (vraie base). Voir
  [`CLAUDE.md`](../CLAUDE.md) et [`docs/TROUBLESHOOTING.md`](TROUBLESHOOTING.md).

---

## Amendement

Ce document ne se modifie que par **décision explicite du propriétaire**. Une évolution
autorisée (nouveau contenu, nouveau métier via le moteur existant, nouvelle version de
catalogue) **n'amende pas** la Constitution : elle l'applique.
