# Modèle — Service

> **Version** 1.0 — **Status** Frozen — **Owner** Architecture — **Last Update** 2026-08-02
> **Niveau:** 3 · Implémentation — **Type:** Modèle de développement (documentation, pas du code)

> Ce modèle décrit **comment structurer** l'artefact. Il n'est pas du code à exécuter : les squelettes ci-dessous sont **illustratifs** et se remplacent par le vrai contenu, en respectant les [contrats](../../contracts/) et le [Domain](../../domain/).

## Objective
Porter la logique métier et les invariants d'un module.

## Quand l'utiliser
Dès qu'un module a des règles (décisions, invariants, orchestration).

## Structure / Squelette
```
class <Feature>Service:
    # applique les invariants (ex. brouillon != devis, calcul unique)
    # orchestre repository + moteurs (lecture) + providers
    # lève des exceptions typées par domaine
    # ne calcule un montant que via le calculateur unique (ADR-023)
```

Le service **décide** ; le router traduit en contrat ; le repository persiste.

## Checklist
- [ ] Invariants du domaine appliqués ici.
- [ ] Exceptions typées (jamais `except:` nu).
- [ ] Aucun calcul de montant hors calculateur unique.
- [ ] Aucune décision prise à la place de l'artisan (Loi 7/18).
- [ ] Testé unitairement (logique pure).

## Related Documents
[../../domain/OBJECT_RULES.md](../../domain/OBJECT_RULES.md)

## Changelog
- 1.0 (2026-08-02) — Modèle initial.
