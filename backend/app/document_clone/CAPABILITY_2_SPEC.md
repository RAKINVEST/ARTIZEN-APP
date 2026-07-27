# Spécification de la Capacité 2 — le modèle documentaire vivant — v1.0

**La constitution de ce qu'ARTIZEN vend réellement.** Troisième document fondateur
du moteur, sœur de la [EXTRACTION_SPEC](EXTRACTION_SPEC.md) (ce qui *décrit* la
page) et de la [REPRODUCTION_SPEC](REPRODUCTION_SPEC.md) (ce qui la *redessine à
l'identique*). Celle-ci régit la **génération** : comment un devis parfaitement
reproduit devient un **modèle vivant** capable de produire *tous les futurs devis
de l'artisan*.

> Elle découle de la [règle d'or de la marque](../../../docs/BRAND.md) et la
> prolonge d'une reproduction vers une génération :
>
> ### « Si l'artisan avait fait ce *nouveau* devis dans son ancien logiciel, serait-il différent ? »
>
> Si la réponse est **non**, la Capacité 2 a réussi.

Figée *avant* toute ligne de code de génération. La modifier, c'est amender la
constitution — une nouvelle version numérotée et justifiée. À graver au
[DECISION_LOG](DECISION_LOG.md) comme ADR fondateur, dans la lignée d'ADR-019
(règle d'or) et ADR-020 (les deux modes).

---

## Préambule — ce que cette étude a confirmé, et l'hypothèse qu'elle corrige

Trois constats président à ce document.

**1. La Capacité 2 est ce qu'ARTIZEN vend ; la Capacité 1 en est le moyen.**
L'artisan n'achète pas « la reproduction parfaite de mon ancien devis » (il l'a
déjà, c'est son PDF). Il achète *« continuer à produire tous mes futurs devis avec
mon identité retrouvée »*. La Capacité 1 est la fondation nécessaire ; la Capacité
2 est le bénéfice quotidien (REPRODUCTION_SPEC, « le parcours en trois temps »,
étape 3). **Ce document est donc le vrai cœur du produit.**

**2. La Capacité 2 est déjà, en grande partie, *architecturée* — pas inventée
ici, mais émergée du travail réalisé.** Le format `.artizen` est explicitement
conçu comme *« the intelligent documentary model an import compiles to — not a
template »* (`artizen_format.py`), en trois couches : graphique (figé), métier
(zones variables), comportemental (règles). Le contrat de la seule intervention
d'IA est *déjà figé* (`ai_contract.py` : `ExtractionBlocks → enrich →
SemanticStructure → assemble_business_layer → BusinessLayer`), et sa moitié
déterministe (`assemble_business_layer`) *fonctionne déjà* avec un mock. Ce
document **formalise cette architecture émergente**, il n'en propose pas une
nouvelle.

**3. Une hypothèse que nous tenions pour vraie est inexacte, et il faut la
corriger ici.** La REPRODUCTION_SPEC grave : *« Le renderer ne compose jamais. »*
C'est vrai — **pour la Capacité 1**, où l'on rejoue le *même* document (mêmes
lignes, même hauteur, même pagination : *« toutes ces décisions ont déjà été
prises par le devis original »*). Mais la Capacité 2 introduit du contenu dont la
taille **diffère** de l'original : dix lignes là où il y en avait trois, un nom de
client plus long, un tableau qui déborde de page. Ces décisions-là **n'ont pas été
prises par le devis original** — elles n'existaient pas. **La Capacité 2 ne peut
donc pas exister sans une forme de recomposition** du corps du document. Nier ce
fait, ce serait spécifier une capacité impossible. Ce document assume cette
tension et en fait sa question centrale (§3, §5, §9).

> **La reformulation qui en découle, et qui gouverne tout le reste :**
> la Capacité 1 conserve **le document**. La Capacité 2 conserve **l'identité du
> document** tout en laissant **couler son contenu**. Ce n'est pas la même loi.

---

## 1. Définition

**La Capacité 2 est la génération d'un document neuf à partir d'un modèle
documentaire vivant, en conservant l'identité visuelle de l'artisan et en ne
laissant varier que ses données.**

- **Sa responsabilité.** Prendre (a) un modèle vivant `.artizen` — un ancien devis
  reproduit *et compris* — et (b) les données d'un nouveau document (client,
  lignes, totaux, dates…), et produire un PDF qui a l'apparence exacte d'un devis
  que l'ancien logiciel de l'artisan aurait produit pour ces mêmes données.
- **Où elle commence.** À la sortie de la Capacité 1 : un `.artizen` dont la couche
  graphique est fidèle (reproduction Platine prouvée). Elle commence *après* que
  l'IA a compris ce document (voir la frontière, §2), c'est-à-dire quand le modèle
  sait *quelles parties de lui-même sont vivantes*.
- **Où elle s'arrête.** Aux octets d'un PDF généré. Elle ne persiste rien
  elle-même, ne calcule aucun montant, ne décide d'aucun prix ni d'aucune TVA
  (invariant produit n°1). Elle s'arrête là où commence l'affichage produit.
- **Ce qu'elle garantit.**
  1. **Conservation d'identité** : toute propriété d'identité de l'original
     (polices, couleurs, logo, en-tête, pied, géométrie des colonnes, styles,
     marges, mentions figées) est restituée sans écart perceptible, sur *chaque*
     futur devis, avec les mêmes tolérances que la REPRODUCTION_SPEC (coord ≤ 0,1 pt,
     police ≤ 0,25 pt, couleur ΔE\*ab < 2,0).
  2. **Déterminisme** : même modèle + mêmes données → même PDF, de façon
     **déterministe** (identité binaire après neutralisation des métadonnées de
     génération ; à défaut, identité **perceptuelle**). Aucune IA à la génération (§6).
  3. **Non-invention** : aucune donnée, aucun montant, aucune position n'est
     inventé. Les données viennent du produit ; les positions, du modèle.
  4. **Auto-cohérence** : le modèle vivant, rempli avec les *données de l'original*,
     **reproduit l'original** (le pont de vérité entre C1 et C2, §8).
- **Ce qu'elle ne garantit pas.**
  1. Elle ne garantit pas qu'un contenu de taille *arbitrairement* différente
     reste esthétiquement parfait : au-delà d'un certain écart (débordement,
     collision), elle doit **signaler**, pas « arranger en silence » (§3, §7).
  2. Elle ne garantit pas la *justesse métier* des données (c'est le rôle du
     calculateur produit et de l'artisan) — seulement leur *placement fidèle*.
  3. Elle ne garantit pas l'autorisation d'usage du modèle : reproduire l'identité
     d'un tiers est un risque juridique traité par la Décision 8, pas par ce moteur.

---

## 2. Frontière avec la Capacité 1

La frontière est un **contrat de données**, déjà figé dans le code. C'est ce qui
permet aux deux capacités d'évoluer séparément.

**Ce que produit exactement la Capacité 1.** Un `ArtizenTemplate` dont **seule la
couche graphique est peuplée** : chaque texte de l'original est un `FixedText`
verbatim, chaque dessin un `Shape`, chaque image un `ImageBlock`
(`pdf_extractor.py`). Aujourd'hui, la couche métier est **vide** (`business.fields
= []`) et la table paramétrique n'est pas renseignée. **Un `.artizen` sortant de la
Capacité 1 est un document *figé mais mort* : il sait se reproduire lui-même, il ne
sait pas encore ce qui, en lui, est vivant.**

**Ce qu'attend exactement la Capacité 2.** Un `.artizen` dont la couche **métier
est peuplée** : les `FieldBinding` (zones variables) et la `TableSpec` (géométrie
des colonnes de lignes) sont renseignés — c'est-à-dire un `.artizen` qui a été
*compris*. Entre les deux se trouve **la seule intervention d'IA de tout le
pipeline** :

```
  Capacité 1                          Frontière (IA + déterministe)                 Capacité 2
  ──────────                          ─────────────────────────────                 ──────────
  PDF → ExtractionBlocks   ──enrich(1 appel IA)──>  SemanticStructure
                                                          │ assemble_business_layer (déterministe)
                                                          ▼
  .artizen (graphique figé)  ────────────────────>  .artizen VIVANT  ──(données neuves)──> nouveau PDF
```

**Les contrats.** (frozen — `ai_contract.py`)
- Entrée de l'IA : `ExtractionBlocks` (blocs positionnés, sans sens).
- Sortie de l'IA : `SemanticStructure` (des *rôles* : « ce bloc est le nom du
  client », « ces 4 colonnes sont Désignation/Qté/PU/Montant »).
- Sortie déterministe : `BusinessLayer` (`FieldBinding` + `SectionPresence`), via
  `assemble_business_layer`, **sans aucune IA**.

**Les invariants de la frontière.**
- **I-C2-1 — Séparation des couches (ADR-003).** La Capacité 2 ne modifie *jamais*
  la couche graphique. Elle ne touche qu'aux couches métier et comportementale.
- **I-C2-2 — Étanchéité du contrat.** Le jour où un vrai enricher remplace le
  `MockAIEnricher`, *rien d'autre ne change* — c'est la preuve, déjà tenue par le
  code, que la couture est saine.
- **I-C2-3 — L'argent reste au produit (invariant produit n°1 & n°3).** La couche
  comportementale (`CalcRule`) *décrit* comment l'original calculait ; à la
  génération dans le produit, **elle ne recalcule rien**. Les montants viennent de
  `quotes/calculator.py`, seule source de vérité (arrondi ROUND_HALF_UP par ligne).
  Le rôle de la couche comportementale se réduit à la **cohérence** (vérifier que la
  convention de l'original correspond) et à l'**affichage conditionnel** (franchise,
  acompte…) — jamais au calcul d'un montant persisté.
- **I-C2-4 — Le PDF source est canonique ; le `.artizen` est dérivé et jetable
  (ADR-022).** Le `.artizen` n'est **jamais** une donnée métier faisant foi : c'est
  une représentation intermédiaire, ré-extractible du PDF source à tout moment, qui
  peut être supprimée, régénérée ou changer de format **sans toucher aux données du
  client**. Le format peut donc évoluer (ex. positions absolues → ancrages
  relationnels) sans dette de migration sur données clients.

---

## 3. Naissance d'un modèle vivant — ce qui devient variable, ce qui reste figé

C'est la décision fondatrice de la capacité. Elle est déjà tranchée dans le code
(`ai_contract.py::_BOUND_ROLES`) et n'a qu'à être formalisée — **avec une nuance
que l'étude a révélée** (la double nature des variables, et le problème du flux).

### 3.1 Ce qui reste **définitivement figé** (l'identité)
Tout ce que l'IA ne marque pas comme un rôle lié, plus tout ce qui n'est jamais
soumis à l'IA (toute la couche graphique) :
- géométrie de page, marges, colonnes, hauteurs de ligne, alignements ;
- polices, tailles, graisses, couleurs, filets, fonds, rayons ;
- logo, images, en-tête, pied de page ;
- les **libellés figés** (`FIXED_LABEL`) : « DEVIS », « LIBELLÉ », « Qté », l'en-tête
  de tableau (`TABLE_HEADER`), les mentions légales (`LEGAL`), les zones de
  signature (`SIGNATURE`), le pied (`FOOTER`).

**Pourquoi.** Ce sont exactement les éléments qui font qu'un document *est* celui de
l'artisan. Les figer, c'est le principe de conservation graphique de la
REPRODUCTION_SPEC, étendu à la génération : *« le renderer ne crée pas une nouvelle
identité, il préserve celle de l'artisan »*.

### 3.2 Ce qui devient **variable** (les données) — et sa double nature
Les rôles liés (`_BOUND_ROLES`) deviennent des `FieldBinding`. Mais l'étude a mis
au jour une distinction que le code ne nomme pas encore et que ce document grave :

- **Variables d'identité (constantes pour cet artisan).** `company.name`,
  `company.address`, `company.siret`, IBAN/BIC. Elles « varient » seulement en ce
  qu'elles sont **résolues depuis le compte**, pas gelées dans le graphique. Sur
  tous les devis d'un artisan, elles sont identiques.
  **Pourquoi les rendre variables plutôt que figées ?** Pour **deux** raisons, dont
  une juridique : (a) fonctionnel — si l'artisan corrige son adresse, tous ses
  futurs devis suivent ; (b) **Décision 8** — ne **jamais** cuire l'identité d'un
  tiers dans la couche figée. Si le SIRET était un `FixedText`, un modèle importé
  d'un concurrent embarquerait à jamais le SIRET du concurrent. En faire une zone
  variable résolue depuis le compte est la garantie technique de la protection de
  l'identité documentaire.
- **Variables de transaction (propres à chaque devis).** `client.*`, `worksite.*`,
  `doc.number`, `doc.date`, `doc.valid_until`, les **lignes** de prestations, et les
  **totaux** (`totals.*`). Elles changent réellement à chaque document.

**Pourquoi.** Ce sont les seules choses qui distinguent deux devis du même artisan.
Tout le reste étant conservé, faire varier *uniquement* ces zones est la définition
même de « le même document, d'autres données ».

### 3.3 Le cas particulier qui gouverne toute la capacité : le corps qui coule
Les zones variables « simples » (nom, date, numéro) se **remplissent** dans un
emplacement fixe. Mais **deux** régions ont une taille qui dépend des données :
- le **tableau des lignes** : N lignes au lieu des M de l'original ;
- tout ce qui est **ancré sous le tableau** (totaux, signature, mentions), qui doit
  se **décaler** quand la hauteur du corps change — et, au-delà de la page, imposer
  un **saut** et la répétition de l'en-tête/pied.

**C'est ici que « le renderer ne compose jamais » cesse de suffire.** La Capacité 2
exige une recomposition **minimale et disciplinée** :

> **Principe du cadre et du flux (fondateur, propre à la Capacité 2).**
> L'identité est un **cadre** conservé absolument (en-tête, pied, logo, couleurs,
> polices, géométrie des colonnes, styles). Seul le **corps** coule : les lignes
> s'ajoutent ou se retirent, les blocs ancrés au flux se décalent de la hauteur du
> corps, et un débordement insère une page qui répète le **même** cadre. Le flux
> n'invente aucun style ; il ne fait que *dérouler* le contenu dans un cadre figé.

Ce principe n'annule pas la REPRODUCTION_SPEC : à la **reproduction** (C1), zéro
zone variable, le corps ne coule pas, le renderer ne compose toujours pas. La
recomposition est une opération **de génération**, pas de reproduction.

> **Inconnue majeure que ce principe expose** (voir §9, U-C2-1) : le format
> `.artizen` encode aujourd'hui des **positions absolues** (`FieldBinding.rect`),
> **pas des relations de flux**. Il ne dit pas « ces totaux sont ancrés *sous* le
> tableau » vs « ce pied est ancré *en bas de page* ». Savoir *ce qui coule avec le
> corps* et *ce qui reste au cadre* est une information qui n'est pas encore captée.
> Ce document **nomme** ce manque ; il ne le tranche pas (ce serait concevoir une
> architecture nouvelle). C'est la première inconnue à lever, et elle se lève sur
> corpus réel, pas par la réflexion.

---

## 4. Le modèle documentaire vivant — description fonctionnelle

Fonctionnellement — non techniquement — un **modèle documentaire vivant** est :

> **La mémoire de la manière dont un artisan fait ses devis.** Pas un exemple de
> devis : la connaissance de *comment* ses devis sont faits — à quoi ils
> ressemblent, et ce qui, en eux, change d'un devis à l'autre.

**Ce qu'il contient.**
- Une **apparence** complète et figée (le cadre d'identité) — issue de la Capacité 1.
- Une **carte de ses zones vivantes** : où va le client, où vont les lignes, où
  vont les totaux — et lesquelles sont d'identité (constantes) vs de transaction.
- Une **compréhension de sa structure** : quelles sections existent
  (`SectionPresence` : logo ✓, client ✓, tableau ✓, TVA ✓…), quelles colonnes
  compose son tableau, quelles règles d'affichage conditionnel s'appliquent
  (franchise, acompte).
- Sa propre **confiance** : le modèle sait à quel point il s'est compris
  (`confidence`, `confidence_stars`, `estimated_fidelity`).
- Tout cela **auto-contenu** (polices et images embarquées) : le modèle reproduit
  l'identité *pour toujours*, sans dépendance externe.

**Ce qu'il sait faire.**
- Se **reproduire** lui-même à l'identique (hérité de C1).
- **Accueillir** de nouvelles données de transaction et produire un nouveau
  document qui conserve son identité.
- **Se présenter** à l'artisan pour validation (« voici ce que j'ai reconnu ») —
  le *rapport de reconnaissance* (le « Template Studio »).
- **Dire quand il ne sait pas** : signaler une zone qu'il n'a pas comprise, un
  débordement qu'il ne peut absorber, plutôt que deviner.

**Ce qu'il ne doit jamais faire.**
- **Moderniser, réorganiser, « améliorer »** l'identité (interdits de la
  REPRODUCTION_SPEC, hérités intégralement).
- **Inventer** une donnée, un montant, une TVA (invariant produit n°1).
- **Recalculer** un montant que le produit a déjà calculé (invariant n°3).
- **Se remplir tout seul** de données non validées, ou **s'appliquer** sans
  confirmation (invariant produit n°7 : rien sans confirmation explicite).
- **Embarquer l'identité d'un tiers** dans sa couche figée (Décision 8).

---

## 5. Les transformations

La chaîne complète, du PDF au nouveau devis. Pour chaque étape : entrée → sortie,
responsabilité, invariant. Les trois premières existent (Capacité 1 + contrat IA) ;
les deux dernières sont le périmètre propre de la Capacité 2.

| # | Transformation | Entrée | Sortie | Responsabilité | Invariant |
|---|---|---|---|---|---|
| 1 | **Extraction** | PDF natif | `ExtractionBlocks` (blocs positionnés) | Décrire, jamais interpréter | EXTRACTION_SPEC : « l'extracteur décrit » ; aucune interprétation métier |
| 2 | **`.artizen` graphique** | blocs | `ArtizenTemplate` (couche graphique) | Figer l'apparence à l'identique | REPRODUCTION_SPEC : conservation graphique ; replay déterministe |
| 3 | **Compréhension** (1 appel IA) | `ExtractionBlocks` | `SemanticStructure` (rôles) → `BusinessLayer` | Nommer *ce qu'est* chaque bloc | I-C2-2 : l'IA comprend, ne dessine pas ; 1 appel, à l'import |
| 4 | **Modèle vivant** | graphique + `BusinessLayer` | `.artizen` complet, **validé** | Fusionner apparence + zones vivantes, faire valider | I-C2-1 : la couche graphique n'est pas touchée ; rien sans confirmation (n°7) |
| 5 | **Nouveau devis** | modèle vivant + données produit | PDF | Dérouler les données dans le cadre figé | I-C2-3 : aucun calcul, aucune invention ; déterministe ; principe cadre/flux |

**Note sur l'étape 4 (la naissance) :** c'est là que le modèle *devient vivant*, et
c'est un **acte validé**, pas automatique. L'artisan (ou ARTIZEN sous sa
supervision) confirme le rapport de reconnaissance avant que le modèle serve à
produire de vrais devis. Cette porte de validation est l'héritière directe de
l'invariant n°7 et du geste de la Décision 8.

**Note sur l'étape 5 (la génération) :** elle réutilise les primitives du renderer
déterministe (qui sait déjà dessiner `fields` et `rows` — prouvé par les tests),
augmentées de la logique de flux du §3.3. Un mapper produit `Quote → (fields,
rows)` — l'équivalent, côté métier, de `document_mapper.quote_to_document` — reste à
écrire ; le contrat côté renderer, lui, existe.

---

## 6. Le rôle de l'IA — la règle réévaluée pour la Capacité 2

La règle gravée est : **« L'IA comprend. Elle ne dessine jamais. »** L'étude
confirme la règle et la **renforce** — elle ne l'affaiblit pas.

**Ce que fait exactement l'IA.** *Une seule chose, une seule fois.* À l'import,
elle reçoit les blocs positionnés et **attribue des rôles** : « ce texte est le nom
du client », « cette bande est l'en-tête de tableau », « ces 4 colonnes sont
Désignation / Qté / PU / Montant », « ce chiffre est le Total TTC ». Elle produit du
**sens**, sous la forme d'un `SemanticStructure`.

**Ce qu'elle ne fait jamais.**
- Elle n'invente **aucune coordonnée** (les positions viennent de l'extraction).
- Elle n'invente **aucun montant, aucune TVA, aucun prix**.
- Elle ne **dessine rien**, ni à l'import, ni jamais.
- Elle est **totalement absente de la génération** : produire les futurs devis est
  100 % déterministe et ne coûte rien par document.

> **Le renforcement propre à la Capacité 2.** En reproduction (C1), l'IA n'existe
> pas du tout. En génération (C2), l'IA n'intervient **qu'une fois, à la naissance
> du modèle**, jamais à l'usage. Autrement dit : *l'IA nomme les zones vivantes une
> fois pour toutes ; elle ne touche plus jamais aucun devis de l'artisan.* Chaque
> futur devis est produit sans elle. La règle devient :
>
> ### L'IA nomme, une seule fois, à la naissance. Le déterminisme dessine, pour toujours.

**Comment le garantir (mécanismes déjà en place).**
- **La couture est un contrat de données** (`ai_contract.py`) : l'IA ne peut
  produire qu'un `SemanticStructure` (des rôles), jamais un pixel.
- **`assemble_business_layer` est déterministe et sans IA** : il transforme les
  rôles en `FieldBinding` aux coordonnées *de l'extraction*, pas à des coordonnées
  inventées par l'IA.
- **Repli obligatoire sans clé** : `MockAIEnricher` renvoie une structure vide mais
  valide — le pipeline tourne de bout en bout sans modèle ni réseau. Corollaire
  produit : **sans clé IA, la Capacité 2 dégrade proprement vers le Mode 1**
  (identité appliquée), jamais une erreur. « L'app démarre et répond toujours »
  (règle d'abstraction de fournisseur).
- **Toute réponse d'IA est revalidée** (invariant produit n°4) : un rôle attribué à
  un bloc inexistant, une colonne incohérente sont écartés, pas crus sur parole.

---

## 7. Les risques

| Domaine | Risque | Comment le limiter |
|---|---|---|
| **Technique** | **Le débordement du corps** casse la mise en page (totaux qui chevauchent le pied, table hors page). C'est *le* risque central (§3.3). | Principe cadre/flux ; ancrage explicite à lever sur corpus (U-C2-1) ; **signaler** un débordement non absorbable plutôt que l'arranger. |
| **Technique** | **Compréhension erronée** : l'IA marque une mention figée comme variable, rate une colonne, confond client et chantier. | Rapport de reconnaissance **validé** par l'humain (étape 4) ; revalidation (invariant n°4) ; confiance affichée ; repli Mode 1 si confiance basse. |
| **Technique** | **Longueur variable** : un nom/valeur plus long que l'emplacement d'origine déborde ou tronque. | Tolérances explicites ; mise à l'échelle horizontale (déjà éprouvée en reproduction, E-012) ; signaler au-delà d'un seuil. |
| **Fonctionnel** | **Rupture de l'invariant argent** : la couche comportementale recalcule et diverge du calculateur produit. | I-C2-3 gravé : le `.artizen` ne recalcule jamais un montant persisté ; le calculateur reste seule source de vérité. |
| **Fonctionnel** | Le **premier** devis coïncide avec l'original (même nb de lignes) et masque le problème de flux ; il éclate au 2ᵉ. | Tester la génération sur un **balayage de tailles de contenu**, pas sur un seul cas (§8, §10). |
| **Juridique** | **Reproduire l'identité d'un tiers** devient bien plus grave qu'en Mode 1 : on ne fait plus « ressembler », on **restitue** fidèlement. | Décision 8 : identité d'entreprise en zone **variable** résolue depuis le compte (jamais figée) ; signal de cohérence d'identité ; confirmation avant usage. |
| **Produit** | **Qualité par-artisan non bornée** : un modèle mal reproduit dégrade *son* devis sous le gabarit maison — pire que le Mode 1. | L'**oracle en gardien de production** : ne servir le Mode 2 que si la fidélité du modèle dépasse le seuil de certification ; sinon repli Mode 1 automatique. |
| **Marque** | **Confondre Mode 1 et Mode 2** : présenter une identité *appliquée* comme une restitution. | Mots réservés au Mode 2 (ADR-020 : « à l'identique, restitution, fidèle, identité retrouvée ») ; la Capacité 2 seule a droit à ces mots. |
| **Marque** | **La règle d'or trahie sur du neuf** : le nouveau devis « sent » ARTIZEN, pas l'artisan. | Le juge reste l'œil de l'artisan sur un devis *nouveau* (§8) ; un écart que l'oracle rate est un défaut de l'oracle, à corriger (REPRODUCTION_SPEC). |

---

## 8. Les critères de réussite — de la **capacité**, pas du moteur

La fidélité de reproduction (Capacité 1) est jugée par l'oracle. La **Capacité 2**
réussit quand *tous* les critères suivants sont vrais — ils portent sur la
génération de documents **neufs**, pas sur la reproduction.

1. **Naissance juste.** Sur le corpus annoté, l'attribution des rôles atteint une
   précision/rappel cible (les zones variables sont les bonnes, ni oubliées, ni
   inventées). *Mesurable* contre une annotation humaine.
2. **Cadre conservé à 100 %.** Quelles que soient les données injectées, les
   éléments d'identité (polices, couleurs, logo, en-tête, pied, géométrie des
   colonnes) sont **inchangés** — dérive nulle. *Mesurable* déterministiquement :
   on compare le cadre du généré à celui du modèle.
3. **Flux correct.** Sur un **balayage** de tailles de contenu (1 ligne, 3, la
   valeur de l'original, 20, débordement multi-pages ; noms courts et longs), la
   génération se produit **sans collision, sans troncature silencieuse, sans page
   perdue** — ou **signale** proprement quand elle ne peut pas. *Mesurable* sur
   contenu synthétique.
4. **Auto-cohérence (le pont C1↔C2).** Le modèle vivant, rempli avec **les données
   de l'original**, **reproduit l'original** au seuil de l'oracle. Un modèle qui, en
   devenant vivant, aurait « oublié » de se reproduire est un échec. *Mesurable*
   par l'oracle existant.
5. **Verdict de l'artisan sur du neuf.** Placé devant un devis *nouveau* (client et
   lignes qu'il n'a jamais faits ainsi) généré par ARTIZEN, l'artisan répond **non**
   à : *« si vous aviez fait ce devis dans votre ancien logiciel, serait-il
   différent ? »*. Juge de dernier ressort, subjectif *en plus* d'être mesuré.
6. **Aucune fuite d'identité (Décision 8).** Aucun généré ne porte l'identité figée
   d'un tiers ; l'identité d'entreprise provient toujours du compte.
7. **Dégradation propre.** Sans clé IA, sans compréhension suffisante, ou sous
   débordement, la capacité **retombe** sur le Mode 1 ou **signale**, sans jamais
   produire un document faux ni planter.

> La Capacité 2 est réussie le jour où un artisan produit **son dixième devis de la
> semaine** dans ARTIZEN et ne remarque même pas qu'un logiciel différent du sien
> l'a fabriqué.

---

## 9. Les inconnues

Dans la discipline du programme (EXTRACTION_SPEC/UNKNOWNS : *chaque inconnue devient
une expérience, jamais une opinion*), voici les inconnues propres à la Capacité 2.
Numérotées `U-C2-n` ; à reporter dans [UNKNOWNS.md](UNKNOWNS.md) à la ratification.

| ID | Inconnue | Nature | Résolution |
|---|---|---|---|
| **U-C2-1** | **Ancrage flux vs cadre.** Comment savoir ce qui coule avec le corps (totaux, signature) et ce qui reste au cadre (pied) ? Le format encode des positions absolues, pas des relations. | La plus structurante | **Corpus réel** : observer, sur de vrais devis à nombres de lignes variés, quels blocs se déplacent. Décider *ensuite* si on infère l'ancrage ou si on étend le format. |
| **U-C2-2** | **Fiabilité de l'attribution de rôles** par une vraie IA (précision/rappel réels sur des devis réels). | Empirique | **Corpus réel + annotation humaine** ; mesurer contre le gold standard. |
| **U-C2-3** | **Détection de table** (spécifiée, non codée) : identifier la région, les colonnes, le corps répétable. | Technique + empirique | **Corpus réel** : les tableaux EBP/Batappli sont-ils détectables géométriquement (rejoint U-001) ? |
| **U-C2-4** | **Débordement de page** : la répétition en-tête/pied et le report de totaux d'un vrai devis multi-pages sont-ils reproductibles pour *N* lignes ≠ original ? | Technique | **Corpus réel multi-pages** (SJE, 11 pages) : générer avec plus/moins de lignes, mesurer. |
| **U-C2-5** | **Longueur des données variables** : jusqu'où un nom/valeur plus long tient-il sans casser (mise à l'échelle, retour ligne, troncature) ? | Technique | **Semi-synthétique** : injecter des longueurs croissantes dans un vrai modèle, trouver le seuil de rupture. |
| **U-C2-6** | **Couche comportementale minimale** : quelles règles d'affichage conditionnel (franchise, acompte, remise) sont réellement nécessaires vs sur-conçues ? | Fonctionnel | **Corpus réel** : ne garder que les règles observées ; le reste est spéculatif (règle d'extraction « 2ᵉ consommateur »). |
| **U-C2-7** | **Seuil de bascule Mode 1 → Mode 2** : à partir de quelle fidélité/confiance sert-on le modèle reproduit plutôt que le gabarit maison ? | Produit + empirique | **Corpus + jugement** : corréler score oracle et verdict artisan (rejoint U-002). |
| **U-C2-8** | **Devis image/scan** (0 texte natif) : la Capacité 2 exige-t-elle de l'OCR, ou reste-t-elle réservée au natif en V1 ? | Périmètre | **Décision de périmètre** (rejoint U-016) : peut se trancher **sans données** — probablement « natif d'abord ». |

**Ce qui peut se décider *sans* corpus :** le périmètre (U-C2-8, natif d'abord), et
les invariants de ce document (séparation des couches, l'argent au produit, l'IA une
seule fois, la porte de validation, la double nature des variables). **Ce qui exige
le corpus réel :** tout le reste — et en premier U-C2-1, dont dépend l'existence
même de la génération multi-tailles.

---

## 10. La feuille de route — de la compréhension, pas du développement

Ordre de **réduction des inconnues**, pas de codage. Chaque étape est une
expérience qui lève une inconnue et produit une décision.

- **Étape 0 — Ratifier cette constitution.** La graver en ADR, reporter les
  `U-C2-n` dans UNKNOWNS.md. *Sans données.* (fait par ce document, une fois validé.)
- **Étape 1 — Trancher le périmètre (U-C2-8).** Acter « natif d'abord » pour la
  Capacité 2. *Sans données.* Décision de PO.
- **Étape 2 — Débloquer le Starter Corpus.** 5 vrais devis (ADR-005/021). **Rien de
  crédible ne se mesure avant.** Prérequis de tout ce qui suit.
- **Étape 3 — Expérience « anatomie du flux » (U-C2-1, la première).** Sur les
  devis du corpus, *annoter à la main* ce qui bouge quand on ajoute/retire des
  lignes (totaux ? signature ? mentions ?). **Objectif : comprendre l'ancrage
  avant de décider s'il s'infère ou se déclare.** C'est l'expérience fondatrice de
  la capacité.
- **Étape 4 — Expérience « compréhension » (U-C2-2, U-C2-3).** Annoter les rôles et
  les tableaux du corpus (gold standard). Mesurer ce qu'une vraie IA devrait
  atteindre. Décider du contrat de détection de table.
- **Étape 5 — Expérience « auto-cohérence » (critère §8.4).** Remplir un modèle
  vivant avec les *données de son propre original* et vérifier que l'oracle
  retrouve l'original. C'est le premier test *de bout en bout* de la Capacité 2, et
  il ne demande **aucune** donnée nouvelle — juste la boucle.
- **Étape 6 — Expérience « flux sous contrainte » (U-C2-4, U-C2-5).** Générer, à
  partir d'un vrai modèle, des devis à 1/3/20 lignes et à noms longs ; trouver les
  seuils de rupture et la règle de signalement.
- **Étape 7 — Expérience « bascule » (U-C2-7).** Corréler score oracle et verdict
  artisan pour fixer le seuil Mode 1 → Mode 2 en production.

À l'issue de l'étape 7, et **seulement là**, la question « comment construire la
Capacité 2 ? » cesse d'être spéculative : chaque inconnue est levée par une mesure,
et la construction peut commencer avec la même discipline que le reste du programme.

---

## Statut

**v1.0 — figée.** Troisième document fondateur du moteur, après EXTRACTION_SPEC et
REPRODUCTION_SPEC. Formalise l'architecture *émergée* (format `.artizen` à trois
couches, contrat IA figé, `assemble_business_layer` déterministe), corrige une
hypothèse (« le renderer ne compose jamais » est une loi de la Capacité 1 ; la
Capacité 2 exige le principe cadre/flux), et ouvre huit inconnues à lever sur
corpus réel. Toute évolution des invariants, des critères ou du principe cadre/flux
exige une nouvelle version datée et motivée.

---

<br>

> # La Capacité 1 fait disparaître ARTIZEN d'un devis.
> # La Capacité 2 le fait disparaître de **tous** les devis à venir.
>
> ### Le modèle ne connaît pas le métier de l'artisan.
> ### Il connaît la manière dont l'artisan le met en forme — et il la garde, pour toujours.
