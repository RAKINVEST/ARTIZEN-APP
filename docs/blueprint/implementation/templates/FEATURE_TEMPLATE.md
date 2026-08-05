# Modèle — Fonctionnalité (Feature)

> **Version** 1.0 — **Status** Frozen — **Owner** Architecture — **Last Update** 2026-08-02
> **Niveau:** 3 · Implémentation — **Type:** Modèle de développement (documentation, pas du code)

> Ce modèle décrit **comment structurer** l'artefact. Il n'est pas du code à exécuter : les squelettes ci-dessous sont **illustratifs** et se remplacent par le vrai contenu, en respectant les [contrats](../../contracts/) et le [Domain](../../domain/).

## Objective
Créer une fonctionnalité de bout en bout (backend module + feature Flutter) de façon cohérente.

## Quand l'utiliser
À chaque nouvelle capacité produit reliée à un Flow et à des Contracts existants.

## Structure / Squelette
**Backend (module vertical)** — un package auto-contenu :

```
backend/app/<feature>/
  models.py        # tables SQLAlchemy (si persistance)
  schemas.py       # Pydantic (contrats d'entrée/sortie)
  repository.py    # accès DB (hérite de repositories/base)
  service.py       # logique métier (invariants, décisions)
  deps.py          # dépendances FastAPI (CurrentUserDep, ...)
  router.py        # endpoints -> montés sous /api
```

**Frontend (feature-first)** :

```
frontend/lib/features/<feature>/
  data/            # modèles Freezed + repository impl
  domain/          # interface de repository
  presentation/    # providers Riverpod + écrans
```

Enregistrer : `api/router.py` + `models/__init__.py` (backend).

## Checklist
- [ ] Rattachée à un Flow ([../../flows/](../../flows/)) et à des Contracts ([../../contracts/](../../contracts/)).
- [ ] Réutilisation prouvée (aucun objet/moteur/API existant ne répondait déjà).
- [ ] `company_id` du contexte ; tenant mismatch → 404.
- [ ] Deux langues : aucun terme d'ingénierie à l'écran.
- [ ] Tests aux bons niveaux ; DoD cochée.

## Related Documents
[FEATURE = FLOW + CONTRACTS + DOMAIN] — voir [../PROJECT_STRUCTURE.md](../PROJECT_STRUCTURE.md)

## Changelog
- 1.0 (2026-08-02) — Modèle initial.
