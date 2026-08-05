# Modèle — Documentation

> **Version** 1.0 — **Status** Frozen — **Owner** Architecture — **Last Update** 2026-08-02
> **Niveau:** 3 · Implémentation — **Type:** Modèle de développement (documentation, pas du code)

> Ce modèle décrit **comment structurer** l'artefact. Il n'est pas du code à exécuter : les squelettes ci-dessous sont **illustratifs** et se remplacent par le vrai contenu, en respectant les [contrats](../../contracts/) et le [Domain](../../domain/).

## Objective
Documenter au format unique, sans duplication.

## Quand l'utiliser
Pour tout document du Blueprint ou de module.

## Structure / Squelette
Réutiliser le format canonique : [../../templates/DOCUMENT_TEMPLATE.md](../../templates/DOCUMENT_TEMPLATE.md).

```
Entête : Version / Status / Owner / Last Update / Depends On / Used By / Niveau
Sections : Objective / Responsibilities / Constraints / Rules / Forbidden /
           Acceptance Criteria / Related Documents / Next Reading / Changelog
```

Une information n'existe **qu'une fois** (Loi 1) ; ailleurs on référence.

## Checklist
- [ ] Format unique respecté.
- [ ] Français (doc) / anglais (commentaires de code).
- [ ] Aucune duplication ; liens `[[...]]` vers les documents liés.
- [ ] Changelog tenu.
- [ ] Mise à jour du Blueprint si impact architectural.

## Related Documents
[../DOCUMENTATION_RULES.md](../DOCUMENTATION_RULES.md) · [../../templates/DOCUMENT_TEMPLATE.md](../../templates/DOCUMENT_TEMPLATE.md)

## Changelog
- 1.0 (2026-08-02) — Modèle initial.
