# Feuille de route produit — ARTIZEN

> **Document stratégique de référence.** Aucun développement, aucune décision
> d'implémentation : il fixe le cap produit, les familles fonctionnelles, la
> carte des modules, leurs dépendances, les priorités par phase, les reports
> explicites et les critères de déclenchement de chaque phase.
>
> **Portée temporelle** : 12 mois glissants à partir de la clôture de la
> **V1.0 — Wizard** (certifiée et devenue le flux principal de création de devis).
>
> **Ce document ne modifie aucune architecture et n'implémente rien.**

## Note de terminologie (à lire une fois)

Deux systèmes de versions coexistent dans le dépôt — ne pas les confondre :

- **Versions d'ingénierie** (tags git) : `v1.0.0-rc1` (socle certifié), `v2.0.0-rc1`
  (cycle de vie du devis + PDF + duplication). Historique dans
  [`docs/ROADMAP.md`](ROADMAP.md) et [`CHANGELOG.md`](../CHANGELOG.md).
- **Versions produit** (ce document) : **V1.0 / V1.1 / V1.2 / V2** — jalons de
  valeur utilisateur. La **V1.0 produit** = tout l'acquis actuel (Métiers &
  Catalogues gelés + cycle de vie du devis + PDF + **Wizard complet** + flux
  principal). Les phases ci-dessous partent de là.

---

## 0. Positionnement & règle d'or

Artizen est un **assistant métier** pour artisans du bâtiment ; le devis en est la
**conséquence**, pas la finalité. La règle qui filtre toute décision produit
([`DECISIONS.md`](DECISIONS.md)) :

> **Si une fonctionnalité ne fait pas gagner du temps à l'artisan ou ne rend pas
> son travail plus simple, elle n'a pas sa place dans Artizen.**

Deux invariants qui ne se rediscutent pas et bornent toute la roadmap :
**backend = seule source de vérité (aucun calcul côté Flutter)** et
**Métiers & Catalogues = couche gelée**.

---

## 1. Vision produit à 12 mois

**Point de départ (acquis V1.0)** : un artisan produit un **devis certifié** en
quelques minutes, sur un **catalogue métier stable**, avec des montants calculés
au centime par le backend et un PDF prêt à envoyer.

**Cap à 12 mois** : passer du *« faiseur de devis »* à l'*« assistant du cycle
commercial »* de l'artisan — **devis → facture → suivi** — assisté par l'IA, sans
jamais dégeler l'acquis. Trois mouvements successifs :

1. **Consolider le devis** (V1.1) — unifier la création (IA **et** manuelle autour
   d'un seul moteur, le Wizard) et compléter le devis (lignes libres, prix
   personnalisés, remise/acompte, envoi).
2. **Gérer & fiabiliser** (V1.2) — pilotage des devis, certifications d'entreprise,
   robustesse (brouillon qui survit à une coupure), contenus métiers restants.
3. **Ouvrir le cycle commercial** (V2) — **factures** (puis avoirs, bons de
   commande) sur le moteur PDF déjà mutualisable, puis **suivi / statistiques**.

**Ce qui ne change pas sur 12 mois** : la taxonomie des métiers (slugs gelés),
les 7 décisions d'architecture, le principe « le backend calcule, Flutter
affiche », la discipline **un chantier à la fois**.

---

## 2. Grandes familles fonctionnelles

| Famille | Rôle | État |
|---|---|---|
| **Compte & identité** | Inscription, auth JWT, multi-tenant, image de marque (logo, couleurs, mentions) | ✅ Existant |
| **Métiers & Catalogues** | Taxonomie gelée, import de catalogues métiers, catalogue personnel de l'artisan | ✅ Existant — **gelé** |
| **Clients** | Fiche client (CRM léger) | ✅ Existant |
| **Création de devis** | Wizard guidé (client → dossier → articles → personnaliser → récap → créer) | ✅ Existant (V1.0) |
| **Cycle de vie du devis** | Numéro `DEV-AAAA-NNNN`, statuts, PDF à la demande, duplication | ✅ Existant |
| **Assistance IA** | Copilote (texte), dictée vocale, suggestion d'articles depuis le catalogue | ✅ Existant (copilote) — à **unifier** au Wizard |
| **Onboarding & import** | Import d'un modèle de devis existant, analyse/détection de documents | ✅ Existant |
| **Documents commerciaux** | Factures, avoirs, bons de commande | 🔜 Prévu (V2) |
| **Pilotage** | Statistiques, notifications, relances de devis | 🔜 Prévu (V1.2 → V2) |
| **Paiements** | Encaissement / suivi de règlement | 🕓 Prévu lointain (post-V2) |

---

## 3. Cartographie des modules

### Modules existants (patron vertical `models/schemas/repository/service/deps/router`)

| Backend | Frontend (feature) | Famille |
|---|---|---|
| `users`, `auth`, `branding` | `auth`, `branding`, `settings` | Compte & identité |
| `catalog` (+ `catalog/trades` gelé) | `catalog`, `metiers` | Métiers & Catalogues |
| `clients` | `clients` | Clients |
| `quotes` (+ `pdf`, `document_mapper`) | `quote_wizard`, `quotes` | Devis + cycle de vie |
| `quote_assistant`, `voice_quote`, `ai_conversations` | `quote_assistant` | Assistance IA |
| `document_analysis`, `document_detection`, `template_import` | `template_import`, `dashboard`, `landing` | Onboarding & import |
| Transverse : `core`, `database`, `ai`, `email`, `tasks` (arq), `storage`, `redis_client` | `core/api` (Dio) | Infrastructure |

### Modules prévus (nommés, non implémentés)

| Module | Famille | Fondation déjà posée |
|---|---|---|
| `invoices` (factures) | Documents commerciaux | `app/pdf/` réutilisable ; numérotation `quote_counters` extensible |
| `credit_notes` (avoirs), `purchase_orders` (bons de commande) | Documents commerciaux | idem `app/pdf/` |
| `CompanyCertification` (RGE, QualiPAC…) | Compte & identité | Modèle **réservé** (champ `rge_number` existant) |
| `statistics`, `notifications` | Pilotage | — |
| `payments` | Paiements | — |

> Règle d'ajout inchangée : un nouveau module suit le patron vertical + s'enregistre
> dans `api/router.py` et `models/__init__.py`. Un métier s'ajoute par un fichier
> de données `trades/*.py`, **zéro moteur**.

---

## 4. Dépendances entre modules

Le fil rouge : **rien ne se branche avant le maillon dont il dépend.** Les factures
sont un PDF ; les paiements suivent une facture ; les statistiques agrègent des
devis/factures existants.

```mermaid
graph TD
  auth[Compte & identité] --> catalog[Métiers & Catalogues]
  auth --> clients[Clients]
  auth --> branding[Image de marque]

  catalog --> wizard[Wizard de devis]
  clients --> wizard
  wizard --> quotes[Cycle de vie du devis + PDF]

  ai[Copilote IA / Voix] -. V1.1 : unification .-> wizard
  branding --> pdf[Moteur PDF app/pdf]
  quotes --> pdf

  pdf --> invoices[Factures V2]
  quotes -. numérotation légale héritée .-> invoices
  invoices --> credit[Avoirs / Bons de commande V2]
  invoices --> payments[Paiements post-V2]

  quotes --> stats[Statistiques / Pilotage V1.2→V2]
  invoices --> stats
```

Dépendances **à sens unique et justifiées** (jamais l'inverse) : `pdf` n'importe que
`app.pdf.*` ; `quote_assistant`/`quote_wizard` lisent `catalog`/`clients`/`quotes`
mais ne les modifient pas ; la traduction Devis → Document vit côté métier
(`quotes/document_mapper.py`).

---

## 5. Priorités par phase

### 🎯 V1.1 — Unifier et compléter le devis *(phase courante)*

Objectif : **un seul moteur de création** (le Wizard) et une **fonctionnalité devis
complète**. Chaque item est un chantier isolé, périmètre figé, validé avant le suivant.

| Prio | Chantier | Impact | Aboutit à |
|---|---|---|---|
| **1** | **Intégration du Copilote IA au Wizard** | Frontend (IA → `QuoteDraft` → Wizard) | Retrait de `QuoteFormScreen` + route `/quotes/new` |
| 2 | **Lignes libres** + **prix personnalisé par ligne** | Backend (modèle/API/migration) + Wizard | Devis hors-catalogue (péage, location…) et prix ajustés |
| 3 | **Remise / acompte** | Backend (champs du devis) + Wizard | Devis commercialement complet |
| 4 | **Envoi du devis** (e-mail + partage/impression) | Backend (`POST /quotes/{id}/send`, `EmailProvider`) + confirmation | Devis livré au client depuis l'app |
| 5 | **Ventilation TVA par taux** (récap / PDF) | Backend (`vat_breakdown`) | Document conforme aux usages |
| 6 | **Objet / chantier du devis** | Backend (champ) + Wizard | Contexte du devis nommé |

**Fin de V1.1** : `QuoteFormScreen` supprimé, tous les parcours de création unifiés,
devis complet, tests verts des deux côtés.

### 🔭 V1.2 — Gérer, fiabiliser, compléter

Objectif : passer d'« un devis créé » à « un portefeuille de devis piloté », et
lever la dette non-bloquante.

| Chantier | Détail |
|---|---|
| **Gestion avancée des devis** | Recherche/filtres enrichis, relances, statuts affinés |
| **Certifications d'entreprise** | Mécanisme `CompanyCertification` (type, numéro, organisme, dates) — mentions PDF, aides |
| **Robustesse hors-ligne (léger)** | Survie du brouillon à une coupure passagère (décision 6, **réévaluée sur retours bêta**) |
| **Contenus métiers restants** | 3 activités `planned` (froid, solaire-thermique, géothermie) + les 5 `deferred_v2` — **par données, zéro moteur** |
| **Durcissements techniques reportés** | Rate limiting partagé (Redis), cookie `HttpOnly` web, extraction du cycle `users ↔ branding` (module `companies`) — cf. [`ROADMAP.md`](ROADMAP.md) |

### 🚀 V2 — Ouvrir le cycle commercial

Objectif : **la facture**, puis ses dérivés, puis le pilotage — sur le moteur PDF
déjà mutualisable.

| Chantier | Dépend de | Note |
|---|---|---|
| **Factures** | `app/pdf`, numérotation `quotes` | **Numérotation séquentielle sans trou** = obligation légale (art. 242 nonies A CGI) — hérite du schéma `quote_counters` verrouillé |
| **Avoirs, bons de commande** | Factures | Mêmes `app/pdf.*`, une chaîne = un `title` |
| **Suivi & statistiques** | Devis + factures existants | Agrégation, tableaux de bord |
| **Notifications / relances** | Suivi | Rappels devis/facture |

### 🕓 Post-V2 (nommé pour mémoire)

Paiements (encaissement/suivi), planning, photos de chantier — chacun un module
vertical, **après** que la chaîne devis → facture soit stable.

---

## 6. Fonctionnalités explicitement reportées

| Fonctionnalité | Phase cible | Raison du report |
|---|---|---|
| Pont Copilote IA → Wizard | **V1.1 (chantier 1)** | Évolution fonctionnelle, pas un reroutage |
| Lignes libres / prix personnalisé | **V1.1** | Touche modèle + API + migration |
| Remise / acompte | **V1.1** | Champs du devis (décision 5) |
| Envoi e-mail / partage | **V1.1** | Endpoint + `EmailProvider` à créer |
| Ventilation TVA par taux | **V1.1** | Valeur faible en création ; le calcul existe déjà |
| Objet / chantier du devis | **V1.1** | Champ modèle (le dossier reste navigation, décision P4.3) |
| Certifications d'entreprise | **V1.2** | Modèle réservé, mécanisme à construire |
| Hors-ligne complet | **V1.2+ (réévalué)** | Quasi une seconde app ; en ligne requis en V1 (décision 6) |
| Métiers `planned` / `deferred_v2` | **V1.2** | Par données, sur demande |
| Factures / avoirs / BC | **V2** | La chaîne document doit précéder ses branches |
| Statistiques / notifications | **V2** | Agrègent des documents qui doivent exister |
| Paiements / planning / photos | **Post-V2** | Après stabilisation devis → facture |

---

## 7. Critères de déclenchement de chaque phase

Une phase ne s'ouvre pas au calendrier mais sur **critères remplis**.

| Phase | Se déclenche quand… | Se clôt quand… |
|---|---|---|
| **V1.1** | ✅ **Déjà déclenchée** (V1.0 certifiée, Wizard flux principal) | `QuoteFormScreen` retiré, devis complet (lignes/prix/remise/envoi), tests verts, doc à jour |
| **V1.2** | V1.1 validée **et** premiers retours d'une **bêta utilisateur** collectés (priorise gestion vs contenus) | Portefeuille de devis pilotable + dette non-bloquante levée |
| **V2** | Devis **stable en usage réel** **et** besoin facture **confirmé** (demande utilisateur ou obligation) **et** moteur PDF confirmé mutualisable | Chaîne devis → facture livrée et certifiée |
| **Post-V2** | Chaîne devis → facture stable en production | — |

Critères transverses à **chaque** chantier (hérités du Wizard) :
**périmètre figé → analyse → plan → dev → tests → doc → compte rendu → validation
explicite** avant d'ouvrir le suivant. Aucune affirmation sans preuve.

---

## 8. Principes directeurs (non négociables)

1. **Un chantier à la fois**, terminé complètement avant le suivant.
2. **Ne jamais dégeler** Métiers & Catalogues, les 7 décisions d'architecture, ni les
   invariants produit (cf. [`ARCHITECTURE_V1_REFERENCE.md`](ARCHITECTURE_V1_REFERENCE.md)).
3. **Backend seule source de vérité** : aucun calcul, aucune logique métier côté Flutter.
4. **Chaque nouvelle règle transverse** est un signal à valider *avant* de l'intégrer,
   pas à ajouter au fil de l'eau.
5. **La V1.0 est un acquis** : aucune phase ultérieure ne la remet en cause.

---

*Références : [`ARCHITECTURE_V1_REFERENCE.md`](ARCHITECTURE_V1_REFERENCE.md) ·
[`DECISIONS.md`](DECISIONS.md) · [`TAXONOMIE-METIERS.md`](TAXONOMIE-METIERS.md) ·
[`ROADMAP.md`](ROADMAP.md) · [`release/10_V1_WIZARD_RELEASE.md`](release/10_V1_WIZARD_RELEASE.md) ·
[`release/11_V1_WIZARD_CERTIFICATION.md`](release/11_V1_WIZARD_CERTIFICATION.md) ·
[`release/12_V1.1_BACKLOG.md`](release/12_V1.1_BACKLOG.md).*
