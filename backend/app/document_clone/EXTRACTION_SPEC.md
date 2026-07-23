# Spécification d'extraction — v1.0

**La constitution du Programme expérimental d'extraction** (ex-« Brique 4 »). Ce
document est figé *avant* toute ligne de code d'extraction. Il n'est pas une
implémentation : c'est le **contrat scientifique** auquel tout extracteur devra
se conformer, et par lequel tout extracteur sera jugé. Le modifier, c'est amender
la constitution — cela exige une nouvelle version numérotée et justifiée.

> **Ce n'est plus « développer une fonctionnalité ».** L'objectif du programme est
> de transformer progressivement des inconnues ([UNKNOWNS.md](UNKNOWNS.md)) en
> connaissances validées. Le cycle n'est pas *idée → code → correction*, mais :
>
> **Hypothèse → Expérience → Mesure → Décision → ADR (ou évolution de la spec).**

> ARTIZEN ne clone pas un document parce qu'une IA « devine ». Il applique un
> **protocole déterministe**, mesuré par **six KPI**, validé sur un **corpus de
> référence certifié et reproductible**. L'extracteur en est la première étape —
> et la plus strictement disciplinée.

---

## 0. Principe directeur — l'extracteur est *descriptif*, jamais interprétatif

L'extracteur **observe** ce qui est physiquement sur la page et le **transcrit**.
Il ne comprend rien, ne décide rien, n'invente rien. Toute interprétation —
« ceci est un SIRET », « ce nombre est le total TTC », « ces lignes forment un
tableau de prestations » — appartient à la **Brique 5 (IA)**, jamais ici. Cette
frontière est la raison d'être du découpage : *l'extracteur décrit, l'IA
comprend, le renderer redessine*. Chacune est vérifiable isolément.

Corollaire : l'extracteur est une **fonction pure et déterministe** du PDF.
Même PDF → même `.artizen`, octet pour octet (cf. §6, Replay).

---

## 1. Qu'est-ce qu'un bloc ? — la taxonomie des primitives

On distingue deux niveaux. Les **primitives** sont lues directement des
opérateurs du PDF. Les **structures dérivées** sont produites par des relations
*géométriques* (§2) entre primitives — jamais par du sens métier — et gardent
toujours une trace vers les primitives dont elles sont issues.

### 1.1 Primitives (niveau 1 — lues, jamais déduites)

| Primitive | Champs obligatoires | Source PDF |
|---|---|---|
| **TextRun** | `text` (verbatim), `rect` (x,y,w,h pt), `font` (nom embarqué), `size` (pt), `color` (hex), `bold`, `italic`, `baseline` | opérateurs `Tj`/`TJ` + état graphique |
| **Rect** | `rect`, `fill` (hex\|∅), `stroke` (hex\|∅), `stroke_width`, `radius` | `re`/`f`/`S` |
| **Line** | `p0`, `p1`, `stroke`, `width` | `m`/`l`/`S` |
| **Image** | `rect`, `asset_hash` (sha256 des octets), `dpi`, `colorspace` | `Do` (XObject image) |

Repère : **origine en haut à gauche**, unités en **points** (1 pt = 1/72"),
cohérent avec `Rect` du format `.artizen`. Le y-flip vers le repère PDF
bas-gauche est fait par le renderer, pas stocké.

### 1.2 Structures dérivées (niveau 2 — géométrie uniquement)

| Structure | Définition | Contrainte |
|---|---|---|
| **Zone** | région rectangulaire regroupant des primitives voisines (en-tête, bloc adresse, pied) | par proximité/alignement seulement |
| **Table** | grille détectée par un faisceau de `Line`/`Rect` alignés + colonnes de `TextRun` | doit référencer ses lignes et colonnes primitives |
| **Row** / **Cell** | subdivision d'une `Table` par les séparateurs détectés | une cellule = les `TextRun` contenus dans son `rect` |

Une structure dérivée est **réversible** : on doit pouvoir retrouver exactement
les primitives qui la composent. Si la détection d'une table est incertaine, on
**ne la crée pas** — on laisse les primitives brutes (une table ratée est pire
qu'une table absente : cf. §4).

---

## 2. Dans quel ordre extrait-on ? — le pipeline descendant

```
Page  →  Zones  →  Blocs  →  Relations  →  Structure
```

1. **Page** — géométrie, marges, rotation, nombre de pages.
2. **Zones** — découpage géométrique grossier de la page en régions.
3. **Blocs** — lecture des primitives dans chaque zone (§1.1).
4. **Relations** — alignements, contenance, adjacence, colonnes : **géométrie
   pure**, aucun sens.
5. **Structure** — dérivation des tables/cellules à partir des relations (§1.2).

Toujours **du haut vers le bas**, jamais l'inverse. On ne part **jamais** d'une
attente métier (« il doit y avoir un tableau de prestations ») pour aller
chercher des blocs qui la confirment : ce serait de l'interprétation déguisée, et
la source n°1 de fausses détections.

---

## 3. Les invariants — non négociables

1. **Aucune coordonnée inventée.** Tout `rect` provient d'un opérateur du PDF.
2. **Aucune police inventée.** Le `font` est le nom embarqué. Une police
   substituée (introuvable) est **signalée**, jamais choisie en silence (§4).
3. **Aucun texte modifié.** `text` est verbatim : espaces, casse, ligatures,
   caractères spéciaux conservés. *La normalisation n'existe que pour la
   comparaison* (dans le comparateur), jamais dans le modèle stocké.
4. **Aucune fusion automatique de blocs.** Deux `TextRun` adjacents restent deux
   `TextRun`. Un regroupement n'existe que sous forme de structure dérivée
   explicite et réversible (§1.2), avec sa règle enregistrée.
5. **Aucune interprétation métier.** Rôles, champs, montants, calculs → Brique 5.
6. **Déterminisme.** Même entrée → même sortie, octet pour octet. L'ordre de
   sérialisation est canonique (tri stable), jamais dépendant de l'itération d'un
   ensemble.
7. **Traçabilité.** Toute structure dérivée pointe vers ses primitives sources.

---

## 4. Quelles erreurs sont acceptables ? — les seuils

Le tableau distingue ce qui **casse une extraction** (perte ou déformation
d'information) de ce qui est **toléré** (imperceptible ou informationnellement
neutre).

| Écart | Verdict | Seuil |
|---|---|---|
| Fusion de deux `TextRun` distincts | ❌ **Interdit** | — |
| Perte d'un `TextRun` non vide | ❌ **Interdit** | — |
| Perte d'une `Image` | ❌ **Interdit** | — |
| Texte modifié (même 1 caractère) | ❌ **Interdit** | — |
| Table erronée (mauvais découpage) | ❌ **Interdit** (mieux vaut pas de table) | — |
| Coordonnée approximative | ✅ Toléré | écart ≤ **0,1 pt** |
| Taille de police approximative | ✅ Toléré | écart ≤ **0,25 pt** |
| Couleur approximative | ✅ Toléré | **ΔE\*ab (CIE76) < 2,0** |
| Police substituée (métriques équivalentes) | ⚠ Toléré mais **signalé** | baisse le KPI *Polices* |
| Ordre de lecture des blocs | ✅ Sans impact | comparaison géométrique |

**ΔE\*ab** = distance euclidienne dans l'espace CIE L\*a\*b\*. Un ΔE < 1 est
imperceptible à l'œil ; < 2 reste indétectable en usage courant. C'est le seuil
d'acceptation couleur.

> **Écart connu spec ↔ implémentation.** Le comparateur v1
> ([`comparator.py`](comparator.py)) approxime la tolérance couleur par une
> **quantification à 16 niveaux/canal**, pas encore par un vrai ΔE\*ab. Le
> passage à ΔE\*ab < 2,0 est une évolution *planifiée* du comparateur, à traiter
> avant de certifier une source en Or/Platine. C'est le seul point où l'oracle
> n'implémente pas encore le seuil de cette spec.

---

## 5. Comment mesurer le succès ? — une métrique par sous-système

On **ne se contente pas du score global**. Chaque sous-système a sa propre
mesure, pour savoir *où* le moteur progresse ou régresse :

| Sous-système | Métrique | Catégorie de l'oracle |
|---|---|---|
| Texte extrait | rappel : % des `TextRun` présents | **Structure** (33 %) |
| Coordonnées | proximité moyenne des blocs appariés | **Mise en page** (27 %) |
| Polices | % des paires (police, taille) exactes | **Typographie** (16 %) |
| Couleurs | % conformes (ΔE < 2,0) | **Couleurs** (11 %) |
| Images | % présentes (nombre + position) | **Images** (6 %) |
| Rectangles / Lignes | % des formes présentes | **Couleurs/Formes** |
| Pagination | même nombre de pages | **Pagination** (7 %) |

Ces sept axes **sont déjà** ceux du comparateur pondéré : la spec ne réclame donc
aucun nouvel outil de mesure, elle **nomme le contrat** que l'oracle applique
déjà. Le score global pondéré → badge de certification : **Bronze ≥ 90 · Argent
≥ 95 · Or ≥ 98 · Platine ≥ 99,5**. Les cinq KPI produit (Fidélité, Couverture,
Confiance, Temps de validation, Auto-pass) agrègent ces mesures au niveau du
corpus ([Corpus/README](../../Corpus/README.md)).

Exemple de rapport par sous-système visé sur un Gold Standard :

```
Texte extrait   99,8 %
Images         100,0 %
Rectangles     100,0 %
Polices         99,4 %
Coordonnées     99,7 %
Couleurs        99,9 %
→ Fidélité      99,6 %   (Or)
```

---

## 6. Reproductibilité — le Replay

Chaque benchmark est **rejouable**. Deux garanties le rendent possible :

* **Entrées épinglées** — chaque document porte le sha256 de ses octets
  (`content_hash`) ; un run est donc lié à des fichiers exacts.
* **Moteur déterministe** — pas d'horloge, pas d'aléa, rendu et comparaison
  purs, tri de sortie canonique.

D'où une **empreinte de run** (`fingerprint`, sur *hash d'entrée + scores KPI*) :
deux runs sur des entrées et un code identiques donnent la **même empreinte**.

```
docker compose exec backend python benchmark.py --label v0.8
docker compose exec backend python benchmark.py --replay     # ✓ reproduit run #47
```

On peut alors affirmer **sans ambiguïté** : *« la version 0.8 a fait baisser
Batappli de 99,3 à 98,9. »* — parce que le run #47 est reproductible à
l'identique et que seule une modification du code (ou du corpus) peut changer
l'empreinte.

---

## 7. Processus — le programme expérimental d'extraction

Une fois cette spec figée, et **seulement ensuite** :

```
Starter Corpus (5 devis réels très différents)
   → Première extraction (contre CE corpus, jamais synthétique)
   → Benchmark  →  Corrections  →  Benchmark  →  Corrections  →  …
```

Règle de gouvernance permanente : **aucune heuristique d'extraction n'est écrite
sans un document réel qui la justifie** (voir la mémoire projet). Chaque
itération est mesurable (§5), comparable (§6) et objectivement justifiable.

---

## 8. Statut

**v1.0 — figée.** Toute évolution des primitives, de l'ordre, des invariants ou
des seuils exige une nouvelle version (v1.1, v2.0…), datée et motivée. C'est ce
qui permet à la Brique 4 d'évoluer de façon *contrôlée*, sans jamais remettre en
cause les fondations mesurées de la plateforme.
