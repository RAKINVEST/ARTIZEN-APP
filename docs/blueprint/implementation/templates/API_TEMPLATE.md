# Modèle — API / Endpoint

> **Version** 1.0 — **Status** Frozen — **Owner** Architecture — **Last Update** 2026-08-02
> **Niveau:** 3 · Implémentation — **Type:** Modèle de développement (documentation, pas du code)

> Ce modèle décrit **comment structurer** l'artefact. Il n'est pas du code à exécuter : les squelettes ci-dessous sont **illustratifs** et se remplacent par le vrai contenu, en respectant les [contrats](../../contracts/) et le [Domain](../../domain/).

## Objective
Exposer un endpoint dont le contrat est défini avant le code.

## Quand l'utiliser
À chaque nouvelle route HTTP.

## Structure / Squelette
**Contrat d'abord** (dans [../../contracts/API_CONTRACTS.md](../../contracts/API_CONTRACTS.md)), puis router.

```
<VERBE> /api/<ressource>
  Auth   : Bearer (company_id du contexte)
  Entrée : schema Pydantic validé
  Sortie : schema de réponse
  Erreurs: enveloppe { error: { code, message } } + statut correct
```

Statuts : 400/401/403/404(tenant)/409/413/415/422/429/5xx.

## Checklist
- [ ] Contrat défini avant le code.
- [ ] `company_id` du contexte ; jamais du client.
- [ ] Validation d'entrée ; enveloppe d'erreur normalisée.
- [ ] Compatible (additif) ou versionné + ADR.
- [ ] Vérifié par un `curl` réaliste.

## Related Documents
[../../contracts/API_CONTRACTS.md](../../contracts/API_CONTRACTS.md) · [../ERROR_HANDLING.md](../ERROR_HANDLING.md)

## Changelog
- 1.0 (2026-08-02) — Modèle initial.
