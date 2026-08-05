# Modèle — Repository

> **Version** 1.0 — **Status** Frozen — **Owner** Architecture — **Last Update** 2026-08-02
> **Niveau:** 3 · Implémentation — **Type:** Modèle de développement (documentation, pas du code)

> Ce modèle décrit **comment structurer** l'artefact. Il n'est pas du code à exécuter : les squelettes ci-dessous sont **illustratifs** et se remplacent par le vrai contenu, en respectant les [contrats](../../contracts/) et le [Domain](../../domain/).

## Objective
Isoler l'accès aux données derrière une interface stable.

## Quand l'utiliser
Quand un module persiste ou lit des données.

## Structure / Squelette
Le repository est le **seul** point d'accès aux données du module.

```
class <Entity>Repository(BaseRepository):
    # requêtes paramétrées (jamais de SQL concaténé)
    # toujours tenant-scopé (company_id du contexte)
    # pagination bornée (limit <= 200), pas de N+1
```

La logique métier vit dans le service, pas dans le repository.

## Checklist
- [ ] Hérite de `repositories/base`.
- [ ] Requêtes paramétrées ; tenant-scopé.
- [ ] Aucune règle métier dans le repository.
- [ ] Pagination bornée ; index adéquats.
- [ ] Testé (intégration DB réelle).

## Related Documents
[../ARCHITECTURE_RULES.md](../ARCHITECTURE_RULES.md)

## Changelog
- 1.0 (2026-08-02) — Modèle initial.
