# Programme P1 — Reproduction des PDF natifs — Rapport de clôture

> **Nature de ce document.** Ce n'est ni un README, ni une documentation
> technique, ni un texte marketing. C'est le **rapport de clôture d'un programme
> de R&D**. Il est factuel, daté, mesuré, et raconte les échecs autant que les
> réussites. Objectif : qu'une personne arrivant dans le projet dans un an
> comprenne *ce que nous voulions démontrer, comment nous l'avons démontré, et
> pourquoi le moteur P1 est aujourd'hui considéré comme mature.*
>
> **Date de clôture : 2026-07-25.** Période du programme : 2026-07.
> Périmètre : **reproduction fidèle des devis PDF *natifs*** (texte extractible).
> Les PDF image/scan relèvent de **P2** (§7, §10).
>
> Sources primaires (vérité du programme, non résumées ici) :
> [EXPERIMENTS.md](../backend/app/document_clone/EXPERIMENTS.md) ·
> [DECISION_LOG.md](../backend/app/document_clone/DECISION_LOG.md) ·
> [UNKNOWNS.md](../backend/app/document_clone/UNKNOWNS.md) ·
> [PERFORMANCE_HISTORY.md](../backend/app/document_clone/PERFORMANCE_HISTORY.md) ·
> [EXTRACTION_SPEC.md](../backend/app/document_clone/EXTRACTION_SPEC.md) ·
> [REPRODUCTION_SPEC.md](../backend/app/document_clone/REPRODUCTION_SPEC.md).

---

## 1. Vision initiale

**Pourquoi P1 a existé.** La promesse d'ARTIZEN ([BRAND.md](BRAND.md)) est
*« ARTIZEN retrouve votre identité et la restitue dans chacun de vos devis. »* La
règle d'or qui en découle (ADR-019) est impitoyable : *« Je ne vois pas la
différence avec le mien. »* Cette promesse n'a de sens que si l'on sait, à partir
d'un ancien devis, **reproduire le document à l'identique** — pas « refaire un
devis qui ressemble », mais **reconstruire le même document**.

**La question à résoudre.** *Est-il techniquement possible, à partir d'un devis
PDF natif quelconque, de produire un PDF que l'artisan ne distingue pas de
l'original — et de le **prouver par la mesure**, pas par l'impression ?*

**Le pari.** Ne pas s'appuyer sur une IA qui « devine » un rendu (coûteux, non
reproductible), mais sur un **protocole déterministe** : extraire la description
graphique exacte du PDF, la compiler dans un format propriétaire (`.artizen`), et
la **redessiner** — chaque décision guidée par un **oracle de fidélité** mesurable.

---

## 2. Les inconnues initiales

Au départ, le programme n'avait pas des « fonctionnalités à coder » mais des
**inconnues à lever** (registre [UNKNOWNS.md](../backend/app/document_clone/UNKNOWNS.md)).
Les principales, et leur sort :

| Inconnue | Pourquoi elle existait | Comment elle a été levée |
|---|---|---|
| **Extraction PDF** | Un PDF natif encode des opérateurs, pas une structure ; savoir en tirer position/police/couleur exactes n'allait pas de soi | Extracteur géométrique (PyMuPDF) transcrivant chaque *span* à sa bbox (E-004) |
| **Format `.artizen`** | Il fallait un modèle qui *sépare* ce qui se rend, ce qui varie, ce qui se calcule | Format 3 couches figé (ADR-003) : graphique / métier / comportemental |
| **Renderer** | Redessiner par coordonnées absolues, sans rien recomposer | Renderer déterministe (ADR-001, construit *avant* l'extraction) |
| **Multipage** | Les vrais devis font 2, 3, 11 pages ; le format était mono-page | `GraphicPage` + boucle `showPage` (U-012 → E-006) |
| **Benchmark / Oracle** | « Ça marche sur mon PDF » ne prouve rien ; il fallait un juge objectif | Oracle PDF↔PDF (ADR-004) + benchmark reproductible (Replay, ADR-008) |
| **Typographie** | Les polices d'origine sont souvent absentes ou propriétaires | Substitut métrique libre + **mise à l'échelle** à la largeur d'origine (U-013 → E-007, E-012) |
| **Images** | Logos, pictos, signatures : combien sont vraiment restitués ? | Extraction de tous les placements + oracle **perceptuel** (U-015 → E-009, E-010, E-013) |
| **Tables** | Sont-elles détectables *géométriquement* ? | Partiellement : couvertes par la fidélité texte+position ; détection dédiée non nécessaire pour atteindre Platine |
| **Représentativité** | 1 ou 2 PDF ne prouvent pas la généralité | Starter Corpus de **5 familles** (ADR-012 → E-011) |

Restées **ouvertes et hors P1** : anonymiseur PII (U-006), scans/OCR (U-003, U-016
→ P2), accord inter-annotateurs à 99 % non éprouvé faute de second annotateur
(U-002).

---

## 3. Chronologie

Chaque étape : objectif → résultat → enseignement.

1. **Renderer déterministe (d'abord).** *Objectif :* fixer la cible avant
   l'extraction (ADR-001). *Résultat :* un renderer pur `(template, données) →
   PDF`. *Enseignement :* réduire une inconnue à la fois — l'extraction sait ce
   qu'elle doit produire.
2. **Format `.artizen` + Oracle + Benchmark.** *Objectif :* un modèle générique et
   un juge mesurable. *Résultat :* format 3 couches, comparateur pondéré (7 axes),
   Replay reproductible. *Enseignement :* la mesure devient la boussole, pas
   l'intuition.
3. **Première extraction réelle (E-004).** *Objectif :* transcrire un vrai PDF.
   *Résultat :* Chapot 87,3 %, SJE 71,3 %. *Enseignement :* la géométrie seule
   suffit pour Structure/Mise en page/Couleurs ; restent typographie et multipage.
4. **Multipage (E-006).** *Objectif :* reproduire *n'importe quel* devis.
   *Résultat :* Chapot 90,8 % (Bronze), pagination réparée. *Enseignement :* un
   score bas peut être *artificiel* (une page 2 non mesurée le masquait).
5. **Substitut typographique (E-007).** *Résultat :* rendu plus fidèle mais **score
   en baisse** (84 %). *Enseignement décisif :* **le facteur limitant n'était plus
   le moteur, mais la mesure** (voir §4).
6. **Refonte de l'oracle (E-008, E-010).** *Objectif :* mesurer la perception, pas
   l'étiquette. *Résultat :* Chapot 96,8 %, SJE 98,7 %. *Enseignement :* un oracle
   se corrige comme un moteur.
7. **Budget d'erreur.** *Objectif :* laisser **la donnée choisir** le sprint
   suivant. *Résultat :* priorisation objective, sans débat. *Enseignement :* le
   labo se pilote comme un codec — on attaque la plus grosse perte.
8. **Généralisation (E-011).** *Objectif :* prouver au-delà de 2 familles.
   *Résultat :* 5 familles, **aucune ne s'effondre**, typographie = 66 % du budget
   *général*. *Enseignement :* la maturité, c'est *aucun effondrement*, pas un 100 %.
9. **Typographie (E-012).** *Résultat :* mise à l'échelle horizontale → 4 natifs à
   99,6–99,9 %. *Enseignement :* la bonne technique est simple et absorbe *toutes*
   les polices.
10. **Images (E-013).** *Résultat :* remplir la bbox exacte → SJE **100 % Platine**.
    *Enseignement :* le dernier point vient souvent d'un détail de rendu (aspect
    ratio), pas d'un grand chantier.
11. **Reconnaissance (Décision 8, produit).** *Objectif :* que l'artisan *vive* la
    promesse. *Résultat :* un écran qui *reconnaît* l'entreprise. *Enseignement :*
    la valeur perçue se joue en quelques secondes, pas dans le benchmark.

---

## 4. Les expériences qui ont changé le programme

On ne recopie pas les 13 fiches ; on garde celles qui ont *réellement* infléchi le
projet, **échecs compris** — un résultat négatif est une réussite scientifique
quand il élimine une mauvaise direction.

- **E-005 — embarquer les polices (INFIRMÉE).** *Hypothèse :* réutiliser la fonte
  du PDF donnerait la typographie exacte. *Résultat :* **régression** 87,3 → 72,1 %
  (la Structure s'effondre). *Décision :* revert. *Valeur :* a fermé une fausse
  piste et lancé l'étude typographique. **Honnêteté :** le diagnostic initial
  (« fontes sous-ensemblées ») s'est révélé **faux** — le recensement a montré des
  fontes *complètes* ; la vraie cause était le ré-encodage à la sortie. L'erreur
  est consignée, pas masquée.
- **E-007 — substitut métrique (le « faux échec »).** *Hypothèse :* un substitut
  libre suffirait. *Résultat :* rendu plus fidèle **mais score plus bas**, parce
  que l'oracle comparait des *noms* de police. *Décision :* **garder le renderer,
  corriger l'oracle.** *Valeur :* la découverte la plus importante du programme —
  la mesure était devenue le goulot.
- **E-008 — oracle perceptuel.** *Hypothèse :* comparer taille/graisse/**largeur
  rendue** plutôt que le nom. *Résultat :* Chapot 84 → 93,8 % *sans toucher le
  renderer*. *Décision :* adopté. *Valeur :* la fidélité mesurée rejoint enfin la
  perception.
- **E-009/E-010 — images : le rendu était bon, la mesure fausse.** *Résultat :*
  `get_images` comptait des ressources *jamais dessinées* ; l'oracle passe aux
  objets réellement peints (`get_image_info`). *Décision :* adopté. *Valeur :* même
  schéma qu'E-007, appliqué aux images.
- **E-011 — généralisation.** *Résultat :* 5 familles à 96,8–100 %. *Décision :*
  débloque le sprint typographie (ADR-021). *Valeur :* la preuve que l'architecture
  tient hors des 2 premiers devis.
- **E-012 — mise à l'échelle horizontale (CONFIRMÉE après infirmation).** *Hypothèse
  1 (infirmée) :* la police exacte réduit l'écart → aucun effet. *Hypothèse 2
  (confirmée) :* mettre le texte à l'échelle de la largeur d'origine. *Résultat :*
  4 natifs à 99,6 %+. *Valeur :* un point ne se force pas en relâchant la mesure,
  il se gagne en rendant le texte *réellement* à la bonne largeur.

---

## 5. Les principaux ADR

Décisions fondatrices ([DECISION_LOG.md](../backend/app/document_clone/DECISION_LOG.md)) —
pourquoi, et ce qu'elles ont changé.

| ADR | Pourquoi | Ce que ça a changé |
|---|---|---|
| 001 | Le renderer fixe la cible de l'extraction | Une inconnue traitée à la fois |
| 002 | L'IA comprend, ne dessine pas | Rendu reproductible, sans coût par document |
| 003 | `.artizen` 3 couches | Généricité (devis → facture → avoir…) |
| 004 | Oracle PDF↔PDF, juge unique | Pilotage par la mesure, pas l'impression |
| 005 | Développer contre un corpus **réel** | Éviter le biais du premier PDF |
| 007 | Constitution d'extraction figée *avant* le code | Évolution contrôlée du moteur |
| 008 | Replay (benchmarks rejouables) | « v0.8 a fait baisser X de 99,3 à 98,9 » sans ambiguïté |
| 013 | Deux natures de code (infra stable / `extraction/` expérimental) | Une expérience ne contamine pas les fondations |
| 016 | Objectif = **réduire l'incertitude** | La vérité vient des données |
| 019 | Règle d'or *« je ne vois pas la différence »* | Loi suprême du renderer |
| 020 | Deux modes (identité appliquée / restitution fidèle) | Honnêteté : ne pas faire passer l'un pour l'autre |
| 021 | Optimisations fines **après** le Starter Corpus | Ne pas optimiser 2 PDF quand il en faut des centaines |

*(ADR-006, 009-012, 014-015, 017-018 : anonymiseur, Double Gold, gouvernance des
références, critères de sortie, périmètre gelé, renommage du programme, deux
produits — voir le journal.)*

---

## 6. Les résultats obtenus (faits, sans embellissement)

**Benchmark final — 4 devis natifs (P1), oracle actuel, renderer déterministe :**

| Devis | Logiciel | Fidélité | Structure | Typographie | Images | Badge |
|---|---|---|---|---|---|---|
| Chapot | Mediabat | 99,8 % | 100 | 98,5 | 100 | Platine |
| SJE | Solabaie | 100 % | 100 | 100 | 100 | Platine |
| Pneu | (autre) | 99,6 % | 100 | 97,7 | 100 | Platine |
| Poêle à bois | (autre) | 99,9 % | 99,8 | 100 | 99,9 | Platine |

- **Généralisation :** 4 familles natives différentes, **toutes en Platine** (≥ 99,5).
  *Aucune ne s'effondre.* Aucune heuristique spécifique à un logiciel.
- **Stabilité / reproductibilité :** moteur déterministe, entrées épinglées
  (`content_hash`), `benchmark.py --replay`.
- **Tests :** **742 verts** (backend 568 + frontend 174) au 2026-07-25, 0 régression.
- **Trajectoire mesurée** (document de référence Chapot) : 87,3 → 90,8 → *84,0
  (correction d'oracle)* → 93,8 → 96,8 → **99,8 %**. Détail :
  [PERFORMANCE_HISTORY.md](../backend/app/document_clone/PERFORMANCE_HISTORY.md).

**Réserve honnête.** Ces chiffres sont ceux du **moteur de R&D** (chaîne
`document_clone` : extracteur → `.artizen` → renderer → oracle). Ils prouvent que
la reproduction native est atteignable et la mesurent. Leur **intégration dans le
parcours d'import livré** (Mode 2 en production) est une étape *produit*, distincte
de la démonstration P1 (§10).

---

## 7. Ce qui est volontairement hors périmètre

P1 traite **uniquement la reproduction des PDF natifs** (texte extractible). Sont
**explicitement hors P1** :

- **PDF image / scan** — pas de texte extractible, tout est raster. Le devis
  « Fenêtre Diffusion » du corpus en est un : il obtient 100 % de façon *triviale*
  (on reproduit l'image), ce qui **ne mesure pas** le moteur texte. → **Programme
  P2** (OCR / reconstruction), gouvernance et **KPI séparés** (U-016).
- **OCR** — reconnaissance de caractères : autre problème (erreurs de lecture,
  glyphes manquants, tableaux reconstruits). → P2.
- **Factures, avoirs, contrats, bons d'intervention** — le format `.artizen` est
  générique par conception (ADR-003), mais le périmètre a été **gelé aux devis**
  (ADR-015) jusqu'à maîtrise complète de la boucle. → programmes futurs.
- **Détection de tables dédiée**, **fonte reconstruite non-subsettée** (voie A),
  **fingerprint inter-comptes** — non nécessaires pour atteindre Platine en P1 ;
  laissés comme évolutions incrémentales optionnelles.

---

## 8. Les enseignements

**Ce qui nous a surpris.**
- **Le moteur n'était pas le principal problème — la mesure l'était** (E-007). Deux
  fois (typographie *puis* images), un rendu correct était *sous-évalué* par un
  oracle qui comptait des artefacts techniques (noms de police, ressources PDF)
  plutôt que ce que l'œil voit.
- **Le texte lettre-espacé** (Mediabat, « S A R L ») cassait l'extraction *par
  regex* mais **ne gêne pas la reproduction** : on le recopie verbatim.
- **Le dernier point** (SJE 99,2 → 100) venait d'un `preserveAspectRatio` mal placé,
  pas d'un grand chantier.

**Intuitions qui se sont révélées fausses.**
- « Il faut embarquer la police exacte » — **faux** : la métrique et la **mise à
  l'échelle** comptent, pas la famille (E-005, E-012).
- « Les images sont mal rendues » — **faux** : elles étaient bien rendues, c'est le
  comptage qui était faux (E-009).
- Notre propre **diagnostic d'E-005** (« fontes sous-ensemblées ») était erroné ;
  la mesure ultérieure l'a corrigé. *On documente les erreurs.*

**Décisions déterminantes.**
- **ADR-001** (renderer d'abord) et **ADR-004** (oracle juge) : le socle qui a rendu
  tout le reste mesurable.
- **Le budget d'erreur** : passer d'un pilotage par intuition à un pilotage par la
  contribution mesurée à la perte — *les données choisissent le sprint*.
- **ADR-019/020** (règle d'or + deux modes) : ont protégé l'honnêteté (ne jamais
  appeler « restitution » ce qui n'en est pas une).

**Ce que nous referions différemment.** Construire l'**oracle perceptuel plus tôt**
nous aurait épargné les détours des métriques par nom/comptage. Mais ces détours
ont *aussi* forgé la discipline la plus précieuse du labo : **corriger sa propre
mesure**, et considérer un rendu indiscernable au score plus bas comme un signal
d'améliorer l'oracle, jamais de dégrader le renderer.

---

## 9. Critères de clôture

P1 est déclaré **mature** — non parce qu'il est *parfait*, mais parce que :

1. **Les objectifs sont atteints** : reproduction native indiscernable, mesurée, à
   badge Platine sur 4 familles.
2. **Les inconnues critiques sont levées** : extraction, format, renderer,
   multipage, oracle perceptuel, typographie, images (U-010, U-012 à U-015).
3. **Le moteur généralise** : 5 familles, aucune ne s'effondre, sans heuristique
   spécifique (E-011).
4. **Les évolutions restantes sont incrémentales** : les résidus (quelques spans de
   largeur, 3 textes, un logo introuvable par fitz des deux côtés) sont infimes et
   diffus. Aucune n'exige une rupture d'architecture.

Le moteur **continuera d'évoluer**, mais il n'est **plus le facteur limitant du
projet**.

---

## 10. Passage de relais

Le centre de gravité du projet change. P1 a prouvé le **cœur technique** ; la valeur
se joue désormais ailleurs.

**Vers le produit ARTIZEN.** L'artisan ne verra jamais l'oracle ni le `.artizen` ;
il verra *« ARTIZEN a reconnu mon entreprise »*. La priorité devient la **valeur
perçue** : l'écran de reconnaissance (Décision 8), le parcours d'import, et — étape
produit distincte — l'**intégration de la reproduction Mode 2** dans le flux livré.

**Vers le programme P2 (indépendant).** Les PDF image/scan sont un **autre moteur**
(OCR + reconstruction), avec sa **propre gouvernance et ses propres KPI**, jamais
mélangés à ceux de P1. P2 s'ouvrira sur une décision technologique dédiée.

**Pourquoi ce transfert est légitime.** Le laboratoire a rempli sa mission : il a
transformé une inconnue majeure (« est-ce faisable ? ») en une **capacité mesurée
et reproductible**. Ce que le programme laisse derrière lui n'est pas seulement un
moteur — c'est une **méthode** (hypothèse → mesure → décision → ADR, pilotée par le
budget d'erreur) réutilisable pour P2 et les programmes suivants.

> *En une phrase : nous voulions démontrer qu'un artisan ne distinguerait pas son
> devis natif de sa reproduction. Nous l'avons démontré, mesuré, et rendu
> reproductible — et nous savons désormais exactement ce qui reste hors de cette
> preuve.*

---

*Clôturé le 2026-07-25. Ce rapport est un instantané historique : il décrit P1 à sa
clôture et n'a pas vocation à être tenu à jour — les évolutions ultérieures vivent
dans les journaux du moteur et les futurs programmes.*
