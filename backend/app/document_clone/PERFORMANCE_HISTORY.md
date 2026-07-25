# Historique des performances du moteur de reproduction

> La preuve, dans un tableau : **chaque amélioration est mesurée, reproductible,
> justifiée, et sans régression cachée.** Dans un an, cette page montre que la
> qualité n'a pas été *affirmée* — elle a été *franchie*, étape par étape, sur un
> corpus réel.

**À lire avec une clé de lecture honnête.** Deux choses ont progressé en
parallèle, et il ne faut pas les confondre :

- le **moteur** (extraction + renderer) — la fidélité *réelle* du rendu ;
- l'**oracle** (la mesure) — la fidélité de *ce que l'on mesure* à la perception.

Certaines étapes améliorent le moteur ; d'autres améliorent la mesure. Une fois
même (E-007), la fidélité **a baissé** — non parce que le rendu s'était dégradé,
mais parce que l'oracle a **cessé de récompenser une ressemblance illusoire**
(nom de police). Le laboratoire qui **corrige sa propre mesure** est plus
crédible qu'un chiffre qui ne monte jamais.

## Trajectoire (document de référence : Chapot / Mediabat, présent à chaque run)

| Étape | Corpus | Fidélité | Structure | Typographie | Images | Levier | Ce qui change |
|---|---|---|---|---|---|---|---|
| E-004 | 2 | 87,3 % | 100 | 42,9 | 100 | moteur | 1re extraction réelle (mono-page ; oracle *nom* + page 0) |
| E-006 | 2 | 90,8 % | 100 | 42,9 | 100 | moteur | reproduction **multipage** |
| E-007 | 2 | 84,0 % | 100 | **0** | 100 | moteur | substitut métrique libre — *typo mise à 0 par l'oracle **nom** : artefact de mesure, pas une régression* |
| E-008 | 2 | 93,8 % | 98,5 | 83,3 | 50 | **oracle** | typo par **métriques** (plus par nom) + **toutes les pages** |
| E-010 | 2 | 96,8 % | 98,5 | 83,3 | 100 | **oracle** | images **perceptuelles** (objets dessinés, pas ressources) |
| E-011 | **5** | 96,8 % | 99,2 | 83,3 | 100 | corpus | **généralisation** : 5 familles, aucune ne s'effondre |
| E-012 | 5 | **99,8 %** | 100 | **98,5** | 100 | moteur | typo : **mise à l'échelle** à la largeur d'origine |

*Fidélité = score pondéré global de l'oracle **en vigueur à cette étape** (le
badge : Bronze ≥ 90 · Argent ≥ 95 · Or ≥ 98 · Platine ≥ 99,5).*

## Où en est le corpus complet (P1 — devis natifs, oracle actuel)

Après E-012, l'oracle **actuel** appliqué aux 4 devis natifs :

| Devis | Fidélité | Structure | Typographie | Images | Badge |
|---|---|---|---|---|---|
| Chapot (Mediabat) | 99,8 % | 100 | 98,5 | 100 | **Platine** |
| SJE (Solabaie) | **100 %** | 100 | 100 | 100 | **Platine** |
| Pneu | 99,6 % | 100 | 97,7 | 100 | **Platine** |
| Poêle à bois | 99,9 % | 99,8 | 100 | 99,9 | **Platine** |

Après E-013 (bbox image remplie) : **4 devis natifs sur 4 en Platine ou à 99,6 %+**.
Les résidus restants sont infimes et diffus — quelques spans de largeur
(Typographie Pneu/Chapot) et 3 textes (Poêle). Le moteur P1 est **à son plateau**.

> **Deux sous-programmes, deux KPI (ne jamais mélanger).**
> **P1 — PDF natif** (ce tableau) : objectif *reproduction parfaite*.
> **P2 — PDF image / scan** (ex. Fenêtre Diffusion) : objectif *reconstruction*
> (OCR) — programme séparé, métriques séparées ([U-016](UNKNOWNS.md)).

## Reproductibilité

Chaque ligne est **rejouable** : entrées épinglées par `content_hash`, moteur
déterministe, `python benchmark.py --replay`. À terme, ce tableau se
**génère automatiquement** depuis `benchmark_history.json` (tendances déjà
tracées par le Benchmark Engine) plutôt que d'être tenu à la main — c'est le
prochain incrément d'outillage du laboratoire.
