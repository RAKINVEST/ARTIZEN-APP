# V3 — Roadmap & modules (Phases 4-5)

**Vision** : faire d'ARTIZEN la référence SaaS des artisans du bâtiment —
de l'appel client au paiement, avec l'IA comme colonne vertébrale. La V2
couvre *catalogue → devis → PDF*. La V3 ferme la chaîne *devis → facture →
paiement* et industrialise la saisie par l'IA vocale.

## Socle technique préalable (fondations, avant tout module métier)

Ces chantiers ne sont pas des fonctionnalités mais des prérequis
d'architecture (issus de l'audit). **À livrer en premier.**

| # | Fondation | Pourquoi | Prio |
|---|---|---|---|
| F1 | **File de tâches asynchrones** (Arq/Celery + Redis) | OCR, IA lourde, emails, PDF de masse ne doivent plus bloquer une requête | 🔴 |
| F2 | **Redis** (broker + cache + rate limit partagé) | Scalabilité multi-workers | 🔴 |
| F3 | **Auth durcie** : PyJWT + cookie HttpOnly (web) | Dette bloquante pour audit sécu | 🔴 |
| F4 | **Module `companies`** (casser le cycle users↔branding) | Propreté avant d'ajouter des modules qui dépendent de l'entreprise | 🟠 |
| F5 | **Stockage objet S3** (abstrait derrière `storage`) | Pièces jointes chantier/OCR/signatures | 🟠 |
| F6 | **CI/CD** (analyze/test/build + déploiement) | Non-régression à mesure que le périmètre croît | 🟠 |
| F7 | **Isolation des tests** (base dédiée + transaction par test) | Fiabilité | 🟡 |

## Modules métier

Format par module : **Objectif · Architecture · API · BDD · UI · Tests ·
Risques · Estimation · Priorité**. Estimations en semaines-personne (SP),
indicatives.

### M1 — Assistant IA « devis vocal » 🔴 PRIORITÉ ABSOLUE
- **Objectif** : créer un devis quasi sans clavier depuis la parole de
  l'artisan. Détail complet : `03_IA_VOICE_TO_QUOTE.md`.
- **Architecture** : capture audio → STT → NLU (extraction prestations +
  quantités) → matching catalogue (réutilise `quote_assistant.match_validator`)
  → construction de brouillon → variantes → email. Pipeline **asynchrone**
  (F1) avec états intermédiaires. `AIProvider` étendu (STT + LLM).
- **API** : `POST /ai/voice-quote` (upload audio → job), `GET /ai/jobs/{id}`
  (statut/résultat), `POST /ai/voice-quote/{id}/refine` (variantes).
- **BDD** : `ai_jobs` (id, company_id, type, status, transcript, result JSON,
  timings). Aucun devis créé par l'IA (invariant V2 conservé).
- **UI** : écran « micro » (enregistrer/parler), transcription en direct,
  proposition d'articles éditable, variantes, aperçu, envoi.
- **Tests** : mocks STT/LLM déterministes ; validation matching ; le devis
  reste un geste explicite.
- **Risques** : latence, coût API, qualité de transcription en environnement
  bruyant (chantier), hallucination (jugée par re-validation catalogue).
- **Estimation** : 6-8 SP. **Priorité 1.**

### M2 — Facturation 🔴
- **Objectif** : transformer un devis accepté en facture conforme.
- **Architecture** : nouveau module `invoices` réutilisant `app/pdf/` +
  `quotes/calculator` ; numérotation `FAC-AAAA-NNNN` **sans trou** (compteur
  FOR UPDATE, obligation légale art. 242 nonies A CGI) ; statuts
  `émise/payée/annulée` ; avoirs `AV-AAAA-NNNN`.
- **API** : `POST /invoices` (depuis un devis accepté), `GET`, `/pdf`,
  `/status`, `/credit-note`.
- **BDD** : `invoices`, `invoice_lines`, `invoice_counters`, `credit_notes`.
- **UI** : liste factures, détail, PDF, conversion depuis devis.
- **Risques** : conformité e-invoicing / **Factur-X** (obligation FR
  2026-2027), immutabilité, mentions légales.
- **Estimation** : 5-7 SP. **Priorité 2.**

### M3 — Paiement 🟠
- **Objectif** : encaisser (lien de paiement, acompte, solde).
- **Architecture** : intégration **Stripe** (abstraite derrière un
  `PaymentProvider`, comme `AIProvider`) ; webhooks → statut facture.
- **API** : `POST /payments/intent`, `POST /payments/webhook`, `GET /payments`.
- **BDD** : `payments` (facture, montant, statut, provider_ref).
- **Risques** : PCI-DSS (déléguer à Stripe), réconciliation, remboursements.
- **Estimation** : 4-5 SP. **Priorité 4.**

### M4 — Signature électronique 🟠
- **Objectif** : faire signer devis/factures (valeur légale).
- **Architecture** : provider eIDAS (Yousign/DocuSign) abstrait ; horodatage,
  preuve d'intégrité (hash du PDF).
- **API** : `POST /signatures`, webhook, `GET /signatures/{id}`.
- **BDD** : `signatures` (document, signataire, statut, preuve).
- **Risques** : valeur juridique, conservation probante.
- **Estimation** : 3-4 SP. **Priorité 5.**

### M5 — OCR / import intelligent 🟡
- **Objectif** : numériser factures fournisseurs, bons, plans → catalogue/coûts.
- **Architecture** : réutilise `document_analysis`/`document_detection` +
  provider OCR (Tesseract local / cloud) en **tâche async** (F1).
- **API** : `POST /ocr/upload`, `GET /ocr/{id}`.
- **BDD** : réutilise `document_analyses` (+ type `supplier_invoice`).
- **Risques** : précision, formats hétérogènes.
- **Estimation** : 4-6 SP. **Priorité 6.**

### M6 — CRM (clients enrichi) 🟠
- **Objectif** : historique, relances, segmentation, interactions.
- **Architecture** : extension du module `clients` (interactions, tags,
  échéances) ; pas de nouveau service lourd.
- **API** : `/clients/{id}/interactions`, `/clients/{id}/timeline`.
- **BDD** : `client_interactions`, `client_tags`.
- **Estimation** : 3-4 SP. **Priorité 4.**

### M7 — Agenda / planning 🟡
- **Objectif** : rendez-vous, interventions, disponibilités.
- **Architecture** : module `scheduling` ; lien devis/chantier.
- **API** : `/appointments` CRUD, `/availability`.
- **BDD** : `appointments`, `availability`.
- **Risques** : synchronisation calendriers externes (CalDAV/Google).
- **Estimation** : 4-5 SP. **Priorité 5.**

### M8 — Chantier / suivi 🟡
- **Objectif** : suivre l'exécution (avancement, photos, coûts réels).
- **Architecture** : module `projects` reliant devis/facture/agenda ; photos
  via `storage` S3 (F5).
- **API** : `/projects` CRUD, `/projects/{id}/photos`, `/progress`.
- **BDD** : `projects`, `project_photos`, `project_costs`.
- **Estimation** : 5-6 SP. **Priorité 6.**

### M9 — Comptabilité (export) 🟡
- **Objectif** : export FEC / journal de ventes, TVA, liaison expert-comptable.
- **Architecture** : module `accounting` en **lecture seule** (agrège
  factures/paiements) ; exports normés.
- **API** : `/accounting/exports` (FEC, CSV), `/accounting/vat`.
- **Risques** : conformité comptable FR.
- **Estimation** : 3-5 SP. **Priorité 7.**

### M10 — Tableau de bord (BI) 🟠
- **Objectif** : CA, taux d'acceptation, encours, marge, pipeline.
- **Architecture** : agrégations (vues matérialisées / cache Redis) ; pas de
  nouvel écrit métier.
- **API** : `/dashboard/metrics`.
- **Estimation** : 2-3 SP. **Priorité 3.**

### M11 — Notifications 🟠
- **Objectif** : email/push/SMS (devis envoyé, facture due, relances).
- **Architecture** : service `notifications` + providers (email/SMS/push)
  abstraits ; déclenché par events, envoyé en **tâche async** (F1).
- **API** : `/notifications`, préférences.
- **BDD** : `notifications`, `notification_preferences`.
- **Estimation** : 3-4 SP. **Priorité 3.**

### M12 — Synchronisation / offline 🟡
- **Objectif** : usage terrain sans réseau (chantier), sync différée.
- **Architecture** : cache local (SQLite/Isar côté Flutter) + réconciliation ;
  API idempotente + horodatage.
- **Risques** : conflits, complexité — **chantier à part entière**.
- **Estimation** : 6-8 SP. **Priorité 7.**

### M13 — Mobile natif (packaging & distribution) 🟠
- **Objectif** : builds iOS + Android signés, stores, notifications push.
- **Architecture** : l'app Flutter existe déjà (Android validé) ; ajouter iOS,
  signature, CI mobile, OTA.
- **Estimation** : 3-4 SP. **Priorité 3** (partiellement fait en V2).

### M14 — Administration / back-office 🟠
- **Objectif** : gestion des comptes, plans (SaaS), rôles, facturation SaaS.
- **Architecture** : module `admin` + notion de **rôles** (aujourd'hui absente)
  et d'**abonnement** ; superviseur multi-tenant.
- **API** : `/admin/*` (protégé rôle admin).
- **BDD** : `subscriptions`, `roles`, `audit_log`.
- **Risques** : introduit la notion de rôle/plan — structurant.
- **Estimation** : 4-6 SP. **Priorité 4.**

## Matrice de priorisation (impact × valeur × complexité × ROI)

| Module | Impact user | Valeur métier | Complexité | ROI | Ordre |
|---|---|---|---|---|---|
| **Fondations F1-F3** | — (socle) | Élevée | Moyenne | 🔴 | **0** |
| **M1 IA vocale** | Très élevé | Très élevée | Élevée | 🔴 | **1** |
| **M2 Facturation** | Élevé | Très élevée (légal) | Moyenne | 🔴 | **2** |
| M10 Dashboard BI | Moyen | Élevée | Faible | 🟢 | 3 |
| M11 Notifications | Élevé | Moyenne | Faible | 🟢 | 3 |
| M3 Paiement | Élevé | Élevée | Moyenne | 🟠 | 4 |
| M6 CRM | Moyen | Moyenne | Faible | 🟢 | 4 |
| M14 Admin/SaaS | Moyen | Élevée (monétisation) | Moyenne | 🟠 | 4 |
| M4 Signature | Moyen | Élevée | Moyenne | 🟠 | 5 |
| M7 Agenda | Moyen | Moyenne | Moyenne | 🟡 | 5 |
| M5 OCR | Moyen | Moyenne | Élevée | 🟡 | 6 |
| M8 Chantier | Moyen | Moyenne | Élevée | 🟡 | 6 |
| M9 Comptabilité | Faible | Moyenne | Moyenne | 🟡 | 7 |
| M12 Offline | Élevé (terrain) | Moyenne | Très élevée | 🟡 | 7 |

## Séquence recommandée

**Sprint 0** (fondations) → **IA vocale** (M1) → **Facturation** (M2) →
**Dashboard + Notifications** (M10, M11) → **Paiement + CRM + Admin** (M3, M6,
M14) → **Signature + Agenda** (M4, M7) → **OCR + Chantier** (M5, M8) →
**Comptabilité + Offline** (M9, M12).

Chaque module suit la même discipline V2 : une fonctionnalité à la fois,
terminée (archi → implémentation → tests → casse → doc) avant la suivante.
