# Contrat — AI

> **Version** 1.0 — **Status** Frozen — **Owner** AI Engine — **Last Update** 2026-08-02
> **Depends On:** [../CONTRACT_INDEX.md](../CONTRACT_INDEX.md) — **Used By:** implementation, ui, ai — **Niveau:** 2 · Architecture · **Type:** Domaine

## Nom
AI

## Description
Contrat des échanges avec l'IA.

## Pourquoi existe-t-il
L'IA enrichit, n'invente pas, ne décide pas (Loi 7/18).

## Responsable
AI Engine (propriétaire unique du contrat).

## Version
1.0 — évolution selon [../VERSIONING_POLICY.md](../VERSIONING_POLICY.md).

## Entrée
prompt + contexte

## Sortie
réponse structurée

## Champs
- prompt
- context
- response
- confidence
- sources
- justification
- refusal
- timeout

## Types
Types normalisés du contrat DTO (string, integer, **decimal en chaîne**, boolean, uuid, date ISO 8601, listes). Voir [../DTO_CONTRACTS.md](../DTO_CONTRACTS.md).

## Valeurs autorisées
confiance ∈ [0,1] ; justification obligatoire ; refus explicite

## Valeurs interdites
**inventer une valeur** ; décider ; dépasser le timeout sans refus

## Obligatoire
Champs marqués requis dans le contrat (validés en couche Syntaxe).

## Optionnel
Champs nullables **documentés** (un `null` a un sens précis, jamais ambigu).

## Contraintes
Respecte l'enveloppe/format unique ; aucun champ orphelin ; aucune donnée inventée.

## Validation
Couches Syntaxe → Formats → Métier → Permissions → Relations → Unicité → Cohérence (voir [../VALIDATION_RULES.md](../VALIDATION_RULES.md)).

## Erreurs possibles
extraction_provider_unavailable, timeout

## Permissions
Garde Authentication + Authorization ; `company_id` du contexte ; mismatch tenant → 404 (voir [../SECURITY_CONTRACTS.md](../SECURITY_CONTRACTS.md)).

## Compatibilité
SemVer ; ajouts optionnels = mineur ; rupture = majeur + ADR + migration (voir [../VERSIONING_POLICY.md](../VERSIONING_POLICY.md)).

## Évolutions prévues
Support multimodal, embeddings

## Related Documents
[../DTO_CONTRACTS.md](../DTO_CONTRACTS.md) · [../ERROR_CONTRACTS.md](../ERROR_CONTRACTS.md) · [../COMPATIBILITY_RULES.md](../COMPATIBILITY_RULES.md)

## Next Reading
[../CONTRACT_INDEX.md](../CONTRACT_INDEX.md)

## Changelog
- 1.0 (2026-08-02) — Fiche de contrat initiale (Domaine).
