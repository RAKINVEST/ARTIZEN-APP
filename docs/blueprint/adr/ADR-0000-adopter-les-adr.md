# ADR-0000 — Adopter les Architecture Decision Records

> **Version** 1.0 — **Status** Frozen — **Owner** Architecture — **Last Update** 2026-08-02
> **Depends On:** [README.md](README.md) — **Used By:** tous les ADR suivants — **Niveau:** 2 · Architecture

## Statut
Frozen

## Contexte
Artizen se construit sur une vision à 10–20 ans (Bible Produit + Constitution). Les choix structurants doivent survivre au temps et aux personnes. Sans trace du **pourquoi**, une décision est ré-ouverte à chaque nouveau contributeur, ce qui mène aux réécritures que la Loi 17 interdit.

## Problème
Comment garantir que chaque décision d'architecture importante est justifiée, traçable, immuable et remplaçable sans être perdue (Loi 5) ?

## Options
1. **Aucune trace formelle** — rapide, mais le « pourquoi » se perd ; réécritures assurées.
2. **Un seul document « décisions »** — devient un fourre-tout (interdit) et illisible.
3. **Un ADR par décision, numéroté et immuable** — traçable, navigable, conforme aux Lois 4/5/6/17.

## Décision
Adopter le système **ADR** : un fichier `ADR-NNNN-<titre>.md` par décision structurante, basé sur [../templates/ADR_TEMPLATE.md](../templates/ADR_TEMPLATE.md), indexé dans [README.md](README.md).

## Justification
Respecte la Loi 6 (tout est explicable), la Loi 4 (versionné), la Loi 5 (aucune destruction : un ADV obsolète est *superseded*, jamais supprimé) et la Loi 17 (évolutivité : on remplace, on ne réécrit pas l'historique).

## Conséquences
- **Positives** : mémoire des décisions, onboarding facilité, cohérence long terme.
- **Négatives** : discipline d'écriture requise pour chaque décision structurante.

## Alternatives rejetées
Options 1 et 2 (voir ci-dessus) : perte du « pourquoi » ou document fourre-tout.

## Impact
Toute décision d'architecture future passe par un ADR. Les 11 ADR proposés dans la revue d'architecture V2 seront créés à mesure de leur consommateur réel.

## Historique
- 1.0 (2026-08-02) — Adoption, statut Frozen.
