# Modèle — Widget réutilisable

> **Version** 1.0 — **Status** Frozen — **Owner** Architecture — **Last Update** 2026-08-02
> **Niveau:** 3 · Implémentation — **Type:** Modèle de développement (documentation, pas du code)

> Ce modèle décrit **comment structurer** l'artefact. Il n'est pas du code à exécuter : les squelettes ci-dessous sont **illustratifs** et se remplacent par le vrai contenu, en respectant les [contrats](../../contracts/) et le [Domain](../../domain/).

## Objective
Extraire un composant d'UI réutilisable et cohérent.

## Quand l'utiliser
Quand un fragment d'UI sert (ou servira) plus d'un écran — second consommateur = signal d'extraction.

## Structure / Squelette
```
features/.../presentation/widgets/<widget>.dart
# ou core/widgets/ si transverse (deuxième consommateur)
# stateless par défaut ; état confié à un Notifier/provider
```

Respecter la charte d'identité (couleurs, dégradés, typographie).

## Checklist
- [ ] Extrait au **second** consommateur, pas par anticipation.
- [ ] Cohérent avec la charte d'identité.
- [ ] Sans logique métier ni accès données direct.
- [ ] Testé (widget test) si comportement non trivial.
- [ ] Accessible et responsive (`max-width:100%`).

## Related Documents
[../../ui/](../../ui/)

## Changelog
- 1.0 (2026-08-02) — Modèle initial.
