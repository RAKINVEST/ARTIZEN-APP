# Decision Log — moteur de clonage documentaire (ADR)

Le journal des **décisions d'architecture** de la plateforme d'ingénierie
documentaire. Chaque entrée est un *Architecture Decision Record* : la décision,
son pourquoi, sa date. Dans un an, à la question « pourquoi avons-nous fait ce
choix ? », la réponse est ici.

Convention : `ADR-NNN` immuable. Une décision qu'on renverse n'est pas effacée —
on ajoute un nouvel ADR qui `remplace` l'ancien, en gardant la trace. Complète
(ne remplace pas) les décisions **produit** de [`docs/DECISIONS.md`](../../../docs/DECISIONS.md).

| ID | Décision | Pourquoi | Date | Statut |
|---|---|---|---|---|
| ADR-001 | Renderer déterministe **avant** l'extraction | Réduire le risque : un renderer prouvé fixe la cible que l'extraction devra alimenter ; l'inverse aurait couplé deux inconnues | 2026-07 | Acté |
| ADR-002 | L'IA est limitée à la **compréhension** (jamais au dessin) | Garantir un rendu reproductible et sans coût par document ; l'IA attribue des rôles, elle n'invente ni coordonnée ni montant | 2026-07 | Acté |
| ADR-003 | Format `.artizen` en **3 couches** (graphique/métier/comportemental) | Séparer ce qui se rend, ce qui varie, ce qui se calcule → généricité (devis/facture/avoir…) | 2026-07 | Acté |
| ADR-004 | **Oracle** de fidélité PDF↔PDF comme juge unique | Piloter par la mesure, pas par l'impression ; toute régression visible en chiffres | 2026-07 | Acté |
| ADR-005 | Développer l'extraction **contre un corpus réel**, jamais synthétique | Un rendu parfait sur un PDF maison ne prouve rien ; éviter le biais du premier PDF | 2026-07 | Acté |
| ADR-006 | **Anonymiseur** obligatoire à l'ingest | Le risque n°1 du corpus est juridique (PII) ; protéger avant que le corpus grossisse | 2026-07 | Acté |
| ADR-007 | **Constitution d'extraction** figée avant tout code (EXTRACTION_SPEC v1.0) | La Brique 4 doit évoluer de façon contrôlée : primitives, ordre, invariants, seuils définis d'avance | 2026-07 | Acté |
| ADR-008 | **Replay** — benchmarks reproductibles (hash d'entrée + empreinte) | Pouvoir affirmer « v0.8 a fait baisser Batappli de 99,3 à 98,9 » sans ambiguïté | 2026-07 | Acté |
| ADR-009 | **Double Gold** + accord inter-annotateurs (6ᵉ KPI) | Prouver que la *référence elle-même* est fiable, pas seulement le moteur | 2026-07 | Acté |
| ADR-010 | Gouvernance à 3 états (Draft→Reviewed→**Certified**) ; seul le certifié entre au benchmark officiel | Empêcher qu'une référence erronée ou non validée fausse un chiffre officiel | 2026-07 | Acté |
| ADR-011 | **Garde-fou de régression** par famille au merge | Une heuristique qui gagne sur Batappli mais perd sur EBP n'est pas automatiquement acceptable — éviter l'accumulation de cas particuliers | 2026-07 | Acté |
| ADR-012 | `layout_family` au manifeste pour le Starter Corpus | Les 5 documents doivent être *structurellement* différents ; interdire les doublons déguisés (deux exports d'un même modèle Word) | 2026-07 | Acté |

## Décisions volontairement **différées** (à trancher avec des données)

| Sujet | Position actuelle | À décider quand |
|---|---|---|
| Seuil d'accord 99,0 % | Empirique, provisoire | Après le premier corpus réel (recalibrage) |
| Arbitre (3ᵉ niveau du Double Gold) | Prévu au protocole, non implémenté | Au premier désaccord A/B irréductible |
| Vraie tolérance couleur ΔE\*ab < 2,0 dans l'oracle | Approximée par quantification 16 niveaux | Avant toute certification Or/Platine |
| Extraction de tables (structures dérivées) | Spécifiée, non codée | Brique 4, sur corpus réel |
