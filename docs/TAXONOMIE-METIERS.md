# Taxonomie officielle des métiers — Artizen

> **La colonne vertébrale d'Artizen.** Familles → activités → qualifications. Cette taxonomie
> est la **référence unique** de toute l'application : catalogues, recherche, filtres,
> statistiques, marketplace, IA, connecteurs et API publique nomment les métiers par les
> **slugs** définis ici.
>
> **Les slugs sont gelés.** Choisis une fois, jamais renommés — tout ce qui est en aval s'y
> réfère. La source machine autoritaire est [`backend/app/catalog/trades/taxonomy.py`](../backend/app/catalog/trades/taxonomy.py) ;
> ce document en est le miroir humain. Exposée aussi par `GET /catalog/taxonomy`.

## Principes de conception (à ne pas rediscuter)

1. **Un métier = une ou plusieurs activités.** « Plombier-chauffagiste » = `plomberie` +
   `chauffage`. Le métier (ce que l'artisan *est*) n'est pas stocké ; les **activités**
   (unités de composition du catalogue) le sont (décision 7).
2. **Deux concepts distincts, jamais mélangés :**
   - **Qualification d'exercice** = *droit de faire* des travaux réservés (`pg`, `irve`,
     `fluides-frigorigenes`, `certification-amiante`). Elle **influence le moteur** : elle
     débloque un pack. Rattachée à sa **famille**.
   - **Certification d'entreprise** = mention administrative (`rge`, `qualipv`, `qualipac`,
     `qualibois`, `qualisol`, `eco-artisan`, `qualifelec`). **Aucun impact catalogue** :
     justifie une aide, apparaît sur les devis. **Transverse** (hors famille).
3. **Les énergies renouvelables ne sont pas une famille.** Le photovoltaïque *est* de
   l'électricité ; le solaire thermique / la géothermie *sont* des sources de chaleur
   (fluides). La dimension « verte / aidée » est une **qualification** (RGE, QualiPAC,
   QualiPV, QualiBois, QualiSol), pas un métier.
4. **Un slug identifie exactement une chose, pour toujours** (familles, activités et
   qualifications partagent un seul espace de noms — unicité globale garantie par test).
5. **Statuts** (cycle de vie officiel, lu par l'API `?status=`, le back-office, les tests) :
   `implemented` (activité + packs, importable) · `planned` (au périmètre V1, à développer) ·
   `deferred_v2` (repoussé en V2) · `deprecated` (était disponible, en retrait).

## Les 6 familles

### 🟦 fluides — Fluides & génie climatique
**Activités** : `plomberie` ✅ · `chauffage` ✅ · `climatisation` ✅ · `ventilation` ✅ ·
`traitement-eau` ✅ · `froid` · `solaire-thermique` · `geothermie`
**Qualifications d'exercice** : `pg` ✅ · `fluides-frigorigenes` ✅

### 🟨 electricite — Électricité & courants faibles ✅ **TERMINÉ**
**Activités** : `electricite-generale` ✅ · `domotique` ✅ · `photovoltaique` ✅ · `reseaux-vdi` ✅ ·
`alarme-intrusion` ✅ · `videosurveillance` ✅ · `controle-acces` ✅ · `interphonie` ✅
**Qualifications d'exercice** : `irve` ✅

### 🟩 finition — Finition intérieure (second œuvre)
**Activités** : `platrerie` · `peinture` · `carrelage` · `revetements-sol` · `parquet` ·
`menuiserie-interieure` · `cuisine` · `agencement`

### 🟧 enveloppe — Enveloppe du bâtiment
**Activités** : `charpente` · `couverture` · `zinguerie` · `menuiserie-exterieure` ·
`stores-pergolas` · `facade` · `isolation` · `isolation-exterieure` · `bardage` · `etancheite`

### 🟥 gros-oeuvre — Gros œuvre & travaux publics
**Activités** : `maconnerie` · `terrassement` · `demolition` · `vrd` · `assainissement` ·
`forage` · `enrobes`

### 🟪 specialises — Métiers spécialisés & services techniques
**Activités** : `piscine` · `serrurerie-metallerie` · `automatismes-portails` · `vitrerie` ·
`ferronnerie` · `paysagisme` · `cloture` · `arrosage` · `terrasse-bois` · `ascenseur` ·
`ramonage` · `desamiantage` · `traitement-charpente` · `hygiene-nuisibles` · `nettoyage` ·
`diagnostic`
**Qualifications d'exercice** : `certification-amiante`
**Reporté V2** : `cordiste` · `cuvelage` · `paratonnerre` · `antenniste` · `home-staging`

## Certifications d'entreprise (transverses — aucun impact catalogue)

`rge` · `eco-artisan` · `qualipac` · `qualipv` · `qualibois` · `qualisol` · `qualifelec`

Mentions administratives portées par l'entreprise (aides, logo, devis), **hors famille**.
Modèle conceptuel **réservé, non développé** (V1 : champ `rge_number` sur `Company`) :

```
CompanyCertification(company_id, type, numero, organisme,
                     date_obtention, date_expiration, statut)
```

Une entreprise pourra en détenir autant qu'elle veut, avec validité — sans modifier le modèle.
Le mécanisme complet est une fonctionnalité à part, à développer plus tard.

## Ordre de développement (lots)

`fluides` ✅ (fait) → `electricite` → `finition` → `enveloppe` → `gros-oeuvre` → `specialises`.

## Règle de gel

Chaque activité est développée puis **prouvée générique** par
[`test_trades_generic.py`](../backend/app/tests/test_trades_generic.py) (import + lecture par
l'endpoint du wizard). Quand toutes les activités `planned` seront `implemented`, cette couche
sera **définitivement gelée**. Toute évolution ultérieure = nouveaux articles versionnés
(changelog), jamais un renommage de slug.
