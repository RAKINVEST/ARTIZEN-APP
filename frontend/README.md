# Artizen — client Flutter (Étape 6 MVP + Étape 7-9 Copilote IA + Étape 8 Import de devis)

Client mobile/web pour le copilote artisan Artizen. Permet à un artisan
de trouver/créer ses clients, gérer son catalogue de prestations et
fournitures, créer un devis en y ajoutant des lignes de catalogue, et
voir les montants HT/TVA/TTC — **calculés uniquement par le backend**.
Flutter ne recalcule jamais un montant financier : il affiche, navigue,
capture la saisie utilisateur et appelle l'API. Depuis l'Étape 7,
complété à l'Étape 9, un écran "Copilote IA" permet de décrire des
travaux en langage libre et de se voir proposer des lignes de
catalogue correspondantes (modifiables, complétables manuellement,
avec un score de confiance visuellement distinct faible/modéré/fort),
sans que Flutter (ni même le backend) n'invente jamais un article ou un
prix — voir "Feature `quote_assistant`" plus bas. Depuis l'Étape 8, un
écran "Importer un ancien devis" permet de configurer automatiquement
l'identité de l'entreprise et le modèle de devis à partir d'un PDF
existant, toujours avec relecture et validation explicite avant toute
application — voir "Feature `template_import`" plus bas.

## Stack technique

| Domaine              | Choix                                       |
|----------------------|----------------------------------------------|
| Framework            | Flutter (stable), Dart ^3.12.2                |
| Gestion d'état        | Riverpod 2.x (`flutter_riverpod`)               |
| Navigation             | GoRouter 14.x                                     |
| Client HTTP             | Dio 5.x                                             |
| Modèles immuables + JSON | Freezed + json_serializable                           |
| Stockage sécurisé          | `flutter_secure_storage` (token JWT, prêt pour l'auth réelle) |
| Formatage monétaire          | `intl`                                                          |
| Sélection de fichiers          | `file_picker` (compatible Web) — Étape 8, import de PDF           |
| Tests                          | `flutter_test`, `mocktail`                                        |

Choix explicitement écartés : **Provider** et **GetX** (imposés hors
périmètre par l'énoncé) au profit de Riverpod, qui offre un typage plus
strict des providers, un `ProviderContainer` testable sans widget tree,
et une gestion native de l'état asynchrone (`AsyncValue`) qui mappe
directement sur les 4 états requis par chaque écran (chargement / vide /
erreur / succès).

## Démarrage rapide

Prérequis : Flutter SDK installé (`flutter --version`), et le backend
Artizen démarré (`docker compose up` depuis `artizen/`, API disponible
sur `http://localhost:8000`).

```bash
cd artizen/frontend
flutter pub get

# Génère les fichiers *.freezed.dart et *.g.dart (modèles immuables + JSON)
dart run build_runner build --delete-conflicting-outputs

flutter analyze
flutter test
```

Lancer l'application (cible Web, aucun SDK Android/Visual Studio requis) :

```bash
flutter run -d web-server --web-port 3000
```

Puis ouvrir `http://localhost:3000` dans un navigateur. Le port **3000**
n'est pas arbitraire : le backend n'autorise que les origines listées dans
`CORS_ORIGINS`, qui vaut `http://localhost:3000` — un autre port serait
bloqué par CORS. Cette valeur vient du fichier `.env` de la racine (recopié
depuis `.env.example`), que `docker-compose.yml` charge via `env_file` ;
elle n'est pas écrite dans le compose. Pour servir le frontend ailleurs,
c'est donc `.env` qu'il faut modifier, puis redémarrer le backend.

`lib/core/api/api_config.dart` lit l'URL de l'API via une variable de
compilation :

```bash
flutter run -d web-server --web-port 3000 --dart-define=API_BASE_URL=http://localhost:8000/api
```

(`http://localhost:8000/api` est déjà la valeur par défaut ; ce
`--dart-define` n'est utile que pour pointer vers un autre environnement.)

## Arborescence (Feature-First)

```text
lib/
├── core/
│   ├── api/          # ApiConfig, DioClient, intercepteurs (auth, erreurs, logging), ApiException
│   ├── theme/         # AppTheme (Material 3)
│   ├── navigation/       # GoRouter (app_router.dart), AppShell (bottom nav bar)
│   ├── widgets/            # AsyncValueView/AsyncListView, LoadingState, EmptyState, ErrorState
│   └── utils/                # CurrencyFormatter
├── shared/
│   ├── providers/       # currentCompanyIdProvider (bootstrap company_id partagé par tous les modules)
│   └── widgets/            # ConfirmDialog, SearchField
├── features/
│   ├── auth/             # data/ domain/ presentation/ — login simulé, plomberie JWT prête
│   ├── dashboard/           # Compteurs (clients/catalogue/devis) + derniers devis
│   ├── clients/               # CRUD + recherche
│   ├── catalog/                 # Catégories + articles (service/produit)
│   ├── quotes/                     # Liste, détail, création de devis (lignes de catalogue uniquement)
│   ├── quote_assistant/               # Étape 7 : description libre -> suggestion -> devis
│   ├── branding/                         # Étape 8 : Company/BrandProfile/DocumentTemplate (identité)
│   └── template_import/                     # Étape 8 : import PDF -> aperçu -> validation -> modèle actif
└── main.dart                                    # ArtizenApp (MaterialApp.router)
```

Chaque feature suit `data/` (modèles + implémentation repository via
Dio) / `domain/` (interface repository abstraite) / `presentation/`
(écrans + providers Riverpod + widgets locaux) — jamais l'inverse :
`domain/` ne dépend d'aucun détail Dio, `presentation/` ne parle jamais
directement à Dio, uniquement à travers un repository injecté par
provider.

## Choix d'architecture

### Pourquoi Feature-First plutôt que Layer-First

Une arborescence par couche (`models/`, `screens/`, `providers/` au
niveau racine) devient difficile à naviguer dès qu'un projet dépasse
quelques écrans — exactement la même leçon que le pivot vertical du
backend à l'étape 2 (voir le README racine, "Modules métier verticaux
vs couches transverses"). Ici, chaque dossier `features/<nom>/`
regroupe tout ce qui concerne un domaine (clients, catalogue, devis) :
ajouter un nouveau module métier (ex: factures, plus tard) revient à
ajouter un nouveau dossier sans toucher aux autres.

### `core/api/` : la seule couche qui connaît Dio

- **`ApiConfig`** — une seule constante, `baseUrl`, lue via
  `String.fromEnvironment('API_BASE_URL', ...)` pour permettre de
  changer d'environnement à la compilation sans recompiler le code.
- **`ApiException`** (union Freezed : `network`, `timeout`,
  `server(statusCode, code, message)`, `unknown`) — un type d'erreur
  unique et exhaustif, pattern-matchable dans l'UI (`when`/`map`) pour
  afficher un message adapté sans jamais exposer une `DioException` brute
  à un écran.
- **`ErrorInterceptor`** — traduit chaque `DioException` en
  `ApiException` au même endroit pour toute l'application. Le corps
  d'erreur backend (`{"error": {"code", "message"}}`, voir README racine
  section "Gestion des erreurs") est lu ici pour remplir `code`/`message`
  quand le serveur répond en 4xx/5xx, plutôt que de laisser chaque écran
  reparser la réponse.
- **`AuthInterceptor`** — injecte `Authorization: Bearer <token>` si un
  token est présent (`AuthTokenStorage.readToken()`), sans bloquer la
  requête sinon : la plupart des endpoints ne sont pas encore protégés
  côté backend, donc l'absence de token n'est jamais une erreur ici.
- **`PrettyDioLogger`** — n'est branché que si `kDebugMode` est vrai
  (aucun log réseau en profil release).
- **`AuthTokenStorage`** — interface abstraite avec une seule
  implémentation (`SecureAuthTokenStorage`, `flutter_secure_storage`),
  volontairement placée dans `core/api/` et non dans `features/auth/` :
  c'est une infrastructure transverse potentiellement consommée par
  n'importe quel intercepteur, pas une règle métier du module auth.

### Pourquoi Freezed + json_serializable plutôt que des classes à la main

Chaque modèle (`Client`, `CatalogItem`, `Quote`, ...) a besoin de trois
choses systématiquement sujettes à erreur si écrites à la main :
immutabilité, `==`/`hashCode` corrects, et sérialisation JSON fidèle au
contrat backend. Freezed génère les deux premiers, `json_serializable`
le troisième — à partir de la même déclaration de classe annotée
`@freezed`.

`build.yaml` configure `json_serializable` globalement :

```yaml
targets:
  $default:
    builders:
      json_serializable:
        options:
          field_rename: snake
          include_if_null: false
```

- `field_rename: snake` : les modèles Dart s'écrivent en camelCase
  (convention Dart) mais sérialisent en snake_case (convention de l'API
  Python) sans qu'aucun modèle n'ait à répéter `@JsonKey(name: '...')`
  champ par champ.
- `include_if_null: false` : un champ non renseigné est **omis** du JSON
  envoyé plutôt que sérialisé en `null` — indispensable pour les
  `*Input` utilisés en `PUT` (mise à jour partielle), qui doivent
  reproduire la sémantique `exclude_unset=True` de Pydantic côté
  backend : envoyer `null` explicitement écraserait un champ que
  l'utilisateur n'a pas touché.

Les fichiers générés (`*.freezed.dart`, `*.g.dart`) sont commités comme
n'importe quel autre projet Flutter suivant cette stack, et exclus de
l'analyse statique (`analysis_options.yaml` → `analyzer: exclude`).

### Riverpod : `AsyncNotifier` pour l'état serveur, `Notifier`/`StateProvider` pour l'état de formulaire pur

- Chaque liste chargée depuis l'API (`ClientsNotifier`,
  `CategoriesNotifier`, `ItemsNotifier`, `QuotesNotifier`) est un
  `AsyncNotifier<List<T>>` : son état est nativement un `AsyncValue`,
  ce qui donne le triplet chargement/erreur/donnée sans code
  supplémentaire, consommé directement par `AsyncValueView`/
  `AsyncListView` (voir plus bas).
- L'état d'un formulaire de devis en cours de saisie (lignes
  sélectionnées, client choisi) n'appelle aucune API tant qu'on n'a pas
  cliqué "Créer le devis" : `QuoteDraftNotifier` (`Notifier<List<QuoteDraftLine>>`)
  et `quoteDraftClientProvider` (`StateProvider<Client?>`) sont donc de
  simples providers synchrones, sans `AsyncValue`, plus simples et plus
  rapides à tester.
- **Piège de cache identifié et corrigé** : un `FutureProvider` (ou le
  `build()` d'un `AsyncNotifier`) dont le Future a échoué reste
  **indéfiniment en échec tant qu'il n'est pas explicitement invalidé** —
  `ref.invalidate()` sur un provider *aval* ne réexécute pas
  automatiquement un provider *amont* dont il dépend via
  `ref.watch(x.future)`. `currentCompanyIdProvider`
  (`shared/providers/current_company_provider.dart`) est ce provider
  amont commun (bootstrap du `company_id` via `GET /branding/profile`,
  consommé par tous les autres modules) ; sans le comprendre, un simple
  incident réseau transitoire au démarrage aurait rendu l'application
  bloquée en erreur de façon permanente, "Réessayer" ne changeant plus
  jamais rien. Le correctif : une fonction utilitaire
  `refreshCurrentCompanyId(Ref ref)` qui invalide *puis* relit le
  provider amont, appelée par le `refresh()` de chaque notifier aval
  ainsi que par le bouton "Réessayer" du tableau de bord — voir
  `dashboard_screen.dart::_retry`.

### `core/widgets/` : un seul mécanisme pour les 4 états exigés sur chaque écran

`AsyncValueView<T>` (donnée unique) et `AsyncListView<T>` (liste, avec un
état "vide" dédié quand la liste est chargée mais sans élément) sont les
deux seuls widgets qui pattern-matchent un `AsyncValue` : chaque écran
leur délègue le rendu chargement/erreur/vide/succès plutôt que de
réimplémenter un `if (isLoading) ... else if (error) ...` à chaque
endroit. Un futur écran métier n'a qu'à fournir son `builder` pour le
cas "succès" ; les trois autres états sont déjà gérés de façon uniforme
(mêmes widgets `LoadingState`/`EmptyState`/`ErrorState`, même bouton
"Réessayer").

### Navigation : `StatefulShellRoute` pour la barre du bas, routes racine pour le reste

`app_router.dart` déclare une `StatefulShellRoute.indexedStack` à 5
branches (Dashboard/Clients/Catalogue/Devis/Paramètres) : chaque onglet
garde sa propre pile de navigation et son propre état de scroll en
arrière-plan quand on change d'onglet (comportement natif attendu d'une
bottom nav bar). Les écrans qui doivent occuper tout l'écran par-dessus
la barre (formulaire client, formulaire article, formulaire/détail de
devis) sont déclarés comme des `GoRoute` de premier niveau avec
`parentNavigatorKey: _rootNavigatorKey` : ils ne font pas partie du
"shell" et cachent momentanément la bottom bar, comme attendu pour un
formulaire de création.

`redirect` dans `GoRouter` attend `authNotifierProvider.future` avant de
décider si l'utilisateur atterrit sur `/login` ou sur le tableau de bord
— l'auth étant simulée (voir plus bas), c'est surtout la plomberie qui
est prête pour une vraie vérification de session plus tard.

### Auth : inscription et connexion réelles (Étape 10)

Depuis l'étape 10, le backend expose un vrai module `users/`
(`POST /auth/register`, `POST /auth/login`) — la prédiction faite à
l'étape 6 ("le jour où le backend expose `/auth/login`, seul
`AuthRepository.login()` change") s'est vérifiée presque mot pour mot :

- `AuthRepository` (`features/auth/data/auth_repository.dart`) appelle
  désormais réellement `POST /auth/register` / `POST /auth/login` via
  le `dioProvider` partagé, et persiste le `access_token` de la réponse
  dans `AuthTokenStorage` — remplaçant l'ancien token simulé
  (`'demo-simulated-token'`) écrit sans appel réseau.
- `AuthNotifier` gagne des paramètres réels : `login({email, password})`
  et `register({email, password, fullName, companyName})` remplacent
  les anciennes méthodes sans argument. Sa forme (`AsyncNotifier<bool>`,
  `state = AsyncValue.data(true/false)`) ne change pas : c'est
  exactement ce qui permet à `AuthInterceptor` et
  `currentCompanyIdProvider` (tous deux construits à l'étape 6) de
  fonctionner sans aucune modification dès qu'un vrai JWT existe.
- `LoginScreen` devient un vrai formulaire (email, mot de passe,
  validation, état de chargement, message d'erreur via
  `ApiException.displayMessage`) et un nouvel écran `RegisterScreen`
  (email, mot de passe ≥ 8 caractères, nom complet et nom d'entreprise
  optionnels) complète le flux — un lien "Créer un compte"/"J'ai déjà un
  compte" relie les deux. `app_router.dart` ajoute la route `/register`
  et traite `/login` et `/register` de façon symétrique dans le
  `redirect` (aucune des deux routes n'est accessible une fois
  connecté, ni l'inverse).

Aucun changement dans `core/api/` : `AuthTokenStorage`,
`AuthInterceptor` et `ErrorInterceptor` restent exactement ceux conçus à
l'étape 6, la validation de cette prédiction architecturale étant elle
aussi une preuve de la solidité de ce découpage.

### `catalog/`, `clients/`, `quotes/` : aucun calcul financier côté client

`QuoteLineInput` (l'objet envoyé à `POST /quotes`) ne porte qu'un
`catalogItemId` et une `quantity` — structurellement, aucun champ prix
n'existe côté Flutter, à l'image de `QuoteLineCreate` côté backend (voir
README racine, "Artizen n'invente jamais les prix"). `QuoteTotalsCard`
n'affiche que les champs `totalHt`/`totalVat`/`totalTtc` renvoyés par
l'API, passés tels quels à `CurrencyFormatter.format()` (`intl`,
formatage pur, aucune arithmétique). `ItemsNotifier.search()` est la
seule "logique" côté client de tout le module métier, et elle ne fait
que filtrer une liste déjà chargée par sous-chaîne (désignation/code) :
le backend n'exposant pas de paramètre de recherche pour les articles de
catalogue, et le catalogue d'un artisan restant de taille modeste,
filtrer côté client était plus simple qu'ajouter un endpoint dédié.

### `quote_assistant/` : une proposition, jamais une création (Étape 7, complété Étape 9)

```text
features/quote_assistant/
├── data/
│   ├── quote_suggestion_models.dart      # QuoteSuggestionItem, QuoteSuggestion (Freezed)
│   └── quote_assistant_repository_impl.dart
├── domain/
│   └── quote_assistant_repository.dart
└── presentation/
    ├── quote_assistant_providers.dart    # QuoteAssistantNotifier, AcceptedSuggestionItemsNotifier
    └── quote_assistant_screen.dart
```

Accessible depuis l'icône ✨ dans l'AppBar de l'onglet "Devis". Le flux
suit exactement les 5 étapes de l'énoncé (saisie libre → "Analyser" →
suggestions → modification → "Créer le devis"), avec une séparation
nette entre deux états :

- **`QuoteAssistantNotifier`** (`AsyncNotifier<QuoteSuggestion?>`) porte
  la dernière réponse *en lecture seule* renvoyée par `POST
  /quote-assistant/suggest` — jamais modifiée après coup.
- **`AcceptedSuggestionItemsNotifier`** est la copie de travail
  *modifiable* : c'est elle que l'utilisateur édite (quantité, retrait
  d'un article) via "possibilité de modifier" avant de créer le devis.
  Séparer les deux évite qu'éditer une quantité ne donne l'illusion que
  la réponse de l'IA elle-même a changé.

**"Créer le devis" ne crée rien dans ce module.** Il résout chaque
`catalog_item_id` accepté en un vrai `CatalogItem` (un seul appel
`GET /catalog/items?active_only=true`, pour disposer du prix/unité/etc.
que la réponse de suggestion ne porte pas), pré-remplit
`quoteDraftLinesProvider` — le même brouillon que `QuoteFormScreen`
(Étape 6) utilise déjà — puis navigue vers `/quotes/new`. La création
elle-même reste `POST /quotes`, exactement comme avant cette
fonctionnalité : "la création du devis utilise ensuite les endpoints
existants" (énoncé), au pied de la lettre — aucun nouveau code de
création de devis n'a été écrit.

**Sans clé Anthropic configurée, l'écran fonctionne exactement comme
avec une vraie clé — jamais d'écran d'erreur.** Le backend
(`ai/factory.py`) bascule lui-même, automatiquement, sur `MockAIProvider`
(voir README racine, section `quote_assistant/`) : `POST
/quote-assistant/suggest` répond toujours `200` avec une suggestion
valide (par recoupement de mots-clés sur le catalogue, ou une liste vide
si rien ne correspond), jamais une erreur liée à une clé manquante.
Flutter ne sait même pas quel fournisseur a répondu — il affiche la
suggestion reçue normalement, quel que soit le fournisseur réellement
utilisé côté serveur.

**Étape 9 : "Copilote IA" (même écran, deux ajouts).** L'écran est
renommé dans son AppBar ("Copilote IA" plutôt que "Assistant IA" —
même route `/quote-assistant`, même icône ✨, aucune migration de
navigation nécessaire) et gagne :

- **"Ajouter un article"** — `AcceptedSuggestionItemsNotifier.addItem()`
  ajoute une ligne choisie manuellement dans le catalogue (via un petit
  picker dédié, `_ManualItemPickerSheet`, plutôt que de réutiliser le
  picker privé de `QuoteFormScreen` qui n'est pas exporté) à côté de ce
  que l'IA a proposé, avec `reason: 'Ajouté manuellement'` — l'énoncé
  demande explicitement cette possibilité en plus de la modification
  des lignes déjà suggérées.
- **Un bandeau de confiance coloré plutôt qu'un pourcentage nu** —
  "Confiance forte" (≥ 70 %, `primaryContainer`), "Confiance modérée"
  (40-70 %, `tertiaryContainer`), "Confiance faible — vérifiez les
  suggestions" (< 40 %, `errorContainer`) : les états UX "faible
  confiance"/"forte confiance" demandés par l'énoncé doivent être
  *reconnaissables au premier coup d'œil*, pas seulement déductibles
  d'un nombre. Le calcul du niveau (`_confidenceLevelOf`) reste un
  simple `if` sur le `confidence` déjà renvoyé par le backend — aucun
  calcul métier, juste un seuillage d'affichage.

Les autres états UX demandés par l'énoncé étaient déjà couverts avant
l'étape 9 et n'ont pas changé : "analyse en cours" (`LoadingState`
pendant `isLoading`), "aucune correspondance" (`EmptyState` quand la
liste acceptée est vide), "erreur réseau" (`ErrorState` avec
"Réessayer" sur l'état `AsyncError`).

### `branding/` et `template_import/` : import de devis (Étape 8)

```text
features/branding/
├── data/branding_models.dart              # Company, BrandProfile, DocumentTemplate, *UpdateInput
├── domain/branding_repository.dart
├── data/branding_repository_impl.dart
└── presentation/branding_providers.dart   # brandingProfileNotifierProvider

features/template_import/
├── data/template_import_models.dart       # DocumentAnalysisSummary, DetectionResult, Preview, ValidateInput
├── domain/template_import_repository.dart
├── data/template_import_repository_impl.dart
└── presentation/
    ├── template_import_providers.dart     # state machine : idle -> uploading -> analyzing -> preview -> validating -> done
    └── template_import_screen.dart
```

**Pourquoi une feature `branding/` séparée plutôt que tout mettre dans
`template_import/`.** `Company`/`BrandProfile`/`DocumentTemplate`
n'avaient encore aucun modèle côté Flutter (aucune feature précédente
n'en avait besoin). Les regrouper dans leur propre feature — plutôt que
les enterrer dans `template_import/`, seul consommateur actuel — les
rend immédiatement réutilisables par un futur écran "Paramètres de
l'entreprise" sans dépendre de l'écran d'import.

**Une machine à états explicite plutôt que plusieurs providers
indépendants.** Le pipeline est strictement séquentiel (upload →
analyse → aperçu → validation), donc un seul état a du sens à la fois :
`TemplateImportState` est une hiérarchie scellée (`sealed class` +
sous-classes, pattern matching Dart 3 avec `switch`) plutôt que
plusieurs `AsyncNotifier` indépendants qu'il faudrait garder synchronisés
manuellement. `TemplateImportFailed` porte optionnellement le dernier
aperçu obtenu : un échec de *validation* (ex: réseau coupé) réaffiche le
formulaire pré-rempli avec un message d'erreur plutôt que de perdre la
saisie et de forcer un nouvel upload complet.

**Aperçu = valeurs détectées, jamais un formulaire vide.** Chaque champ
du formulaire de prévisualisation est initialisé avec la valeur détectée
si elle existe, sinon la valeur actuelle de l'entreprise, sinon une
chaîne vide — jamais une valeur inventée côté client. La validation
envoie les valeurs *finales* affichées à l'écran (conservées ou
éditées), pas un différentiel : le backend applique tel quel ce que
l'utilisateur a confirmé.

**`file_picker` pour la sélection de fichier, compatible Web.**
`FilePicker.platform.pickFiles(type: FileType.custom, allowedExtensions:
['pdf'], withData: true)` — `withData: true` est indispensable sur Web
(pas d'accès filesystem, seuls les octets en mémoire sont disponibles),
et l'upload utilise `MultipartFile.fromBytes` (Dio) pour la même raison
— jamais `MultipartFile.fromFile`, qui échouerait silencieusement sur
Web.

**"Créer le devis" n'existe pas ici : "Valider ce modèle" ne crée
rien non plus.** Comme `quote_assistant` ne crée jamais de devis
lui-même, `template_import` ne construit jamais de PDF ni de modèle de
zéro : il transmet au backend les octets déjà sélectionnés par
l'utilisateur et les valeurs qu'il a confirmées ; toute la logique de
détection, de persistance et de bascule du modèle actif reste
entièrement côté serveur.

## Tests

```bash
flutter test
```

- **Modèles** (`test/features/*/*_model_test.dart`) : sérialisation/
  désérialisation JSON aller-retour, y compris `field_rename: snake` et
  l'omission des champs null en sortie.
- **Repository** (`clients_repository_test.dart`) : `MockDio` (mocktail)
  vérifie que le repository construit la bonne requête HTTP et parse
  correctement la réponse — aucun réseau réel.
- **Notifier** (`clients_notifier_test.dart`) : `ProviderContainer` avec
  `overrideWith`/`overrideWithValue` sur le repository, sans widget tree,
  pour tester la logique Riverpod isolément.
- **Smoke test applicatif** (`widget_test.dart`) : monte `ArtizenApp` en
  overridant `authTokenStorageProvider`, `currentCompanyIdProvider` et
  les 3 repositories par des fakes (`test/support/fake_repositories.dart`),
  vérifie que l'écran de connexion s'affiche puis que "Se connecter" mène
  au tableau de bord.
- **`quote_assistant`** (`quote_suggestion_models_test.dart`,
  `quote_assistant_notifier_test.dart`) : sérialisation JSON de
  `QuoteSuggestion`/`QuoteSuggestionItem`, et `QuoteAssistantNotifier`
  via un `FakeQuoteAssistantRepository` — vérifie que `analyze()`
  peuple `acceptedSuggestionItemsProvider`, que l'utilisateur peut
  modifier une quantité ou retirer un article, que `clear()`
  réinitialise bien les deux providers, et (Étape 9) que
  `addItem()` ajoute correctement une ligne saisie manuellement.
- **`quote_assistant_screen_test.dart`** (Étape 9, nouveau) : quatre
  `testWidgets` qui montent `QuoteAssistantScreen` avec un
  `QuoteAssistantNotifier` figé sur une confiance donnée (0.9 / 0.5 /
  0.2) et vérifient que le bandeau affiché est bien "Confiance forte" /
  "Confiance modérée" / "Confiance faible", plus une vérification que
  "Ajouter un article" est bien présent une fois une suggestion
  affichée — la seule suite de tests de ce projet qui monte un écran
  complet plutôt qu'un notifier ou un modèle isolément, parce que
  "l'affichage du score de confiance" est justement ce qu'un test de
  notifier ne peut pas prouver à lui seul.
- **`branding`/`template_import`** (`branding_models_test.dart`,
  `template_import_models_test.dart`, `template_import_notifier_test.dart`) :
  sérialisation JSON de `BrandingProfile`/`DetectionResult` (y compris
  l'ignorance silencieuse des champs backend non repris dans le modèle
  partiel), et `TemplateImportNotifier` via un
  `FakeTemplateImportRepository` — vérifie que `importFile()` traverse
  bien upload → process → preview jusqu'à `TemplateImportPreviewReady`,
  que `validate()` atteint `TemplateImportDone`, et que `reset()`
  ramène à `TemplateImportIdle` depuis n'importe quel état.

**Limite connue :** comme côté backend (voir README racine, section
Tests), les tests d'intégration/notifier utilisent des fakes/mocks
plutôt qu'un vrai serveur — aucune suite de tests Flutter n'exécute
d'appel réseau réel contre le backend Docker ; la validation contre le
backend réel a été faite manuellement (voir "Validation manuelle"
ci-dessous).

## Validation manuelle effectuée

Avec le backend démarré (`docker compose up`) et l'application lancée en
mode web (`flutter run -d web-server --web-port 3000`), le parcours
suivant a été exécuté de bout en bout dans un navigateur réel :

1. Connexion (simulée) → arrivée sur le tableau de bord, compteurs
   clients/catalogue/devis chargés depuis l'API.
2. Création d'un client, recherche d'un client existant.
3. Création d'un article de catalogue.
4. Création d'un devis : sélection du client créé à l'étape 2, ajout
   d'une ligne référençant l'article créé à l'étape 3, soumission.
5. Écran de détail du devis : HT, TVA et TTC affichés proviennent tous
   les trois de la réponse `POST /quotes` du backend (`QuoteCalculator`),
   pas d'un calcul Flutter.

### Erreurs rencontrées pendant la validation, et corrections

- **`flutter analyze` — `non_exhaustive_switch_statement`** sur
  `DioExceptionType.transformTimeout` dans `error_interceptor.dart` :
  Dio a ajouté une valeur d'enum entre deux versions mineures ; corrigé
  en remplaçant les derniers cas énumérés par un `default:` — plus
  robuste face à de futures valeurs ajoutées par le SDK.
- **`flutter test` — `test/widget_test.dart` référençait `MyApp`**,
  classe du template par défaut de `flutter create`, jamais adaptée au
  vrai point d'entrée `ArtizenApp` : réécrit entièrement autour de
  `ArtizenApp` + overrides Riverpod.
- **`flutter test` — assertion `findsOneWidget` sur "Tableau de bord"
  en échec** : le texte apparaît légitimement deux fois (titre d'AppBar
  et libellé de la bottom nav bar) ; corrigé en `findsNWidgets(2)`.
- **Lints mineurs** : `RadioListTile` (API `groupValue`/`onChanged`
  dépréciée) remplacé par un `ListTile` + icône de sélection manuelle
  dans `quote_form_screen.dart` ; import `material.dart` inutilisé
  supprimé dans `widget_test.dart` ; fichiers générés (`*.freezed.dart`,
  `*.g.dart`) exclus de l'analyse (`analysis_options.yaml`).
- **Bug d'architecture Riverpod** (cache d'un provider amont en échec
  permanent) : voir la section "Piège de cache identifié et corrigé"
  ci-dessus — le seul bug non cosmétique trouvé pendant la validation,
  corrigé avant la démonstration finale.

Tous les problèmes ci-dessus ont été corrigés ; à la fin de la
validation, `flutter analyze` ne remonte aucun problème et
`flutter test` passe intégralement.

### Étape 7 : validation et limite rencontrée

- **`flutter analyze`** : 0 problème après ajout de `quote_assistant/`
  (une erreur d'import initiale — `catalogRepositoryProvider` importé
  depuis le mauvais fichier — corrigée immédiatement).
- **`flutter test`** : 20/20 verts, dont 5 nouveaux tests
  `quote_assistant` (modèles + notifier).
- **Régression pré-existante trouvée et corrigée en passant** :
  `ClientsNotifier.search()` (Étape 6) souffrait d'une vraie course
  Riverpod — `refresh()` invalide `currentCompanyIdProvider`, ce que
  `build()` observe via `ref.watch(...)`, déclenchant une reconstruction
  automatique concurrente à l'affectation manuelle de `state` ; selon
  l'ordre d'arrivée, le résultat non filtré pouvait écraser le résultat
  filtré. Diagnostiqué avec un test instrumenté (`container.listen`)
  isolant précisément la course. Corrigé en faisant en sorte que
  `search()` ne passe plus par `refreshCurrentCompanyId` (une recherche
  n'a jamais besoin de re-bootstrapper le `company_id` — seule la
  vraie récupération après échec, via "Réessayer", en a besoin).
- **Démonstration manuelle limitée par un incident d'outil (volet
  Browser)** : lors de la première tentative, le volet Browser est
  resté injoignable (`computer`/`read_page`/`resize_window`/exécution JS
  tous en timeout sur 5 onglets), alors que `read_network_requests`
  confirmait que l'application elle-même démarrait correctement — un
  problème d'outil, pas de code. La validation de l'écran "Assistant IA"
  s'est donc appuyée sur `curl` directement contre le backend réel
  (sans navigateur), qui a confirmé le comportement exact que l'écran
  affiche : `POST /quote-assistant/suggest` répond `200` avec une vraie
  suggestion (cas de correspondance) puis `200` avec une liste vide (cas
  sans correspondance) — jamais d'erreur, sans aucune clé configurée.
  Voir README racine, section `quote_assistant/`, pour le détail de
  cette validation en mode automatique sans clé.

### Étape 8 : validation

- **`flutter analyze`** : 0 problème après ajout de `branding/` et
  `template_import/` (une erreur d'import initiale —
  `brandingRepositoryProvider` importé depuis `branding_providers.dart`
  au lieu de `branding_repository_impl.dart`, qui l'exporte réellement —
  corrigée immédiatement).
- **`flutter test`** : 27/27 verts, dont 7 nouveaux tests
  (`branding_models_test.dart`, `template_import_models_test.dart`,
  `template_import_notifier_test.dart`).
- **Même incident d'outil (volet Browser) que l'étape 7** :
  `computer`/`read_page` sont restés en timeout sur un nouvel onglet
  malgré un redémarrage complet du serveur de développement Flutter,
  alors que `read_network_requests` confirmait à nouveau que
  l'application démarrait correctement (tableau de bord chargé avec les
  vraies données). La validation de bout en bout du pipeline
  "importer → analyser → prévisualiser → valider" a donc été faite en
  exécutant la séquence complète via `curl` à l'intérieur du conteneur
  backend (upload d'un PDF généré avec `pypdf`, `process`, `preview`,
  `validate` avec des valeurs de test), qui reproduit exactement les
  appels que l'écran Flutter effectue. Résultat observé : le nouveau
  modèle de devis apparaît bien comme l'unique `is_active: true` parmi
  tous les modèles existants de l'entreprise, et `company`/`brand` dans
  la réponse reflètent les valeurs soumises — le comportement exact
  attendu de "Valider ce modèle".

### Étape 9 : validation

- **`flutter analyze`** : 0 problème après l'ajout du bouton "Ajouter un
  article", du bandeau de confiance et du picker manuel.
- **`flutter test`** : 32/32 verts, dont 5 nouveaux (1 sur
  `addItem()`, 4 `testWidgets` sur le bandeau de confiance et la
  présence du bouton "Ajouter un article").
- **Backend redémarré, 84/84 tests pytest verts** (73 précédents + 11
  nouveaux sur le contexte entreprise/fréquence, la déduplication, la
  pénalité de score et l'ambiguïté du fournisseur de secours).
- **`docker compose down` puis `up`** (arrêt/redémarrage complet, pas
  seulement un restart) : stack saine dès le premier démarrage, `/` et
  `/health` répondent 200, suite pytest rejouée avec succès sur la
  pile fraîchement démarrée.
- **Démonstration réelle de la gestion de l'ambiguïté** : le catalogue
  de démonstration contient, du fait des étapes précédentes, des
  dizaines d'articles nommés identiquement "Chauffe-eau Atlantic 200 L".
  Un appel réel à `POST /quote-assistant/suggest` avec la description
  de l'énoncé ("Remplacement d'un chauffe-eau Atlantic 200 litres avec
  groupe de sécurité...") renvoie une confiance de `0.35` (le niveau
  "ambigu" du `MockAIProvider`, deux meilleurs candidats à égalité) et
  des justifications citant réellement les mots-clés ("Correspondance
  par mots-clés : 200, atlantic, chauffe-eau") — la démonstration la
  plus convaincante possible de "gestion des réponses ambiguës" et
  "meilleure justification des correspondances", obtenue sans donnée
  fabriquée pour l'occasion. Les logs du conteneur backend confirment
  la journalisation détaillée attendue
  (`quote_assistant.raw_response`, `quote_assistant.completed` avec le
  détail des comptages).
- **Même incident d'outil (volet Browser)** que les étapes 7 et 8 :
  non résolu cette session, contourné de la même façon (validation via
  `curl` contre le backend réel, qui reproduit exactement les appels
  que l'écran Flutter effectue).

### Étape 10 : validation

- **`flutter analyze`** : 0 problème après la réécriture
  d'`AuthRepository`/`AuthNotifier`, `LoginScreen`, et l'ajout de
  `RegisterScreen`.
- **`flutter test`** : 42/42 verts, dont 9 nouveaux — `auth_repository_test.dart`
  (login/register/logout, avec un `MockDio` mocktail) et
  `auth_providers_test.dart` (transitions d'état de `AuthNotifier` avec
  un `FakeAuthRepository` partagé dans `test/support/`). Le test
  `widget_test.dart` historique (boot → login → dashboard) a dû être
  adapté : il tapait directement sur "Se connecter" sans remplir de
  champ, ce qui fonctionnait avec l'ancien bouton simulé mais échoue
  désormais puisque le formulaire valide email/mot de passe avant de
  déclencher un vrai appel réseau — corrigé en remplissant les deux
  champs et en substituant `authRepositoryProvider` par le
  `FakeAuthRepository` partagé plutôt que de laisser le test dépendre du
  backend réel.
- **Backend redémarré, 95/95 tests pytest verts** (84 précédents + 11
  nouveaux sur `users/` : inscription, doublon d'email, entreprise
  distincte par compte, connexion, mot de passe incorrect, email
  inconnu, `/me`, 403 sans token, 401 avec token invalide).
- **Démonstration réelle de bout en bout contre le backend Docker**,
  via `curl` (le volet Browser restant instable, comme aux étapes
  précédentes) : inscription de deux comptes indépendants (`Atelier
  Alpha`, `Atelier Beta`), chacun recevant un vrai JWT et sa propre
  `company_id` ; création d'un client et d'une catégorie de catalogue
  pour Alpha *sans jamais envoyer `company_id`* dans le corps de la
  requête (le champ étant désormais optionnel côté schéma, voir README
  racine) ; Beta obtient une liste de clients vide et un `404` en
  tentant d'accéder par id au client d'Alpha ; une connexion avec un
  mauvais mot de passe renvoie `401 unauthorized`. Cette démonstration a
  d'ailleurs révélé le bug `company_id` obligatoire documenté dans le
  README racine, corrigé avant validation finale.
- **`docker compose ps`** : `backend` et `db` sains (`healthy`),
  aucun rebuild d'image nécessaire (le module `users/` et le retrofit
  multi-tenant sont montés en volume, seul un `restart` du conteneur a
  suffi à charger le correctif de schéma `company_id`).
