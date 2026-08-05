# Modèle — Migration (Alembic)

> **Version** 1.0 — **Status** Frozen — **Owner** Architecture — **Last Update** 2026-08-02
> **Niveau:** 3 · Implémentation — **Type:** Modèle de développement (documentation, pas du code)

> Ce modèle décrit **comment structurer** l'artefact. Il n'est pas du code à exécuter : les squelettes ci-dessous sont **illustratifs** et se remplacent par le vrai contenu, en respectant les [contrats](../../contracts/) et le [Domain](../../domain/).

## Objective
Faire évoluer le schéma sans perte ni rupture.

## Quand l'utiliser
À chaque changement de schéma de base.

## Structure / Squelette
```
1. Modifier le(s) modèle(s) SQLAlchemy
2. alembic revision --autogenerate -m "message"
3. RELIRE le script généré (types, index, contraintes, données)
4. Renseigner downgrade si raisonnable
5. Tester sur base de dev
```

Changement destructif -> plusieurs étapes (expand → migrate → contract).

## Checklist
- [ ] Autogenerate **relu**, pas appliqué à l'aveugle.
- [ ] Aucune perte de donnée métier (Loi 5).
- [ ] Additif ou expand/migrate/contract.
- [ ] Modèle enregistré dans `models/__init__.py`.
- [ ] Testée avant livraison.

## Related Documents
[../MIGRATION_GUIDELINES.md](../MIGRATION_GUIDELINES.md)

## Changelog
- 1.0 (2026-08-02) — Modèle initial.
