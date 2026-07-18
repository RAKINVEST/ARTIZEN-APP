# V3 — Conventions, standards & règles de développement (Phases 7-8)

Ces règles prolongent celles de la V2 (`CLAUDE.md`, `CONTRIBUTING.md`). Elles
sont **non négociables** : la V3 doit conserver le niveau de qualité atteint.

## 1. Langues
- **Documentation en français, commentaires de code en anglais.** Constant.

## 2. Architecture
- **Backend** : modules verticaux (`models/schemas/repository/service/deps/
  router`). Dépendances inter-modules **à sens unique et justifiées**,
  documentées. Un nouveau module s'enregistre dans `api/router.py` et
  `models/__init__.py`.
- **Frontend** : feature-first (`data/domain/presentation`). `core/api/` seule
  couche connaissant Dio.
- **Règle d'extraction** : un helper monte au transverse au **2ᵉ**
  consommateur, pas avant. Exception : infra déclarée réutilisable dès le 1er
  (ex. `app/pdf/`).
- **Abstractions de fournisseur** systématiques pour tout service externe
  (IA, paiement, signature, OCR, email, stockage) : interface + factory +
  **mock déterministe** ; l'app démarre et fonctionne sans clé.

## 3. Invariants produit (hérités, absolus)
1. L'IA ne choisit aucun prix/TVA/montant et ne persiste rien (infère la
   quantité, bornée et relue).
2. Un devis/une facture ne se modifie pas — suppression-recréation ou
   duplication ; pas de `PUT`/`PATCH` de contenu.
3. `quotes/calculator.py` (et son équivalent factures) est le **seul** endroit
   où un montant se calcule (`Decimal`, `ROUND_HALF_UP` par ligne).
4. Une réponse d'IA n'est jamais crue : re-validation contre le vrai catalogue.
5. `company_id` vient toujours du JWT.
6. Mismatch de tenant → **404, jamais 403**.
7. Rien n'est appliqué sans confirmation explicite.
8. Numérotation par entreprise garantie **en base** (FOR UPDATE), jamais
   `SELECT MAX+1`. Factures : **sans trou** (obligation légale).

## 4. Design System
- **Source unique** `core/theme/app_theme.dart`. **Aucune couleur codée en
  dur** dans un widget — uniquement les jetons `ArtizenColors`.
- Palette officielle exclusive ; **bleu nuit dominant, or en accent**.
- **Orbitron** réservé au wordmark ARTIZEN ; **Exo 2** pour toute l'UI.
- Espacements sur système **8px** ; radii champ 12 / carte 16.
- Composants réutilisables obligatoires (`AppTextField`, `AppPrimaryButton`,
  `AppSecondaryButton`, `AppLink`, `AppDivider`, `AppInfoCard`, …). Tout
  nouveau motif récurrent → nouveau composant, pas de copie.
- Le **PDF** suit la même palette.

## 5. Qualité & tests
- **Aucune duplication** ; code factorisé ; imports propres ; pas de code mort.
- **Tests systématiques** à chaque fonctionnalité : unité + intégration +
  tentative de casse. Backend en base **isolée** (V3, fondation F7).
- **Portes vertes obligatoires** avant tout merge : `flutter analyze` (No
  issues), `flutter test`, `pytest`, `flutter build web`, `flutter build apk`.
- Toute validation classée : **exécutée / par tests / statique / raisonnée**.
  Ces catégories ne se mélangent jamais.
- Valider les changements de schéma avec un `curl` réaliste (les tests ne
  prouvent pas le contrat HTTP).

## 6. Asynchrone & performance (nouveau en V3)
- Tout traitement lourd (STT/LLM/OCR/email/PDF de masse) passe par la **file
  de tâches** (F1) — jamais dans le fil d'une requête HTTP.
- Pagination systématique sur les collections. Index métier explicites.
- Cache (Redis) pour les agrégations (dashboard) et le rate limit partagé.

## 7. Sécurité & conformité (renforcé)
- Auth : **PyJWT** + cookie HttpOnly (web). Rôles (à introduire proprement).
- RGPD : chiffrement au repos des données sensibles, effacement, export,
  rétention limitée (audio IA, transcriptions).
- Facturation : immutabilité, numérotation sans trou, Factur-X.
- Journal d'audit des actions sensibles.

## 8. Git & CI/CD
- Branches : `v2` = maintenance (figée `v2.0.0`) ; **`develop/v3`** = intégration ;
  une branche par module (`feature/<module>`). Merge vers `develop/v3` après
  portes vertes.
- **Jamais de push sans autorisation explicite** du propriétaire.
- Messages de commit en français, à l'impératif, expliquant le **pourquoi**.
- **CI** (F6) : analyze/test/build à chaque PR ; pas de merge rouge.

## 9. Pièges connus (à ne pas repayer)
`.gitattributes` (LF sur `*.sh`) ; pas de `USER` dans le Dockerfile (réparation
volume) ; `AUTH_RATE_LIMIT_ENABLED=false` dans `conftest` ; annotations
`list[...]` citées dans `QuoteService` ; `bcrypt==4.0.1` épinglé ; Python 3.13
(pas 3.14) ; `@JsonSerializable` sur classe Freezed. Détail : `docs/release/
05_HANDOFF.md` et `CLAUDE.md`.
