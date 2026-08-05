# ADR-0001 — Standard de rapport d'exécution (V3.0, accepté)

> **Version** 2.0 — **Status** Accepted — **Owner** Lead Engineer — **Last Update** 2026-08-02
> **Depends On:** [ADR-0000-adopter-les-adr.md](ADR-0000-adopter-les-adr.md) — **Used By:** toute capacité STEP 8 — **Niveau:** 3 · Implémentation

## Statut
Accepted (V3.0 — référence officielle et définitive du reporting)

## Contexte
La STEP 8 (développement logiciel) produit un rapport par capacité. Sur trois itérations, le Product
Owner a durci ce format (V2.0 → V2.1 → V2.2) pour garantir des rapports **homogènes, honnêtes et
vérifiables** sur toute la durée du projet, exploitables pour le pilotage, les revues d'architecture,
les audits qualité et les décisions produit — sans information complémentaire.

## Problème
Comment figer un format de rapport unique, empêcher sa dérive informelle, et rendre toute évolution
traçable (Loi 4/17) ?

## Options
1. **Format libre par capacité** — rapide mais hétérogène, non comparable, non auditable.
2. **Format documenté mais modifiable à volonté** — dérive silencieuse, incohérence dans le temps.
3. **Format figé, évolution par ADR uniquement** — homogène, traçable, conforme aux Lois 4/5/17.

## Décision
Adopter le **Standard de rapport d'exécution V3.0** comme format officiel et **définitif** de tout
rapport de capacité STEP 8. Structure en **3 pages** : (1) Executive Summary lisible en 30 s
(dont branche/commit Git, risque, blocage, temps restant, prochaine action) ; (2) Rapport détaillé
(15 sections avec preuves) ; (3) Gouvernance — (A) matrice décisionnelle, (B) dépendances,
(C) qualité notée, (D) progression Master Plan, (E) discipline d'honnêteté, (F) **niveau de confiance**
🟢 Vérifié / 🟡 Estimation / 🟠 Hypothèse, (G) décisions réellement prises, (H) historique de la capacité.
Toute évolution future du format **exige un nouvel ADR** qui supersede celui-ci (besoin, bénéfices,
impacts, compatibilité avec les rapports historiques). Aucune évolution informelle n'est autorisée.

## Justification
- **Loi 4** (versionné) : le format porte une version explicite.
- **Loi 5** (aucune destruction) : un standard remplacé est *superseded*, jamais effacé.
- **Loi 6** (tout est explicable) : chaque affirmation d'un rapport porte une preuve.
- **Loi 17** (évolutivité sans réécriture) : on remplace par ADR, on ne dérive pas.

## Règle d'honnêteté (contraignante)
Un rapport ne coche jamais une étape sans preuve. Distinction obligatoire et permanente :
**conçu · écrit · compilé · exécuté · testé · validé techniquement · validé fonctionnellement ·
accepté produit · mesuré.** Chaque affirmation importante porte un niveau de confiance
(🟢 Vérifié / 🟡 Estimation / 🟠 Hypothèse). Interdiction d'annoncer « fonctionnel / testé /
performant / optimisé / rapide / pas de N+1 » sans exécution ou mesure réelle.

## Conséquences
- **Positives** : rapports comparables et auditables sur des années ; pilotage fiable du Master Plan.
- **Négatives** : discipline de rédaction accrue par capacité.

## Alternatives rejetées
Options 1 et 2 : hétérogénéité ou dérive silencieuse du format.

## Impact
Toutes les capacités restantes (à partir de #8) suivent ce format. Toute modification passe par un ADR-000N ultérieur.

## Historique
- 1.0 (2026-08-02) — Adoption du standard V2.2, statut Frozen.
- 2.0 (2026-08-02) — Standard porté en **V3.0**, statut **Accepted** ; ajout des sections
  Gouvernance E–H (honnêteté étendue, niveau de confiance, décisions prises, historique de capacité).
  Devient la référence officielle et définitive ; l'effort se concentre désormais sur le produit.
