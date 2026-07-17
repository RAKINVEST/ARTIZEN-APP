# Roadmap V2

**Écrit le 2026-07-17**, au démarrage de la V2. La V1 est figée sur `main`
au tag `v1.0.0-rc1` ; tout le travail V2 vit sur la branche `v2`.

Cette roadmap n'invente pas de direction produit. Elle croise deux sources
existantes :

1. **Ce que le projet dit de lui-même** — `README.md:70` : « Les futurs
   modules métier (factures, planning, photos, notifications, paiements,
   statistiques) s'ajouteront selon le même patron vertical » ; `app/pdf/`
   existe, vide, annoté « Génération de PDF (devis, factures) — à venir » ;
   `branding/interfaces.py` déclare un port `DocumentRenderer` jamais
   implémenté.
2. **Les 10 recommandations de l'audit V1**, classées par valeur dans
   `docs/release/04_RELEASE_PACKAGE.md`, chacune adossée à une preuve.

## Le constat qui ordonne tout le reste

**Artizen est un SaaS de devis dans lequel un artisan ne peut pas produire
de devis.**

Il peut composer les lignes, le backend calcule HT/TVA/TTC au centime, le
copilote IA propose des articles — puis le devis reste dans une base de
données. Il n'existe aucune route, aucun module, aucune ligne de code qui
produise le PDF que l'artisan enverra à son client. `app/pdf/` est un
paquet vide depuis l'étape 1.

Ce n'est pas une opinion : c'est ce que le README annonce lui-même comme
« à venir », et ce que le port `DocumentRenderer` attend depuis l'étape 2.

**Tout le reste de la V2 en dépend.** Les factures (module suivant nommé
par le README) sont un PDF. Les paiements suivent une facture. Sans
génération de document, la chaîne s'arrête au premier maillon.

## Jalon V2.1 — Rendre le devis livrable

Un devis qu'on peut identifier, corriger, et envoyer.

| # | Item | Pourquoi maintenant | Décision produit requise ? |
|---|---|---|---|
| **1** | **Cycle de vie du devis** : `status` + `quote_number` | Un PDF envoyé à un client a besoin d'un numéro. « Devis 3f2a-8b1c-… » n'est pas envoyable. Et l'audit a établi que `status` doit précéder **toute** route d'écriture — voir ci-dessous. | ⚠️ **OUI** — format de numérotation et jeu de statuts sont visibles par le client final |
| **2** | **Génération du PDF de devis** (`app/pdf/`, port `DocumentRenderer`) | Le trou décrit plus haut. | ⚠️ **Partielle** — mise en page |
| **3** | **Endpoint de comptage** (`GET /clients/count`, …) | Supprime le « 100+ » du dashboard au profit du vrai total. Recommandation #2 de l'audit. | Non |

### Pourquoi `status` doit précéder toute route de modification

L'audit V1 a établi ceci, et c'est le risque le plus mal compris du projet :

> L'absence de route d'écriture sur `/quotes` **n'est pas un oubli : c'est
> aujourd'hui la seule garantie** que les totaux persistés restent cohérents
> avec les lignes. `QuoteCalculator` n'a aucune fonction de recalcul sur un
> devis existant, et rien dans l'architecture n'obligerait un futur
> `PUT /quotes/{id}` à repasser par lui.

Ajouter un `PUT` avant `status`, c'est ouvrir la porte à des devis dont le
total ne correspond plus aux lignes — le pire défaut possible pour ce
produit. L'ordre n'est pas négociable.

### La numérotation a une contrainte légale différée

La numérotation séquentielle sans trou est une obligation légale pour les
**factures** (art. 242 nonies A CGI), **pas** pour les devis. Mais le
README annonce les factures comme module suivant. Le schéma de
numérotation choisi maintenant sera celui dont les factures hériteront.

**Contrainte technique, non négociable :** unicité **par entreprise**
garantie **en base** (`UNIQUE (company_id, quote_number)`), jamais un
`SELECT MAX(...)+1` applicatif — qui créerait une race sur deux créations
simultanées.

## Jalon V2.2 — Dette de sécurité et d'architecture

Aucune décision produit. Chaque item est adossé à une preuve de l'audit V1.

| # | Item | Preuve / motif |
|---|---|---|
| 4 | **Remplacer `python-jose` par PyJWT** | Non maintenu depuis 2021. 219 avertissements de dépréciation à chaque `pytest`. |
| 5 | **Cookie `HttpOnly` + `SameSite`** pour le web | Sur web, `flutter_secure_storage` retombe en localStorage : tout XSS lit le JWT. `allow_credentials` est déjà actif. |
| 6 | **Rate limiting partagé** (Redis) + `X-Forwarded-For` | Le compteur est en mémoire *par worker* : le plafond réel est ~4× celui configuré, et l'IP du socket est fausse derrière un proxy. |
| 7 | **Casser le cycle `users ↔ branding`** | Seule entorse réelle au « sens unique » du README. `Company` vit dans `branding` alors que l'inscription en crée une. |
| 8 | **`ApiClient` dans `core/api/`** | Les 7 features importent Dio directement, contre le contrat « `core/api/` est la seule couche qui connaît Dio ». |

## Jalon V2.3 — Qualité IA

| # | Item | Note |
|---|---|---|
| 9 | **Parsing IA tolérant aux réponses partielles** | Un article malformé fait perdre toute la réponse (502). ⚠️ La correction **doit** faire remonter les items rejetés jusqu'à `SuggestionScorer`, sinon le score devient trop optimiste. |
| 10 | **Double pénalité des doublons** | Mesuré : 0.40 au lieu de 0.85 pour un article proposé deux fois. ⚠️ **Arbitrage produit** : trancher entre les deux valeurs. |

## Hors périmètre V2 — nommé pour mémoire

Le README annonce `planning`, `photos`, `notifications`, `paiements`,
`statistiques`. Aucun n'est dans cette roadmap : la chaîne
devis → PDF → facture doit exister avant qu'on lui ajoute des branches.
`factures` est le candidat naturel pour la V3, une fois le rendu PDF
mutualisable.

## Règles de travail V2 (héritées de l'audit V1)

- **La V1 ne bouge pas.** `main` + tag `v1.0.0-rc1` sont figés.
- **Une fonctionnalité à la fois**, terminée complètement (architecture →
  implémentation → tests → tentative de casse → documentation) avant la
  suivante.
- **Aucune affirmation sans preuve.** Chaque validation est classée :
  exécutée / par tests / statique / raisonnée-sans-preuve. Ces catégories
  ne se mélangent jamais.
- **Les pièges de la V1 restent des pièges** : `.gitattributes` (LF),
  pas de `USER` dans le Dockerfile, `AUTH_RATE_LIMIT_ENABLED=false` dans
  `conftest`, annotations `list[...]` citées dans `QuoteService`. Voir
  `docs/release/05_HANDOFF.md`.
