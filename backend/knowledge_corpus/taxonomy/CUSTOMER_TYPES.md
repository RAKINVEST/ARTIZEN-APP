# Customer Types — Types de client

> **Version** 1.0 — **Status** Validated (éditorial) — **Owner** Éditorial / Contenu métier — **Last Update** 2026-08-02
> **Depends On:** [TAXONOMY.md](TAXONOMY.md) — **Used By:** cards, recherche, stats

## Objective
Classer le **type de client** d'un contexte de savoir. Axe `client:`. Éditorial (à ne pas confondre
avec les objets `Customer`/`Contact`/`Company` du domaine). Contrôlé, extensible.

## Vocabulaire officiel (`client:`)
| Slug | Sens |
|---|---|
| `particulier` | client final personne physique |
| `professionnel` | entreprise / artisan / commerçant |
| `syndic` | syndic de copropriété |
| `bailleur` | propriétaire bailleur / gestion locative |
| `collectivite` | collectivité / secteur public |
| `promoteur` | promoteur / constructeur |
| `assurance` | mandat assurance / sinistre |
| `agence` | agence immobilière / gestion |

## Règles
- `client:` qualifie le **contexte** d'une carte (une même opération peut différer selon le client).
- N'entretient **aucune** donnée client réelle (le domaine gère `Customer`).
- Extensible ; synonymes → [ALIASES.md](ALIASES.md).

## Décompte
**8 types de client** (extensible).

## Changelog
- 1.0 (2026-08-02) — Classification initiale.
