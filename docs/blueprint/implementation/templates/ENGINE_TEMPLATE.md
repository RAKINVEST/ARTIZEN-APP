# Modèle — Moteur (Engine)

> **Version** 1.0 — **Status** Frozen — **Owner** Architecture — **Last Update** 2026-08-02
> **Niveau:** 3 · Implémentation — **Type:** Modèle de développement (documentation, pas du code)

> Ce modèle décrit **comment structurer** l'artefact. Il n'est pas du code à exécuter : les squelettes ci-dessous sont **illustratifs** et se remplacent par le vrai contenu, en respectant les [contrats](../../contracts/) et le [Domain](../../domain/).

## Objective
Ajouter un moteur (capacité read-side) sans jamais faire décider la machine ni écrire dans le cœur.

## Quand l'utiliser
Quand une capacité transverse (lecture, analyse, restitution) n'est couverte par aucun moteur existant.

## Structure / Squelette
Un moteur se **nourrit d'événements** et expose des lectures. Il ne mute pas le cœur.

```
<engine>/
  # entrées : événements du domaine (souscription)
  # sorties : read-models / suggestions (jamais une décision imposée)
  # dépendances : à sens unique, déclarées, sans cycle
```

Décrire dans la fiche : responsabilité unique, entrées (événements), sorties, dépendances, frontières, ce qu'il **ne fait pas**.

## Checklist
- [ ] Responsabilité unique, absente de [../../engines/ENGINE_MAP.md](../../engines/ENGINE_MAP.md).
- [ ] Ne décide rien à la place de l'artisan (Loi 7/18).
- [ ] N'écrit jamais dans le cœur (read-side).
- [ ] Dépendances à sens unique, sans cycle.
- [ ] Fiche Engine créée dans le Blueprint.

## Related Documents
[../../engines/ENGINE_GUIDELINES.md](../../engines/ENGINE_GUIDELINES.md)

## Changelog
- 1.0 (2026-08-02) — Modèle initial.
