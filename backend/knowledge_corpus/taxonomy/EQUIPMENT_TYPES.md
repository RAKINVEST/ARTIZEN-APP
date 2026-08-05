# Equipment Types — Équipements

> **Version** 1.0 — **Status** Validated (éditorial) — **Owner** Éditorial / Contenu métier — **Last Update** 2026-08-02
> **Depends On:** [TAXONOMY.md](TAXONOMY.md) — **Used By:** cards, recherche, diagnostics

## Objective
Classer l'**équipement** concerné par une carte. Axe `equipement:`. Éditorial, contrôlé, extensible.

## Vocabulaire officiel (`equipement:`)
**Sanitaire** : `wc` · `lavabo` · `evier` · `receveur` · `baignoire` · `mitigeur` · `chasse-eau`
**Production ECS / chauffage** : `chauffe-eau` · `ballon-ecs` · `chaudiere` · `radiateur` ·
`plancher-chauffant` · `pac` · `poele` · `thermostat`
**Aéraulique / climatisation** : `vmc` · `climatisation` · `split` · `gaine` · `bouche-extraction`
**Électricité** : `tableau-electrique` · `disjoncteur` · `prise` · `interrupteur` · `luminaire` · `borne-irve`
**Extérieur / spécialisés** : `portail` · `volet-roulant` · `piscine` · `pompe` · `adoucisseur`

## Règles
- `equipement:` peut être **multi-valué**.
- Rattaché quand pertinent à une **activité** ([PROFESSIONS.md](PROFESSIONS.md)) et une **pièce** ([ROOM_TYPES.md](ROOM_TYPES.md)).
- Extensible ; synonymes (ex. « cumulus » → `chauffe-eau`) → [ALIASES.md](ALIASES.md).

## Décompte
**~30 équipements** en 5 groupes (extensible).

## Changelog
- 1.0 (2026-08-02) — Classification initiale.
