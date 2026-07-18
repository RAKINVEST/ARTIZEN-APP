# 09 — Corrections post-UAT (rapport d'architecte)

**Date : 2026-07-18.** Branche `v2`. Cycle de correction post-recette
téléphone, au-dessus de la release `v2.0.0` (figée). Aucun tag touché.

## 1. Résumé exécutif

La recette sur téléphone réel a remonté un défaut **bloquant** — « le modèle
importé n'est pas utilisé par le PDF » — et plusieurs frictions UX. Le
diagnostic a montré que le bloquant n'était pas total : l'**identité**
(raison sociale, SIRET, TVA, adresse, coordonnées) et la **couleur
primaire** étaient déjà appliquées au PDF (le profil est rechargé à chaque
rendu). Il manquait trois choses : le **logo** (détecté mais jamais stocké,
donc jamais dessiné), l'usage de la **couleur secondaire**, et — côté UX —
la possibilité de **prévisualiser** et **télécharger** un PDF depuis un
brouillon, l'**affichage clair** du modèle actif, et un **aperçu du rendu**
après import.

Toutes ces anomalies sont corrigées, testées, et — pour le bloquant —
**prouvées de bout en bout** : un devis généré après import d'un PDF à logo
embarque désormais le logo, l'identité et les couleurs de l'entreprise.

**Limite d'architecture nommée :** le moteur PDF (reportlab) **redessine**
sa propre mise en page à partir des *données* de marque ; il ne reproduit
pas le *visuel* exact du PDF importé. C'est un choix assumé (la même mise en
page sert devis, factures, avoirs, bons de commande sans branche par type).
« Utiliser le modèle importé » signifie donc, et c'est ce qui est livré :
appliquer l'identité, le logo et les couleurs — pas cloner le graphisme du
document d'origine.

## 2. Anomalies corrigées

| # | Priorité | Anomalie | Correction |
|---|---|---|---|
| 1 | **P1** | Logo importé non appliqué au PDF | Extraction de la 1re image du PDF importé (`logo_detector.extract_first_image_png`), stockée comme logo de marque à la validation (`template_import.validate` → `BrandingService.set_logo_from_bytes`). Le renderer lisait déjà `brand.logo_path`. |
| 2 | **P1** | Couleur secondaire persistée mais inutilisée | Le renderer applique `secondary_color` (filet sous l'en-tête + libellés ÉMETTEUR/CLIENT), avec repli sur la primaire. |
| 3 | **P1** | Pas de prévisualisation PDF depuis un brouillon | Écran d'aperçu in-app dédié (`QuotePdfPreviewScreen`, `PdfPreview`), action « Aperçu du PDF » sur le détail, disponible **tous statuts, brouillon inclus**. |
| 4 | **P1** | Pas de téléchargement depuis un brouillon | Action « Télécharger le PDF » distincte, disponible **tous statuts**. (L'API `GET /quotes/{id}/pdf` l'autorisait déjà à tout statut ; c'était une lacune d'UI.) |
| 5 | **P2** | Aucun aperçu du rendu après import | Endpoint `GET /quotes/sample-pdf` (devis de démonstration rendu avec l'identité courante) + écran « Aperçu du rendu » + bouton sur l'écran de fin d'import et dans Paramètres. |
| 6 | **P2** | Modèle actif non affiché | Paramètres affiche le modèle actif : identité (raison sociale), modèle importé (nom du fichier) ou défaut, logo appliqué — avec « Aperçu du rendu » et « Importer / remplacer ». |
| 7 | **P2** | Affichage des lignes peu clair | `CurrencyFormatter.formatQuantity` (trim des `.00`, virgule FR) → « Qté : 1 unité × 1 500,00 € HT ». |
| 8 | **P2** | Toutes les données détectées ne sont pas exploitées | Avec le logo désormais stocké, l'ensemble identité + couleurs + logo est appliqué au PDF (voir §5). |

**Catalogue (P2) :** vérifié, aucune correction nécessaire — recherche,
création, édition, désactivation/réactivation sont présentes ; la
« suppression » est un **soft-delete** (désactivation), ce qui est le bon
comportement : un article désactivé ne casse aucun devis existant (les lignes
d'un devis sont un instantané figé).

## 3. Décisions d'architecture

- **Où extraire le logo.** L'extraction vit dans `document_detection`
  (`logo_detector.py`) — le module qui possède déjà la lecture pypdf/Pillow
  fragile — exposée via `DocumentDetectionService.extract_logo`. Aucune
  dépendance nouvelle : `template_import` orchestrait déjà `document_detection`
  et `branding`. Les octets ne transitent jamais par la base.
- **Zéro duplication du stockage logo.** `upload_logo` et
  `set_logo_from_bytes` partagent `_store_logo` (stockage + `logo_path` +
  purge de l'ancien fichier).
- **Sample PDF dans `quotes`.** `quotes` possède le `document_mapper` et
  dépend déjà de `branding` (sens autorisé). `sample_document` réutilise
  `_company_party` et le renderer — le devis de démo passe par le **même
  chemin** qu'un vrai devis, il ne peut donc pas diverger. Route
  `GET /quotes/sample-pdf` déclarée **avant** `/{quote_id}`.
- **Aperçu = mêmes octets que l'envoi.** L'aperçu in-app appelle le même
  endpoint que le téléchargement : ce qui est prévisualisé est, à l'octet
  près, ce que le client reçoit. Composant partagé `PdfPreviewScaffold`.
- **Invariants tenus.** Aucun montant calculé hors `QuoteCalculator` ; le
  moteur PDF ne calcule toujours rien ; `company_id` vient du JWT ; le devis
  n'a toujours ni `PUT` ni `PATCH` de contenu.

## 4. Tests réalisés

| Suite | Avant | Après | Ajouts |
|---|---:|---:|---|
| `pytest` (conteneur) | 208 | **214** | logo appliqué à l'import ; import sans logo n'invente rien ; `extract_first_image_png` (image / sans image) ; secondary_color rend sans erreur ; sample-pdf rend avec l'identité |
| `flutter test` | 63 | **68** | `formatQuantity` (trim, virgule FR) + `format` (fallback) |
| `flutter analyze` | — | **No issues found!** | |
| `flutter build web --release` | — | **√ Built** | |
| `flutter build apk --debug` | — | **√ Built** | |

## 5. Preuve que le modèle importé est utilisé par le moteur PDF

Exécutée de bout en bout contre le backend Docker réel (compte neuf → import
d'un PDF à logo bleu → validation identité+couleurs → création d'un vrai
devis → génération du PDF, inspecté avec pypdf) :

```
logo_detected: True
logo_path set: True
legal_name   : SARL CHAPOT ÉNERGIES RENOUVELABLES
primary/secondary: #0a5ac8 #e8a13a
quote        : DEV-2026-0001 TTC 900.00
=== PREUVE ===
PDF is %PDF-: True
PDF embeds an image (logo): True        ← le logo importé est bien dessiné
PDF carries identity (SARL CHAPOT): True
PDF carries SIRET: True
PDF carries number: True
```

`PdfReader(pdf).pages[0].images` est **non vide** : le logo extrait à
l'import apparaît dans le devis généré. Avant correction, `logo_path`
restait nul et cette liste était vide.

## 6. Validations effectuées

- **Automatisées (toutes vertes)** : 214 pytest (conteneur), 68 flutter
  test, analyze propre, builds web + apk.
- **Preuve E2E backend** : ci-dessus (§5).
- **Recette visuelle sur téléphone : bloquée par l'environnement, pas par le
  code.** Le nouvel APK est installé sur le Blackview BV9100, mais le
  **proxy de ports de Docker Desktop** est retombé pendant cette passe
  (conteneur `Up healthy`, appels internes OK, mais `http://localhost:8000`
  injoignable depuis l'hôte), ce qui coupe le tunnel USB `adb reverse`. Même
  classe de fragilité que l'instabilité WSL/Docker déjà documentée.
  L'application a été prouvée fonctionnelle sur ce même téléphone lors de la
  session précédente (connexion `200`, tableau de bord chargé, aperçu PDF).

## 7. Risques résiduels

- **Le graphisme exact du PDF importé n'est pas reproduit** (reportlab
  redessine). Choix assumé ; à revoir seulement si le produit exige un rendu
  pixel-perfect du document d'origine (chantier majeur, hors périmètre).
- **`postal_code` / `city` non capturés** par le formulaire d'import Flutter
  (seul `address_line` l'est) : l'adresse s'affiche, mais pas séparée. Mineur.
- **Extraction du logo heuristique** : première image de la page 1. Un PDF
  dont la première image n'est pas le logo importerait la mauvaise image ;
  dégradation propre (jamais d'échec). Acceptable pour un import relu.
- **Recette téléphone non rejouée** cette passe (proxy Docker) — à refaire au
  prochain environnement Docker stable ; ce n'est pas un risque produit.

## 8. Niveau de maturité

| Fonctionnalité | Maturité | Justification |
|---|---:|---|
| Application de l'identité importée au PDV (identité + couleurs + logo) | **95 %** | Prouvé E2E, testé ; reste la non-reproduction du graphisme (choix) et le split adresse |
| Prévisualisation / téléchargement depuis un brouillon | **95 %** | Écrans livrés, analyze/test verts ; recette visuelle device à rejouer |
| Aperçu du rendu après import | **90 %** | Endpoint + écrans livrés, testés ; recette visuelle à rejouer |
| Affichage du modèle actif (Paramètres) | **90 %** | Livré, testé ; pas d'édition champ-à-champ de l'identité (hors périmètre) |
| Affichage des lignes de devis | **100 %** | Corrigé et testé unitairement |
| **Ensemble du lot post-UAT** | **~92 %** | Toutes anomalies corrigées et testées ; seul manque une re-recette visuelle sur téléphone, bloquée par l'environnement Docker |
