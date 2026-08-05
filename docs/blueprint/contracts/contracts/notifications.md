# Contrat — Notifications

> **Version** 1.0 — **Status** Frozen — **Owner** Notification Engine — **Last Update** 2026-08-02
> **Depends On:** [../CONTRACT_INDEX.md](../CONTRACT_INDEX.md) — **Used By:** implementation, ui, ai — **Niveau:** 2 · Architecture · **Type:** Domaine

## Nom
Notifications

## Description
Contrat des notifications.

## Pourquoi existe-t-il
Informer sans envahir (Loi 15).

## Responsable
Notification Engine (propriétaire unique du contrat).

## Version
1.0 — évolution selon [../VERSIONING_POLICY.md](../VERSIONING_POLICY.md).

## Entrée
événement

## Sortie
notification

## Champs
- title
- level
- confidence

## Types
Types normalisés du contrat DTO (string, integer, **decimal en chaîne**, boolean, uuid, date ISO 8601, listes). Voir [../DTO_CONTRACTS.md](../DTO_CONTRACTS.md).

## Valeurs autorisées
non bloquant

## Valeurs interdites
pop-up bloquante

## Obligatoire
Champs marqués requis dans le contrat (validés en couche Syntaxe).

## Optionnel
Champs nullables **documentés** (un `null` a un sens précis, jamais ambigu).

## Contraintes
Respecte l'enveloppe/format unique ; aucun champ orphelin ; aucune donnée inventée.

## Validation
Couches Syntaxe → Formats → Métier → Permissions → Relations → Unicité → Cohérence (voir [../VALIDATION_RULES.md](../VALIDATION_RULES.md)).

## Erreurs possibles
—

## Permissions
Garde Authentication + Authorization ; `company_id` du contexte ; mismatch tenant → 404 (voir [../SECURITY_CONTRACTS.md](../SECURITY_CONTRACTS.md)).

## Compatibilité
SemVer ; ajouts optionnels = mineur ; rupture = majeur + ADR + migration (voir [../VERSIONING_POLICY.md](../VERSIONING_POLICY.md)).

## Évolutions prévues
Canaux push/e-mail

## Related Documents
[../DTO_CONTRACTS.md](../DTO_CONTRACTS.md) · [../ERROR_CONTRACTS.md](../ERROR_CONTRACTS.md) · [../COMPATIBILITY_RULES.md](../COMPATIBILITY_RULES.md)

## Next Reading
[../CONTRACT_INDEX.md](../CONTRACT_INDEX.md)

## Changelog
- 1.0 (2026-08-02) — Fiche de contrat initiale (Domaine).
