# Plan de production industrielle du patrimoine métier

> **Document de planification** (Phase 1 du Knowledge Production Program). Aucune
> carte n'est produite, aucun moteur/Blueprint/architecture n'est modifié. La
> production s'appuie **exclusivement** sur la Knowledge Factory livrée
> ([docs/KNOWLEDGE_FACTORY.md](KNOWLEDGE_FACTORY.md)) et sur la gouvernance
> éditoriale **existante** ([knowledge_corpus/factory/](../backend/knowledge_corpus/factory/)),
> sans la modifier.

## 0. État de départ (mesuré)

Source de vérité : `python -m app.knowledge_factory.cli metrics`.

- **1 Livre sur 62 amorcé** (plomberie), ~22 items, **tous en Brouillon**, 0 publié.
- Couverture métier : **1,3 %** (1/79 slugs) · qualité gate : **0 %** (corpus tout-brouillon).
- Chaîne de production, contrôles, cycle de vie et tableau de bord : **opérationnels**.

## 1. Plan global

### Principe directeur
Produire **Livre par Livre**, un Livre = une unité indépendante (curation par
références, zéro duplication — [BOOK_SYSTEM](../backend/knowledge_corpus/books/BOOK_SYSTEM.md)).
On ne « remplit » pas le corpus en vrac : on **achève des Livres** jusqu'à leur
socle (MVB — *Minimum Viable Book*), dans un ordre de valeur décroissante.

### Ordre de priorité (3 critères, dans cet ordre)
1. **Statut applicatif** : les **54 métiers implémentés** d'abord (l'app les
   supporte déjà → valeur artisan immédiate), puis les 3 *planifiés*, enfin les 5
   *différés V2* (cordiste, cuvelage, paratonnerre, antenniste, home-staging).
2. **Ampleur & demande** : palier **A** (12 métiers larges et fréquents) avant
   **B** (32) avant **C** (18) — cf. [matrice](CORPUS_COVERAGE_MATRIX.md).
3. **Cohérence de famille** : produire une **Collection** groupée (vocabulaire,
   normes et équipements partagés → cadence accélérée, relations inter-cartes
   naturelles).

### Dépendances
- **Amont (toutes satisfaites)** : taxonomie gelée ✅, Factory ✅, modèle de carte
  + guides éditoriaux ✅, corpus embarqué dans l'image ✅.
- **Aucune dépendance logicielle restante** : la production est un travail
  **éditorial**, pas de développement.
- **Transversalités** (ex. PAC) : gérées par **relations entre Livres**, ne
  bloquent jamais l'indépendance d'un Livre.

### Volume
- **Corpus V1 = 5 874 items** répartis sur 62 Livres (détail : matrice).
- Socle mûr (V2→V3) : densification (variantes, équipements, régional, REX) →
  trajectoire vers plusieurs centaines de milliers, **sans sortir de la taxonomie**.

## 2. Découpage en vagues (indépendantes)

| Vague | Périmètre | Livres | Items (cible) | Objet |
|---|---|---|---|---|
| **V0 — Pilote** | plomberie | 1 | 160 (socle ~40 d'abord) | Valider la chaîne bout-en-bout (Brouillon→Publication réelle via le gate) |
| **V1 — Cœur A** | 11 Livres palier A restants (chauffage, climatisation, electricite-generale, platrerie, peinture, carrelage, menuiserie-interieure, menuiserie-exterieure, charpente, couverture, maconnerie) | 11 | 1 760 | Profondeur immédiate sur les métiers les plus demandés |
| **V2 — Fluides/Élec/Finition (B+C)** | ventilation, traitement-eau, domotique, photovoltaique, reseaux-vdi, revetements-sol, parquet, cuisine, agencement, alarme-intrusion, videosurveillance, controle-acces, interphonie | 13 | 1 060 | Compléter les 3 premières familles |
| **V3 — Enveloppe + Gros-œuvre** | zinguerie, facade, isolation, isolation-exterieure, bardage, etancheite, stores-pergolas, terrassement, demolition, vrd, assainissement, forage, enrobes | 13 | 1 107 | Familles enveloppe + gros-œuvre |
| **V4a — Spécialisés implémentés** | piscine, serrurerie-metallerie, automatismes-portails, vitrerie, ferronnerie, paysagisme, ascenseur, desamiantage, traitement-charpente, diagnostic, cloture, arrosage, terrasse-bois, ramonage, hygiene-nuisibles, nettoyage | 16 | 1 254 | Longue traîne implémentée |
| **V5 — Planifiés + Différés V2** | froid, solaire-thermique, geothermie (planifiés) + cordiste, cuvelage, paratonnerre, antenniste, home-staging (différés) | 8 | 533 | Métiers non encore actifs dans l'app — dernier |

Somme des vagues : 160 + 1 760 + 1 060 + 1 107 + 1 254 + 533 = **5 874** (= cible matrice) · Livres : 1+11+13+13+16+8 = **62**.

Chaque vague est **autonome** : un pod éditorial peut la produire sans attendre
une autre. Les vagues V1→V4a peuvent tourner **en parallèle** (un pod par
Collection).

## 3. Processus de validation (workflow existant, inchangé)

Adossé à la gouvernance éditoriale **déjà livrée** — aucune modification (Loi 7/18 :
l'IA propose, un humain valide, l'IA ne publie jamais).

| Étape (cycle Factory) | Qui | Fait quoi | Référence gouvernance |
|---|---|---|---|
| **Brouillon** | Auteur (assisté IA) | `factory import` / `generate` → brouillon conforme | [AUTHOR_GUIDE](../backend/knowledge_corpus/factory/AUTHOR_GUIDE.md) |
| **Relecture** | Relecteur métier | cohérence, sécurité, tags, relations | [REVIEW_GUIDE](../backend/knowledge_corpus/factory/REVIEW_GUIDE.md) |
| **Validation** | Validateur (expert senior) | vérité terrain + **sources** (A/B) | [VALIDATION_GUIDE](../backend/knowledge_corpus/factory/VALIDATION_GUIDE.md), [SOURCE_POLICY](../backend/knowledge_corpus/factory/SOURCE_POLICY.md) |
| **Publication** | Responsable éditorial | `factory release --to publication` (**gate obligatoire**) | [EDITORIAL_WORKFLOW](../backend/knowledge_corpus/factory/EDITORIAL_WORKFLOW.md) |
| **Archivage** | Responsable éditorial | fin de vie / remplacement | [DEPRECATION_POLICY](../backend/knowledge_corpus/factory/DEPRECATION_POLICY.md) |

**Corrections terrain** : une remontée d'artisan **n'édite jamais** une carte
publiée. Elle ouvre une **nouvelle version en Brouillon** (append-only,
[VERSION_POLICY](../backend/knowledge_corpus/factory/VERSION_POLICY.md)) qui
re-parcourt Relecture → Validation → Publication. L'historique conserve toutes les
versions.

**Garde-fou automatique** : `release --to publication` refuse toute carte sans
source / taxonomie / relations / confiance, en doublon, à lien cassé ou à champ
obligatoire manquant. Un contenu non conforme **ne peut pas** être publié.

## 4. Tableau de bord de suivi (la Factory, sans nouveau logiciel)

Outils : `dashboard` (HTML), `metrics` (JSON), `report`, `validate`. Cadence :
**hebdomadaire, par vague**.

| Indicateur | Définition | Cible Corpus V1 | Source Factory |
|---|---|---|---|
| Couverture | métiers avec ≥1 carte publiée / 62 | ≥ 54/62 (implémentés) | `metrics.coverage_metier` |
| Qualité | taux de passage du gate | 100 % des publiées (gatées) | `report.cards_passing_gate` |
| Validation | % validé / (brouillon+validé) par Livre | ≥ 90 % par Livre livré | `metrics.by_status` |
| Volume | items publiés vs cible matrice | burn-up par Livre/vague | `metrics.total` + matrice |
| Temps moyen | délai Brouillon→Publication | à établir (baseline V0) | dates `## Historique` |
| Taux de rejet | cartes renvoyées en relecture / soumises | < 30 % (baseline V0) | file éditoriale |
| Densité | relations / carte | ≥ 2,0 | `metrics.density` |
| Confiance | distribution A/B/C/D des publiées | majorité A/B | `metrics.by_confidence` |
| Fraîcheur | cartes < 365 j / obsolètes | 0 obsolète | `metrics.fresh/stale` |

## 5. Cadence & estimation de calendrier

**Hypothèses** (à recalibrer sur la baseline mesurée en V0) :
- Le brouillon est **peu coûteux** (import/génération IA) ; le **goulot est la
  validation humaine** (chaque carte relue + validée + sourcée).
- **Pod** = 1 auteur (assisté IA) + 1 relecteur + 1 validateur.
- Débit validé réaliste : **~15 items/pod-jour** (cartes plus rapides ; diagnostics/
  procédures plus lents à sourcer).

| Jalon | Périmètre | Items | Pod-jours | Avec 4 pods |
|---|---|---|---|---|
| **Corpus V1-α** | V0 + V1 (12 Livres A) | ~1 920 | ~130 | **~6–7 semaines** |
| **Corpus V1** | 54 Livres implémentés (MVB) | ~5 341 | ~356 | **~4,5 mois** |
| **Corpus V1 complet** | 62 Livres | 5 874 | ~390 | **~5 mois** |

*Estimations de planification, pas des engagements — la V0 fournit la vraie
vélocité.*

## 6. Roadmap opérationnelle

```
Maintenant ─┬─► Corpus V1-α ──► RC-2 ──► Validation terrain ──► Corpus V1 ──► V1.0 (GA)
            │   (V0+V1)          (soft.   (bêta artisans,        (54 Livres    (KPIs atteints
            │   12 Livres A      RC-2 +   corrections terrain    MVB validés)   + terrain OK)
            │   ~1 900 publiés)  corpus)  en boucle)
```

| Jalon | Contenu | Critère de sortie |
|---|---|---|
| **M0 (fait)** | Plan + matrice + vagues + KPIs prêts | ce document |
| **Corpus V1-α** | V0 pilote publié + 12 Livres A au socle | ≥ 1 900 cartes **publiées** (gate 100 %), pilote plomberie complet |
| **RC-2** | RC-2 logicielle **embarquant** le corpus V1-α (corpus commité) | image contient le corpus ; couverture ≥ 12/62 ; dashboard vert |
| **Validation terrain** | Bêta artisans des 12 métiers A ; boucle corrections | taux de rejet terrain mesuré ; densité ≥ 2 ; confiance majorité A/B |
| **Corpus V1** | 54 Livres implémentés au MVB, validés | couverture ≥ 54/62 ; 0 carte publiée hors gate ; 0 obsolète |
| **V1.0 (GA)** | Corpus V1 + terrain validé | KPIs cibles atteints (§4) ; référentiel gelé |

## 7. Risques

| Risque | Gravité | Mitigation |
|---|---|---|
| **Corpus non versionné** (`backend/knowledge_corpus` non suivi git) | Élevé | **Commiter** avant toute production (action PO) — prérequis absolu |
| Goulot de **validation humaine** (experts métier rares) | Élevé | Prioriser palier A/implémentés ; mutualiser validateurs par famille ; sourcer via SOURCE_POLICY |
| **Sources** insuffisantes sur métiers normés (gaz, élec, hauteur) | Moyen | Exigence A/B renforcée sur domaines critiques ; double relecture |
| Dérive **qualité à l'échelle** | Moyen | Gate automatique bloquant + dashboard hebdo + audit d'échantillon |
| Estimation de vélocité incertaine | Faible | Recalibrer sur la baseline V0 avant d'engager V1 |
| Détection de sources trop stricte (motifs DTU/NF) | Faible | Affinage Factory V1.1 (déjà tracé dans [ROADMAP_V1.1](ROADMAP_V1.1.md)) |

## 8. Ce que l'équipe éditoriale fait dès demain

1. **Prérequis PO** : commiter `backend/knowledge_corpus/`.
2. **V0 pilote (plomberie)** : compléter le socle, passer les premières cartes
   Brouillon → Publication via `factory release`, **mesurer la vélocité réelle**.
3. Établir la **baseline** des KPIs (temps moyen, taux de rejet) sur V0.
4. Lancer **V1** (4 pods, une Collection chacun) une fois la baseline connue.
