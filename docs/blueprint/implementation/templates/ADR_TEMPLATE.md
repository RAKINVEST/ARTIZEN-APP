# Modèle — ADR (renvoi)

> **Version** 1.0 — **Status** Frozen — **Owner** Architecture — **Last Update** 2026-08-02
> **Niveau:** 3 · Implémentation — **Type:** Modèle de développement (documentation, pas du code)

> Ce modèle décrit **comment structurer** l'artefact. Il n'est pas du code à exécuter : les squelettes ci-dessous sont **illustratifs** et se remplacent par le vrai contenu, en respectant les [contrats](../../contracts/) et le [Domain](../../domain/).

## Objective
Consigner une décision d'architecture structurante.

## Quand l'utiliser
Décision coûteuse à inverser, ou rupture de compatibilité de contrat.

## Structure / Squelette
Le gabarit ADR canonique vit déjà dans [../../templates/ADR_TEMPLATE.md](../../templates/ADR_TEMPLATE.md) et les ADR dans [../../adr/](../../adr/).

```
ADR-XXXX — Titre
Status : Proposed | Accepted | Superseded
Contexte / Décision / Conséquences / Alternatives écartées
```

Ce fichier n'existe que pour que le développeur trouve l'ADR depuis `implementation/`.

## Checklist
- [ ] Numéro ADR unique et séquentiel.
- [ ] Contexte, décision, conséquences, alternatives.
- [ ] Rupture de contrat -> ADR obligatoire.
- [ ] Référencé depuis les documents impactés.
- [ ] Statut tenu à jour.

## Related Documents
[../../adr/](../../adr/) · [../../templates/ADR_TEMPLATE.md](../../templates/ADR_TEMPLATE.md)

## Changelog
- 1.0 (2026-08-02) — Modèle initial.
