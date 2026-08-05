# Decision Engine — Responsabilité & frontières

> **Version** 1.0 — **Status** Validated — **Owner** Decision — **Last Update** 2026-08-02
> **Depends On:** [README.md](README.md) — **Used By:** DECISION_PIPELINE, DECISION_INTEGRATIONS — **Niveau:** 2 · Architecture · **Couche:** read-side

## Objective
Préciser ce que fait — et ne fait jamais — le cerveau d'Artizen.

## Responsabilité unique
**Transformer une intention en un plan d'action proposé, classé et expliqué**, en orchestrant en
lecture les moteurs concernés. Une seule question ; aucune autre (Loi 1).

## Ce qu'il fait (les 8 responsabilités)
1. **Comprend** l'intention (langage artisan).
2. **Construit le contexte** (profession, client, chantier, historique… — [DECISION_CONTEXT.md](DECISION_CONTEXT.md)).
3. **Interroge** les moteurs concernés (lecture seule, via contrats/événements).
4. **Sélectionne** les meilleures connaissances (validées, confiance élevée — [DECISION_SCORING.md](DECISION_SCORING.md)).
5. **Assemble** une **proposition** (devis pré-rempli, kits, phrases, procédures, contrôles, photos attendues…).
6. **Explique** chaque choix ([DECISION_EXPLAINABILITY.md](DECISION_EXPLAINABILITY.md)).
7. **Attend la validation** de l'utilisateur (il ne valide jamais à sa place — Loi 7/18).
8. **Déclenche** — **après validation** — les workflows, via les moteurs propriétaires.

## Ce qu'il ne fait jamais (frontières)
- **N'écrit pas** le cœur ; **ne persiste rien** (artefacts transitoires — [DECISION_OBJECTS.md](DECISION_OBJECTS.md)).
- **Ne crée pas** de `Quote`/`Invoice`/`Mission` : ces gestes sont **explicites** et exécutés par le
  moteur propriétaire (Quote/Billing/Mission) **sur validation** (invariant CLAUDE.md #1).
- **Ne calcule aucun montant** (ADR-023) — il propose des lignes ; le calcul reste au calculateur unique.
- **N'invente rien** : il ne fait que **sélectionner/classer** des connaissances existantes ([DECISION_RULES.md](DECISION_RULES.md)).
- **Ne décide pas** : il propose ; l'artisan décide.

## Précédent réel (cohérence)
`quote_assistant` (module existant) : lit le catalogue, propose une sélection, **ne persiste rien**,
ne crée aucun devis. Le Decision Engine **généralise** ce patron à toute intention.

## Conformité (STEP 1–8)
- Domain gelé : Decision = read-side (cité dans les fiches objets). ✅
- Constitution : Lois 1, 5, 7/18 ; ADR-023 ; invariant IA (propose, ne persiste rien). ✅

## Changelog
- 1.0 (2026-08-02) — Spécification initiale.
