# Modèle — Test

> **Version** 1.0 — **Status** Frozen — **Owner** Architecture — **Last Update** 2026-08-02
> **Niveau:** 3 · Implémentation — **Type:** Modèle de développement (documentation, pas du code)

> Ce modèle décrit **comment structurer** l'artefact. Il n'est pas du code à exécuter : les squelettes ci-dessous sont **illustratifs** et se remplacent par le vrai contenu, en respectant les [contrats](../../contracts/) et le [Domain](../../domain/).

## Objective
Écrire un test au bon niveau, déterministe et sans donnée client réelle.

## Quand l'utiliser
Pour toute logique métier, tout endpoint, tout bug corrigé (non-régression).

## Structure / Squelette
**Backend (pytest)** :

```
# test_<sujet>.py — miroir de la source
# unitaire pur -> pas de DB (peut tourner --noconftest)
# intégration -> DB réelle (pas d'isolation : données déterministes)
def test_<comportement_attendu>(): ...
```

**Frontend (flutter test)** : `<sujet>_test.dart`, fakes/mocks (pas de vrai backend).

## Checklist
- [ ] Niveau juste (unitaire / intégration / fonctionnel).
- [ ] Nom descriptif du comportement.
- [ ] Déterministe ; **aucune donnée client réelle**.
- [ ] Un bug corrigé = un test qui le reproduit.
- [ ] Vert avant merge.

## Related Documents
[../TEST_STRATEGY.md](../TEST_STRATEGY.md)

## Changelog
- 1.0 (2026-08-02) — Modèle initial.
