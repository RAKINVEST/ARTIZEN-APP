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

## Comment contribuer un cas

1. Déposer le `.pdf` réel dans le bon dossier (radical `source-NNN.pdf`).
2. Lancer l'import → obtenir le `.artizen.json`.
3. Rendre le `.artizen.json` → **valider à l'œil** contre l'original.
4. Une fois conforme, geler le rendu en `.expected.pdf`.

Tant que l'étape 1 n'a pas de vrais fichiers, les briques 4 (extraction) et 5
(enrichissement IA) restent des coquilles non prouvables.
