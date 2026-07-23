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

## Registre

Aucune expérience à ce jour — **en attente des 5 premiers PDF natifs**. On ne
raisonnera sur des faits qu'à partir de leur entrée dans le corpus.

| Exp | Inconnue | Hypothèse | N docs | Résultat (mesuré) | Décision | Statut |
|---|---|---|---|---|---|---|
| _(exemple de format — non réel)_ | U-001 | Tableaux EBP détectables géométriquement | 5 | — | — | — |

> **Anti-biais (règle du registre).** (1) Aucun chiffre n'est inscrit s'il n'est
> pas **produit par le benchmark** — pas d'estimation, pas de « à peu près ».
> (2) Une amélioration n'est retenue que si elle est **généralisable** : validée
> sur la famille entière, pas sur un document ; `--gate` doit passer. (3) Un
> résultat qui *infirme* l'hypothèse a **autant de valeur** qu'un succès : il
> lève l'inconnue tout autant.
