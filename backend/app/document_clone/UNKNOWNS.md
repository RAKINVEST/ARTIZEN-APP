# Registre des inconnues — UNKNOWNS

Le pendant des [ADR](DECISION_LOG.md). Un ADR enregistre une **décision** ; ce
registre enregistre une **question à laquelle le projet ne sait pas encore
répondre**. La règle de la Phase R&D : *chaque inconnue devient une expérience,
jamais une opinion.* On ne tranche une inconnue qu'avec une mesure sur le corpus
réel — pas par la réflexion.

Objectif du projet à partir de maintenant : **réduire cette liste**, pas ajouter
des briques.

| ID | Inconnue | Comment la résoudre ? | Statut |
|---|---|---|---|
| U-001 | Les tableaux EBP sont-ils toujours détectables *géométriquement* (lignes/rectangles) ? | Tester la détection sur 20 PDF EBP réels | Ouverte |
| U-002 | Le seuil d'accord de **99 %** est-il réaliste ? | Mesurer l'accord de deux annotateurs indépendants sur le Starter Corpus | Ouverte |
| U-003 | Quelle **couverture** moyenne obtient-on sur des **scans** ? | Construire un sous-corpus `Scan/`, mesurer Analyzer + extraction OCR | Ouverte |
| U-004 | Combien de **familles de mise en page** existe-t-il par logiciel ? | Cataloguer `layout_family` au fil de l'ingest | Ouverte |
| U-005 | Les polices sont-elles **embarquées** dans les exports réels, ou substituées ? | Mesurer `embedded_font_count` sur tout le corpus | Ouverte |
| U-006 | L'anonymiseur **laisse-t-il passer** de la PII (noms, adresses) sur de vrais devis ? | Relecture manuelle d'un échantillon, taux de PII résiduelle | Ouverte |
| U-007 | Sur les PDF **hybrides**, quel pipeline gagne (structurel vs OCR) ? | Comparer les deux sur un sous-corpus `Hybrides/` | Ouverte |
| U-008 | La convention d'arrondi **par ligne** (française) est-elle respectée par tous les logiciels ? | Comparer les totaux reconstruits aux originaux réels | Ouverte |
| U-009 | La quantification couleur 16 niveaux suffit-elle, ou faut-il un vrai **ΔE\*ab** ? | Mesurer les faux positifs/négatifs couleur sur le corpus | Ouverte |
| U-010 | Combien de logiciels écrivent le texte **lettre par lettre espacée** (« S A R L »), cassant les regex de champs ? | Observé sur Mediabat (E-001). Normaliser le texte avant regex, mesurer le gain sur le corpus | **Résolue → E-003** (Mediabat réparé, SJE non régressé) |
| U-011 | Comment récupérer **nom d'entreprise** et **TVA** quand les chiffres sont *groupés* (« 948 081 807 ») et que la 1re ligne n'est pas la raison sociale ? | Regex VAT tolérant les espaces + heuristique de nom moins naïve. Mesurer sur le corpus (distincte de U-010) | **Ouverte (observée sur Chapot, E-003)** |
| U-012 | Le format `.artizen` et le renderer sont **mono-page** ; les vrais devis sont **multi-pages** (SJE = 11 pages). Comment étendre sans casser le déterminisme ? | `GraphicPage` + `pages` + renderer `_draw_page` par page | **Résolue → E-006** (Chapot 90,8 %, Pagination 100 %, 22 tests verts) |
| U-014 | L'**oracle** ne lit que la **page 0** → fidélité des pages 2+ non mesurée ; et il compare les **noms** de police, pénalisant un rendu identique | Sprint 4 (E-008) : appariement page par page + typographie par **métriques** (taille/graisse/italique/largeur rendue), `_Span` sans nom de police | **Résolue → E-008** (Chapot 84→93,8 %, SJE 78,6→94 %, 77 tests verts) |
| U-015 | **Fidélité graphique** — couche dessinée non textuelle. Diagnostic (E-009) : le **rendu était fidèle**, la **mesure fausse** (`image_score` comptait les ressources `get_images`, pas les images dessinées). | E-009 : extraction dédupliquée + toutes positions. **E-010 : `image_score` perceptuel** (placements `get_image_info`, aire) → Chapot 93,8→96,8 %, SJE 94→98,7 %, 562 tests verts | **Résolue (mesure) → E-010** ; reste le cas limite Chapot p2 |
| U-013 | Les **polices** ne sont pas embarquées → repli au rendu. Impact plus large que prévu (analyse Sprint 2, E-006) : **(1)** Typographie basse ; **(2)** rappel texte −2 à −6 %/page car le repli n'a pas certains caractères (**`ʼ` U+02BC**) et ses métriques font **re-segmenter** les spans par `fitz` (« 278-0 ter » → « 278-0 »+« ter »). La mise en page, elle, reste fidèle (positions 99,9 %). | Étude → [TYPOGRAPHY_STRATEGY.md](TYPOGRAPHY_STRATEGY.md) ; stratégie **E validée par le PO** ; **voie C livrée** (`font_resolver.py`, E-007) : substitut métrique libre, `.artizen` garde le nom d'origine. Reste la greffe voie A (police embarquée) quand E-005 sera élucidé + licence vérifiée | **Voie C résolue → E-007** ; voie A ouverte |

Convention : `U-NNN` immuable. Une inconnue résolue passe en `Résolue → ADR-xxx`
(la réponse devient une décision) ou `Résolue → sans impact`. On ne supprime pas
une ligne : on garde la trace de ce qu'on ignorait et de comment on l'a levé.

## La métrique phare de la Phase 3 : inconnues éliminées

À chaque point d'avancement, **l'indicateur n°1 n'est plus la fidélité — c'est le
nombre d'inconnues éliminées.** Il mesure directement la *réduction du risque
scientifique* : les KPI disent à quel point le moteur est performant ; les
inconnues disent à quel point on **comprend** réellement le problème. Les deux
dimensions sont complémentaires.

| Point | Inconnues ouvertes | Inconnues résolues |
|---|---|---|
| S0 (départ, corpus vide) | 9 | 0 |
| S1 (2 devis réels : Mediabat + Solabaie) | 10 | 1 |
| S2 (1re extraction réelle, E-004) | 12 | 1 |
| S3 (multipage, E-006) | 13 | 2 |
| S4 (oracle perceptuel, E-008) | 15 | 4 |
| S5 (budget d'erreur + oracle image, E-010) | 15 | 6 |

De S0 à S1, le corpus réel a **ouvert** 2 inconnues (U-010, U-011 — invisibles sans
données) et **fermé** 1 (U-010 → E-003). Le total *monte* d'abord : c'est sain — le
réel révèle ce que la réflexion ne voyait pas. La courbe ne descend qu'ensuite.

U-001..009 sont toutes **ouvertes en 2026-07** (S0). Cette date d'ouverture est la
base du **KPI du laboratoire** — le délai moyen *inconnue → décision* (cf
[EXPERIMENTS.md](EXPERIMENTS.md)) : il mesure la santé du *laboratoire* (Produit
B), pas la performance du moteur (Produit A).

*(À compléter à chaque expérience du Starter Corpus — la courbe descendante des
inconnues ouvertes est le vrai tableau de bord de la Phase 3.)*

Le détail de chaque expérience (hypothèse → mesure → décision) est tenu dans
[EXPERIMENTS.md](EXPERIMENTS.md) — le registre qui ferme la boucle
inconnue → expérience → ADR.
