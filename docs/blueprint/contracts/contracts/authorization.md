# Contrat — Authorization

> **Version** 1.0 — **Status** Frozen — **Owner** Authorization Engine — **Last Update** 2026-08-02
> **Depends On:** [../CONTRACT_INDEX.md](../CONTRACT_INDEX.md) — **Used By:** implementation, ui, ai — **Niveau:** 2 · Architecture · **Type:** Sécurité

## Nom
Authorization

## Description
Contrat d'autorisation.

## Pourquoi existe-t-il
Décider du droit d'agir.

## Responsable
Authorization Engine (propriétaire unique du contrat).

## Version
1.0 — évolution selon [../VERSIONING_POLICY.md](../VERSIONING_POLICY.md).

## Entrée
acteur + action

## Sortie
décision

## Champs
- role
- action
- scope

## Types
Types normalisés du contrat DTO (string, integer, **decimal en chaîne**, boolean, uuid, date ISO 8601, listes). Voir [../DTO_CONTRACTS.md](../DTO_CONTRACTS.md).

## Valeurs autorisées
scoping tenant

## Valeurs interdites
company_id du client

## Obligatoire
Champs marqués requis dans le contrat (validés en couche Syntaxe).

## Optionnel
Champs nullables **documentés** (un `null` a un sens précis, jamais ambigu).

## Contraintes
Respecte l'enveloppe/format unique ; aucun champ orphelin ; aucune donnée inventée.

## Validation
Couches Syntaxe → Formats → Métier → Permissions → Relations → Unicité → Cohérence (voir [../VALIDATION_RULES.md](../VALIDATION_RULES.md)).

## Erreurs possibles
forbidden, not_found

## Permissions
Garde Authentication + Authorization ; `company_id` du contexte ; mismatch tenant → 404 (voir [../SECURITY_CONTRACTS.md](../SECURITY_CONTRACTS.md)).

## Compatibilité
SemVer ; ajouts optionnels = mineur ; rupture = majeur + ADR + migration (voir [../VERSIONING_POLICY.md](../VERSIONING_POLICY.md)).

## Évolutions prévues
Politiques fines

## Related Documents
[../DTO_CONTRACTS.md](../DTO_CONTRACTS.md) · [../ERROR_CONTRACTS.md](../ERROR_CONTRACTS.md) · [../COMPATIBILITY_RULES.md](../COMPATIBILITY_RULES.md)

## Next Reading
[../CONTRACT_INDEX.md](../CONTRACT_INDEX.md)

## Changelog
- 1.0 (2026-08-02) — Fiche de contrat initiale (Sécurité).
