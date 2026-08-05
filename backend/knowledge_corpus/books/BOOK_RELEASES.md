# Book Releases — Publication d'un Livre

> **Version** 1.0 — **Status** Validated — **Owner** Éditorial / Contenu métier — **Last Update** 2026-08-02
> **Depends On:** [BOOK_VERSIONING.md](BOOK_VERSIONING.md), [BOOK_GOVERNANCE.md](BOOK_GOVERNANCE.md) — **Used By:** responsables de Livre

## Objective
Définir comment une version de Livre est **publiée** (release), de façon reproductible.

## Processus de release
1. **Gel du sommaire** de la version (liste des références figée).
2. **Contrôles** : toutes les cartes référencées sont **Validées** (Factory) ; navigation homogène ;
   taxonomie respectée ; zéro duplication ; relations résolues.
3. **Validation de la release** par un humain habilité ([BOOK_GOVERNANCE.md](BOOK_GOVERNANCE.md)).
4. **Publication** : version marquée `Publié` + entrée d'historique (date, responsable, validateur).
5. **Rollback** possible : revenir à la version précédente (append-only, jamais destructif).

## Critères d'acceptation d'un Livre (qualité)
- [ ] Structure **homogène** (gabarit unique).
- [ ] **Aucune duplication** de connaissance.
- [ ] **Taxonomie** respectée · **Factory** respectée.
- [ ] **Navigable** · **Versionné** · **Traçable**.

## Règles
- Une release **ne publie jamais** de carte non validée.
- Aucune suppression : une version remplacée est **archivée**.
- Rupture de compatibilité (scission/fusion) = **ADR** + plan de migration.

## Changelog
- 1.0 (2026-08-02) — Processus initial.
