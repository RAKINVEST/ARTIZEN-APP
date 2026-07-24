# Étude — stratégie de reproduction typographique (U-013)

> **Décision d'architecture, pas correctif au fil de l'eau.** Le verrou du moteur
> n'est plus la géométrie (positions ≈ 99,8 % — E-006) ni les couleurs (100 %) :
> c'est la **fidélité typographique**. Et le vrai sujet n'est pas « la police »,
> c'est la **stratégie** de reproduction des polices, car ce choix irrigue tout le
> renderer.
>
> Cette étude **compare** ; elle ne code pas, ne modifie ni le renderer ni
> l'oracle, et ne cherche pas à gonfler un score. Elle se termine par une
> **recommandation argumentée** — mais **la décision appartient au PO**. Le sprint
> U-013 ne démarre qu'une fois cette décision validée.
>
> Rappel du cap : *l'objectif n'est pas de reproduire le **nom** interne des
> polices ; c'est que l'artisan ne distingue pas son devis de sa reproduction.*
> La stratégie retenue sera celle qui **maximise l'indiscernabilité visuelle**.

---

## 1. Les faits mesurés (le socle)

Recensement en lecture seule des polices du corpus (PyMuPDF), et résultats des
expériences déjà menées. **Aucune intuition ici — que du mesuré.**

### 1.1 Chapot (Mediabat) — polices **embarquées et complètes**

| Police | Type PDF | Embarquée | Sous-ensemblée | Extraction |
|---|---|---|---|---|
| Arial | TrueType | **oui** | non (complète) | 38 044 o `.ttf` |
| Arial-Bold | TrueType | **oui** | non | 25 072 o `.ttf` |
| Arial-BoldItalic | TrueType | **oui** | non | 18 276 o `.ttf` |
| Arial-Italic | TrueType | **oui** | non | 11 828 o `.ttf` |
| TimesNewRoman-Bold | TrueType | **oui** | non | 15 904 o `.ttf` |
| Helvetica ×4 | Type1 | non (base14) | — | — |

→ **La voie A (réutiliser l'embarqué) est techniquement possible sur Chapot** :
polices présentes, complètes, extractibles en TTF exploitable.

### 1.2 SJE (Solabaie) — **aucune police embarquée**

15 polices distinctes, **toutes `Arial` (TrueType/Type0), non embarquées** (le PDF
les *référence* mais ne les *contient pas*). Extraction → vide.

→ **La voie A est impossible sur SJE.** Il n'y a rien à réutiliser. Seule une
police système/embarquée par ARTIZEN, métriquement compatible avec Arial, peut
restituer ce document.

### 1.3 Ce que l'échec E-005 et l'analyse Sprint 2 ont montré

- **E-005** (embarquer naïvement les fontes) a **régressé** Chapot 87,3 → 72,1 %
  (Structure 100 → 53,8 %). *Note d'honnêteté :* le recensement 1.1 montre que les
  fontes de Chapot sont **complètes**, pas sous-ensemblées — donc la cause n'est
  **pas** « subset/cmap » comme d'abord supposé. Le mécanisme réel est à confirmer
  (probablement le **ré-encodage à la sortie** par reportlab : il ré-sous-ensemble
  et réencode la fonte dans le PDF produit, et `fitz` relit alors un texte
  différent). **C'est un risque, pas une fatalité** — la voie A mérite un test
  contrôlé, pas d'être écartée.
- **Sprint 2** : la police de repli (Helvetica) provoque deux défauts mesurés —
  (1) caractères absents (`ʼ` U+02BC → `dʼune` mal relu), (2) métriques
  différentes → `fitz` **re-segmente** les spans (`278-0 ter` → `278-0` + `ter`).
  Les deux **disparaîtraient** avec une police aux **bonnes métriques et au bon
  jeu de caractères**.

### 1.4 Le piège de l'oracle (déterminant pour lire les gains)

L'oracle compare les **noms** de police. Conséquence directe sur cette étude :

- une police **réellement Arial** (voie A) → `fitz` relit « Arial » → le score
  Typographie **monte** ;
- une police **métriquement compatible mais nommée autrement** (voie C, ex.
  *Liberation Sans*) → visuellement identique, mais `fitz` relit « Liberation
  Sans » ≠ « Arial » → le score Typographie **reste bas**, alors que
  **l'indiscernabilité visuelle est atteinte**.

C'est exactement le cas « score bas / rendu indiscernable » : il ne devra jamais
faire *dégrader* le renderer, mais *faire évoluer l'oracle* (Sprint 4, U-014/
métriques). **À retenir : le score Typographie actuel n'est pas un juge fiable de
la voie C.** Le juge reste l'œil.

---

## 2. Les stratégies comparées

Chaque voie est jugée sur : principe · avantages · limites · complexité · impact
fidélité · impact juridique · compatibilité avec la promesse ARTIZEN.

### A. Réutiliser la police embarquée quand elle est exploitable

- **Principe.** Extraire la fonte du PDF source, l'embarquer dans le `.artizen`,
  la faire rejouer par le renderer.
- **Avantages.** Fidélité maximale *par nature* (c'est **la** police d'origine) ;
  le nom relu matche → l'oracle actuel la récompense.
- **Limites.** Ne marche **que** si la fonte est embarquée **et** complète — vrai
  pour Chapot, **faux pour SJE** (0 embarquée). Le ré-encodage reportlab en sortie
  a régressé E-005 : à maîtriser (sous-ensemblement de sortie + `ToUnicode`).
- **Complexité.** Moyenne à élevée (contrôler le pipeline d'embarquement/sortie).
- **Impact fidélité.** Très élevé **là où c'est applicable**.
- **Impact juridique.** ⚠ **Réel.** Réextraire et stocker une fonte propriétaire
  (Arial = Monotype) dans le `.artizen`, puis la restituer, peut enfreindre l'EULA
  de la fonte, même pour le document de l'artisan.
- **Compatibilité promesse.** Excellente sur le fond (c'est *sa* police), sous
  réserve du point juridique.

### B. Reconstruire une police complète à partir d'une sous-ensemblée

- **Principe.** Quand la fonte embarquée est partielle, reconstituer les glyphes
  manquants pour obtenir une fonte complète et ré-embarquable.
- **Avantages.** Débloquerait les sources qui n'embarquent qu'un subset.
- **Limites.** Les glyphes absents **n'existent pas** dans le subset : on ne
  « reconstruit » pas ce qui manque sans une source externe de la même fonte — on
  retombe alors sur C. Techniquement lourd et fragile.
- **Complexité.** Élevée.
- **Impact fidélité.** Incertain ; risque d'introduire des glyphes approximés.
- **Impact juridique.** ⚠ Idem A, aggravé (manipulation de la fonte).
- **Compatibilité promesse.** Faible rapport valeur/risque. *Cas d'usage non
  observé dans le corpus actuel* (Chapot est complet, SJE n'embarque rien).

### C. Associer la police PDF à une police système métriquement compatible

- **Principe.** Mapper chaque police nommée vers une fonte **libre** aux
  **métriques identiques** : Arial → *Liberation Sans* / *Arimo* ; Times New Roman
  → *Liberation Serif* / *Tinos*. Ces substituts sont **conçus comme
  drop-in métrique** (mêmes chasses, même crénage) et couvrent l'Unicode (dont
  `ʼ`).
- **Avantages.** Marche **partout**, y compris SJE (non-embarqué). **Corrige les
  deux défauts Sprint 2** (caractères + re-segmentation) car métriques =
  identiques. Licences **propres** (OFL/Apache).
- **Limites.** Ce n'est pas *au glyphe près* la police d'origine (dessin très
  proche, pas identique) ; **le nom relu diffère** → l'oracle actuel ne le
  récompense pas (cf. 1.4). Nécessite d'embarquer ces fontes libres dans l'app.
- **Complexité.** Faible à moyenne (table de correspondance + fontes libres).
- **Impact fidélité.** Élevé **visuellement** ; **sous-évalué** par l'oracle actuel
  (nom).
- **Impact juridique.** ✅ Nul (fontes libres, redistribuables).
- **Compatibilité promesse.** Très bonne : *indiscernabilité visuelle* sans
  dépendre de l'embarquement ni du juridique.

### D. Couche de correspondance typographique propre à ARTIZEN

- **Principe.** Un référentiel ARTIZEN qui, pour chaque police rencontrée, décrit
  la meilleure restitution (substitut, ajustements de graisse/chasse, exceptions
  de glyphes), enrichi au fil du corpus.
- **Avantages.** Capitalise la connaissance ; gère les cas spéciaux ; c'est **C
  industrialisé et gouverné**.
- **Limites.** Prématuré tant qu'on n'a pas mesuré C sur plusieurs familles ; sur-
  ingénierie si C suffit.
- **Complexité.** Élevée (référentiel + gouvernance).
- **Impact fidélité.** Potentiellement le plus haut à terme.
- **Impact juridique.** ✅ Nul si adossé à des fontes libres.
- **Compatibilité promesse.** Excellente à terme ; **pas maintenant** (ADR-016 :
  réduire l'incertitude d'abord, pas ajouter des briques).

### E. *(proposition)* Hybride A→C, décidé par document

- **Principe.** **Si** la fonte est embarquée, complète et **libre de droits** →
  A. **Sinon** → C (substitut métrique). Un seul chemin, deux issues selon le fait
  mesuré du PDF.
- **Avantages.** Prend le meilleur de chaque : la vraie police quand c'est sûr et
  légal, un substitut métrique fidèle partout ailleurs. Couvre **Chapot ET SJE**.
- **Limites.** Deux chemins à tester ; hétérogénéité (certains docs en vraie
  police, d'autres en substitut) — mais chacun indiscernable *pour son document*.
- **Complexité.** Moyenne.
- **Impact fidélité.** Le plus élevé sur l'ensemble du corpus.
- **Impact juridique.** ✅ Maîtrisé (A limité aux fontes libres ; C sinon).
- **Compatibilité promesse.** La meilleure : maximise l'indiscernabilité visuelle
  **sans compromettre la reproductibilité ni la généralisation à l'ensemble du
  corpus** — jamais optimiser Chapot au détriment des futurs EBP/Batappli/Word.

---

## 3. Tableau de synthèse

| Voie | Marche sur SJE ? | Fidélité visuelle | Récompensé par l'oracle actuel | Juridique | Complexité |
|---|---|---|---|---|---|
| A embarqué | ❌ (0 embarqué) | très élevée où applicable | ✅ (nom relu = origine) | ⚠ EULA fonte | moyenne-élevée |
| B reconstruire subset | ❌ | incertaine | partiel | ⚠⚠ | élevée |
| C substitut métrique | ✅ | élevée | ❌ (nom ≠) | ✅ libre | faible-moyenne |
| D couche ARTIZEN | ✅ | la + haute à terme | ❌ (nom ≠) | ✅ | élevée (prématuré) |
| **E hybride A→C** | ✅ | **la + haute** | mixte | ✅ maîtrisé | moyenne |

---

## 4. Recommandation argumentée

**Voie E (hybride A→C), démarrée par C — implémentée comme une *architecture de
résolution des polices*, pas un simple remplacement.** Décidée par le PO. Trois
niveaux, dans cet ordre :

1. **Police embarquée** si complète, exploitable **et** licence permissive (voie A).
2. **Sinon**, substitut **métriquement compatible** couvrant tout l'Unicode
   nécessaire (voie C) — un *fallback intelligent*, jamais une fin en soi.
3. **Conservation** : le `.artizen` garde **toutes** les métadonnées de la police
   d'origine (nom, famille, graisse, italique, taille). La résolution se fait **au
   rendu**, jamais en gravant le substitut dans le modèle — on pourra donc revenir
   à la vraie police si elle devient un jour exploitable.

Justification, mesurée :

1. **C seule couvre déjà tout le corpus** (Chapot *et* SJE) et **corrige les
   défauts Sprint 2** (les métriques Liberation/Arimo = Arial règlent l'apostrophe
   et la re-segmentation). C'est le **plus gros gain visuel pour le plus faible
   risque**, sans aucun problème juridique.
2. **A vient se greffer ensuite**, *uniquement* quand la fonte embarquée est
   complète **et** libre de droits (donc pas Arial/Times → en pratique A servira
   surtout des fontes maison/libres d'autres logiciels). A n'est pas prioritaire
   car, sur le corpus actuel, l'embarqué est soit absent (SJE) soit propriétaire
   (Chapot = Arial).
3. **B et D sont écartées maintenant** : B n'a aucun cas d'usage mesuré ; D est une
   industrialisation prématurée de C (à reconsidérer après mesure sur 5 familles).

> Conséquence assumée : sur Chapot, C rendra l'Arial via *Liberation Sans*. Le
> score **Typographie** de l'oracle **ne montera pas** (nom ≠), mais le **rappel
> texte remontera** (apostrophe + re-segmentation réglées) et surtout le rendu
> deviendra **visuellement indiscernable**. C'est le signal, prévu, qu'il faudra
> **faire évoluer l'oracle** (Sprint 4) — jamais dégrader le renderer.

---

## 5. Plan d'implémentation (à lancer seulement après validation PO)

1. **Bundler** dans l'app les substituts métriques libres (Liberation Sans/Serif
   ou Arimo/Tinos), embarqués en assets — un socle qui couvre Arial/Helvetica/
   Times, soit l'écrasante majorité des devis.
2. **Table de correspondance** `police PDF → substitut` (famille + graisse +
   italique), avec normalisation des noms (`Arial,Bold` → Liberation Sans Bold).
3. **Renderer** : `_font_name` consulte la table et charge le substitut au lieu du
   repli Helvetica base14. *(Modification du moteur — pas de l'oracle.)*
4. **Rejouer le benchmark** Chapot + SJE. Attendu : rappel texte ↑, positions
   maintenues ; Typographie ~inchangée (nom) → **preuve** que l'oracle doit
   évoluer.
5. **Greffe A** (plus tard) : si fonte embarquée complète **et** licence
   permissive détectée → l'embarquer telle quelle ; sinon C. Test contrôlé du
   ré-encodage reportlab (le point qui a fait échouer E-005).

---

## 6. Gains attendus (estimation prudente, à confirmer par mesure)

- **Rappel texte** : retour vers ~100 %/page (les 2–6 % perdus étaient dus au
  repli) → Structure de Chapot et SJE regagne ~2–3 points chacune.
- **Re-segmentation** : disparaît (métriques Arial exactes).
- **Typographie (oracle actuel)** : **peu de gain** tant que l'oracle compare les
  noms — c'est attendu et documenté, pas un échec.
- **Indiscernabilité visuelle** : gain **majeur** (bon dessin + bonnes chasses +
  bons caractères). C'est le seul gain qui compte.

## 7. Risques

- **Oracle trompeur** : la vraie amélioration (C) ne se verra pas dans le score
  Typographie → risque de la croire inutile. *Mitigation :* juger à l'œil +
  planifier l'évolution oracle (Sprint 4).
- **Substitut imparfait** sur des polices exotiques (ni Arial ni Times) : prévoir
  un repli Unicode générique correct, et enrichir la table au fil du corpus (embryon
  de D).
- **Voie A / ré-encodage** : le mécanisme d'échec E-005 doit être élucidé avant
  d'activer A, sous peine de re-régresser.
- **Juridique** : ne jamais activer A sur une fonte propriétaire sans base légale ;
  par défaut, C (libre).

---

## 8. Décision

**En attente de validation PO.** L'étude recommande **E (hybride), démarré par C**.
Une fois la voie choisie, le sprint U-013 démarre sur ce périmètre — et sur lui
seul.
