# Registre des expériences — EXPERIMENTS

Le journal de la **Phase 3**. Il ferme la boucle entre les questions
([UNKNOWNS.md](UNKNOWNS.md)) et les décisions ([DECISION_LOG.md](DECISION_LOG.md)) :
chaque ligne est une **inconnue transformée en connaissance validée**, mesurée par
le benchmark, jamais par une intuition.

## Jalon 1 — prouver que le laboratoire produit de la connaissance

Le premier succès **n'est pas un score de 99 %.** C'est un cycle complet, mené
jusqu'au bout, sur une seule inconnue :

> U-xxx testée sur ~5 documents → hypothèse confirmée (ou infirmée) → décision
> prise → ADR ou amendement de la spec → **une inconnue en moins.**

Si ce cycle tourne proprement une fois, le laboratoire a prouvé sa valeur — bien
avant que le moteur soit « bon ».

## Le cycle d'une expérience

1. **Choisir** l'inconnue la plus *rentable* à lever (U-xxx).
2. **Formuler** une hypothèse falsifiable (« les tableaux EBP sont détectables
   géométriquement dans ≥ 90 % des cas »).
3. **Prototyper** l'heuristique en **branche de travail**, dans
   [`extraction/`](extraction/), sur N documents *réels* du corpus.
4. **Mesurer** via `python benchmark.py` — KPI par sous-système, `--official`
   (références certifiées), `--gate` (pas de régression d'une autre famille).
5. **Décider** : confirmée / infirmée / reportée → ADR ou amendement de la
   [spec](EXTRACTION_SPEC.md) ; mettre à jour le burndown d'[UNKNOWNS](UNKNOWNS.md).
6. **Merger** dans `main` **seulement si** le benchmark valide (gouvernance
   [ADR-011](DECISION_LOG.md)).

## Structure obligatoire d'une fiche d'expérience

Le laboratoire vaut par sa capacité à **séparer les faits des décisions**. Chaque
expérience suit donc, sans exception, cette chaîne — et ne mélange jamais ses
maillons :

```
Question → Hypothèse → Protocole → Résultats → Interprétation → Décision → ADR (si besoin)
```

**Résultat**, **Interprétation** et **Décision** ne sont **pas interchangeables** :

| Maillon | Nature | Exemple |
|---|---|---|
| Résultat | *fait mesuré* | « 12 des 15 tableaux reconstruits correctement. » |
| Interprétation | *lecture du fait* | « La géométrie seule *semble* suffisante pour cette famille. » |
| Décision | *choix engagé* | « Conserver l'approche géométrique pour Word. » |

Un résultat ne se discute pas ; une interprétation se challenge ; une décision
s'assume. Les confondre est la première source de conclusions trop rapides.

### Gabarit d'une fiche (à recopier par expérience)

```
### E-NNN — <titre>  (inconnue : U-xxx)
Question      : la question précise à laquelle on répond
Hypothèse     : énoncé falsifiable
Protocole     : corpus utilisé (ids), heuristique testée, commande benchmark
Résultats     : chiffres PRODUITS par le benchmark (KPI par sous-système)
Biais observés: ce qui pourrait fausser la lecture (famille unique, N trop petit…)
Interprétation: ce que les résultats suggèrent — pas plus
Décision      : confirmée / infirmée / reportée
ADR / spec    : ADR-xxx ou amendement, si la décision engage l'architecture
Ouverte le / Décidée le : <dates>  (→ alimente le KPI du laboratoire)
```

## Quand une expérience *réussit* — redoubler de méfiance

Une expérience qui échoue est facile à analyser. Une expérience qui réussit est
plus dangereuse. Pour **chaque succès**, la fiche doit répondre à deux questions,
sous peine d'être incomplète :

1. **Pourquoi cela fonctionne-t-il ?** (le mécanisme, pas la coïncidence)
2. **Dans quels cas cela cessera-t-il de fonctionner ?** (les limites)

La réponse à la seconde question est, le plus souvent, la **prochaine expérience**.

## KPI du laboratoire — temps « inconnue → décision »

Un seul indicateur, et ce n'est **pas** un KPI du moteur : le **délai moyen entre
l'ouverture d'une inconnue et la décision qui la clôt** (ADR ou amendement).

```
UNKNOWNS (ouverte le) ──▶ Expérience ──▶ Décision / ADR (le)   =   N jours
```

Il mesure la santé du **laboratoire** (Produit B), pas la performance du moteur.
Signal d'alerte : une inconnue ouverte depuis longtemps *sans protocole
d'expérience* — le labo se grippe. Chaque fiche porte donc ses dates
`Ouverte le / Décidée le`, et la moyenne se lit sur le registre.

## Registre

Premières données réelles (2 devis natifs, via le module existant
`document_detection`, pas encore la Brique 4). Ouvertes le 2026-07-23.

| Exp | Inconnue | Résultat mesuré | Observation | Statut |
|---|---|---|---|---|
| **E-001** | U-010 (texte lettre-espacé) | **Chapot / Mediabat — confiance 54 %** ; tableau **détecté** (19 lignes, conf 1.0), couleurs réelles `#4ca549`/`#365e92`, logo/en-tête/pied ✓ | Champs SIRET/tél/email/entreprise **KO** : Mediabat écrit le texte **lettre par lettre espacée** (« S A R L », « 0 6  5 9 ») → les regex échouent → **U-010** | Résolue → **E-003** |
| **E-002** | U-001 (tableaux) | **SJE / Solabaie — confiance 76 %** ; SIRET, TVA, tél, email, logo, en-tête, pied ✓ | **Tableau NON détecté** (conf 0) sur ce format | Ouverte |

**Interprétation croisée (avec méfiance) :** la détection **varie fortement par
source** — Mediabat = *tableau OK / champs KO* ; SJE = *champs OK / tableau KO*.
Aucune source n'est « résolue ». Deux chantiers concrets, indépendants :
1. **Normaliser le texte lettre-espacé** avant les regex (corrige E-001, sans
   risque pour les autres) → **fait, voir E-003**.
2. **Fiabiliser la détection de tableau** par famille (corrige E-002) → à creuser.

Ces 2 devis deviennent les **2 premiers du Starter Corpus** (Mediabat, Solabaie).
Il en manque 3 (styles/logiciels différents) pour l'amorce complète.

### E-003 — normalisation du texte lettre-espacé  (inconnue : U-010)

| Maillon | Contenu |
|---|---|
| **Question** | Peut-on récupérer les champs (SIRET, tél, email, adresse) sur un export lettre-espacé (Mediabat) **sans casser** un export propre (Solabaie) ? |
| **Hypothèse** | *falsifiable* — dans un export lettre-espacé, **1 espace colle les glyphes d'un mot, 2 espaces séparent les mots**. En n'appliquant cette règle qu'aux lignes lettre-espacées, on répare Chapot et on laisse SJE intact. |
| **Protocole** | `text_normalizer.collapse_letter_spacing` appliqué **aux seuls** détecteurs de champs (`contact`/`siret`/`vat`) dans l'`aggregator` ; les détecteurs de position gardent le texte brut. Mesuré par les **vrais** détecteurs sur les 2 PDF réels + agrégat complet. |
| **Résultats** | **Chapot** : champs 2/6 → **5/6** (SIRET `94808180700018`, tél `0659192595`, email, adresse corrigée) ; confiance **0.54 → 0.70**. **SJE** : 6/6 → **6/6**, confiance **0.76 → 0.76** (**aucune régression**). 7 tests unitaires + 26 tests détection existants : **33 passent**. |
| **Interprétation** | La règle « 1 espace = colle / 2 espaces = frontière » tient sur toute la source Mediabat. Le garde-fou *par ligne* (≥ 60 % de tokens ≤ 2 caractères) protège la prose normale : SJE, qui ne lettre-espace pas ses lignes de champs, passe inchangé — la non-régression n'est pas un espoir, elle est **mesurée**. |
| **Décision** | **Confirmée → mergée.** U-010 close. |
| **ADR / spec** | Correctif d'un module V1 livré (`document_detection`), pas une heuristique de la Brique 4 → pas d'ADR ; consigné ici. |
| **Ouverte / Décidée** | 2026-07-23 / 2026-07-23 (délai inconnue → décision : **0 j**) |

**Pourquoi ça marche ?** L'information est intégralement présente dans le texte
extrait ; seule sa *segmentation* est cassée. On ne devine rien — on répare un
espacement, réversible et local.

**Quand ça cessera de marcher ?** (1) Un logiciel qui sépare aussi les mots par
**un seul** espace (pas deux) : la règle collerait les mots — non observé à ce
jour, à surveiller. (2) Les champs **VAT** et **nom d'entreprise** de Chapot
restent KO, mais pour une **autre** cause (regex VAT exigeant 9 chiffres
contigus ; `_guess_company_name` prend la 1re ligne = l'adresse) → **U-011**,
distincte, à ne pas confondre avec U-010. C'est la prochaine expérience.

### E-004 — premier extracteur géométrique réel  (Capacité 1 : reproduire à l'identique)

Première expérience de **Capacité 1** : un vrai PDF natif redessiné, mesuré par
l'oracle. Le maillon manquant — `extraction/pdf_extractor.py` (PyMuPDF) —
transcrit la page 1 en `.artizen` (spans texte verbatim + formes + logo), que le
renderer déterministe rejoue.

| Maillon | Contenu |
|---|---|
| **Question** | Un extracteur géométrique v0 (aucune interprétation métier) peut-il reproduire un vrai devis assez fidèlement pour valoir une base de départ mesurable ? |
| **Hypothèse** | En transcrivant chaque span à sa bbox exacte (texte verbatim, couleur, position), on atteint une fidélité **Structure + Mise en page + Couleurs** proche de 100 %, les polices et le multi-page restant les seuls trous. |
| **Protocole** | `extract()` (fitz) → `render_artizen()` → `compare_pdfs()` sur Chapot (Mediabat) et SJE (Solabaie), les 2 seuls devis réels du corpus. |
| **Résultats** | **Chapot : 87,3 %** — Structure **100 %**, Mise en page **99,8 %**, Couleurs **100 %**, Images **100 %** ; 130/130 textes reproduits. Typographie **42,9 %**, Pagination **50 %**. **SJE : 71,3 %** — Structure 97,1 %, Mise en page 99,9 %, Couleurs 100 % ; Typographie 0 %, Images 10,9 %, Pagination 9,1 % (doc 11 pages / 46 images). |
| **Biais observés** | N = 2, 2 familles ; l'oracle ne lit que la page 1 (sauf le compte de pages) ; typographie pénalisée par le repli de police (non embarquée). |
| **Interprétation** | La **géométrie seule suffit** pour Structure/Mise en page/Couleurs (proche de 100 % sur les 2 familles). Les deux trous ont chacun une cause unique : **polices non embarquées** (Typographie) et **format mono-page** (Pagination + contenu des pages 2+). Le texte lettre-espacé de Mediabat **ne gêne pas** la reproduction (recopié verbatim). |
| **Décision** | Base de départ **validée**. Prochaines expériences ciblées : **E-005 embarquer les polices** (→ Typographie, U-013) ; **multi-page** dans le format (U-012). |
| **ADR / spec** | Prototype `extraction/` (zone expérimentale) ; **non mergé sur `main`** (ADR-011 : exige le benchmark sur références certifiées). |
| **Ouverte / Décidée** | 2026-07-24 / 2026-07-24 |

**Pourquoi ça marche ?** L'oracle récompense le texte présent, bien placé, de la
bonne couleur — exactement ce qu'une transcription géométrique fidèle produit,
sans aucune interprétation.

**Quand ça cessera de marcher ?** Dès qu'on vise la certification (Or ≥ 98) : la
typographie (16 %) et le multi-page (pagination 7 % + contenu des pages suivantes)
deviennent bloquants. Ce sont les deux prochaines inconnues à lever (U-013, U-012).

### E-005 — embarquer les polices exactes  (inconnue : U-013) — **INFIRMÉE**

| Maillon | Contenu |
|---|---|
| **Question** | Embarquer la police exacte du PDF source (au lieu du repli) fait-il monter la Typographie sans régression ? |
| **Hypothèse** | En extrayant les fontes TrueType/OpenType (`fitz.extract_font`) et en les enregistrant dans `assets`+`FontRef`, la Typographie monte vers ~95 %. |
| **Protocole** | Ajout de `_extract_fonts` à l'extracteur ; `render → compare` sur Chapot + SJE. |
| **Résultats** | **Chapot : 87,3 % → 72,1 %** (RÉGRESSION). Structure **100 % → 53,8 %**, Typographie **inchangée à 42,9 %**. 3 polices embarquées. SJE **inchangé** (0 police embarquée : ses fontes sont CFF/Type1, non enregistrables par reportlab). |
| **Interprétation** | Les polices sont **sous-ensemblées** : réencodées, leur `cmap` ne fait pas l'aller-retour → `fitz` relit un **texte différent** du PDF reproduit → le rappel texte (Structure) s'effondre. Et le nom de la police re-embarquée ne matche pas l'original → Typographie non améliorée. Embarquer la fonte subsettée **telle quelle** est contre-productif ici. |
| **Décision** | **Infirmée → revert.** E-004 (87,3 %) reste la meilleure base. **U-013 reste ouverte**, mais la voie « embarquer la fonte subsettée telle quelle » est **fermée**. |
| **Ouverte / Décidée** | 2026-07-24 / 2026-07-24 (délai 0 j) |

**Ce que l'échec révèle (le plus précieux) :** l'oracle compare les **noms** de
police. Une police visuellement identique mais renommée (ou re-subsettée) est
pénalisée **à tort** — exactement le cas « [ce qui constitue un échec](REPRODUCTION_SPEC.md#ce-qui-constitue-un-échec) :
un écart que les indicateurs voient alors que l'œil ne le verrait pas ». Deux vraies
pistes pour U-013, à trancher sur plus de familles : (a) **améliorer l'oracle** —
comparer des **métriques** de police, pas le nom ; (b) reconstruire une fonte
**complète** (non subsettée) avant de l'embarquer.

### E-006 — reproduction multipage  (inconnue : U-012)

Sprint 1 de la feuille de route PO : le moteur doit reproduire **n'importe quel**
devis, pas seulement un 2-pages. Le format et le renderer étaient mono-page.

| Maillon | Contenu |
|---|---|
| **Question** | Étendre `.artizen` et le renderer au multi-page fait-il monter la fidélité sans régresser le mono-page ? |
| **Hypothèse** | Une page = une `GraphicPage` (géométrie + contenu propres) ; le renderer boucle et **préserve les sauts de page**. Pagination → 100 %, mono-page inchangé. |
| **Protocole** | `GraphicPage` + `GraphicLayer.pages` (rétrocompatible) ; renderer `_draw_page` par page ; extracteur transcrit **toutes** les pages. `render → compare` sur Chapot + SJE + 22 tests moteur. |
| **Résultats** | **Chapot : 87,3 % → 90,8 % (Bronze)** ; Pagination 50 → **100 %** ; 2 pages, **201 textes** reproduits. **SJE : 71,3 % → 77,7 %** ; Pagination 9,1 → **100 %** ; 11 pages, **823 textes / 503 images** extraits. **22 tests moteur verts** (mono-page inchangé). |
| **Interprétation** | Le multi-page fait ce qu'on attendait : la pagination est réparée et le PDF reproduit contient **toutes** les pages. Confirmé : le 71 % de SJE était en partie **artificiel**. **Limite honnête** : l'oracle (`comparator._read`) ne lit que la **page 0** pour le contenu → les pages 2+ ne sont pas encore *mesurées* (seul leur nombre l'est) → **U-014**. C'est une évolution du **thermomètre**, volontairement différée (sprint oracle) — on ne le touche pas pendant qu'on construit le moteur. |
| **Décision** | **Confirmée → gardée.** U-012 close côté format/renderer. |
| **ADR / spec** | Évolution d'infra (format+renderer) **ordonnée par le PO** ; pas d'ADR (directive « aucun nouvel ADR sauf nécessité absolue »). Consignée ici. |
| **Ouverte / Décidée** | 2026-07-24 / 2026-07-24 |

### E-007 — voie C : substitut métrique-compatible  (inconnue : U-013)

Sprint U-013 (stratégie E validée par le PO), phase C : `font_resolver.py` rend
chaque police via un substitut **libre et métriquement compatible** (Liberation
Sans ≡ Arial, Liberation Serif ≡ Times), classé par famille (serif/sans/mono) pour
**généraliser** au-delà d'Arial. Le `.artizen` garde le **nom d'origine** intact
(résolution au rendu → on pourra revenir à la vraie police).

| Maillon | Contenu |
|---|---|
| **Question** | Un substitut métrique-compatible (voie C) répare-t-il les défauts Sprint 2 sans régresser la géométrie ? |
| **Hypothèse** | Métriques Arial exactes + Unicode complet → apostrophe `ʼ` et re-segmentation réglées ; positions maintenues. |
| **Résultats mesurés** | **SJE** : rappel page 1 97,1 → **100 %** ; **pages avec écart 7 → 0** ; global 77,7 → **78,6 %**. **Chapot** : positions 99,8 → 99,9 % ; **Typographie 42,9 → 0 %** → global 90,8 → **84,0 %**. **22 tests moteur verts.** |
| **Interprétation** | Voie C est **objectivement plus fidèle** (positions ↑, rappel SJE 100 % sur *toutes* les pages, Unicode complet). La baisse de Chapot est **entièrement** due à la Typographie *nom* : les 42,9 % étaient un **faux ami** (match de nom fortuit Helvetica orig ↔ repli Helvetica). Liberation Sans (≡ Arial réel de Chapot) est plus proche du vrai rendu, mais l'oracle compare les **noms** → 0. **C'est le cas prévu « rendu meilleur / score nom pire ».** |
| **Décision** | **Gardée** (règle PO : ne jamais dégrader le renderer pour le score ; un rendu plus fidèle au score plus bas → faire évoluer l'oracle). **Preuve mesurée que le prochain verrou est l'oracle** (U-014 + Typographie par métriques, pas par nom) — Sprint 4. |
| **ADR / spec** | Évolution du moteur (renderer + `font_resolver`), ordonnée par le PO. Pas d'ADR. |
| **Ouverte / Décidée** | 2026-07-24 / 2026-07-24 |

**Quand ça cessera de marcher / reste ouvert.** (1) Chapot page 2 garde 3 textes
non appariés (`278-0 ter`, `et`, `279-0 bis`) — re-segmentation résiduelle, hors
apostrophe. (2) Les substituts sont *métrique-exacts* pour Arial/Times ; les autres
familles (Calibri…) seront des approximations visuelles à mesurer sur les
prochaines familles (Sprint 3). (3) Voie A (police embarquée réelle) reste un hook,
à activer quand le mécanisme E-005 sera élucidé et la licence vérifiée.

### E-008 — Sprint 4 : l'oracle mesure enfin le rendu  (inconnue : U-014)

Ouvert par le PO **sur preuve mesurée** : E-007 avait montré un rendu meilleur
avec un score plus bas. Le facteur limitant n'était plus le moteur, mais la
mesure. **Le renderer n'a pas été touché de tout le sprint.**

| Maillon | Contenu |
|---|---|
| **Question** | L'oracle peut-il juger la fidélité **visuelle réelle** — sans jamais récompenser une différence visible, ni pénaliser une différence invisible ? |
| **Hypothèse** | En comparant les propriétés qui **déterminent le rendu** (taille, graisse, italique, **largeur rendue**) au lieu du **nom** de police, et en mesurant **toutes les pages**, le score converge vers la perception humaine. |
| **Protocole** | `comparator.py` : `_Span` sans nom de police (name-blind *par construction*), appariement **page par page**, agrégation document ; 2 indicateurs. Tests dédiés + rejeu du benchmark. Renderer inchangé. |
| **Résultats mesurés** | **Chapot 84,0 → 93,8 % (Bronze)** — Typographie **0 → 83,3 %**. **SJE 78,6 → 94,0 % (Bronze)** — Typographie **0 → 96,7 %**, Structure 97,1 → **100 %** (823/823 textes sur 11 pages). Chapot Structure 100 → 98,5 % : mesure **plus honnête** (toutes pages, les 3 textes récalcitrants de la page 2 comptent enfin). **77 tests verts.** |
| **Validation des deux lois** | ✅ *invisible non pénalisé* : Helvetica ↔ Liberation Sans (mêmes chasses, noms différents) → typographie ≥ 90 %. ✅ *visible détecté* : autre famille < 90 %, autre taille < 50 %. ✅ *toutes les pages* : une divergence en page 3 fait baisser le score. |
| **Interprétation** | Le gain de +9,8 et +15,4 points **ne vient d'aucune amélioration du rendu** — le renderer est identique. Il vient de la **fin d'une pénalité injustifiée**. L'oracle jugeait une étiquette ; il juge désormais ce que l'œil voit. |
| **Décision** | **Confirmée → gardée.** U-014 close. |
| **Ouverte / Décidée** | 2026-07-24 / 2026-07-24 |

**Ce que les deux indicateurs révèlent immédiatement.** Structurelle **99,2 %**
(Chapot) et **100 %** (SJE) : *le placement est résolu*. Perceptuelle **82,8 %** et
**81,9 %** : le retard n'est plus la typographie mais les **images** (Chapot 50 %,
SJE **9,1 %** — 503 images extraites, bien moins restituées). **C'est le prochain
verrou du moteur**, désigné par la mesure et non par l'intuition — exactement ce
pour quoi la séparation structurelle/perceptuelle a été demandée.

### E-009 — Fidélité graphique : le rendu est bon, la métrique est fausse  (inconnue : U-015)

Sprint désigné par le **budget d'erreur** (images = 69,5 % de la perte). *Data
before action* : on diagnostique avant de coder.

| Maillon | Contenu |
|---|---|
| **Question** | La perte « images » (70 % du budget) est-elle un problème de **rendu** ou de **mesure** ? |
| **Diagnostic** | Pipeline original → extrait → rendu, par page. **Correctif d'extraction livré** : toutes les positions via `get_image_info` (au lieu de `rects[0]` qui n'en gardait qu'une) + **déduplication des octets par xref** (SJE : 503 ImageBlocks/503 assets → 55 placements/**12 assets**). |
| **Résultat clé (mesuré)** | Les 12 images distinctes de SJE se décodent **toutes** (JPEG RGB, reportlab OK) — **aucun échec de rendu**. `get_images` compte **605** images (55/page) mais `get_image_info` (ce qui est *dessiné*) en trouve **~5/page** — que le candidat **reproduit**. Le PDF *référence* 55 images/page en ressources, n'en **dessine** que ~5. Budget images **inchangé** (91 %) : le correctif d'extraction ne le bouge pas. |
| **Interprétation** | **Le rendu est visuellement fidèle ; la métrique est fausse.** `image_score` compare des **comptages `get_images`** = références du dictionnaire de ressources, gonflées, **pas ce que l'œil voit**. C'est **le même schéma que la typographie au Sprint 4** (on comparait des *noms*, on doit comparer le *rendu*). Ici : on compte des *artefacts*, on doit compter des *placements dessinés*. |
| **Décision** | Correctif d'extraction **gardé** (modèle plus juste et 40× plus léger). **Recommandation : rendre `image_score` perceptuel** — comparer les placements réellement dessinés (`get_image_info` : nombre + position + aire), pas `get_images`. Changement d'oracle → **feu vert PO attendu** (comme Sprint 4). |
| **Reste ouvert** | Chapot page 2 : le même logo qu'en page 1 est dessiné mais **ni** `get_image_rects` **ni** `get_image_info` ne retrouvent son rectangle → placement manquant (cas limite fitz, à creuser). |
| **Ouverte / Décidée** | 2026-07-24 / (métrique : en attente PO) |

### E-010 — oracle image perceptuel  (inconnue : U-015)

Feu vert PO après E-009 : le rendu était bon, la **mesure** fausse. **Le renderer
n'est pas touché** ; seule la façon de mesurer les images évolue — comme la
typographie au Sprint 4 (nom → rendu ; ici : ressource PDF → image dessinée).

| Maillon | Contenu |
|---|---|
| **Question** | `image_score` peut-il mesurer les images **réellement dessinées** (position, dimensions, aire) au lieu des **ressources** `get_images` (dont beaucoup jamais peintes) ? |
| **Hypothèse** | En comparant les placements de `get_image_info`, pondérés par l'**aire couverte**, un rendu fidèle n'est plus pénalisé et une image manquante reste détectée. |
| **Protocole** | `_read` collecte les images dessinées par page ; `_image_score` = rappel d'aire apparié par position+taille. Renderer inchangé. Tests dédiés + rejeu benchmark. |
| **Résultats mesurés** | **Chapot 93,8 → 96,8 %** ; **SJE 94,0 → 98,7 %** (image 9,1 → ~96 %). **562 tests passent** (0 régression). |
| **Validation des lois** | ✅ *fidèle non pénalisé* (image identique → 100 %). ✅ *manquante/déplacée détectée* (< 50 % + gap). ✅ **test spécial** : PDF **3 références / 1 dessinée** → ancien oracle (comptage) 33 %, **nouveau 100 %**. |
| **Anti-laxisme** | Le gain **ne relâche pas** la mesure : une image absente, déplacée ou redimensionnée est toujours prise. Le score monte **parce que la mesure est plus fidèle à l'œil**, pas plus permissive. |
| **Décision** | **Confirmée → gardée.** U-015 (mesure) close. |
| **Ouverte / Décidée** | 2026-07-24 / 2026-07-24 |

**Le budget d'erreur se recompose — et désigne le prochain sprint, par la donnée :**

```
AVANT E-010 : Images 69,5%  ·  Typographie 26,2%  ·  Structure 4,1%
APRÈS E-010 : Typographie 71,5%  ·  Images 16,8%  ·  Structure 11,1%
```

**La typographie redevient le contributeur n°1 (71,5 %)** — non par intuition, par
recomposition mesurée du budget. C'est le prochain sprint : Chapot Typographie 83,3 %
(la largeur rendue de certains spans diffère encore), SJE 96,7 %.

### E-011 — généralisation sur le Starter Corpus complet (5 familles)

Starter Corpus complété (ADR-012) : Mediabat, Solabaie, **Fenêtre Diffusion,
Pneu, Poêle à bois** (logiciels/métiers différents). Condition d'ADR-021 :
mesurer avant d'optimiser.

| Maillon | Contenu |
|---|---|
| **Question** | Le moteur (extraction → rendu → oracle) **généralise-t-il** au-delà de 2 familles, et la typographie est-elle un verrou **général** ou un cas particulier ? |
| **Résultats mesurés** | **Chapot 96,8 % (Argent) · SJE 98,7 % (Or) · Fenêtre 100 % (Platine) · Pneu 99,0 % (Or) · Poêle 99,1 % (Or).** Aucune famille ne s'effondre. |
| **Budget d'erreur agrégé (5)** | **Typographie 66,3 % · Structure 20,4 % · Images 11,8 % · Mise en page 1,5 %.** |
| **Interprétation** | (1) **L'architecture généralise** : 5 logiciels, tous ≥ 96,8 %, sans heuristique spécifique. (2) **La typographie est le verrou n°1 *général*** (66 %), confirmé sur le corpus — pas un artefact de Chapot. La **Structure** (rappel texte, 20 %) monte en n°2, tirée par les documents longs (Poêle : 453 textes, rappel 98 %). |
| **Décision** | Généralisation **validée**. **Sprint Typographie débloqué** (ADR-021 satisfait). Nouvelle inconnue : **Fenêtre = devis image/scan** (0 texte extrait, 100 % trivial car tout est raster) → **U-016**, un *mode de reproduction distinct*. |
| **Ouverte / Décidée** | 2026-07-24 / 2026-07-24 |

### E-012 — Sprint Typographie  (inconnue : U-013)

Sprint désigné par le budget d'erreur (Typographie = 66 % du corpus, E-011).
Mesuré sur les **4 devis natifs (P1)** — Fenêtre exclue (P2, image).

| Maillon | Contenu |
|---|---|
| **Question** | D'où vient l'écart typographique (largeur rendue), et comment le réduire côté renderer ? |
| **Diagnostic** | **Tous** les échecs sont des écarts de **largeur** (aucun de graisse/taille), petits (3–7 %, un Tahoma à 10 %), sur des polices variées (Helvetica, Arial, Tahoma…). |
| **Hyp. 1 — INFIRMÉE** | « Utiliser la police *exacte* (base-14 Helvetica pour Helvetica) réduit l'écart. » → **aucun effet** : les échecs Helvetica persistent à l'identique. L'écart n'est pas la *famille*, c'est une différence **fine de métriques/chasse** entre tout substitut et la source. Reverté. |
| **Hyp. 2 — CONFIRMÉE** | « Mettre chaque run **à l'échelle horizontale** pour occuper la largeur d'origine (`rect.w`, déjà extraite) absorbe l'écart. » → transform translate+scale sur les runs alignés à gauche. |
| **Résultats mesurés** | **Chapot 96,8 → 99,8 % (Platine)** · SJE 98,7 → 99,2 % · Pneu 99,0 → 99,6 % (Platine) · Poêle 99,1 → 99,9 % (Platine). Typographie : Chapot **83,3 → 98,5**, SJE 96,7 → **100**, Pneu 94 → 97,7, Poêle → **100**. Structure 99,8–100. **30 tests verts.** |
| **Anti-laxisme** | Ce n'est **pas** un relâchement de l'oracle (tolérance largeur inchangée à 2 %) : le texte occupe **réellement** la bonne largeur, donc la mise en page s'aligne comme la source. Coût assumé : les glyphes du substitut sont étirés de quelques % (imperceptible ; ce ne sont déjà pas les glyphes d'origine). |
| **Décision** | **Confirmée → gardée.** U-013 largement résolue. Budget P1 recomposé : Images 50 % · Typographie 41 % (résidu faible) · Structure 5 %. |
| **Ouverte / Décidée** | 2026-07-25 / 2026-07-25 |

### E-013 — fidélité graphique : remplir la bbox image (résidu SJE)

Nuit d'autonomie. Le résidu images de SJE (87,5 %) venait du **renderer** :
`preserveAspectRatio=True` rétrécissait l'image dans sa bbox quand les ratios
différaient. Or la bbox de `get_image_info` **est** l'étendue réellement
dessinée → il faut la **remplir** (`preserveAspectRatio=False`).

| Résultat mesuré | **SJE 99,2 → 100 % (Platine)** ; images 87,5 → 100, perceptuel 96,1 → 100. **Aucune régression** : Chapot 99,8 · Pneu 99,6 · Poêle 99,9 · Fenêtre 100. **33 tests moteur verts.** |
|---|---|

**Reste — non actionnable (consigné).** Le logo de la **page 2 de Chapot** n'est
localisé par **aucune** méthode fitz (`get_image_rects` et `get_image_info` vides
des *deux* côtés) → l'oracle est aveugle **symétriquement** (donc non pénalisé).
Le reproduire exigerait d'**inventer** des coordonnées — interdit
([EXTRACTION_SPEC §3](EXTRACTION_SPEC.md)). Laissé tel quel.

| Exp | Inconnue | Hypothèse | N docs | Résultat (mesuré) | Décision | Statut |
|---|---|---|---|---|---|---|
| _(gabarit — expériences futures ici)_ | U-xxx | … | N | — | — | — |

> **Anti-biais (règle du registre).** (1) Aucun chiffre n'est inscrit s'il n'est
> pas **produit par le benchmark** — pas d'estimation, pas de « à peu près ».
> (2) Une amélioration n'est retenue que si elle est **généralisable** : validée
> sur la famille entière, pas sur un document ; `--gate` doit passer. (3) Un
> résultat qui *infirme* l'hypothèse a **autant de valeur** qu'un succès : il
> lève l'inconnue tout autant.
