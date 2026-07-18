# RAPPORT DE CERTIFICATION — ARTIZEN V2 PRO

> **Mission qualité totale.** Question posée : *« Qu'est-ce qui empêcherait aujourd'hui un artisan de
> payer pour ARTIZEN ? »* Aucun développement — audit uniquement. Rôles endossés : CTO, PO, Lead QA,
> UX, Test Engineer, expert Flutter, expert FastAPI, artisan chauffagiste/plombier, commercial SaaS.

## Méthodologie

- **4 audits statiques du code réel** (frontend UX/DS, backend/auth, PDF/conformité légale FR,
  produit/dette), chaque constat référencé au fichier.
- **1 recette dynamique** contre l'instance en cours d'exécution : inscription, création de 120
  clients + 200 articles + devis, mesures de latence, pagination, recherche, doublons, champs
  invalides, génération PDF.
- **Vérification des constats critiques** : le « crash XML du PDF sur `&` » suspecté a été **testé et
  n'a pas été reproduit** (PDF valide, HTTP 200) → **retiré** du rapport. Un audit honnête écarte ses
  propres faux positifs.

---

## 1. État réel du produit

**Un excellent moteur, une carrosserie inachevée aux deux bouts.**

Le socle d'ingénierie est **nettement au-dessus d'un MVP** : multi-tenant réel (`ensure_same_company`,
404 et non 403 anti-énumération), calculs `Decimal` centralisés (`QuoteCalculator`), numérotation
verrouillée `FOR UPDATE`, validation d'upload (magic bytes + tailles), refus de `DEBUG`/secret
placeholder en production, enveloppe d'erreur cohérente, **aucun N+1**, **0 marqueur TODO/FIXME**,
Design System propre (**zéro couleur codée en dur**), mécanisme des 4 états réellement utilisé,
dégradations gracieuses (mock IA invisible, fallback logo/couleur). **Performances excellentes** à
l'échelle testée (14 ms/création, listes < 25 ms).

Mais le **parcours de valeur de l'artisan est incomplet à ses deux extrémités** :
- **En amont**, il ne peut pas se configurer proprement : impossible de saisir SIRET/assurance depuis
  l'app sans importer un ancien PDF ; pas de support micro-entrepreneur.
- **En sortie**, le devis produit **n'est pas conforme à la loi française du bâtiment**, ne peut pas
  être **envoyé** depuis l'app, et il n'y a **pas de facturation**.

Le produit **démontre** très bien (démo courte impressionnante) mais **ne tient pas une journée réelle**
d'un artisan établi (catalogue > 100, conformité, encaissement).

### Tableau de synthèse

| Sévérité | Nombre | Signification |
|---|---|---|
| 🔴 Critique | 6 | Empêche la commercialisation |
| 🟠 Majeur | 20 | Dégrade fortement l'expérience payante |
| 🟡 Moyen | 19 | Amélioration importante |
| 🔵 Mineur | 8 | Finition |

---

## 2 à 6. Catalogue des défauts

Chaque défaut porte un **ID**, une **étiquette de domaine** (couvre les sections *2 défauts*, *3 risques*,
*4 UX*, *5 Design System*, *6 technique*) et les champs demandés. Un index par domaine suit en §4-6-bis.

### 🔴 CRITIQUES — bloquent la commercialisation

#### C1 — Le devis PDF n'est pas légalement conforme (bâtiment) · *Légal / Produit*
- **Description** : mentions légales = **deux lignes en dur** (`quotes/document_mapper.py:39-42`).
  Manquent : **assurance décennale / RC pro** (assureur + couverture géographique, obligatoire bâtiment
  depuis 2014), **conditions et délais de paiement** (+ pénalités, indemnité 40 € B2B), **zone « Bon
  pour accord » / signature / date client**, **forme juridique + capital + RCS/RM + APE**, **mention
  RGE**. Ironie : `BrandProfile.signature_path`/`stamp_path` existent mais **ne sont jamais rendus**, et
  le document affirme « vaut acceptation dès signature » sans imprimer de case pour signer.
- **Cause** : `Company` n'a aucun champ assurance/forme juridique (`branding/models.py:30-43`) ; mentions
  non configurables.
- **Impact utilisateur** : l'artisan envoie un document non conforme à son client final.
- **Risque commercial** : **rédhibitoire** — « votre devis n'est même pas légal » ; sanction
  administrative + argument d'annulation client. Touche 100 % des artisans du bâtiment.
- **Priorité** : P0.
- **Solution** : champs assurance/forme juridique sur `Company` + bloc signature dans le renderer +
  mentions configurables ; réutiliser `signature_path`/`stamp_path`.
- **Temps estimé** : 3–4 j.

#### C2 — Aucun support micro-entrepreneur / franchise en base de TVA · *Légal / Produit*
- **Description** : `vat_rate` obligatoire par article, le PDF affiche **toujours** « Total TVA »
  (`renderer.py:298-318`). Aucune bascule « **TVA non applicable, art. 293 B du CGI** », aucun flag non
  assujetti.
- **Cause** : pas de flag `vat_exempt` sur `Company`, mention en dur.
- **Impact utilisateur** : la **majorité des artisans solo sont auto-entrepreneurs** → devis avec
  « Total TVA 0,00 € » faux, sans la mention obligatoire.
- **Risque commercial** : le **cœur de cible** ne peut pas produire un devis correct ; redressement /
  contestation possible.
- **Priorité** : P0.
- **Solution** : flag franchise TVA + neutralisation colonne/total TVA + mention 293 B automatique.
- **Temps estimé** : 1,5 j.

#### C3 — Impossible de saisir son identité légale depuis l'app · *Produit / UX*
- **Description** : SIRET/`legal_name`/adresse ne se renseignent que via l'écran **« Importer un ancien
  devis »** (`template_import_screen.dart:203-223`). L'écran **Paramètres n'édite rien**
  (`settings_screen.dart`). Les routes `PUT /branding/company` & `/brand` existent mais **aucun écran ne
  les appelle** (dette documentée #10, `docs/AUDIT-V1.md`).
- **Cause** : écran « Mon entreprise » jamais construit.
- **Impact utilisateur** : un artisan sans ancien PDF (débutant, venant du papier) **ne peut pas mettre
  son SIRET** ; et l'import a un effet de bord (remplace le modèle actif).
- **Risque commercial** : **mortel à l'onboarding** — premier devis émis sans mentions.
- **Priorité** : P0.
- **Solution** : écran « Mon entreprise » branché sur les routes existantes (modèles Flutter déjà là).
- **Temps estimé** : 1,5–2 j.

#### C4 — Réinitialisation de mot de passe absente · *Sécurité / Produit* — **confirmé dynamiquement (404)**
- **Description** : pas de route `forgot-password`/`reset-password` (`users/router.py`), pas de champ
  token de reset (`users/models.py`), **aucune infra e-mail** dans le backend. Testé : `POST
  /auth/forgot-password` → **404**.
- **Cause** : jamais implémenté.
- **Impact utilisateur** : oubli de mot de passe = **compte définitivement verrouillé**.
- **Risque commercial** : premier ticket support d'un SaaS grand public ; chaque oubli = compte perdu
  ou opération SQL manuelle.
- **Priorité** : P0.
- **Solution** : envoi e-mail + token expirable + écrans ; dépend de l'infra mail (voir M2).
- **Temps estimé** : 2–3 j (après infra mail).

#### C5 — Catalogue plafonné à 100 articles, silencieusement · *Technique / UX / Montée en charge* — **confirmé dynamiquement**
- **Description** : le Flutter **charge tout puis filtre côté client** (`catalog_providers.dart:44-68`,
  `catalog_repository_impl.dart:40`) **sans passer de `limit`** ; le backend plafonne par défaut à
  **100** et **n'expose aucun `q`** pour le catalogue. Testé : `GET /catalog/items?q=…` **ignore `q`**
  (renvoie tout), et la liste par défaut plafonne à 100. Résultat : **au-delà du 100ᵉ article, invisible,
  introuvable (la recherche ne porte que sur les 100 chargés) et non ajoutable à un devis** — sans
  « 100 sur 250 ».
- **Cause** : pas de pagination UI, pas de recherche serveur catalogue.
- **Impact utilisateur** : un artisan établi (300 articles) ne voit qu'un tiers de son catalogue et ne
  peut pas deviser le reste.
- **Risque commercial** : **mur fonctionnel** dès le premier client sérieux.
- **Priorité** : P0.
- **Solution** : recherche `q` serveur sur le catalogue + pagination/infinite-scroll + indicateur.
- **Temps estimé** : 3–4 j.

#### C6 — Pas de facturation (devis → facture) · *Produit* — *périmètre V3 assumé, mais bloqueur commercial*
- **Description** : aucun module `invoices` (`api/router.py`). `app/pdf/` sait rendre une « FACTURE »
  mais rien ne l'appelle.
- **Cause** : **choix de périmètre documenté** (reporté V3, `docs/ROADMAP.md`).
- **Impact utilisateur** : l'artisan ne peut pas **encaisser** — il garde un second outil.
- **Risque commercial** : c'est **la raison d'achat** d'un logiciel de gestion ; sans elle, pas de
  migration depuis Excel/l'existant. À traiter malgré son statut « planifié ».
- **Priorité** : P1 (selon positionnement : un produit « devis seul » peut se vendre, mais la promesse
  est amputée).
- **Solution** : module `invoices` sur le patron existant + numérotation légale (`QuoteCounter` déjà
  prévu) + mapper.
- **Temps estimé** : 1–2 semaines.

### 🟠 MAJEURS — dégradent fortement l'expérience payante

| ID | Défaut (réf.) · domaine | Cause | Impact / risque | Solution | Temps |
|---|---|---|---|---|---|
| M1 | **Double-soumission du devis → 2 devis créés** (`quote_form_screen.dart:72-131`, `AppPrimaryButton` sans `loading:`) · UX/Tech | Bouton non gardé pendant l'appel | Doublons de devis en base sur double-tap | `loading:` + guard `_saving` | 0,5 j |
| M2 | **Pas d'envoi du devis (email/SMS) ni relance** (aucune infra mail) · Produit | Non implémenté | Envoi manuel depuis la boîte perso ; pas de relance = CA perdu | Service mail + relance J+7/J+15 | 4–5 j |
| M3 | **Édition de devis inexistante** (delete+recreate ; `quotes/router.py`) · Produit/UX | Choix assumé (invariant #2) | Corriger une faute impose de recréer | Édition de **brouillon** (repasse par `create`) | 3–4 j |
| M4 | **Email/téléphone client sans validation** (`client_form_screen.dart:140-156` ; backend `str` non `EmailStr`) · UX/Tech | Validators absents | Données erronées imprimées sur le PDF client | `EmailStr` + validators inline | 0,5 j |
| M5 | **Quantité IA non validée/normalisée → 422 sur tout le devis** (`quote_assistant_screen.dart:291-300`) · UX/Tech | N'utilise pas `DecimalInput` | « 2,5 » / vide / « abc » casse la création entière | Réutiliser `DecimalInput.validate/normalize` | 0,5 j |
| M6 | **Recherche client : spinner plein écran + requête par frappe, sans debounce** (`clients_providers.dart:29-39`) · UX/Perf | `AsyncValue.loading()` à chaque lettre | Clignotement + N requêtes ; pénible en réseau faible | Debounce 300 ms + conserver les données | 0,5 j |
| M7 | **Pickers client/article sans état vide** (`quote_form_screen.dart:143,220`) · UX | `AsyncValueView` sans empty | Bottom-sheet blanche au moment de créer un devis | État vide guidé | 0,5 j |
| M8 | **Liste devis sans recherche/filtre + plafond 100** (`quotes_list_screen.dart`, `quotes_providers.dart:12`) · UX/Scale | Pas de `q`/filtre | Devis anciens inatteignables ; aucun filtre statut/client | Recherche + filtres + pagination | 2–3 j |
| M9 | **Inscription sans confirmation de mot de passe** (`register_screen.dart:100-116`) · UX | Champ absent | Faute masquée → compte inaccessible (aggravé par C4) | Champ « confirmer » | 0,5 j |
| M10 | **Config API : HTTP clair / localhost par défaut, non modifiable in-app** (`api_config.dart:11-14`) · Tech/Sécu | `--dart-define` seulement | Build prod sans define = app morte ; cleartext bloqué Android | HTTPS + réglage serveur / build prod fiable | 1 j |
| M11 | **Aucun quota/rate-limit sur les endpoints IA** (`quote_assistant/router.py`, `rate_limit.py:51`) · Sécu/Coût | Rate limit limité à `/auth` | Coût provider LLM non maîtrisé (boucle / token volé) | Quota par tenant + rate limit IA | 2 j |
| M12 | **Rate limiter mémoire par défaut + `X-Forwarded-For` non géré** (`rate_limit.py:78-81`, `config.py:128`) · Sécu | Backend `memory`, clé = IP socket | Derrière proxy : anti-brute-force/énumération dégradé | Activer Redis (déjà dispo) + XFF de confiance | 1 j |
| M13 | **`limit` de pagination non plafonné** (`*/router.py`) · Sécu/Tech — **confirmé (`limit=1e8` → 200)** | Pas de `Query(le=…)` | Chargement de toute la table → pic mémoire/DoS | `Query(ge=0, le=200)` | 0,5 j |
| M14 | **Pas de refresh token / logout / vérif e-mail** (`auth/security.py`, `users/service.py`) · Sécu | Non implémenté | Token 24 h non révocable ; comptes fantômes | Refresh + révocation + vérif e-mail | 3–4 j |
| M15 | **Pas d'import CSV clients/catalogue** (`api/router.py`) · Produit | Non implémenté | Migration depuis Excel = tout ressaisir → « je préfère Excel » | Endpoints import + prévisualisation | 3–4 j |
| M16 | **Onboarding non guidé** (dashboard 0/0/0, pas de wizard/démo/catalogue type) · Produit/UX | Aucun parcours d'activation | Le nouvel artisan ne sait pas par où commencer | Wizard 1-2-3 + catalogues métier pré-remplis | 4–6 j |
| M17 | **Base de démo polluée** (doublons « Chauffe-eau Atlantic » créés par les tests sans isolation) · Tech/Image | Tests sur la vraie base | Démo commerciale fait amateur | Base de test dédiée + purge démo | 1–2 j |
| M18 | **Pas de mode hors-ligne** (100 % serveur) · Produit — *à arbitrer* | Architecture online | Artisan en zone blanche : rien ne marche | Cache local + file de synchro | plusieurs sem. (cadrer) |
| M19 | **Devis sans objet / adresse chantier / acompte / remise** (`quotes/models.py`) · Produit | Modèle minimal | Devis bâtiment paraît pauvre | Champs additionnels + rendu | 3–5 j |
| M20 | **Aucun test Flutter e2e réel** (fakes partout) · Tech/Qualité | Choix de test | Un bug réel (`company_id` → 422) a survécu à 95 tests | Quelques tests e2e contre un vrai backend | 2–3 j |

### 🟡 MOYENS — améliorations importantes

| ID | Défaut (réf.) · domaine | Solution | Temps |
|---|---|---|---|
| Y1 | `offset`/`limit` négatifs → **HTTP 500** (`*/router.py`) — *confirmé* · Tech | `Query(ge=0)` | 0,25 j |
| Y2 | Aller-retour `/branding/profile` avant chaque écran/refresh (`current_company_provider.dart:21-26`) · Perf | Mettre en cache l'id entreprise | 0,5 j |
| Y3 | `refresh()` vide la liste (spinner plein écran) au pull-to-refresh (providers) · UX | Conserver les données pendant le refresh | 0,5 j |
| Y4 | Import de modèle sans validation (SIRET/TVA/**couleurs hex**) (`template_import_screen.dart:291-318`) · UX | Validators + `AppTextField` | 0,5 j |
| Y5 | Format monétaire brut « 45.50 € » (point) dans les pickers (`quote_form_screen.dart:235`) · DS | `CurrencyFormatter.format` | 0,25 j |
| Y6 | `TextField` bruts vs `AppTextField` (`search_field.dart`, import, pickers) · DS | Unifier sur `AppTextField` | 1 j |
| Y7 | Risque d'overflow `AppPrimaryButton` (petit écran / gros textScale) (`app_components.dart:111-129`) · DS/Responsive | `Flexible` + ellipsis | 0,25 j |
| Y8 | **Aucun `Semantics`** + FAB « + » sans tooltip/label · Accessibilité | `Semantics`/`tooltip` | 1 j |
| Y9 | Validation format e-mail en auth (non-vide seulement) (`login/register_screen`) · UX | Regex e-mail | 0,25 j |
| Y10 | Catégories non éditables/supprimables + pas de toast (`catalog_screen.dart:99-140`) · Produit/UX | CRUD catégories + feedback | 1 j |
| Y11 | Picker manuel IA sans `onRetry` (`quote_assistant_screen.dart:389`) · UX | Ajouter `onRetry` | 0,25 j |
| Y12 | Champs texte clients/catalogue non bornés en longueur (schemas + modèles) · Tech | `max_length` + colonnes bornées | 0,5 j |
| Y13 | Copilote IA envoie jusqu'à 1000 articles au LLM (`quote_assistant/service.py`) · Perf/Coût | Pré-filtrage / vectorisation | 2 j |
| Y14 | JWT en `localStorage` sur le web (lisible par XSS) · Sécu | Cookie HttpOnly (reporté V3) | 1–2 j |
| Y15 | Validité figée à 30 j, non paramétrable (`document_mapper.py:40`) · Produit | Champ configurable | 0,5 j |
| Y16 | PDF : pas de numérotation de page ni rappel d'identité en pied · Légal/finition | `onPage` canvas | 0,5 j |
| Y17 | PDF : cellules numériques/unité non wrappées → débordement (`renderer.py:253-257`) · Finition | `Paragraph` sur toutes les cellules | 0,5 j |
| Y18 | `font_family`, `signature/stamp`, `website` saisis mais **jamais rendus** sur le PDF · Produit | Les appliquer au rendu | 1 j |
| Y19 | Mono-utilisateur par entreprise (pas d'équipe) (`users/models.py`) · Produit — *selon cible* | Invitations + rôles | 1 sem. |

### 🔵 MINEURS — finition

| ID | Défaut (réf.) | Solution |
|---|---|---|
| B1 | Pas de snackbar de succès au changement de statut devis (`quote_detail_screen.dart:62`) | Ajouter le toast |
| B2 | Déconnexion sans confirmation (`settings_screen.dart:71`) | Dialogue de confirmation |
| B3 | Fuite de `TextEditingController` non `dispose()` (`add_category_dialog.dart:11`) | `dispose()` |
| B4 | Contraste `placeholder` (#94A3B8 ≈ 2.8:1) limite ; hauteur `AppLink` possiblement < 48 dp | Ajuster |
| B5 | Paramètres affiche « Serveur : http://localhost:8000/api » en clair (`settings_screen.dart:63`) | Masquer en prod |
| B6 | Version « 2.0.0 » nue | Contextualiser |
| B7 | `website` de l'entreprise jamais affiché (doublon Y18) | Rendu PDF |
| B8 | Police non-Unicode (caractères exotiques → carré vide) | Police Unicode embarquée |

---

## 4-6-bis. Index par domaine (sections 4 UX / 5 Design System / 6 Technique)

- **4. Incohérences UX** : C3, M1, M3, M5, M6, M7, M8, M9, M16, Y3, Y9, Y10, Y11, B1, B2. Transverse :
  friction du parcours « créer un devis » (pickers sans recherche/état vide) et onboarding non guidé.
- **5. Incohérences Design System** : Y5 (format monétaire point vs virgule), Y6 (`TextField` bruts vs
  `AppTextField`), Y7 (overflow bouton). **NB : le DS est globalement un point fort** — zéro couleur en
  dur, espacements/rayons/chips centralisés ; les écarts sont périphériques.
- **6. Problèmes techniques** : C5, M10, M11, M12, M13, M14, M17, M20, Y1, Y2, Y12, Y13, Y14, B3.

---

## 3-bis. Risques (synthèse)

| Risque | Origine | Gravité |
|---|---|---|
| **Juridique** : devis non conforme émis en production | C1, C2 | 🔴 |
| **Perte de compte** : oubli de mot de passe irrécupérable | C4 | 🔴 |
| **Fonctionnel/scale** : catalogue > 100 inutilisable | C5 | 🔴 |
| **Coût** : dépense LLM non maîtrisée | M11 | 🟠 |
| **Sécurité** : brute-force/énumération auth derrière proxy ; token 24 h non révocable ; JWT localStorage | M12, M14, Y14 | 🟠 |
| **Intégrité** : doublons de devis (double-tap) | M1 | 🟠 |
| **Image** : base de démo polluée, mentions « localhost » visibles | M17, B5 | 🟠/🔵 |
| **Exploitation** : `limit` non borné, 500 sur offset négatif | M13, Y1 | 🟠/🟡 |

---

## 7. Améliorations possibles (au-delà des défauts)

- Suivi d'ouverture/acceptation du devis (lien client) ; signature électronique.
- KPI dashboard enrichi (CA signé, taux de transformation, devis en attente).
- Catalogues métier pré-remplis + tarifs indicatifs.
- Duplication « depuis un modèle » / devis-types.
- Export comptable, TVA récapitulative.
- Notifications push (devis accepté).
- Recherche globale (clients + articles + devis).

---

## 8. Plan de correction par priorité

- **Phase 0 — Quick wins (~1 sem)** : M1, M4, M5, M6, M7, M9, M13, Y1, Y5, Y7, Y8. *(fiabilité +
  finition immédiate, très fort ROI perçu)*
- **Phase 1 — Conformité & identité (~1,5 sem)** : **C1, C2, C3** + Y15, Y16, Y17, Y18. *(débloque la
  légalité du devis et l'onboarding)*
- **Phase 2 — Montée en charge (~1 sem)** : **C5**, M8, Y2, Y13. *(pagination + recherche serveur)*
- **Phase 3 — Compte & sécurité (~1 sem)** : **C4**, M2 (infra mail, prérequis de C4), M10, M11, M12,
  M14.
- **Phase 4 — Valeur commerciale (~2 sem)** : M2 (envoi + relance), M15 (import CSV), M16 (wizard +
  catalogues métier), M17.
- **Phase 5 — Facturation (~2 sem)** : **C6** (module `invoices`).
- **Backlog produit** : M18 (offline), M19 (champs devis), M20 (tests e2e), Y10, Y19, mineurs.

---

## 9. Temps estimé pour une version commercialisable

- **Pilote payant crédible (positionnement « devis conforme », sans facturation)** : **Phases 0→3 ≈
  4–5 semaines** (1–2 devs). Débloque : conformité légale, identité, montée en charge, reset password,
  envoi e-mail, sécurité d'exploitation.
- **GA complète (avec facturation + activation)** : **+ Phases 4→5 ≈ 9–11 semaines** au total.

*Aucune réécriture nécessaire : le socle absorbe ces chantiers rapidement.*

---

## 10. Note finale

### 🎯 54 / 100 (maturité commerciale aujourd'hui)

| Axe | Note | Commentaire |
|---|---|---|
| Qualité d'ingénierie / robustesse | 82/100 | Multi-tenant, `Decimal`, verrous, uploads, 0 N+1, perfs |
| Complétude produit | 38/100 | Pas de facture, d'envoi, d'import, édition limitée |
| Conformité légale FR | 28/100 | PDF non conforme, micro-TVA absente |
| UX / onboarding / activation | 45/100 | Cold start non guidé, frictions de parcours |
| Image pro du livrable | 58/100 | Rendu premium mais document non conforme + démo polluée |
| Sécurité / exploitation | 60/100 | Bon socle, mais reset/quota/proxy à finir |

**Projection** : après Phases 0→3, **~76/100** (pilote payant). Après Phases 0→5, **~88/100** (GA).

---

## Verdict — « Serais-tu prêt à commercialiser ARTIZEN demain ? »

## ❌ NON — pas en l'état.

Et **pas** pour un problème d'ingénierie : le moteur est excellent. Le blocage est **produit + conformité** :

1. **Le livrable central — le devis — n'est pas légal** pour la cible principale (bâtiment +
   auto-entrepreneurs) : ni assurance décennale, ni zone de signature, ni traitement micro-TVA (C1, C2).
2. **L'artisan ne peut pas se configurer** depuis l'app (SIRET/assurance gated derrière l'import ; pas
   de reset password) (C3, C4).
3. **Il ne peut pas travailler à l'échelle réelle** (catalogue > 100 invisible) (C5), **ni envoyer**
   son devis, **ni facturer**, **ni importer** son existant (M2, C6, M15).

Ce sont **6 blocages 🔴 clairs**, tous corrigeables en **quelques jours à deux semaines chacun** sur un
socle sain. **~4–5 semaines** de travail ciblé (Phases 0→3) amènent à un **pilote payant crédible**
(≈ 76/100) ; la facturation et l'activation (Phases 4→5) portent à une **GA** vers ≈ 88/100.

**La mission de certification est atteinte** : ARTIZEN n'est **pas** commercialisable demain, la raison
est précise et documentée, et le chemin pour y arriver est chiffré et court.
