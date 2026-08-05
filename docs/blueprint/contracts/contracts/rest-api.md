# Contrat — REST API

> **Version** 1.0 — **Status** Frozen — **Owner** API Engine — **Last Update** 2026-08-02
> **Depends On:** [../CONTRACT_INDEX.md](../CONTRACT_INDEX.md) — **Used By:** implementation, ui, ai — **Niveau:** 2 · Architecture · **Type:** Transport

## Nom
REST API

## Description
Contrat des endpoints HTTP synchrones.

## Pourquoi existe-t-il
Point d'entrée unique et stable pour Flutter et intégrations.

## Responsable
API Engine (propriétaire unique du contrat).

## Version
1.0 — évolution selon [../VERSIONING_POLICY.md](../VERSIONING_POLICY.md).

## Entrée
DTO de requête + JWT

## Sortie
DTO de réponse + code HTTP

## Champs
- uri
- méthode
- corps
- en-têtes

## Types
Types normalisés du contrat DTO (string, integer, **decimal en chaîne**, boolean, uuid, date ISO 8601, listes). Voir [../DTO_CONTRACTS.md](../DTO_CONTRACTS.md).

## Valeurs autorisées
GET/POST/PUT/PATCH/DELETE ; codes 2xx/4xx/5xx

## Valeurs interdites
company_id en query ; verbe non standard

## Obligatoire
Champs marqués requis dans le contrat (validés en couche Syntaxe).

## Optionnel
Champs nullables **documentés** (un `null` a un sens précis, jamais ambigu).

## Contraintes
Respecte l'enveloppe/format unique ; aucun champ orphelin ; aucune donnée inventée.

## Validation
Couches Syntaxe → Formats → Métier → Permissions → Relations → Unicité → Cohérence (voir [../VALIDATION_RULES.md](../VALIDATION_RULES.md)).

## Erreurs possibles
validation_error, unauthorized, forbidden, not_found, conflict

## Permissions
Garde Authentication + Authorization ; `company_id` du contexte ; mismatch tenant → 404 (voir [../SECURITY_CONTRACTS.md](../SECURITY_CONTRACTS.md)).

## Compatibilité
SemVer ; ajouts optionnels = mineur ; rupture = majeur + ADR + migration (voir [../VERSIONING_POLICY.md](../VERSIONING_POLICY.md)).

## Évolutions prévues
Versionnement par `/v2` si rupture

## Related Documents
[../DTO_CONTRACTS.md](../DTO_CONTRACTS.md) · [../ERROR_CONTRACTS.md](../ERROR_CONTRACTS.md) · [../COMPATIBILITY_RULES.md](../COMPATIBILITY_RULES.md)

## Next Reading
[../CONTRACT_INDEX.md](../CONTRACT_INDEX.md)

## Changelog
- 1.0 (2026-08-02) — Fiche de contrat initiale (Transport).
