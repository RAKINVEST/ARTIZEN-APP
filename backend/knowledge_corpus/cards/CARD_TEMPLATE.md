# <Titre de la carte>

> **Modèle officiel de Knowledge Card** — copier ce fichier pour créer une carte (Brouillon).
> Une carte = **UNE opération métier**, jamais un produit. Respecter [../EDITORIAL_GUIDE.md](../EDITORIAL_GUIDE.md),
> [../TAGGING.md](../TAGGING.md), [../RELATIONSHIP_RULES.md](../RELATIONSHIP_RULES.md).

## Métadonnées (obligatoires *)
| Champ | Valeur |
|---|---|
| Identifiant * | `<uuid ou slug gelé>` |
| Titre * | `<action + objet + contexte>` |
| Profession * | `metier:<slug officiel>` (taxonomie gelée) |
| Famille | `famille:<…>` |
| Sous-famille | `<…>` |
| Version * | `v1.0` |
| Auteur * | `<nom>` |
| Validateur * | `<nom — vide tant que Brouillon>` |
| Statut * | `Brouillon` \| `Validé` \| `Archivé` |
| Indice de confiance | `<facette qualitative>` |

## Cadrage (obligatoires *)
- **Objectif ***: `<le résultat visé, en une phrase>`
- **Résumé ***: `<2–3 phrases, test des 5 secondes>`
- **Description complète** : `<le détail du savoir-faire>`
- **Pré-requis** : `<conditions préalables>`
- **Difficulté** : `simple | moyenne | avancee | expert`
- **Temps moyen** : `<durée indicative>`
- **Compétences nécessaires** : `<…>`

## Ressources
- **Outillage** : `<liste — requiert-outil>`
- **Matériel** : `<liste — requiert-materiau>`
- **Consommables** : `<liste>`
- **Kit conseillé** : `<utilise-kit → objet Kit>`

## Réalisation (obligatoires *)
- **Étapes ***: `1. … 2. … 3. …`
- **Contrôles** : `<vérifications en cours/fin de geste — a-checklist>`
- **Points critiques ***: `<ce qui ne pardonne pas>`
- **Sécurité ***: `<EPI, risques, consignes>`

## Cadre & suites
- **Normes** : `<respecte-norme → standard sourcé>`
- **Garantie** : `<→ objet Warranty>`
- **Maintenance** : `<→ objet Maintenance>`
- **SAV** : `<points de suivi>`
- **Diagnostics liés** : `<traite-diagnostic>`

## Média & preuves
- **Photos** : `<illustree-par → objet Photo/Media>`
- **Vidéos** : `<illustree-par>`
- **Documents** : `<documentee-par → objet Document>`

## Langage & réutilisation
- **Phrases associées** : `<cite-phrase → objet Phrase>`
- **FAQ** : `<questions fréquentes>`
- **Retours terrain** : `<enrichie-par → retours d'expérience>`

## Relations & tags (obligatoires *)
- **Relations ***: `<verbes de RELATIONSHIP_RULES : utilise-kit, traite-diagnostic, variante-de…>`
- **Tags ***: `metier:… famille:… probleme:… equipement:… materiau:… piece:… marque:… complexite:… urgence:… saison:… type:…`

## Historique (append-only)
| Version | Date | Auteur | Validateur | Motif |
|---|---|---|---|---|
| v1.0 | 2026-… | … | … | création |

> **Rappels de conformité** : aucun prix/TVA (le montant vit dans `Catalog`/calculateur — ADR-023) ;
> aucune norme non sourcée ; carte validée = non modifiée en place (nouvelle version) ; pas de
> suppression de contenu métier (archivage — Loi 5).
