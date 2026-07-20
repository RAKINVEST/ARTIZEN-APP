# 08 — Wizard Readiness : le projet est-il prêt à câbler entièrement le wizard ?

> **Revue uniquement. Aucun développement.** Ce document répond à une seule question :
> *« Le projet est-il prêt à câbler entièrement le wizard de devis ? »*
> Il liste ce qui est prêt, ce qui manque, les dépendances, les risques et une estimation.
>
> Base : branche `develop/v3`, **60 routes** exposées par l'API (OpenAPI live), backend
> **480 tests verts**, frontend `flutter analyze` propre + **124 tests verts**.
> Constitution : [`ARCHITECTURE_V1_REFERENCE.md`](../ARCHITECTURE_V1_REFERENCE.md).

> ⚠️ **Note de numérotation** : les préfixes `07_` et `08_` de `docs/release/` étaient déjà
> pris (`07_V2_CERTIFICATION`, `08_USER_ACCEPTANCE_TEST`, `09_POST_UAT_CORRECTIONS`). Ce
> fichier est créé au nom exact demandé. Une renumérotation (→ `10_`, `11_`) est possible sur
> décision du propriétaire.

---

## 1. Réponse courte

**OUI — le projet est prêt à câbler le wizard de bout en bout pour le parcours nominal
(lignes issues du catalogue, « Envoyer » = passage au statut *envoyé* + PDF).** Les 7 étapes
ont chacune leur endpoint backing, testé et stable. Aucun trou bloquant pour ce parcours.

**Trois sous-fonctionnalités dépendent d'une décision de périmètre** (chacune = une petite
extension backend *si* elle est jugée V1) : **lignes libres**, **prix personnalisé par ligne**,
**envoi par e-mail**. Aucune ne bloque le parcours nominal ; ce sont des **décisions**, pas des
inconnues.

---

## 2. Cartographie des 7 étapes → endpoints

| # | Étape | Endpoint(s) backing | Statut |
|---|---|---|---|
| 1 | **Client** | `GET /api/clients`, `GET /api/clients/{id}`, `POST /api/clients` | ✅ Prêt |
| 2 | **Dossier** | `GET /api/catalog/categories/overview`, `GET /api/catalog/categories`, `.../{id}` | ✅ Prêt |
| 3 | **Articles** | `GET /api/catalog/items` (recherche/pagination), `GET /api/catalog/items/{id}`, `POST /api/quote-assistant/suggest` (IA, option) | ✅ Prêt (catalogue) · ⚠️ lignes libres (voir §4) |
| 4 | **Personnaliser** | `POST /api/quotes/calculate` (chiffrage live, sans persistance) | ✅ Prêt pour quantités · ⚠️ prix par ligne (voir §4) |
| 5 | **Récap** | résultat de `POST /api/quotes/calculate` (`total_ht/vat/ttc` + lignes) ; `GET /api/quotes/{id}/readiness` (post-création) | ✅ Prêt · ⚠️ ventilation TVA par taux (voir §4) |
| 6 | **Créer** | `POST /api/quotes` (devis numéroté `DEV-AAAA-NNNN`) | ✅ Prêt |
| 7 | **Envoyer** | `PUT /api/quotes/{id}/status` (draft→sent), `GET /api/quotes/{id}/pdf` | ✅ Prêt (marquer envoyé + PDF) · ⚠️ envoi e-mail (voir §4) |

Bonus utiles déjà présents : `POST /api/quotes/{id}/duplicate` (corriger un devis émis, décision 4),
`GET /api/quotes/{id}/readiness` (contrôle serveur « prêt à émettre »), `GET /api/quotes/sample-pdf`.

---

## 3. Ce qui est PRÊT

- **Tous les endpoints du parcours nominal existent, sont montés sous `/api` et testés**
  (`test_quotes.py`, `test_quote_lifecycle.py`, `test_quote_calculation.py`, `test_catalog_*`,
  `test_clients.py`).
- **Le contrat de chiffrage est propre pour un client web** : `QuoteCalculationRequest` et
  `QuoteCreate` ont `company_id` **optionnel** (écrasé par le JWT) — le piège historique
  (`company_id` resté requis → 422 côté vrai client) est déjà évité. `lines` vide est valide
  pour `calculate` (chiffre à zéro), `min_length=1` pour `create`.
- **Le backend reste seul à calculer** (décision 3) : le client envoie `catalog_item_id +
  quantity`, le serveur photographie désignation/unité/prix/TVA depuis le catalogue et renvoie
  les totaux `Decimal` sérialisés en chaînes. `POST /quotes/calculate` ne persiste rien.
- **Le socle Flutter est en place** :
  - Feature `quotes` (`data/domain/presentation`) déjà existante (liste/détail/cycle de vie V2).
  - `quote_wizard` : coquille 7 étapes, gating par `stepCompleteProvider`, `QuoteDraft` +
    `DraftLine` (chaque ligne porte `catalogItemId`, `designation`, `unit`, `quantity`,
    `unitPriceHt` — la « photographie » de décision 5, côté client).
  - Étapes **Client** et **Dossier** déjà câblées.
- **`core/api/` (Dio) unique**, `AsyncNotifier` pour l'état serveur : le patron d'appel est établi.

---

## 4. Ce qui MANQUE (conditionné à une décision de périmètre)

Aucun de ces points ne bloque le parcours nominal. Chacun est une **petite extension backend**
*si* jugé V1. Le modèle `DraftLine` (Flutter) **documente déjà** les deux premiers.

| Manque | Détail | Impact | Effort si V1 |
|---|---|---|---|
| **A. Lignes libres** | `QuoteLineCreate.catalog_item_id` est **requis**. Décision 5 prévoit une ligne « saisie de zéro » (péage, location, intervention exceptionnelle). | Étape **Articles** limitée aux articles du catalogue. | Rendre `catalog_item_id` **nullable** (+ `SET NULL`) et ajouter `designation/unit/unit_price_ht/vat_rate` optionnels à `QuoteLineCreate` ; migration Alembic. **S** |
| **B. Prix personnalisé par ligne** | `QuoteLineCreate` n'accepte que `catalog_item_id + quantity` ; le prix vient du catalogue. Décision 5 : « un prix peut différer de celui du catalogue ». | Étape **Personnaliser** = quantités OK ; pour changer un prix il faut éditer l'article (`PUT /catalog/items/{id}`) — pas d'override ad hoc par ligne. | Même extension de schéma que A (champ prix par ligne) + calculateur inchangé (il calcule déjà à partir du prix fourni). **S** |
| **C. Envoi par e-mail** | Aucun endpoint « envoyer le devis au client ». Le module `email` existe (utilisé pour le reset mot de passe). | Étape **Envoyer** = marquer *envoyé* + fournir le PDF (partage manuel) OK ; pas d'envoi automatique. | `POST /api/quotes/{id}/send` (génère le PDF + `EmailProvider`), transition `sent`. **M** |
| **D. Ventilation TVA par taux (récap)** | `QuoteCalculation` renvoie `total_ht/vat/ttc` + lignes, pas la ventilation par taux. Le calculateur sait la produire (`calculate_vat_breakdown`) — non exposée sur `/calculate`. | **Récap** affiche les totaux ; un tableau TVA par taux nécessiterait ce champ (le client ne doit pas le recomposer — décision 3). | Ajouter `vat_breakdown` à la réponse `QuoteCalculation`. **S** |
| **E. Remise / acompte** | `QuoteCreate` n'a pas de champ remise/acompte (décision 5 : ce sont des champs du devis, pas des lignes). | Hors périmètre si le wizard V1 ne les propose pas. | Champs `Quote` + schéma + calcul + migration. **M** |

Légende effort : **S** = petit (schéma + éventuelle migration), **M** = moyen (endpoint + logique + tests).

---

## 5. Dépendances (câblage, sans nouvelle API)

1. **`QuotesRepository` (Flutter)** exposant `calculate`, `create`, `updateStatus`, `pdf`,
   `readiness` via `core/api` (Dio). La feature `quotes` existe ; à compléter, pas à créer.
2. **Modèles Freezed** miroirs des schémas : `QuoteCalculationRequest`, `QuoteCalculation`
   (+ `QuoteLineCalculation`), `QuoteCreate`, `QuoteRead`. `build_runner` après chaque modèle.
3. **Mapping `DraftLine` → `QuoteLineCreate`** (`{catalogItemId, quantity}`) pour `calculate` et
   `create` — le cœur du câblage des étapes 3→6.
4. **Anti-rebond** sur l'appel `POST /quotes/calculate` à l'étape **Personnaliser** (recalcul à
   chaque frappe) — pur frontend.
5. **Providers Riverpod** : `AsyncNotifier` pour le chiffrage/la création ; le brouillon reste en
   `Notifier` (état local, survit à une coupure — décision 6).

---

## 6. Risques

| Risque | Gravité | Mitigation |
|---|---|---|
| **Dérive schéma ↔ vrai client** (piège CLAUDE.md : `company_id` requis avait cassé le client). | Moyen | Valider `calculate`/`create` au **`curl` réaliste**, pas seulement pytest. `company_id` déjà optionnel : bon point de départ. |
| **Attente implicite de lignes libres / prix ad hoc** (A, B) alors que l'API ne les gère pas encore. | Moyen | Trancher le périmètre **avant** de câbler l'étape Articles/Personnaliser ; sinon livrer le nominal catalogue d'abord. |
| **« Envoyer » interprété comme e-mail** (C) sans endpoint. | Moyen | Trancher : marquer *envoyé* + PDF (prêt) vs envoi e-mail (à développer). |
| **Chattiness du recalcul live** (Personnaliser). | Faible | Anti-rebond + annulation de requête. |
| **Quantité hors bornes** `Numeric(10,2)` → 422 volontaire. | Faible | Le wizard doit afficher l'erreur 422, pas la masquer (déjà refusé côté serveur, à dessein). |
| **PDF généré à la demande, jamais stocké.** | Faible | Récupérer le PDF au moment de l'envoi ; pas de cache à gérer. |

---

## 7. Estimation (indicative, hors développement — revue)

- **Parcours nominal (catalogue, Envoyer = marquer + PDF)** : câblage des étapes 3→7 sur des
  endpoints existants → **le gros du travail est du câblage Flutter**, pas du backend.
  Ordre de grandeur : **quelques jours** (repository + modèles Freezed + 5 vues d'étape +
  anti-rebond + tests widget), aucun changement backend.
- **+ Lignes libres & prix par ligne (A+B)** : **~0,5–1 j backend** (schéma nullable + champs
  prix + migration + tests), calculateur inchangé, puis câblage.
- **+ Envoi e-mail (C)** : **~1 j backend** (endpoint `POST /quotes/{id}/send` + `EmailProvider`
  + tests), puis un bouton côté wizard.
- **+ Ventilation TVA récap (D)** : **~0,5 j** (champ de réponse).
- **+ Remise/acompte (E)** : **~1–2 j** (modèle + calcul + migration + UI) si retenu.

---

## 8. Conclusion — Le projet est-il prêt à entrer dans la phase de câblage complet du wizard ?

**Oui.** Le parcours nominal du wizard (Client → Dossier → Articles catalogue → Personnaliser
quantités → Récap → Créer → Envoyer/PDF) repose **entièrement sur des endpoints qui existent,
sont montés, testés et stables** (480 tests backend, 124 frontend, `analyze` propre). Le socle
Flutter (feature `quotes`, coquille `quote_wizard`, `QuoteDraft`/`DraftLine`, gating, étapes
Client & Dossier câblées) est en place. Le câblage restant est **majoritairement du travail
frontend sur API stable**, sans toucher au moteur ni à l'architecture gelée.

**Trois décisions de périmètre** doivent être tranchées **avant** de câbler les sous-parties
correspondantes — lignes libres (A), prix par ligne (B), envoi e-mail (C) — chacune étant une
petite extension backend bien délimitée, **non bloquante** pour le reste. Le modèle `DraftLine`
anticipe déjà A et B ; « Envoyer » a une version prête (marquer *envoyé* + PDF) qui n'attend
aucune décision.

**Recommandation** : câbler d'abord le **parcours nominal catalogue** de bout en bout (zéro
backend), puis traiter A/B/C/D/E à la carte selon le périmètre V1 retenu. Le projet est prêt à
entrer dans la phase de câblage.
