# Registre des expériences — EXPERIMENTS

Le journal de la **Phase 3**. Il ferme la boucle entre les questions
([UNKNOWNS.md](UNKNOWNS.md)) et les décisions ([DECISION_LOG.md](DECISION_LOG.md)) :
chaque ligne est une **inconnue transformée en connaissance validée**, mesurée par
le benchmark, jamais par une intuition.

## Jalon 1 — prouver que le laboratoire produit de la connaissance

Le premier succès **n'est pas un score de 99 %.** C'est un cycle complet, mené
jusqu'au bout, sur une seule inconnue :

> U-xxx testée sur ~5 documents → hypothèse confirmée (ou infirmée) → décision
> prise → ADR ou amendement de la spec → **une inconnue en moins.**

Si ce cycle tourne proprement une fois, le laboratoire a prouvé sa valeur — bien
avant que le moteur soit « bon ».

## Le cycle d'une expérience

1. **Choisir** l'inconnue la plus *rentable* à lever (U-xxx).
2. **Formuler** une hypothèse falsifiable (« les tableaux EBP sont détectables
   géométriquement dans ≥ 90 % des cas »).
3. **Prototyper** l'heuristique en **branche de travail**, dans
   [`extraction/`](extraction/), sur N documents *réels* du corpus.
4. **Mesurer** via `python benchmark.py` — KPI par sous-système, `--official`
   (références certifiées), `--gate` (pas de régression d'une autre famille).
5. **Décider** : confirmée / infirmée / reportée → ADR ou amendement de la
   [spec](EXTRACTION_SPEC.md) ; mettre à jour le burndown d'[UNKNOWNS](UNKNOWNS.md).
6. **Merger** dans `main` **seulement si** le benchmark valide (gouvernance
   [ADR-011](DECISION_LOG.md)).

## Structure obligatoire d'une fiche d'expérience

Le laboratoire vaut par sa capacité à **séparer les faits des décisions**. Chaque
expérience suit donc, sans exception, cette chaîne — et ne mélange jamais ses
maillons :

```
Question → Hypothèse → Protocole → Résultats → Interprétation → Décision → ADR (si besoin)
```

**Résultat**, **Interprétation** et **Décision** ne sont **pas interchangeables** :

| Maillon | Nature | Exemple |
|---|---|---|
| Résultat | *fait mesuré* | « 12 des 15 tableaux reconstruits correctement. » |
| Interprétation | *lecture du fait* | « La géométrie seule *semble* suffisante pour cette famille. » |
| Décision | *choix engagé* | « Conserver l'approche géométrique pour Word. » |

Un résultat ne se discute pas ; une interprétation se challenge ; une décision
s'assume. Les confondre est la première source de conclusions trop rapides.

### Gabarit d'une fiche (à recopier par expérience)

```
### E-NNN — <titre>  (inconnue : U-xxx)
Question      : la question précise à laquelle on répond
Hypothèse     : énoncé falsifiable
Protocole     : corpus utilisé (ids), heuristique testée, commande benchmark
Résultats     : chiffres PRODUITS par le benchmark (KPI par sous-système)
Biais observés: ce qui pourrait fausser la lecture (famille unique, N trop petit…)
Interprétation: ce que les résultats suggèrent — pas plus
Décision      : confirmée / infirmée / reportée
ADR / spec    : ADR-xxx ou amendement, si la décision engage l'architecture
Ouverte le / Décidée le : <dates>  (→ alimente le KPI du laboratoire)
```

## Quand une expérience *réussit* — redoubler de méfiance

Une expérience qui échoue est facile à analyser. Une expérience qui réussit est
plus dangereuse. Pour **chaque succès**, la fiche doit répondre à deux questions,
sous peine d'être incomplète :

1. **Pourquoi cela fonctionne-t-il ?** (le mécanisme, pas la coïncidence)
2. **Dans quels cas cela cessera-t-il de fonctionner ?** (les limites)

La réponse à la seconde question est, le plus souvent, la **prochaine expérience**.

## KPI du laboratoire — temps « inconnue → décision »

Un seul indicateur, et ce n'est **pas** un KPI du moteur : le **délai moyen entre
l'ouverture d'une inconnue et la décision qui la clôt** (ADR ou amendement).

```
UNKNOWNS (ouverte le) ──▶ Expérience ──▶ Décision / ADR (le)   =   N jours
```

Il mesure la santé du **laboratoire** (Produit B), pas la performance du moteur.
Signal d'alerte : une inconnue ouverte depuis longtemps *sans protocole
d'expérience* — le labo se grippe. Chaque fiche porte donc ses dates
`Ouverte le / Décidée le`, et la moyenne se lit sur le registre.

## Registre

Premières données réelles (2 devis natifs, via le module existant
`document_detection`, pas encore la Brique 4). Ouvertes le 2026-07-23.

| Exp | Inconnue | Résultat mesuré | Observation | Statut |
|---|---|---|---|---|
| **E-001** | U-001 (tableaux) | **Chapot / Mediabat — confiance 54 %** ; tableau **détecté** (19 lignes, conf 1.0), couleurs réelles `#4ca549`/`#365e92`, logo/en-tête/pied ✓ | Champs SIRET/tél/email/entreprise **KO** : Mediabat écrit le texte **lettre par lettre espacée** (« S A R L », « 0 6  5 9 ») → les regex échouent → **U-010** | Ouverte |
| **E-002** | U-001 (tableaux) | **SJE / Solabaie — confiance 76 %** ; SIRET, TVA, tél, email, logo, en-tête, pied ✓ | **Tableau NON détecté** (conf 0) sur ce format | Ouverte |

**Interprétation croisée (avec méfiance) :** la détection **varie fortement par
source** — Mediabat = *tableau OK / champs KO* ; SJE = *champs OK / tableau KO*.
Aucune source n'est « résolue ». Deux chantiers concrets, indépendants :
1. **Normaliser le texte lettre-espacé** avant les regex (corrige E-001, sans
   risque pour les autres) → décision probable : amendement du détecteur.
2. **Fiabiliser la détection de tableau** par famille (corrige E-002) → à creuser.

Ces 2 devis deviennent les **2 premiers du Starter Corpus** (Mediabat, Solabaie).
Il en manque 3 (styles/logiciels différents) pour l'amorce complète.

| Exp | Inconnue | Hypothèse | N docs | Résultat (mesuré) | Décision | Statut |
|---|---|---|---|---|---|---|
| _(gabarit — expériences futures ici)_ | U-xxx | … | N | — | — | — |

> **Anti-biais (règle du registre).** (1) Aucun chiffre n'est inscrit s'il n'est
> pas **produit par le benchmark** — pas d'estimation, pas de « à peu près ».
> (2) Une amélioration n'est retenue que si elle est **généralisable** : validée
> sur la famille entière, pas sur un document ; `--gate` doit passer. (3) Un
> résultat qui *infirme* l'hypothèse a **autant de valeur** qu'un succès : il
> lève l'inconnue tout autant.
