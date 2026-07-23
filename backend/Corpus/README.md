# Corpus Officiel ARTIZEN

Le banc d'essai permanent du **moteur de clonage documentaire**. Chaque PDF réel
déposé ici devient un cas de test vivant : on mesure, à chaque évolution du
moteur, si le rendu ARTIZEN se rapproche — ou s'éloigne — de l'original de
l'artisan. C'est la moitié « données » de la plateforme d'évaluation ; la moitié
« mesure » (le comparateur de fidélité) vit dans
[`app/document_clone/comparator.py`](../app/document_clone/comparator.py).

> **Ce dossier est vide de PDF pour l'instant — c'est normal, et c'est le
> blocage n°1.** Le moteur ne peut pas être développé ni certifié contre des
> devis *synthétiques* (un rendu parfait sur un PDF maison ne prouve presque
> rien). Il faut de **vrais devis natifs** exportés par les logiciels du marché.

## Starter Corpus — 5 documents, pas 1, pas 100

Le premier extracteur épouserait la structure du **premier** PDF qu'il voit
(biais classique : Entreprise → Client → Tableau → Totaux gravé en dur), et il
faudrait tout réécrire au deuxième document. Un seul PDF est donc un piège ; cent
sont inutiles pour *démarrer*. La bonne amorce est un **Starter Corpus de 5
documents très différents** — le moteur voit immédiatement ce qui est invariant,
ce qui varie, ce qui doit être générique :

1. **1 Batappli** &nbsp; 2. **1 EBP** &nbsp; 3. **1 Word→PDF** &nbsp; 4. **1 Excel→PDF** &nbsp; 5. **1 personnalisé**

La Brique 4 (extraction) démarre **exclusivement** sur ces 5. En parallèle, la
collecte progresse vers **100–200 documents** répartis par logiciel et par style
— l'actif long terme qui fera du Document Intelligence Engine un avantage
concurrentiel. Court terme : 5 pour développer. Long terme : 200 pour durcir.

## Ingest — le pipeline d'entrée dans le corpus

Aucun fichier n'entre à la main. [`ingest.py`](../ingest.py) (CLI) +
[`app/document_clone/ingest.py`](../app/document_clone/ingest.py) automatisent
l'entrée, sans jamais supposer quoi que ce soit du contenu :

```
PDF original
   ↓  Validation      lisible ? au moins une page ?
   ↓  Analyzer        natif / hybride / image + ★
   ↓  Anonymiseur     PII structurée retirée (email/IBAN/tél/SIRET)
   ↓  Classement      Corpus/<logiciel>/<id>.pdf   (version anonymisée)
   ↓  Manifeste       manifest.json — statut pending_extraction
```

```
docker compose exec backend python ingest.py mon-devis.pdf --software Batappli
docker compose exec backend python ingest.py --list
docker compose exec backend python ingest.py --promote batappli-001
```

Le risque n°1 du corpus est **juridique**. [`anonymizer.py`](../app/document_clone/anonymizer.py)
retire déterministement email / IBAN / téléphone / SIRET-SIREN en préservant la
mise en page (seule chose que le moteur étudie). Noms, adresses, BIC et signatures
ne sont **pas** auto-anonymisés — ils sont *signalés* (`manual_review_required`),
jamais silencieusement manqués.

### Le manifeste — source de vérité du corpus

`Corpus/manifest.json` référence chaque document et son avancement :

```json
{
  "id": "batappli-001", "software": "Batappli", "document_type": "devis",
  "pages": 2, "native_pdf": true, "anonymized": true,
  "gold_standard": false, "status": "pending_extraction"
}
```

Cycle de vie : `pending_extraction → extracted → pending_validation →
gold_standard` (ou `rejected`).

### Gouvernance : le Gold Standard exige une validation humaine

**Un document n'entre au Gold Standard qu'après validation humaine.** L'ingest
écrit *toujours* `gold_standard: false`. Seul `python ingest.py --promote <id>` —
un geste humain explicite, qui **exige le triplet complet** (`.pdf` +
`.artizen.json` + `.expected.pdf`) sur le disque — bascule le drapeau. Une
promotion sur triplet incomplet est refusée. Cette discipline empêche une
référence erronée de fausser tous les benchmarks suivants.

## Arborescence

Un sous-dossier par source, parce que chaque logiciel a sa signature (structure
de texte, polices embarquées, tableaux, calques) et que le moteur devra être
certifié **source par source** (« Compatible Batappli : Or »).

| Dossier | Source |
|---|---|
| `Batappli/` | Export PDF Batappli |
| `EBP/` | EBP Devis & Factures |
| `Sage/` | Sage Multi Devis / Batigest |
| `Tolteck/` | Tolteck |
| `Obat/` | Obat |
| `Word/` | Modèle Word → PDF |
| `Excel/` | Modèle Excel → PDF |
| `LibreOffice/` | LibreOffice Writer/Calc → PDF |
| `Scan/` | Devis papier scanné (image, sans couche texte) |
| `Hybrides/` | PDF mêlant texte natif + fond image |
| `Cas-limites/` | Multi-pages, très longs, remises complexes, TVA multiples, sans logo… |

## Convention Gold Standard

Un cas de référence est un **triplet** portant le même radical :

```
Batappli/
  batappli-001.pdf            # 1. l'original de l'artisan (l'entrée)
  batappli-001.artizen.json   # 2. le template compilé (Analyzer + extraction + IA)
  batappli-001.expected.pdf   # 3. le rendu attendu, validé à l'œil comme conforme
```

* **`.pdf`** — le devis réel, tel qu'exporté par le logiciel. Anonymisé si
  besoin (nom client, adresse), mais on **ne retouche jamais la mise en forme**.
* **`.artizen.json`** — la sérialisation du template ([`ArtizenTemplate`](../app/document_clone/artizen_format.py)),
  produit par le pipeline d'import. C'est l'artefact que l'extraction doit
  savoir reconstruire.
* **`.expected.pdf`** — le rendu déterministe ([`render_artizen`](../app/document_clone/renderer.py))
  du `.artizen.json`, une fois **validé visuellement** comme fidèle. Il gèle la
  cible : toute régression du moteur se voit en comparant le nouveau rendu à ce
  fichier gelé.

Le benchmark, à terme, boucle sur ces triplets :
`compare_pdfs(original.pdf, render_artizen(artizen.json))` → score + écarts, et
compare aussi au `.expected.pdf` pour détecter les régressions pures.

## Niveaux de certification

Le score global du comparateur (catégories pondérées : Structure 33 %, Mise en
page 27 %, Typographie 16 %, Couleurs 11 %, Images 6 %, Pagination 7 %) place
chaque rendu sur une échelle :

| Badge | Seuil | Lecture |
|---|---|---|
| **Platine** | ≥ 99,5 % | Indiscernable de l'original |
| **Or** | ≥ 98 % | Conforme, écarts imperceptibles |
| **Argent** | ≥ 95 % | Fidèle, écarts mineurs repérables |
| **Bronze** | ≥ 90 % | Reconnaissable, à retoucher |
| *Non certifié* | < 90 % | À reprendre |

Une source n'est déclarée « supportée » que lorsqu'un échantillon représentatif
de son dossier atteint le badge visé.

## Les 5 KPIs : Fidélité + Couverture + Confiance + Temps + Auto-pass

La certification ci-dessus mesure la **fidélité** : *ce qu'on a reproduit est-il
conforme ?* Mais un rendu peut être fidèle à 99,8 % sur le cinquième du document
qu'il a compris, et ignorer la signature, l'adresse de chantier et les mentions
légales. Quatre axes, donc, qui doivent progresser **ensemble** :

| Indicateur | Question | Où il est mesuré |
|---|---|---|
| **Fidélité** | Le document est-il reproduit fidèlement ? | [`comparator.py`](../app/document_clone/comparator.py) |
| **Couverture** | Quelle proportion des éléments ARTIZEN reconnaît-elle vraiment ? | [`extract_report.py`](../app/document_clone/extract_report.py) |
| **Confiance** | Le moteur est-il *sûr* de chaque élément reconnu ? | [`extract_report.py`](../app/document_clone/extract_report.py) |
| **Temps de validation** | Combien de temps / de corrections l'artisan doit-il fournir ? | `.meta.json` (Template Studio) → [`benchmark.py`](../app/document_clone/benchmark.py) |
| **Auto-pass** | Quelle part des documents n'a demandé **aucune** correction ? | [`benchmark.py`](../app/document_clone/benchmark.py) |

La couverture et la confiance se lisent sur le **rapport d'extraction** de chaque
document (✓ détecté 99 % / ⚠ absent / ⚠ inconnu). Un élément *confirmé absent*
sort du dénominateur de couverture (il est N/A) ; un élément *inconnu* y reste
(c'est le travail qui manque). La confiance, par élément, permet au **Template
Studio** de ne demander une validation humaine que sur le douteux (Signature 43 %
→ « à valider »), jamais sur tout le document.

Le **temps de validation** est le KPI commercial décisif : si ARTIZEN fait passer
la correction d'un premier import de 5 minutes à 20 secondes, c'est un argument
énorme. Il se mesure côté Studio (secondes, nombre de corrections, nombre de
clics) et se dépose dans un sidecar `<radical>.meta.json` que le benchmark agrège.

L'**auto-pass** est le KPI R&D qui suit les progrès du moteur : sur 200 documents,
172 sans aucune correction → 86 %. C'est la mesure la plus parlante de « le moteur
s'améliore-t-il ? » entre deux versions.

L'argument commercial se lit alors : « ARTIZEN reproduit votre devis à 99 %, en
reconnaît 96 % des éléments, sait lesquels vous montrer pour relecture, vous fait
valider en 20 secondes, et passe 86 % des devis sans retouche ».

## Benchmark permanent — Brique Q1

Une brique *qualité*, pas technique : [`benchmark.py`](../app/document_clone/benchmark.py)
+ la CLI [`../benchmark.py`](../benchmark.py). Une commande —

```
docker compose exec backend python benchmark.py --label v0.5
```

— parcourt tout le `Corpus/`, exécute la chaîne mesurable sur chaque document
(Analyzer sur tous ; rendu + comparateur + certification sur les Gold Standards),
et produit un rapport consolidé (Markdown + JSON) : les 4 KPIs par logiciel, les
certifications, et les **régressions** détectées face au run précédent. Chaque run
s'ajoute à `benchmark_history.json` — le journal des tendances `v0.4 → v0.5 → v0.6`
par logiciel, versionné. C'est l'instrument qui rend la Brique 4 *pilotable* :
version après version, on voit objectivement si une modification améliore ou
dégrade un logiciel donné.

Le tableau de bord du benchmark, une fois le corpus rempli, agrégera par source :

| Logiciel | Documents testés | Fidélité moyenne | Couverture |
|---|---|---|---|
| Batappli | 28 | 99,2 % | 96 % |
| EBP | 15 | 98,7 % | 91 % |
| Sage | 12 | 97,9 % | 89 % |
| Tolteck | 10 | 99,5 % | 98 % |

*(valeurs d'illustration — le benchmark reste gelé tant qu'il n'y a pas de vrais
PDF à mesurer.)*

## Comment contribuer un cas

1. Déposer le `.pdf` réel dans le bon dossier (radical `source-NNN.pdf`).
2. Lancer l'import → obtenir le `.artizen.json`.
3. Rendre le `.artizen.json` → **valider à l'œil** contre l'original.
4. Une fois conforme, geler le rendu en `.expected.pdf`.

Tant que l'étape 1 n'a pas de vrais fichiers, les briques 4 (extraction) et 5
(enrichissement IA) restent des coquilles non prouvables.

## Évolution naturelle : la mémoire documentaire

Une fois le Template Studio en place (extraction → l'artisan corrige → correction
enregistrée), le moteur peut **mémoriser ces corrections** : quelques mois plus
tard, même logiciel + même modèle → reconnaissance immédiate, sans nouvelle passe
IA. C'est la suite logique du Document Intelligence Engine — une mémoire
documentaire qui s'affine à l'usage. À ne pas coder avant que le Studio et le
flux de correction existent (règle : aucune ligne de code sans un document réel
qui la justifie), mais à garder en ligne de mire dès la conception du format des
corrections.
