# Protocole de certification du Gold Standard — v1.0

**La preuve que la référence est fiable.** L'oracle démontre que le moteur est
fidèle *au Gold Standard*. Ce protocole démontre que le *Gold Standard lui-même*
est correct — sans quoi tout le benchmark certifie dans le vide.

> ARTIZEN n'est pas validé sur un corpus de référence *supposé* correct. Il est
> validé sur un corpus de référence **certifié et reproductible**.

C'est un document de gouvernance, pas de code. Il est figé avant la Brique 4 et
s'applique à chaque document qui prétend devenir une vérité de référence.

---

## 1. Le principe — Double Gold

Une référence n'est **jamais** la reconstruction d'une seule personne. C'est un
**Double Gold** : deux reconstructions indépendantes du même PDF, comparées.

```
PDF ──▶ Gold A     (annotateur 1, indépendamment)
PDF ──▶ Gold B     (annotateur 2, indépendamment)
        Gold A ──vs── Gold B  →  accord
```

* **Accord élevé** → la référence est **certifiée** : deux personnes ont vu la
  même chose, l'erreur individuelle est écartée.
* **Désaccord** → **révision** : on ne fait jamais confiance à une référence sur
  laquelle deux annotateurs divergent.

La mesure d'accord réutilise **le même oracle** que la fidélité : on rend Gold A
et Gold B, on compare les deux rendus. C'est le **6ᵉ KPI — accord
inter-annotateurs**. Plus il est élevé, plus le corpus est crédible.

Seuil de certification : **accord ≥ 99,0 %**
([`gold_standard.py`](gold_standard.py), `AGREEMENT_THRESHOLD`).

> **Ce seuil est empirique et provisoire.** 99,0 % est un point de départ, pas
> une vérité : tant qu'il n'existe pas de corpus réel, aucun seuil ne mérite un
> statut de vérité. Il sera **recalibré à partir des premières données** (où se
> situe réellement l'accord de deux bons annotateurs ? 98,5 ? 99,7 ?). Le
> changer = un amendement daté (§8), pas un ajustement discret.

---

## 2. Les trois états — Draft → Reviewed → Certified

Chaque référence porte un `gold_status` au manifeste :

| État | Signification | Transition |
|---|---|---|
| **Draft** | un Gold (A) a été rédigé | `set_gold_status(..., "draft")` |
| **Reviewed** | relu par un humain, **ou** A/B en désaccord à résoudre | `set_gold_status(..., "reviewed")` |
| **Certified** | deux Golds indépendants s'accordent ≥ seuil | **uniquement** `certify_gold_standard(...)` |

**Seuls les documents `certified` entrent dans le benchmark officiel**
(`python benchmark.py --official`). Un `draft` ou un `reviewed` peut servir au
développement, jamais à prononcer un chiffre officiel.

`certified` ne peut **pas** être posé à la main : `set_gold_status` le refuse. Il
s'obtient, il ne se déclare pas.

---

## 3. Comment un Gold est créé

1. Le PDF réel est ingéré (anonymisé) → `pending_extraction` au manifeste.
2. Un **annotateur 1** produit **Gold A** : `<id>.artizen.json` + `<id>.data.json`
   (le template + les valeurs des zones variables). État → `draft`.
3. Un **annotateur 2**, **sans voir Gold A**, produit **Gold B** :
   `<id>.gold-b.artizen.json` + `<id>.gold-b.data.json`.

L'indépendance de A et B est la condition de validité : si B est copié de A,
l'accord ne prouve rien.

---

## 4. Qui valide, et comment les désaccords sont résolus

* La certification est **automatique et mesurée** : `certify_gold_standard`
  calcule l'accord A/B. C'est la machine qui tranche sur le seuil, pas une
  opinion.
* **Accord ≥ 99 %** → `certified`, et le rendu de Gold A est **gelé** en
  `<id>.expected.pdf` (la cible de non-régression).
* **Accord < 99 %** → `reviewed`. Un humain examine *où* A et B divergent (le
  comparateur liste les écarts, pire d'abord), corrige la reconstruction fautive,
  puis relance la certification. Tant que l'accord n'est pas atteint, la
  référence **n'entre pas** dans le benchmark officiel.

### Le troisième niveau — l'arbitre (prévu, non implémenté en v1.0)

Deux annotateurs ne suffisent pas *toujours* : parfois A et B incarnent deux
interprétations légitimes mais différentes, et le désaccord ne se résout pas par
correction. Les corpus scientifiques prévoient alors un **arbitre** :

```
Gold A ─┐
        ├─ désaccord ──▶ Arbitre ──▶ Gold final (certifié)
Gold B ─┘
```

Un troisième annotateur, plus expérimenté, tranche et produit la référence
finale. **Non implémenté en v1.0** (inutile sans corpus), mais inscrit ici pour
que deux interprétations divergentes ne deviennent jamais un *blocage* : la voie
de sortie existe, réservée pour le jour où un désaccord réel l'exigera.

---

## 5. Quand une référence devient officielle

Une référence est officielle quand — et seulement quand — `gold_status ==
certified`. À cet instant :

* `gold_standard: true` au manifeste,
* `<id>.expected.pdf` gelé,
* le document compte dans `python benchmark.py --official`.

---

## 6. Comment une référence peut être révisée

Une vérité de référence n'est pas immuable, mais sa révision est **tracée** :

1. Rouvrir la référence (nouveau Gold B, ou correction motivée d'un Gold).
2. La faire **repasser** par `certify_gold_standard`.
3. Une révision qui change l'`expected.pdf` change l'empreinte du benchmark
   (§ Replay) : la rupture de continuité est donc **visible et datée**, jamais
   silencieuse.

Toute révision d'une référence certifiée doit être justifiée (une erreur trouvée
dans l'original, une évolution du format), exactement comme un amendement à la
[constitution d'extraction](EXTRACTION_SPEC.md).

---

## 7. Pourquoi c'est l'innovation d'ARTIZEN

Le moteur évoluera, les heuristiques changeront, l'IA changera. Ce qui reste
stable, c'est le **laboratoire de validation** : corpus certifié, oracle,
benchmark reproductible, gouvernance. Tant que le laboratoire tient, on peut
remplacer n'importe quel composant **sans perdre la confiance dans les
résultats**. C'est cela qui est difficile à copier — pas le format, pas le moteur.

---

## 8. Statut

**v1.0 — figée.** Toute évolution du protocole (seuil d'accord, états, règles de
révision) exige une nouvelle version datée et motivée.
