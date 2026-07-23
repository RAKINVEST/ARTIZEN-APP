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

| Exp | Inconnue | Hypothèse | N docs | Résultat (mesuré) | Décision | Statut |
|---|---|---|---|---|---|---|
| _(gabarit — expériences futures ici)_ | U-xxx | … | N | — | — | — |

> **Anti-biais (règle du registre).** (1) Aucun chiffre n'est inscrit s'il n'est
> pas **produit par le benchmark** — pas d'estimation, pas de « à peu près ».
> (2) Une amélioration n'est retenue que si elle est **généralisable** : validée
> sur la famille entière, pas sur un document ; `--gate` doit passer. (3) Un
> résultat qui *infirme* l'hypothèse a **autant de valeur** qu'un succès : il
> lève l'inconnue tout autant.
