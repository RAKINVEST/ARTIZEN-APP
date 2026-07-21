# 10 — V1 Wizard : release de référence

> **Référence officielle de la V1 du Wizard de création de devis.** Branche
> `develop/v3` · commit de clôture `c91fefc`. Validé par le propriétaire.
>
> Le Wizard produit un devis **de bout en bout**, sur API stable, sans aucun
> calcul ni logique métier côté Flutter (le backend est seule source de vérité —
> décisions 3 & 4). Constitution : [`ARCHITECTURE_V1_REFERENCE.md`](../ARCHITECTURE_V1_REFERENCE.md).

## 1. Commits de la phase P4

| Commit | Lot |
|---|---|
| `29e0639` | P4.1 — Structure & navigation (garde de sortie) |
| `88c00b8` | P4.2 — Étape Client de production |
| `5ae87e7` | P4.3 — Étape Dossier de production |
| `d973b64` | P4.4 — Ajout des lignes (cœur de la V1) + `?category_id=` |
| `45434d5` | P4.5 — Personnalisation des lignes (quantités + recalcul live) |
| `ea653bf` | P4.6 — Récapitulatif (contrôle qualité) |
| `c91fefc` | P4.7 — Cérémonie de création (« le devis existe ») |

## 2. Architecture finale

- **Frontend feature-first** : `features/quote_wizard/{data,presentation}`, câblé au
  backend via `core/api` (Dio) uniquement.
- **`QuoteDraft`** : client + lignes (photographies, décision 5) + dernière `calculation`
  backend. Le **dossier ouvert** vit hors du brouillon (`selectedFolderProvider`,
  navigation) ; le **devis créé** vit dans `createdQuoteProvider`.
- **Shell** : `PageView` 7 étapes, barre de progression, menu latéral, gating
  (`stepCompleteProvider`), garde de sortie (abandon confirmé / sortie libre après
  création), **auto-avance** à la création.
- **Backend** : inchangé sauf un ajout **additif** — `GET /catalog/items?category_id=`
  (filtre serveur, P4.4). Création `POST /quotes` · chiffrage `POST /quotes/calculate` ·
  PDF `GET /quotes/:id/pdf`.

## 3. Parcours utilisateur

**Client** (recherche/création + auto-sélection) → **Dossier** (nom + nb articles + aperçu)
→ **Articles** (recherche serveur, ajout « ✔ Ajouté (× N) », doublon = incrément) →
**Personnaliser** (quantités ±, suppression, **recalcul live** débouncé) → **Récap**
(contrôle qualité : ✓ client / lignes / HT / TVA / TTC + détail) → **Créer** (cérémonie :
`POST /quotes` → numéro `DEV-AAAA-NNNN`) → **Terminé** (« Votre devis existe » + PDF +
**Voir mes devis** → liste ; brouillon réinitialisé **après** la réussite complète).

## 4. Couverture des tests

- **Wizard : 61 tests** (draft 9 · shell/nav 8 · client 11 · dossier 8 · articles 10 ·
  personnaliser 7 · récap 4 · cérémonie 4), dont un **e2e** couvrant le parcours entier.
- **Frontend total : 172 tests verts** · `flutter analyze` **propre**.
- **Backend : 481 tests verts** (+1 filtre catégorie).

## 5. Invariants tenus

- **Zéro calcul côté Flutter** : numéro et tous les montants viennent du backend.
- **Ligne = photographie** (décision 5) ; **brouillon ≠ devis** (décision 4) ; numéro via
  compteur verrouillé (jamais `SELECT MAX+1`).
- **Dossier = navigation**, pas donnée du devis (décision P4.3).
- **`company_id` du JWT** ; recherche/filtrage **serveur** (scalable).

## 6. Reporté en V1.1 (inchangé)

Prix personnalisé par ligne · lignes libres · remise/acompte · ventilation TVA par taux ·
envoi e-mail (`POST /quotes/{id}/send`) · partage/impression/marquer-envoyé depuis la
confirmation · « objet / chantier du devis » · **bascule du point d'entrée « Nouveau devis »**
(en attente de la phase de certification).

## 7. État

**Wizard V1 terminé — release candidate.** L'ancien `QuoteFormScreen` (`/quotes/new`) reste
le flux principal ; le Wizard est sur `/assistant`. La bascule du point d'entrée est
conditionnée à un **rapport de certification** (stabilisation : validation backend réelle,
audits UX/cohérence/états/performances, revue de code, non-régression).
