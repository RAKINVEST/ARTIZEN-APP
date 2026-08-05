# Versionnement

> **Version** 1.0 — **Status** Frozen — **Owner** Architecture — **Last Update** 2026-08-02
> **Depends On:** [CONVENTIONS.md](CONVENTIONS.md) — **Used By:** tous les documents — **Niveau:** 3 · Implémentation

## Objective
Définir comment sont versionnés les documents, le Blueprint et les templates, et comment un document est déprécié — sans jamais rien détruire (Loi 5).

## Rules
- **Version d'un document** : `MAJEUR.MINEUR`. Mineur = correction/précision ; Majeur = changement de sens. Toujours reflété dans `Version`, `Last Update` et le `Changelog`.
- **Statuts** : `Draft` → `Validated` → `Frozen`. Un document `Frozen` ne se modifie pas sur le fond : on en publie une **nouvelle version** qui référence l'ancienne.
- **Version du Blueprint** : suit [../CHANGELOG.md](../CHANGELOG.md). Incrément majeur = réorganisation de l'arborescence.
- **Version des templates** : un template a sa propre version ; les documents indiquent le template et la version d'origine s'ils s'en écartent.
- **Dépréciation** : statut `Deprecated`, en tête un lien « Remplacé par … ». Le fichier reste (Loi 5) ; il n'est jamais supprimé.
- **Compatibilité documentaire** : un document ne peut dépendre que d'un document `Validated` ou `Frozen` (jamais d'un `Draft` pour une décision structurante).

## Forbidden
Supprimer un document métier ou un ADR. Réutiliser un numéro d'ADR.

## Acceptance Criteria
Chaque document porte version + statut + changelog ; toute dépréciation pointe son remplaçant.

## Related Documents
[CONVENTIONS.md](CONVENTIONS.md) · [QUALITY_RULES.md](QUALITY_RULES.md) · [../adr/README.md](../adr/README.md)

## Next Reading
[QUALITY_RULES.md](QUALITY_RULES.md)

## Changelog
- 1.0 (2026-08-02) — Politique initiale.
