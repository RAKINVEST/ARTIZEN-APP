# Phase 0 — Productivité Artisan — Rapport

> **Mission** : chaque amélioration doit faire gagner du temps à l'artisan. Règle appliquée avant
> chaque changement : *« Cela réduit-il les clics, le temps de saisie ou les risques d'erreur ? »*
> Sinon, non prioritaire. Aucune nouvelle fonctionnalité métier, aucune IA, aucune V3.
>
> **Tests : 270 backend + 90 Flutter, tous verts. `flutter analyze` propre.**

---

## 1. Améliorations livrées (par priorité)

| # | Priorité | Statut | Ce qui réduit clics / saisie / erreurs |
|---|---|---|---|
| 1 | **Recherche instantanée** | ✅ | Recherche **catalogue serveur** (`?q=` désignation + code) ; **débounce** ~300 ms ; **plus de clignotement** (la liste reste affichée pendant la frappe), clients + catalogue |
| 2 | **Filtres intelligents** | ✅ | **Chips de statut** devis (Tous/Brouillon/Envoyé/Accepté/Refusé, `?status=`) : triage en **1 tap** ; filtre client (plomberie serveur prête) |
| 3 | **Pagination performante** | ✅ | **Scroll infini** clients/catalogue/devis ; bornes serveur `offset≥0`, `limit≤200` |
| 4 | **Duplication rapide des devis** | ✅ *(déjà présent)* | `POST /quotes/{id}/duplicate` (V2) → un devis similaire en **1 action**, sans re-saisie |
| 5 | **Création en un minimum de clics** | ✅ | Pickers client/article avec **recherche serveur** + **états vides clairs** ; **garde anti-double-soumission** (fin du bug des 2 devis) ; quantité **normalisée** (virgule FR → plus de 422) |
| 6 | **Sauvegarde automatique** | ⏳ *(différé)* | Non livré : voir §5 (formulaires courts + garde double-soumission + « Réinitialiser » couvrent l'essentiel du risque ; l'autosave d'un brouillon de devis mérite un design dédié) |
| 7 | **États de chargement impeccables** | ✅ | Pull-to-refresh **sans spinner plein écran** ; indicateur discret 2 px ; 4 états (loading/error/empty/data) homogènes via `PagedListView` |
| 8 | **Navigation ultra fluide** | ✅ | Listes fluides (pas de re-render complet, jeton anti-course) ; scroll infini ; *(l'aller-retour `/branding/profile` avant chaque écran — Y2 de l'audit — reste à optimiser)* |
| 9 | **Optimisation des performances** | ✅ | Recherche serviée (charge divisée par ~200), pagination bornée, une requête groupée pour les lignes de devis (déjà en place) |
| 10 | **Cohérence de l'interface** | ✅ | **Un seul** composant de recherche (`debounced_search_field`), `CurrencyFormatter` dans tous les sélecteurs (fini « 45.50 € »), zéro couleur en dur, code mort supprimé (`search_field.dart`) |

**8/10 pleinement livrés, 1 déjà présent (duplication), 1 différé (sauvegarde auto).**

---

## 2. Mesures de performance — avant / après (réelles, instance en cours)

| Action quotidienne | Avant | Après |
|---|---|---|
| **Trouver un article dans un catalogue de 300** | filtre côté client sur les 100 chargés → article #250 **introuvable** ; **86 001 octets** transférés | recherche serveur → **1 article, 431 octets** (**÷199**), **trouvé** |
| **Rechercher un client « Dupont »** | 1 requête **par lettre** + liste vidée à chaque frappe (clignotement) | **1 requête** après la rafale (débounce), liste **conservée** |
| **`GET …?offset=-1`** | **HTTP 500** (erreur brute) | **HTTP 422** (rejet propre) |
| **`GET …?limit=100000000`** | **200** — charge toute la table | **422** — borné à 200 |
| **Double-tap « Créer le devis »** | **2 devis** créés | **1 devis** (garde `_saving` + `loading:`) |

---

## 3. Gains de productivité observables

- **Trouver = taper, plus scroller.** Le mur des 100 articles (audit C5) est levé : n'importe quel
  article d'un gros catalogue se trouve en tapant, y compris pour l'ajouter à un devis. Suppression du
  scroll manuel et des abandons.
- **Triage des devis en 1 tap** au lieu de parcourir toute la liste.
- **Moins de requêtes, moins d'attente** : débounce + payloads réduits (÷200 pour une recherche).
- **Zéro doublon de devis** : le geste le plus coûteux (création) est protégé.
- **Fluidité perçue** : plus de spinner plein écran au rafraîchissement, listes qui ne clignotent plus,
  scroll infini transparent.
- **Moins d'erreurs de saisie** : quantité normalisée (virgule), format monétaire cohérent.

---

## 4. Nouveaux tests

- **Backend (5)** — `test_productivity.py` : recherche catalogue (désignation, code, article > 100
  trouvable), bornes de pagination (offset/limit négatifs/hors borne → 422), filtre devis par statut.
- **Frontend (12, total 90)** — `debouncer_test`, `quotes_notifier_test` (filtre statut + `loadMore`),
  `clients_notifier_test` réécrit (`PagedList`, keep-previous, `loadMore`), forwarding des paramètres
  (`q`/`status`/`client_id`/`offset`/`limit`) dans les 3 tests de repository, fakes paginés.

---

## 5. Limites / différés (honnêtes)

- **Sauvegarde automatique (priorité 6)** : non livrée. Les formulaires sont courts et déjà protégés
  (garde anti-double-soumission, bouton « Réinitialiser », WYSIWYG). Un autosave de brouillon de devis
  demande un design dédié (quand persister, quoi persister, réconciliation) — à cadrer avant de le
  faire, pour ne pas introduire de complexité contraire à l'objectif de fluidité.
- **Aller-retour `/branding/profile`** avant chaque écran (Y2) : latence perçue résiduelle, non traitée.
- **Filtre devis par client** : plomberie serveur + provider prêts, UI dédiée non ajoutée.
- **Validation bout-en-bout mobile manuelle** : aucun test Flutter n'appelle le vrai backend (limite
  documentée du dépôt) ; couverte ici par 90 tests + analyze. Un run réel sur appareil est recommandé
  avant merge.
- Pas de test widget pour `PagedListView`/chips ; comportements couverts au niveau notifier/repository.

---

## 6. Objectif final — « un artisan peut-il travailler toute une journée avec fluidité, rapidité, fiabilité ? »

**Largement atteint pour les gestes quotidiens** : retrouver un client ou un article est instantané
(taper, pas scroller), les devis se trient en un tap et se créent sans doublon, les listes défilent
sans à-coups ni clignotement, et les erreurs d'échelle (500, chargements massifs) ont disparu. La
charge réseau d'une recherche est divisée par ~200.

**Restent, hors périmètre livré** : la sauvegarde automatique (différée, à cadrer) et l'optimisation de
l'aller-retour d'identité — ni l'un ni l'autre ne bloque une journée de travail fluide.

**La Phase 0 est prête pour validation.**
