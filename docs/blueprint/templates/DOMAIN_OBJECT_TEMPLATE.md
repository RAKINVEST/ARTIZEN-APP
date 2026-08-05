# Objet métier — <Nom>

> **Version** 0.1 — **Status** Draft — **Owner** <équipe> — **Last Update** AAAA-MM-JJ
> **Depends On:** [../architecture/](../architecture/README.md) — **Used By:** <moteurs, événements> — **Niveau:** 2 · Architecture

## Objective
<Ce que cet objet représente dans le domaine.>

## Type DDD
Agrégat racine | Entité | Value Object — **justification** : <cycle de vie, identité, immutabilité>.

## Identity
<Comment l'objet est identifié (id, ou égalité par valeur pour un VO).>

## Invariants
<Règles toujours vraies (Loi 1 : source unique ; Loi 5 : pas de destruction du savoir).>

## Relations
<Objets référencés (par id), et objets qui le référencent.>

## Repository
<Nom du repository si agrégat racine ; sinon « aucun (contenu dans son agrégat) ».>

## Domain Events émis
<Liste des événements que cet objet publie.>

## Constraints
Aucune duplication (Loi 1/11). Aucun montant calculé ici hors service dédié.

## Rules
## Forbidden
## Acceptance Criteria
Type justifié · invariants listés · relations par id · repository (ou son absence) déclaré.

## Related Documents
## Next Reading
## Changelog
- 0.1 (AAAA-MM-JJ) — Création.
