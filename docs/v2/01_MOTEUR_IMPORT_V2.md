# ARTIZEN V2 — Moteur d'import de devis (reconstruction complète)

> Nouveau document (hors référentiel V1 gelé). Décision produit : l'import ne
> restitue plus seulement l'identité (logo/couleurs/coordonnées) mais
> **reconstruit le devis complet**, immédiatement modifiable.

## 1. Contexte — pourquoi la V2

La V1 « importait » un devis mais n'en extrayait que l'identité graphique. L'aperçu
était rendu à partir d'un **devis-échantillon codé en dur** (`quotes/document_mapper.py::sample_document`) :
« Client Démonstration », « DEV-2026-0001 », « 10 rue de l'Exemple », lignes et
montants fictifs. Le PDF réel n'était jamais reproduit ; l'artisan voyait de la
donnée de démonstration. **La V2 supprime cette fausse promesse.**

## 2. Règle absolue

**Le PDF importé est la seule source de vérité.** Un champ absent du PDF reste
`null`/vide — jamais inventé. Les montants sont **transcrits tels quels** (aucun
recalcul à l'extraction). Trois barrières font respecter la règle :

1. `schemas.ExtractedQuote` — tous les champs optionnels (rien à remplir de force).
2. `guards.reject_fabricated_data()` — rejette tout littéral de démonstration V1
   (filet anti-régression permanent).
3. `mapper` — si un champ requis pour un rendu fidèle manque (numéro, date, total
   de ligne…), lève `IncompleteExtractionError` en le nommant, au lieu d'inventer.

## 3. Pipeline

```
PDF ─► document_analysis (OCR/analyse : extracted_text)      [existant, réutilisé]
    ─► QuoteExtractor (IA multimodale réelle)                [V2]
    ─► ExtractedQuote (JSON canonique, validé Pydantic)      [V2]
    ─► extracted_quote_to_document → app.pdf.Document        [V2 → moteur de rendu existant]
    ─► HtmlPdfRenderer → PDF de reproduction                 [existant, réutilisé]
       + écran Flutter d'édition lié au JSON                 [V2]
```

Aucune nouvelle table : l'extraction dérive de la ligne `DocumentAnalysis`
existante (qui porte déjà `extracted_text`).

## 4. Contrat canonique `ExtractedQuote`

Entreprise, logo/couleurs (via branding), coordonnées, client, adresses
facturation/chantier, numéro, dates, validité, conditions, mentions légales, TVA
(par taux), remises, acomptes, toutes les lignes (désignation/qté/unité/PU/total,
en-têtes de section), sous-totaux/totaux, coordonnées bancaires, indices de mise
en page (logo, couleurs dominantes, en-tête/pied, zone de signature, colonnes),
et une confiance d'extraction `[0,1]`.

Côté Flutter, le miroir `ExtractedQuote` garde **les montants en `String`**
(exactement comme imprimés) : parser en `double` perdrait la fidélité même que la
V2 protège.

## 5. Fournisseur IA — honnêteté vs qualité

`QuoteExtractor` utilise l'abstraction `app.ai` (provider choisi par clé). Il
**refuse explicitement le mock** (`ExtractionProviderUnavailableError`, 503) :
le mock ne sait pas lire un devis, et renvoyer de l'inventé est interdit. La
*qualité* d'extraction dépend d'une IA réelle ; l'*honnêteté* est garantie quel
que soit le provider.

## 6. Limitations connues (assumées, documentées)

- Le modèle de rendu gelé `app.pdf.Document` n'a pas de type de ligne pour les
  **en-têtes de section** ni les **remises par ligne**. Ces éléments sont
  **conservés dans `ExtractedQuote`** (donc éditables) mais **omis du rendu**
  jusqu'à extension du renderer — on omet plutôt que d'imprimer une fausse ligne
  « 0,00 € ». → sous-tâche renderer (phase d'intégration).
- La disposition visuelle fine (marges, colonnes exactes) est capturée comme
  indices (`layout`) mais le rendu réutilise le gabarit ARTIZEN, pas la
  géométrie pixel du PDF source.
- `sample_document` de la V1 n'est **pas supprimé** : il sert encore l'aperçu
  d'identité du module `branding` (`/quotes/sample-pdf`) et ses tests. Il est
  **déprécié pour l'import** (le chemin V2 ne l'utilise pas) ; sa suppression
  totale est une tâche d'intégration une fois le branding-preview reconsidéré.

## 7. Ce qui est construit (hors ligne) et testé

Backend `app/quote_extraction/` : `schemas`, `exceptions`, `guards`, `mapper`,
`prompt`, `extractor`, `service`, `deps`, `router` (monté dans `api/router.py`).
Frontend `features/quote_extraction/` : modèle, repository (interface+impl),
providers (machine à états), écran d'édition.

Tests : **16 tests unitaires backend** (`app/tests/test_quote_extraction.py`,
`pytest --noconftest`, verts) + **2 tests modèle Flutter** (verts) + `flutter
analyze` sans erreur. Voir le rapport de session.

## 8. Dépendances externes restantes (phase intégration + validation)

1. **Clé IA multimodale** (ex. `ANTHROPIC_API_KEY` sur `artizen-api`) — sans elle
   l'extraction lève 503 par conception. La prod n'en a aucune aujourd'hui.
2. **Corpus de vrais devis** (le « Starter Corpus » : 5 PDF réels) pour régler le
   prompt et **mesurer la fidélité** de bout en bout.
3. Provider Anthropic réel côté backend (branche `anthropic` de `ai/factory` +
   support image dans le prompt), câblage d'un endpoint de persistance en
   brouillon éditable, et extension du renderer (en-têtes de section/remises).
