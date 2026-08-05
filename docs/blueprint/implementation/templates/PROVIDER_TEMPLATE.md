# Modèle — Provider (abstraction fournisseur)

> **Version** 1.0 — **Status** Frozen — **Owner** Architecture — **Last Update** 2026-08-02
> **Niveau:** 3 · Implémentation — **Type:** Modèle de développement (documentation, pas du code)

> Ce modèle décrit **comment structurer** l'artefact. Il n'est pas du code à exécuter : les squelettes ci-dessous sont **illustratifs** et se remplacent par le vrai contenu, en respectant les [contrats](../../contracts/) et le [Domain](../../domain/).

## Objective
Rendre un fournisseur externe remplaçable (Build Product, Not Infrastructure).

## Quand l'utiliser
Pour tout service externe : IA, stockage, e-mail, paiement...

## Structure / Squelette
Dépendre d'une **interface**, jamais du SDK concret.

```
class <Capability>Provider(Protocol): ...      # interface
class Real<Capability>Provider(...): ...          # implémentation réelle
class Mock<Capability>Provider(...): ...           # hors-ligne, déterministe
# factory : bascule sur le mock si la clé/API est absente
```

**L'app démarre toujours sans configuration** ; une clé manquante n'est jamais une erreur.

## Checklist
- [ ] Interface d'abord ; SDK isolé dans l'implémentation réelle.
- [ ] Mock déterministe hors-ligne.
- [ ] Factory bascule automatiquement si la clé manque.
- [ ] Aucun code métier ne dépend du SDK.
- [ ] Le fournisseur est remplaçable sans toucher au métier.

## Related Documents
[../../architecture/](../../architecture/) · [../ARCHITECTURE_RULES.md](../ARCHITECTURE_RULES.md)

## Changelog
- 1.0 (2026-08-02) — Modèle initial.
