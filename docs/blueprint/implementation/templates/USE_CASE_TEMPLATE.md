# Modèle — Cas d'usage (Use Case)

> **Version** 1.0 — **Status** Frozen — **Owner** Architecture — **Last Update** 2026-08-02
> **Niveau:** 3 · Implémentation — **Type:** Modèle de développement (documentation, pas du code)

> Ce modèle décrit **comment structurer** l'artefact. Il n'est pas du code à exécuter : les squelettes ci-dessous sont **illustratifs** et se remplacent par le vrai contenu, en respectant les [contrats](../../contracts/) et le [Domain](../../domain/).

## Objective
Décrire un cas d'usage métier avant de l'implémenter.

## Quand l'utiliser
Pour cadrer une intention utilisateur reliée à un Flow.

## Structure / Squelette
```
Acteur      : artisan (ou système)
Déclencheur : ...
Pré-conditions : ...
Étapes      : 1... 2... 3...
Post-conditions : ...
Événements émis : ...
Erreurs / cas limites : ...
```

Un cas d'usage se rattache à un **Flow** existant ([../../flows/](../../flows/)).

## Checklist
- [ ] Rattaché à un Flow documenté.
- [ ] Acteur, déclencheur, pré/post-conditions explicites.
- [ ] Événements et erreurs listés.
- [ ] Aucune décision automatique à la place de l'artisan.
- [ ] Étoile polaire vérifiée.

## Related Documents
[../../flows/FLOW_PATTERNS.md](../../flows/FLOW_PATTERNS.md)

## Changelog
- 1.0 (2026-08-02) — Modèle initial.
