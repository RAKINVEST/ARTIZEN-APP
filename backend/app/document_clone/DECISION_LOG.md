# Decision Log — moteur de clonage documentaire (ADR)

Le journal des **décisions d'architecture** de la plateforme d'ingénierie
documentaire. Chaque entrée est un *Architecture Decision Record* : la décision,
son pourquoi, sa date. Dans un an, à la question « pourquoi avons-nous fait ce
choix ? », la réponse est ici.

Convention : `ADR-NNN` immuable. Une décision qu'on renverse n'est pas effacée —
on ajoute un nouvel ADR qui `remplace` l'ancien, en gardant la trace. Complète
(ne remplace pas) les décisions **produit** de [`docs/DECISIONS.md`](../../../docs/DECISIONS.md).
Les questions encore **ouvertes** vivent dans [`UNKNOWNS.md`](UNKNOWNS.md).

**Statut** de chaque ADR : **Active** (en vigueur) · **Superseded** (remplacée par
un ADR ultérieur, gardée pour l'histoire) · **Rejected** (envisagée, écartée).
Une bonne architecture évolue : conserver l'historique sans laisser croire qu'une
décision remplacée est toujours en vigueur.

| ID | Décision | Pourquoi | Date | Statut |
|---|---|---|---|---|
| ADR-001 | Renderer déterministe **avant** l'extraction | Réduire le risque : un renderer prouvé fixe la cible que l'extraction devra alimenter ; l'inverse aurait couplé deux inconnues | 2026-07 | Active |
| ADR-002 | L'IA est limitée à la **compréhension** (jamais au dessin) | Garantir un rendu reproductible et sans coût par document ; l'IA attribue des rôles, elle n'invente ni coordonnée ni montant | 2026-07 | Active |
| ADR-003 | Format `.artizen` en **3 couches** (graphique/métier/comportemental) | Séparer ce qui se rend, ce qui varie, ce qui se calcule → généricité (devis/facture/avoir…) | 2026-07 | Active |
| ADR-004 | **Oracle** de fidélité PDF↔PDF comme juge unique | Piloter par la mesure, pas par l'impression ; toute régression visible en chiffres | 2026-07 | Active |
| ADR-005 | Développer l'extraction **contre un corpus réel**, jamais synthétique | Un rendu parfait sur un PDF maison ne prouve rien ; éviter le biais du premier PDF | 2026-07 | Active |
| ADR-006 | **Anonymiseur** obligatoire à l'ingest | Le risque n°1 du corpus est juridique (PII) ; protéger avant que le corpus grossisse | 2026-07 | Active |
| ADR-007 | **Constitution d'extraction** figée avant tout code (EXTRACTION_SPEC v1.0) | La Brique 4 doit évoluer de façon contrôlée : primitives, ordre, invariants, seuils définis d'avance | 2026-07 | Active |
| ADR-008 | **Replay** — benchmarks reproductibles (hash d'entrée + empreinte) | Pouvoir affirmer « v0.8 a fait baisser Batappli de 99,3 à 98,9 » sans ambiguïté | 2026-07 | Active |
| ADR-009 | **Double Gold** + accord inter-annotateurs (6ᵉ KPI) | Prouver que la *référence elle-même* est fiable, pas seulement le moteur | 2026-07 | Active |
| ADR-010 | Gouvernance à 3 états (Draft→Reviewed→**Certified**) ; seul le certifié entre au benchmark officiel | Empêcher qu'une référence erronée ou non validée fausse un chiffre officiel | 2026-07 | Active |
| ADR-011 | **Garde-fou de régression** par famille au merge | Une heuristique qui gagne sur Batappli mais perd sur EBP n'est pas automatiquement acceptable — éviter l'accumulation de cas particuliers | 2026-07 | Active |
| ADR-012 | `layout_family` au manifeste pour le Starter Corpus | Les 5 documents doivent être *structurellement* différents ; interdire les doublons déguisés (deux exports d'un même modèle Word) | 2026-07 | Active |
| ADR-013 | **Deux natures de code** : infrastructure (stable) vs expérimental (`extraction/`) | Empêcher qu'une expérimentation d'heuristique contamine les fondations mesurées | 2026-07 | Active |
| ADR-014 | **Critères de sortie de Phase R&D** mesurables (5 docs, 50 certifiés, fidélité ≥99, couverture ≥95, auto-pass ≥90, validation ≤20 s, 0 régression/3 versions) | Savoir *quand* la R&D se termine, pas seulement quand elle commence → passage R&D → Production | 2026-07 | Active |
| ADR-015 | **Périmètre gelé aux devis** jusqu'à maîtrise complète de la boucle | Risque de succès : un moteur générique ne le devient qu'après robustesse prouvée sur un domaine restreint (pas de factures/avoirs/contrats/bons avant) | 2026-07 | Active |
| ADR-016 | **Objectif = réduire l'incertitude** (registre UNKNOWNS), plus ajouter des briques | La plateforme est complète ; désormais la vérité vient des données, pas de la réflexion | 2026-07 | Active |
| ADR-017 | « Brique 4 » renommée **Programme expérimental d'extraction** ; cycle *Hypothèse→Expérience→Mesure→Décision→ADR/spec* | Ce n'est plus « développer une fonctionnalité » mais transformer des inconnues en connaissances validées ; la fin est actée par [SUCCESS_CRITERIA.md](SUCCESS_CRITERIA.md) | 2026-07 | Active |

## Décisions volontairement **différées** (à trancher avec des données)

| Sujet | Position actuelle | À décider quand |
|---|---|---|
| Seuil d'accord 99,0 % | Empirique, provisoire | Après le premier corpus réel (recalibrage) |
| Arbitre (3ᵉ niveau du Double Gold) | Prévu au protocole, non implémenté | Au premier désaccord A/B irréductible |
| Vraie tolérance couleur ΔE\*ab < 2,0 dans l'oracle | Approximée par quantification 16 niveaux | Avant toute certification Or/Platine |
| Extraction de tables (structures dérivées) | Spécifiée, non codée | Brique 4, sur corpus réel |
