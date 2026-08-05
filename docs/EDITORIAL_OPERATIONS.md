# Système de gouvernance opérationnelle du patrimoine métier

> **Document d'organisation** (phase finale avant la production de masse). Aucun
> logiciel, aucune carte, aucun moteur/Blueprint modifié. Il définit **comment
> plusieurs équipes produisent les 62 Livres en parallèle sans perte de qualité**,
> en s'appuyant sur la Knowledge Factory ([KNOWLEDGE_FACTORY.md](KNOWLEDGE_FACTORY.md)),
> le plan industriel ([CORPUS_PRODUCTION_PLAN.md](CORPUS_PRODUCTION_PLAN.md)), la
> matrice ([CORPUS_COVERAGE_MATRIX.md](CORPUS_COVERAGE_MATRIX.md)) et la gouvernance
> éditoriale existante ([knowledge_corpus/factory/](../backend/knowledge_corpus/factory/)) —
> **aucune de ces règles n'est modifiée**, elles sont orchestrées.

## Cible révisée (enseignement Vague 0)

FAQ et REX **ne sont pas des types de fichiers** (le modèle en a 6 : card, kit,
diagnostic, checklist, procedure, phrase) — ils vivent en **sections** de carte /
phrases `type:rex`. La cible fichiers passe donc de 5 874 à **4 850**.

| Collection | Livres | Fichiers (cible V1) |
|---|---|---|
| fluides | 8 | 791 |
| electricite | 8 | 533 |
| finition | 8 | 844 |
| enveloppe | 10 | 911 |
| gros-oeuvre | 7 | 530 |
| specialises | 21 | 1 241 |
| **Total** | **62** | **4 850** |

Fichiers/Livre par palier : **A = 132 · B = 79 · C = 41**.

---

## Phase 1 — Organisation des équipes

### Rôles et responsabilités (adossés au cycle de vie Factory, inchangé)

| Rôle | Responsabilité | Étape cycle | Guide |
|---|---|---|---|
| **Rédacteur (Auteur)** | Produit les brouillons (assisté IA : `factory import`/`generate`), remplit le modèle | Brouillon | [AUTHOR_GUIDE](../backend/knowledge_corpus/factory/AUTHOR_GUIDE.md) |
| **Relecteur** | Revue métier par les pairs (cohérence, sécurité, tags, relations) | Relecture | [REVIEW_GUIDE](../backend/knowledge_corpus/factory/REVIEW_GUIDE.md) |
| **Expert Validateur** | Vérité terrain + **sources** ; **ressource critique** (Loi 7/18) | Validation | [VALIDATION_GUIDE](../backend/knowledge_corpus/factory/VALIDATION_GUIDE.md), [SOURCE_POLICY](../backend/knowledge_corpus/factory/SOURCE_POLICY.md) |
| **Responsable de Collection** (×6) | Pilote une famille : priorités, relations inter-Livres, arbitrages de lot | — | ce document |
| **Responsable Qualité** | Détient les gates, les audits, le tableau de bord ; garant du niveau à l'échelle | transverse | [QUALITY_CHECKLIST](../backend/knowledge_corpus/factory/QUALITY_CHECKLIST.md) |
| **Responsable Publication** | Exécute `release --to publication` (gate obligatoire), cadence les versions | Publication/Archivage | [EDITORIAL_WORKFLOW](../backend/knowledge_corpus/factory/EDITORIAL_WORKFLOW.md) |
| **Éditeur en chef / Pilote** | Roadmap, capacité, arbitrages inter-collections | transverse | ce document |

### Structure

- **Pod** = **1 rédacteur + 1 relecteur + 1 expert validateur** — l'unité de
  production atomique (un validateur peut être **mutualisé** sur 2 pods d'une même
  famille, car c'est la ressource rare).
- **Squad de Collection** = N pods sous un Responsable de Collection (1 par famille).
- **Fonctions centrales** (transverses aux 6 collections) : Responsable Qualité,
  Responsable Publication, Éditeur en chef.

### Interfaces (qui parle à qui)

| De → Vers | Objet | Cadence |
|---|---|---|
| Responsable Collection → Pod | Affectation de lot, priorités | par sprint |
| Rédacteur → Relecteur | Handoff Brouillon→Relecture | continu |
| Relecteur → Validateur | Handoff Relecture→Validation (file de validation) | continu |
| Validateur → Responsable Publication | Cartes validées prêtes | quotidien |
| Responsable Qualité → tous | Findings d'audit, config des gates, KPIs | hebdo/mensuel |
| Collections ↔ Collections | Relations inter-Livres (axe équipement, ex. PAC) | par jalon |

---

## Phase 2 — Lotissement (chaque lot indépendant)

Hiérarchie : **Programme → Collection (famille) → Livre → Lot → item**.

| Unité | Définition | Taille | Règle d'indépendance |
|---|---|---|---|
| **Livre** | 1 activité de la taxonomie | 41–132 fichiers | Découpé en 3–5 lots |
| **Lot** | Sous-domaine cohérent d'un Livre (cluster équipement/opération) | **15–30 items** | Ne dépend **que** de contenus **publiés** ou du **même lot** pour ses relations |
| **Sprint éditorial** | Fenêtre de travail d'un pod | **2 semaines** | 1 pod = 1 lot / sprint |
| **Vague** | Ensemble de Livres (V0→V5, cf. plan) | 1–16 Livres | Vagues parallélisables (1 squad/famille) |
| **Lot de validation** | Paquet de brouillons prêts pour un validateur | ~1 journée-validateur | Dimensionné sur la capacité du validateur |

**Décomposition standard d'un Livre en lots** (clusters cohérents) — ex. plomberie :
`robinetterie` · `évacuation` · `alimentation/réseau` · `ECS/chauffe-eau` ·
`sanitaires`. Règle générique : **3 à 5 clusters équipement/opération** par Livre.

**Definition of Done d'un lot** : tous les items gate-verts, interconnectés,
validés (humain), publiés ; relations pointant vers du **publié** ou l'intra-lot.

---

## Phase 3 — Modèle de capacité (recalibrable)

### Paramètres (à calibrer sur la baseline humaine — cf. Vague 0)

| Symbole | Sens | Valeur (à mesurer) |
|---|---|---|
| `P` | nombre de pods | décision RH/PO |
| `V` | nombre de validateurs (mutualisés) | décision RH/PO |
| `v_draft` | items rédigés / rédacteur-jour (assisté IA) | **élevé** (~20–40) — pas le goulot |
| `v_review` | items relus / relecteur-jour | ~15–25 |
| `v_valid` | items **validés** / validateur-jour | **INCONNU — goulot** |
| `j` | jours ouvrés / semaine | 5 |

### Formules

- **Débit pod ≈ min(v_draft, v_review, v_valid) = v_valid** (borné par la validation).
- **Capacité hebdo** = `V × v_valid × j`.
- **Capacité mensuelle** ≈ capacité hebdo × 4,3.
- **Charge de validation** = `4 850 / v_valid` (validateur-jours).
- **Charge de relecture** = `4 850 / v_review` (relecteur-jours).
- **Temps → Corpus V1** = `4 850 / (V × v_valid × j)` semaines.

### Scénarios (Corpus V1 = 4 850 fichiers, la validation comme goulot)

| `v_valid` (items/valid-jour) | 4 validateurs | 6 validateurs | 8 validateurs |
|---|---|---|---|
| 8 (conservateur) | ~30 sem. (~7 mois) | ~20 sem. (~5 mois) | ~15 sem. (~3,5 mois) |
| 15 (nominal) | ~16 sem. (~4 mois) | ~11 sem. | ~8 sem. |
| 25 (optimiste) | ~10 sem. | ~6,5 sem. | ~5 sem. |

**`v_valid` est le seul paramètre décisif et il n'est pas mesuré** (Vague 0 n'a pas
fait tourner de pod humain). → **Sprint baseline plomberie obligatoire** avant tout
engagement de calendrier. Le modèle se recalibre en remplaçant `v_valid`.

---

## Phase 4 — Système de pilotage

Tout est alimenté par la Factory (`metrics`/`report`/`dashboard`/`validate`) —
**aucun nouveau logiciel**.

| Cadence | Indicateurs | Seuil d'alerte | Action corrective |
|---|---|---|---|
| **Quotidien** | brouillons produits, **profondeur file de validation**, échecs de gate | file > 2× capacité valid/jour ; échec gate > 30 % | rééquilibrer validateurs ; clinic auteurs ; réduire taille de lot |
| **Hebdomadaire** | publiés vs engagement de sprint (burn-up), **taux de rejet + causes**, vélocité/type | vélocité < 70 % engagement ; rejet > 30 % | re-scoper le lot ; binômage relecture ; atelier sources |
| **Mensuel** | couverture (Livres au MVB/62), qualité (gate), distribution confiance, obsolescence, **lead time** Brouillon→Publication | retard > 1 vague ; obsolescence > 0 ; lead time en hausse | reprioriser vagues ; ajouter pods ; geler le périmètre |

---

## Phase 5 — Programme d'audit

| Audit | Objet | Fréquence | Outil | Seuil / Action |
|---|---|---|---|---|
| **Qualité** | ré-vérifier un échantillon (5 %) de cartes **publiées** | mensuel | échantillon + `validate` | tout défaut → dé-publication + correction (nouvelle version) |
| **Cohérence** | relations, doublons de titre, orphelins | hebdo | `factory duplicates` + relations | orphelin/doublon → correction avant fin de sprint |
| **Taxonomie** | tags vs taxonomie gelée | mensuel | `validate` (`metier_hors_taxonomie`) | tag hors taxonomie → correction |
| **Sources** | chaque carte publiée a une source **valide et traçable** (domaines critiques prioritaires) | mensuel | `report` + revue manuelle | source manquante/faible → repasse validation |
| **Obsolescence** | fraîcheur > 365 j | trimestriel | `metrics.stale` | obsolète → planifier rafraîchissement |
| **Couverture** | matrice réelle vs cible | mensuel | `metrics` + matrice | écart > 1 vague → escalade Éditeur en chef |

Responsable : **Responsable Qualité** (audits transverses aux 6 collections).

---

## Phase 6 — Roadmap opérationnelle (62 Livres → planning)

### Ordre exact (du plan industriel, inchangé)

`V0 plomberie (pilote — fait)` → `V1 (12 Livres A)` → `V2` → `V3` → `V4a` → `V5`.

### Découpage en lots et jalons

| Vague | Livres | Fichiers (rév.) | Lots (~4/Livre) | Jalon |
|---|---|---|---|---|
| **V0** Pilote plomberie | 1 | 132 | 4–5 | **Baseline `v_valid`** (obligatoire) |
| **V1** Cœur A | 11 | ~1 452 | ~44 | **Corpus V1-α** |
| **V2** Fluides/Élec/Finition | 13 | ~869 | ~52 | RC-2 (corpus embarqué) |
| **V3** Enveloppe+Gros-œuvre | 13 | ~909 | ~52 | Validation terrain |
| **V4a** Spécialisés impl. | 16 | ~1 030 | ~64 | Corpus V1 (54 Livres) |
| **V5** Planifiés+Différés | 8 | ~458 | ~32 | Corpus V1 complet (62) |

### Dépendances (bloquantes en amont)

1. **Commit du corpus** `backend/knowledge_corpus/` par le PO — **prérequis absolu**.
2. **Sprint baseline plomberie** (mesure `v_valid`) — avant d'engager V1.
3. **Ajustements Factory V1.1** (gate source *type-aware*, cf. [ROADMAP_V1.1](ROADMAP_V1.1.md)).
4. Relations inter-Livres (axe équipement) coordonnées par les Responsables de Collection.

### Planning jusqu'à V1 (nominal, à recalibrer)

`Baseline (2 sem.) → V1-α (~4 mois à 4 val.) → RC-2 → V2–V4a (parallélisé, ~4–5 mois) → Corpus V1 → V1.0`.
Fenêtres exactes fixées **après** la baseline (§3).

---

## Synthèse : l'organisation est-elle prête ?

**Oui pour l'organisation ; le déclenchement dépend de 3 décisions humaines.** Les
équipes, rôles, interfaces, lots, capacité, pilotage, audits et planning sont
définis et outillés (Factory). Le démarrage effectif de la Vague 1 requiert des
**décisions humaines** (hors périmètre d'un agent) : **(1)** commit du corpus,
**(2)** constitution des pods (RH : validateurs = ressource critique), **(3)**
sprint baseline pour mesurer `v_valid`. Ce sont des *blocages humains réels*, pas
techniques.
