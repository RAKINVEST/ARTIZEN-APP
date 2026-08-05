# <Nom> Engine

> **Version** 1.0 — **Status** Draft — **Owner** <Équipe propriétaire> — **Last Update** 2026-08-02
> **Depends On:** [../ENGINE_MAP.md](../ENGINE_MAP.md) — **Used By:** flows, events — **Niveau:** 2 · Architecture

## Nom
<Nom> Engine

## Mission
<Mission en une phrase — la seule chose que ce moteur fait.>

## Responsabilité
Responsabilité **unique** : <mission>. Aucune autre. Ne décide jamais à la place de l'artisan (Loi 7/18).

## Frontières
- **Fait :** <périmètre exact>.
- **Ne fait pas :** <ce qui appartient à un autre moteur>.
- N'écrit **jamais** dans le cœur : moteur read-side, se nourrit d'événements (Loi 7).

## Objets lus
<objets du domaine consultés (via événements / read-models)>

## Dépendances
À **sens unique** et justifiées ; aucune dépendance montante, aucun cycle. <lister>

## Couplage
Faible ; échange par **événements** et **contrats**, jamais par appel direct au cœur.

## Événements consommés
- `<X>Created` / `<X>Updated` — déclencheur et effet.

## Événements publiés
- `<Nom>...` — charge, consommateurs, impact (voir [../ENGINE_EVENTS.md](../ENGINE_EVENTS.md)).

## Interopérabilité
Dialogue avec <moteurs> via le bus d'événements ; ne mélange jamais ses responsabilités (Loi 16).

## Propriétaire
**<Équipe propriétaire>** (unique).

## Contraintes
- Une clé/API absente n'est jamais une erreur (provider-abstraction ; l'app démarre toujours).
- Aucun montant calculé ici (un seul lieu calcule — ADR-023).

## Related Documents
[../ENGINE_BOUNDARIES.md](../ENGINE_BOUNDARIES.md) · [../ENGINE_DEPENDENCIES.md](../ENGINE_DEPENDENCIES.md) · [../ENGINE_EVENTS.md](../ENGINE_EVENTS.md)

## Next Reading
[../ENGINE_MAP.md](../ENGINE_MAP.md)

## Changelog
- 1.0 (2026-08-02) — Modèle de fiche moteur.
