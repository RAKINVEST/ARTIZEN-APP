# Contrat — <Nom>

> **Version** 0.1 — **Status** Draft — **Owner** <équipe> — **Last Update** AAAA-MM-JJ
> **Depends On:** [../events/](../events/README.md) — **Used By:** <moteurs / implémentation> — **Niveau:** 2 · Architecture

## Objective
<La capacité publique offerte par un moteur à un autre, au niveau sémantique.>

## Owner Engine
<Le moteur propriétaire du contrat.>

## Capability
`<verbe>` — <description de la capacité>.

## Inputs
<Entrées sémantiques (contexte, id, période…), jamais des internes d'agrégat.>

## Outputs
<Sorties. Toute sortie décisionnelle porte `confidence` ∈ [0,1] + `justification` (Loi 6).>

## Invariants
Read-only côté cœur (Loi 7). Explicable (Loi 6). Stable pour évoluer 10 ans (Loi 17).

## Constraints
## Rules
## Forbidden
Fuiter les internes d'un agrégat ; muter un agrégat cœur.

## Acceptance Criteria
Entrées, sorties, invariants et moteur propriétaire déclarés.

## Related Documents
## Next Reading
## Changelog
- 0.1 (AAAA-MM-JJ) — Création.
