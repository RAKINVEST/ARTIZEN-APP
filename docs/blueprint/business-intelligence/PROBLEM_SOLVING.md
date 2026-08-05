# Problem Solving — Méthode de résolution

> **Version** 1.0 — **Status** Validated — **Owner** Business Intelligence — **Last Update** 2026-08-02
> **Depends On:** [REASONING_MODEL.md](REASONING_MODEL.md) — **Used By:** Decision, AI Companion — **Niveau:** 2 · Architecture

## Objective
Décrire la méthode générale de résolution d'un problème métier.

## Méthode
1. **Cadrer** le problème (symptôme observé vs besoin réel).
2. **Recueillir** le contexte (équipement, matériau, pièce, historique — sans rien inventer).
3. **Formuler des hypothèses** (issues de connaissances validées, pas de suppositions gratuites).
4. **Éliminer** par contrôles (du plus probable/simple au plus complexe).
5. **Isoler** la cause unique (distinguer cause et symptôme).
6. **Choisir** la solution (modèle de décision — [DECISION_PATTERNS.md](DECISION_PATTERNS.md)).
7. **Vérifier** après action (contrôle, [REASONING_MODEL.md](REASONING_MODEL.md) temps 9).

## Règles
- Aller **du simple au complexe** ; ne pas remplacer avant d'avoir **diagnostiqué**.
- **Une cause à la fois** : ne pas empiler les interventions sans preuve.
- Si une étape manque d'information → **demander/suspendre** ([UNCERTAINTY.md](UNCERTAINTY.md)), jamais deviner.
- La solution retenue est **proposée** ; l'artisan **valide** (Loi 7/18).

## Anti-patterns
Remplacer sans diagnostiquer · empiler des gestes non prouvés · conclure sous incertitude · ignorer la sécurité.

## Changelog
- 1.0 (2026-08-02) — Méthode initiale.
