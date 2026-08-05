# Book Index — Index officiel des Livres

> **Version** 1.0 — **Status** Validated (miroir taxonomie) — **Owner** Éditorial / Contenu métier — **Last Update** 2026-08-02
> **Depends On:** [../taxonomy/PROFESSIONS.md](../taxonomy/PROFESSIONS.md) — **Used By:** lecteurs, navigation, IA

## Objective
Lister les **Livres** (= activités) par **Collection** (= famille), en **miroir de la taxonomie gelée**.
L'**identifiant stable** est `book:<activite-slug>` ; le **numéro** n'est qu'un ordre de lecture.
**62 Livres** (57 actifs + 5 `deferred_v2`), **6 collections**.

## Collection I — `fluides` (Fluides & génie climatique)
[`book:plomberie`](plomberie/README.md) *(Livre I — Brouillon exemplaire)* · `book:chauffage` ·
`book:climatisation` · `book:ventilation` · `book:traitement-eau` · `book:froid` ·
`book:solaire-thermique` · `book:geothermie`

## Collection II — `electricite` (Électricité & courants faibles)
`book:electricite-generale` · `book:domotique` · `book:photovoltaique` · `book:reseaux-vdi` ·
`book:alarme-intrusion` · `book:videosurveillance` · `book:controle-acces` · `book:interphonie`

## Collection III — `finition` (Finition intérieure)
`book:platrerie` · `book:peinture` · `book:carrelage` · `book:revetements-sol` · `book:parquet` ·
`book:menuiserie-interieure` · `book:cuisine` · `book:agencement`

## Collection IV — `enveloppe` (Enveloppe du bâtiment)
`book:charpente` · `book:couverture` · `book:zinguerie` · `book:menuiserie-exterieure` ·
`book:stores-pergolas` · `book:facade` · `book:isolation` · `book:isolation-exterieure` ·
`book:bardage` · `book:etancheite`

## Collection V — `gros-oeuvre` (Gros œuvre & TP)
`book:maconnerie` · `book:terrassement` · `book:demolition` · `book:vrd` · `book:assainissement` ·
`book:forage` · `book:enrobes`

## Collection VI — `specialises` (Métiers spécialisés & services techniques)
`book:piscine` · `book:serrurerie-metallerie` · `book:automatismes-portails` · `book:vitrerie` ·
`book:ferronnerie` · `book:paysagisme` · `book:cloture` · `book:arrosage` · `book:terrasse-bois` ·
`book:ascenseur` · `book:ramonage` · `book:desamiantage` · `book:traitement-charpente` ·
`book:hygiene-nuisibles` · `book:nettoyage` · `book:diagnostic`
**Reporté V2** : `book:cordiste` · `book:cuvelage` · `book:paratonnerre` · `book:antenniste` · `book:home-staging`

## Règles
- **1 Livre ↔ 1 activité** (slug gelé). Un thème transversal (ex. PAC) **n'est pas** un Livre → [BOOK_RELATIONSHIPS.md](BOOK_RELATIONSHIPS.md).
- Ajouter un Livre = ajouter d'abord l'activité à la taxonomie gelée (`catalog/trades` + ADR).

## Changelog
- 1.0 (2026-08-02) — Index initial (62 Livres / 6 collections).
