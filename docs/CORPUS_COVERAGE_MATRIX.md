# Matrice de couverture du patrimoine — 62 Livres

> Cible de volume **Corpus V1** par Livre et par type de contenu. Document de
> **planification** : aucune carte n'est produite ici. La structure est gelée par
> la taxonomie officielle ([docs/TAXONOMIE-METIERS.md](TAXONOMIE-METIERS.md),
> `catalog/trades/taxonomy.py`) : 6 Collections = 6 familles, 62 Livres = 62
> activités. Un Livre = une unité éditoriale par activité
> ([knowledge_corpus/books/BOOK_SYSTEM.md](../backend/knowledge_corpus/books/BOOK_SYSTEM.md)).

## Modèle de volume (paliers de complexité)

Chaque Livre est classé en **palier** selon l'ampleur du métier (nombre d'opérations
courantes, criticité, largeur d'équipements) :

| Type | Palier A (large) | Palier B (moyen) | Palier C (niche) |
|---|---|---|---|
| Cards | 60 | 35 | 18 |
| Diagnostics | 20 | 12 | 6 |
| Procédures | 15 | 9 | 4 |
| Check-lists | 12 | 7 | 4 |
| Kits | 10 | 6 | 3 |
| Phrases | 15 | 10 | 6 |
| FAQ | 20 | 12 | 6 |
| REX (retours terrain) | 8 | 5 | 2 |
| **Total / Livre** | **160** | **96** | **49** |

Répartition : **A = 12 Livres · B = 32 · C = 18**. Statut app : ✅ implémenté ·
○ planifié · ⏸ différé V2.

## Matrice complète

| Collection | Livre (métier) | Statut | Palier | Cards | Diag. | Proc. | Check | Kits | Phrases | FAQ | REX | Total |
|---|---|---|---|---|---|---|---|---|---|---|---|---|
| fluides | plomberie | ✅ | A | 60 | 20 | 15 | 12 | 10 | 15 | 20 | 8 | 160 |
| fluides | chauffage | ✅ | A | 60 | 20 | 15 | 12 | 10 | 15 | 20 | 8 | 160 |
| fluides | climatisation | ✅ | A | 60 | 20 | 15 | 12 | 10 | 15 | 20 | 8 | 160 |
| fluides | ventilation | ✅ | B | 35 | 12 | 9 | 7 | 6 | 10 | 12 | 5 | 96 |
| fluides | traitement-eau | ✅ | B | 35 | 12 | 9 | 7 | 6 | 10 | 12 | 5 | 96 |
| fluides | froid | ○ | B | 35 | 12 | 9 | 7 | 6 | 10 | 12 | 5 | 96 |
| fluides | solaire-thermique | ○ | B | 35 | 12 | 9 | 7 | 6 | 10 | 12 | 5 | 96 |
| fluides | geothermie | ○ | B | 35 | 12 | 9 | 7 | 6 | 10 | 12 | 5 | 96 |
| electricite | electricite-generale | ✅ | A | 60 | 20 | 15 | 12 | 10 | 15 | 20 | 8 | 160 |
| electricite | domotique | ✅ | B | 35 | 12 | 9 | 7 | 6 | 10 | 12 | 5 | 96 |
| electricite | photovoltaique | ✅ | B | 35 | 12 | 9 | 7 | 6 | 10 | 12 | 5 | 96 |
| electricite | reseaux-vdi | ✅ | B | 35 | 12 | 9 | 7 | 6 | 10 | 12 | 5 | 96 |
| electricite | alarme-intrusion | ✅ | C | 18 | 6 | 4 | 4 | 3 | 6 | 6 | 2 | 49 |
| electricite | videosurveillance | ✅ | C | 18 | 6 | 4 | 4 | 3 | 6 | 6 | 2 | 49 |
| electricite | controle-acces | ✅ | C | 18 | 6 | 4 | 4 | 3 | 6 | 6 | 2 | 49 |
| electricite | interphonie | ✅ | C | 18 | 6 | 4 | 4 | 3 | 6 | 6 | 2 | 49 |
| finition | platrerie | ✅ | A | 60 | 20 | 15 | 12 | 10 | 15 | 20 | 8 | 160 |
| finition | peinture | ✅ | A | 60 | 20 | 15 | 12 | 10 | 15 | 20 | 8 | 160 |
| finition | carrelage | ✅ | A | 60 | 20 | 15 | 12 | 10 | 15 | 20 | 8 | 160 |
| finition | revetements-sol | ✅ | B | 35 | 12 | 9 | 7 | 6 | 10 | 12 | 5 | 96 |
| finition | parquet | ✅ | B | 35 | 12 | 9 | 7 | 6 | 10 | 12 | 5 | 96 |
| finition | menuiserie-interieure | ✅ | A | 60 | 20 | 15 | 12 | 10 | 15 | 20 | 8 | 160 |
| finition | cuisine | ✅ | B | 35 | 12 | 9 | 7 | 6 | 10 | 12 | 5 | 96 |
| finition | agencement | ✅ | B | 35 | 12 | 9 | 7 | 6 | 10 | 12 | 5 | 96 |
| enveloppe | charpente | ✅ | A | 60 | 20 | 15 | 12 | 10 | 15 | 20 | 8 | 160 |
| enveloppe | couverture | ✅ | A | 60 | 20 | 15 | 12 | 10 | 15 | 20 | 8 | 160 |
| enveloppe | zinguerie | ✅ | B | 35 | 12 | 9 | 7 | 6 | 10 | 12 | 5 | 96 |
| enveloppe | menuiserie-exterieure | ✅ | A | 60 | 20 | 15 | 12 | 10 | 15 | 20 | 8 | 160 |
| enveloppe | stores-pergolas | ✅ | C | 18 | 6 | 4 | 4 | 3 | 6 | 6 | 2 | 49 |
| enveloppe | facade | ✅ | B | 35 | 12 | 9 | 7 | 6 | 10 | 12 | 5 | 96 |
| enveloppe | isolation | ✅ | B | 35 | 12 | 9 | 7 | 6 | 10 | 12 | 5 | 96 |
| enveloppe | isolation-exterieure | ✅ | B | 35 | 12 | 9 | 7 | 6 | 10 | 12 | 5 | 96 |
| enveloppe | bardage | ✅ | B | 35 | 12 | 9 | 7 | 6 | 10 | 12 | 5 | 96 |
| enveloppe | etancheite | ✅ | B | 35 | 12 | 9 | 7 | 6 | 10 | 12 | 5 | 96 |
| gros-oeuvre | maconnerie | ✅ | A | 60 | 20 | 15 | 12 | 10 | 15 | 20 | 8 | 160 |
| gros-oeuvre | terrassement | ✅ | B | 35 | 12 | 9 | 7 | 6 | 10 | 12 | 5 | 96 |
| gros-oeuvre | demolition | ✅ | B | 35 | 12 | 9 | 7 | 6 | 10 | 12 | 5 | 96 |
| gros-oeuvre | vrd | ✅ | B | 35 | 12 | 9 | 7 | 6 | 10 | 12 | 5 | 96 |
| gros-oeuvre | assainissement | ✅ | B | 35 | 12 | 9 | 7 | 6 | 10 | 12 | 5 | 96 |
| gros-oeuvre | forage | ✅ | C | 18 | 6 | 4 | 4 | 3 | 6 | 6 | 2 | 49 |
| gros-oeuvre | enrobes | ✅ | C | 18 | 6 | 4 | 4 | 3 | 6 | 6 | 2 | 49 |
| specialises | piscine | ✅ | B | 35 | 12 | 9 | 7 | 6 | 10 | 12 | 5 | 96 |
| specialises | serrurerie-metallerie | ✅ | B | 35 | 12 | 9 | 7 | 6 | 10 | 12 | 5 | 96 |
| specialises | automatismes-portails | ✅ | B | 35 | 12 | 9 | 7 | 6 | 10 | 12 | 5 | 96 |
| specialises | vitrerie | ✅ | B | 35 | 12 | 9 | 7 | 6 | 10 | 12 | 5 | 96 |
| specialises | ferronnerie | ✅ | B | 35 | 12 | 9 | 7 | 6 | 10 | 12 | 5 | 96 |
| specialises | paysagisme | ✅ | B | 35 | 12 | 9 | 7 | 6 | 10 | 12 | 5 | 96 |
| specialises | cloture | ✅ | C | 18 | 6 | 4 | 4 | 3 | 6 | 6 | 2 | 49 |
| specialises | arrosage | ✅ | C | 18 | 6 | 4 | 4 | 3 | 6 | 6 | 2 | 49 |
| specialises | terrasse-bois | ✅ | C | 18 | 6 | 4 | 4 | 3 | 6 | 6 | 2 | 49 |
| specialises | ascenseur | ✅ | B | 35 | 12 | 9 | 7 | 6 | 10 | 12 | 5 | 96 |
| specialises | ramonage | ✅ | C | 18 | 6 | 4 | 4 | 3 | 6 | 6 | 2 | 49 |
| specialises | desamiantage | ✅ | B | 35 | 12 | 9 | 7 | 6 | 10 | 12 | 5 | 96 |
| specialises | traitement-charpente | ✅ | B | 35 | 12 | 9 | 7 | 6 | 10 | 12 | 5 | 96 |
| specialises | hygiene-nuisibles | ✅ | C | 18 | 6 | 4 | 4 | 3 | 6 | 6 | 2 | 49 |
| specialises | nettoyage | ✅ | C | 18 | 6 | 4 | 4 | 3 | 6 | 6 | 2 | 49 |
| specialises | diagnostic | ✅ | B | 35 | 12 | 9 | 7 | 6 | 10 | 12 | 5 | 96 |
| specialises | cordiste | ⏸ | C | 18 | 6 | 4 | 4 | 3 | 6 | 6 | 2 | 49 |
| specialises | cuvelage | ⏸ | C | 18 | 6 | 4 | 4 | 3 | 6 | 6 | 2 | 49 |
| specialises | paratonnerre | ⏸ | C | 18 | 6 | 4 | 4 | 3 | 6 | 6 | 2 | 49 |
| specialises | antenniste | ⏸ | C | 18 | 6 | 4 | 4 | 3 | 6 | 6 | 2 | 49 |
| specialises | home-staging | ⏸ | C | 18 | 6 | 4 | 4 | 3 | 6 | 6 | 2 | 49 |

## Sous-totaux par Collection

| Collection | Livres | Items (cible V1) |
|---|---|---|
| fluides | 8 | 960 |
| electricite | 8 | 644 |
| finition | 8 | 1 024 |
| enveloppe | 10 | 1 105 |
| gros-oeuvre | 7 | 642 |
| specialises | 21 | 1 499 |
| **Total** | **62** | **5 874** |

## Totaux par type de contenu

| Type | Cible V1 |
|---|---|
| Cards | 2 164 |
| Diagnostics | 732 |
| Procédures | 540 |
| Check-lists | 440 |
| Kits | 366 |
| Phrases | 608 |
| FAQ | 732 |
| REX | 292 |
| **Total** | **5 874** |

## Domaines critiques (priorité qualité + sécurité)

Sécurité/normes fortes → validation la plus stricte (sources A/B obligatoires,
double relecture métier) : **gaz/chauffage, électricité, désamiantage, couverture/
travaux en hauteur, cordiste, assainissement, ascenseur, piscine (électricité de
bassin)**. Ces Livres commandent une exigence de source renforcée
([SOURCE_POLICY](../backend/knowledge_corpus/factory/SOURCE_POLICY.md)).

## Note sur les « centaines de milliers »

Les **5 874** items sont la cible **Corpus V1** (un Livre « solide » par métier).
Le patrimoine mûr (V2→V3) multiplie ce socle par les **variantes** (marques,
matériaux, configurations), l'**axe équipement** (ex. PAC transversale), la
**régionalisation** et les **retours terrain** accumulés — la trajectoire vers
plusieurs **centaines de milliers** de connaissances se fait par densification de
ce socle, jamais par élargissement hors taxonomie (invariant Livre n°1).
