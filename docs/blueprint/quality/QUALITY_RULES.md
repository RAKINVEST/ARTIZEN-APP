# Règles qualité

> **Version** 1.0 — **Status** Frozen — **Owner** Architecture — **Last Update** 2026-08-02
> **Depends On:** [VERSIONING.md](VERSIONING.md) — **Used By:** tous les documents — **Niveau:** 3 · Implémentation

## Objective
Garantir un référentiel cohérent, sans doublon, traçable et navigable — condition pour qu'il tienne 10 à 20 ans.

## Rules
1. **Aucun doublon** : une information n'existe qu'une fois (Loi 1). Ailleurs, on **référence**.
2. **Une source de vérité** par sujet ; un sujet n'a qu'un document propriétaire.
3. **Une responsabilité par document** : un document = un rôle clair.
4. **Navigation obligatoire** : `Depends On`, `Used By`, `Next Reading` remplis ; aucun document orphelin.
5. **Historique obligatoire** : `Changelog` présent et tenu à jour.
6. **Traçabilité obligatoire** : toute règle/décision cite la ou les lois et, si utile, l'ADR correspondant.
7. **Explicabilité** : un document qui décrit une suggestion doit décrire sa justification (Loi 6).
8. **Cohérence de format** : tout document suit le format unique (template).

## Forbidden
Créer un document « fourre-tout ». Dupliquer un contenu au lieu de le référencer. Publier un document sans navigation ni changelog.

## Acceptance Criteria
Revue documentaire : 0 doublon · 0 orphelin · 100 % des documents au format unique · liens valides.

## Related Documents
[CONVENTIONS.md](CONVENTIONS.md) · [VERSIONING.md](VERSIONING.md)

## Next Reading
[../glossary/GLOSSARY.md](../glossary/GLOSSARY.md)

## Changelog
- 1.0 (2026-08-02) — Règles qualité initiales.
