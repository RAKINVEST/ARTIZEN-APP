# Modèle — Écran (Flutter)

> **Version** 1.0 — **Status** Frozen — **Owner** Architecture — **Last Update** 2026-08-02
> **Niveau:** 3 · Implémentation — **Type:** Modèle de développement (documentation, pas du code)

> Ce modèle décrit **comment structurer** l'artefact. Il n'est pas du code à exécuter : les squelettes ci-dessous sont **illustratifs** et se remplacent par le vrai contenu, en respectant les [contrats](../../contracts/) et le [Domain](../../domain/).

## Objective
Créer un écran cohérent avec l'identité et le langage artisan.

## Quand l'utiliser
À chaque nouvel écran de la feature.

## Structure / Squelette
```
features/<feature>/presentation/
  <feature>_screen.dart      # widget d'écran
  <feature>_providers.dart   # Riverpod (état serveur = AsyncNotifier)
```

Utiliser le mécanisme unique des 4 états (loading / error / empty / data). Afficher **ce que le backend renvoie** (jamais recalculer un montant).

## Checklist
- [ ] Test des 5 secondes ; langage artisan (deux langues).
- [ ] 4 états gérés via le mécanisme unique de `core/widgets/`.
- [ ] État serveur en `AsyncNotifier` ; pas de rebuild inutile.
- [ ] N'appelle jamais Dio directement (passe par `core/api`).
- [ ] Aucun calcul de montant côté client.

## Related Documents
[../../ui/](../../ui/) · [../../manifesto/](../../manifesto/)

## Changelog
- 1.0 (2026-08-02) — Modèle initial.
