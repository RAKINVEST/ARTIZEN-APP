# Versioning Policy — Politique de versionnement des contrats

> **Version** 1.0 — **Status** Frozen — **Owner** Architecture — **Last Update** 2026-08-02
> **Depends On:** [../quality/VERSIONING.md](../quality/VERSIONING.md) — **Used By:** tous les contrats — **Niveau:** 2 · Architecture

## Objective
Fixer comment un contrat évolue sans casser les consommateurs (Loi 17). SemVer `MAJEUR.MINEUR.PATCH`.

## Règles
| Changement | Niveau | Autorisé sans ADR ? |
|---|---|---|
| Ajout d'un champ **optionnel**, nouvel endpoint, nouvel événement | **Minor** | oui |
| Correction sans impact de forme (doc, exemple) | **Patch** | oui |
| Suppression/renommage de champ, changement de type, champ optionnel→obligatoire, rupture d'événement | **Breaking (Majeur)** | **non → ADR** |
| Marquer obsolète | **Deprecated** | oui (avec remplaçant) |
| Retrait | **Removed** | après période de dépréciation + ADR |

## Procédure de changement cassant
1. ADR décrivant la rupture et la migration.
2. Nouvelle version majeure **coexiste** avec l'ancienne pendant la période de support.
3. Événements : `schema_version` incrémenté + **upcasting** des anciens.
4. Consommateurs migrés ; ancienne version `Deprecated` puis `Removed`.

## Forbidden
**Breaking change silencieux** · version implicite.

## Acceptance Criteria
Tout changement est classé (breaking/minor/patch) ; toute rupture a un ADR et une migration.

## Related Documents
[COMPATIBILITY_RULES.md](COMPATIBILITY_RULES.md) · [../adr/README.md](../adr/README.md)

## Next Reading
[SECURITY_CONTRACTS.md](SECURITY_CONTRACTS.md)

## Changelog
- 1.0 (2026-08-02) — Politique initiale.
