# ARTIZEN — Instrumentation de la bêta

> **Constat** : aucune analytics/télémétrie aujourd'hui (grep `analytics|telemetry|sentry|posthog` = 0).
> Objectif : des indicateurs **facilement exploitables** pour piloter la bêta, **sans construire une
> grosse fonctionnalité**. Approche en 2 paliers : mesurer tout de suite ce qui est déjà là, puis, si
> besoin, ajouter une brique minimale.

---

## 1. Les indicateurs à suivre

| Indicateur | Définition mesurable | Cible |
|---|---|---|
| **Temps moyen — créer un devis** | de l'ouverture du formulaire devis à la réponse `201` de `POST /quotes` | < 90 s |
| **Temps moyen — retrouver un client** | du focus sur la recherche clients au tap sur un résultat | < 10 s |
| **Nombre de clics — parcours clés** | taps entre le tableau de bord et « devis créé » / « client trouvé » | ↓ dans le temps |
| **Nombre d'erreurs** | snackbars d'erreur affichés + réponses `4xx/5xx` (hors 404 de conformité attendus) | → 0 |
| **Temps de chargement** | latence par endpoint (p50/p95) + `GET /health` | p95 < 300 ms |
| **Actions abandonnées** | formulaire ouvert puis quitté **sans** soumission (création client/article/devis) | à observer |

---

## 2. Palier 0 — mesurer sans écrire de code (dès maintenant)

- **Latence API** : déjà capturable. Le backend logue chaque requête (logging centralisé). Activer un
  temps de réponse par requête (middleware de timing) ou lire les logs du reverse-proxy → p50/p95 par
  endpoint. `GET /health` fait un vrai `SELECT 1` → sonde de disponibilité.
- **Temps & clics des parcours clés** : **sessions modérées** (Customer Success). Lors des appels
  d'onboarding, chronométrer « créer un devis » et « retrouver un client » et **compter les taps**
  (grille fournie dans le rapport de validation). 5 artisans × 2 parcours = un échantillon suffisant
  pour une bêta.
- **Erreurs** : l'`error_interceptor` Dio normalise déjà toutes les erreurs. Il suffit d'y **compter**
  (log local) chaque erreur affichée → volume d'erreurs / testeur / semaine.
- **Abandons** : observés en session modérée + déduits du formulaire de retour.

> Ce palier ne demande **aucune** nouvelle fonctionnalité — uniquement de l'observation outillée. Il est
> suffisant pour une bêta privée (petit échantillon).

---

## 3. Palier 1 — brique minimale (optionnelle, si la bêta s'élargit)

Si l'on veut des chiffres agrégés automatiquement (au-delà des sessions modérées), une **brique légère**
suffit — pensée comme les tables `ai_*` (enregistrements, aucune logique métier) :

- **Client** : un `UxTimer`/`UxCounter` fin (démarrer/arrêter autour d'un flux, incrémenter un compteur
  de taps), qui **met en tampon** puis envoie par lots.
- **Backend** : un module `metrics` minimal + `POST /metrics/events` (anonymisé par `company_id`) et une
  table `ux_events` :

```
ux_events
  id (uuid, pk)   company_id (uuid, index)   event (str, index)   -- "quote_created","client_found",…
  duration_ms (float | null)   value (float | null)               -- nb de clics, etc.
  created_at (timestamp, index)   meta (jsonb)
```

- **Exploitation** : requêtes SQL directes (moyennes, p95, comptes par semaine) ou export CSV → tableur.
  Pas de dépendance tierce (pas de Sentry/PostHog) → RGPD simple, données chez soi.

> ⚠️ À n'ajouter **que si** les sessions modérées ne suffisent plus. Pour la Bêta 1 privée, le palier 0
> est recommandé (rester concentré sur la validation terrain, pas sur l'outillage).

---

## 4. Confidentialité

Les métriques d'usage sont **anonymisées** (`company_id`, jamais le contenu d'un devis ni de client).
Aucune donnée personnelle de client final ne transite dans l'instrumentation. Cohérent avec la posture
RGPD du produit (données chez soi, pas de traceur tiers).
