# Professions — Les 62 activités (miroir gelé)

> **Version** 1.0 — **Status** Validated (miroir) — **Owner** Catalog/Taxonomie — **Last Update** 2026-08-02
> **Depends On:** [FAMILIES.md](FAMILIES.md), [../../TAXONOMIE-METIERS.md](../../TAXONOMIE-METIERS.md) — **Used By:** cards, filtres, moteurs

## Objective
Refléter les **activités** de la taxonomie gelée (le « métier » = ce que l'artisan *fait*, unité de
composition). **Source de vérité :** `catalog/trades/taxonomy.py`. Miroir non autoritaire.
`activite:` est l'axe canonique ; `metier:` en est un **alias autorisé** ([ALIASES.md](ALIASES.md)).

## fluides — Fluides & génie climatique
`plomberie` · `chauffage` · `climatisation` · `ventilation` · `traitement-eau` · `froid` ·
`solaire-thermique` · `geothermie` — **Qualif. d'exercice** : `pg`, `fluides-frigorigenes`

## electricite — Électricité & courants faibles
`electricite-generale` · `domotique` · `photovoltaique` · `reseaux-vdi` · `alarme-intrusion` ·
`videosurveillance` · `controle-acces` · `interphonie` — **Qualif.** : `irve`

## finition — Finition intérieure (second œuvre)
`platrerie` · `peinture` · `carrelage` · `revetements-sol` · `parquet` · `menuiserie-interieure` ·
`cuisine` · `agencement`

## enveloppe — Enveloppe du bâtiment
`charpente` · `couverture` · `zinguerie` · `menuiserie-exterieure` · `stores-pergolas` · `facade` ·
`isolation` · `isolation-exterieure` · `bardage` · `etancheite`

## gros-oeuvre — Gros œuvre & travaux publics
`maconnerie` · `terrassement` · `demolition` · `vrd` · `assainissement` · `forage` · `enrobes`

## specialises — Métiers spécialisés & services techniques
`piscine` · `serrurerie-metallerie` · `automatismes-portails` · `vitrerie` · `ferronnerie` ·
`paysagisme` · `cloture` · `arrosage` · `terrasse-bois` · `ascenseur` · `ramonage` · `desamiantage` ·
`traitement-charpente` · `hygiene-nuisibles` · `nettoyage` · `diagnostic`
**Reporté V2** (`deferred_v2`) : `cordiste` · `cuvelage` · `paratonnerre` · `antenniste` · `home-staging`
**Qualif.** : `certification-amiante`

## Décompte
**62 activités** (57 `implemented`/`planned` + 5 `deferred_v2`), **6 familles**, **4 qualifications
d'exercice**, **7 certifications d'entreprise** (transverses, hors famille).

## Fiche d'une profession (structure)
Chaque activité, pour le Corpus, porte : **Nom · Description · Famille · Sous-familles éditoriales ·
Relations · Synonymes interdits · Alias autorisés** — les synonymes/alias sont gérés dans
[ALIASES.md](ALIASES.md) ; les sous-familles dans [SUB_FAMILIES.md](SUB_FAMILIES.md).

## Règle
Slugs **gelés** ; ajout/renommage d'activité = via la taxonomie gelée (fichier `trades/*.py` + registre + ADR), **jamais ici**.

## Changelog
- 1.0 (2026-08-02) — Miroir initial des 62 activités.
