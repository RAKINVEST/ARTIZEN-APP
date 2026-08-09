# ADR-0024 — Représentation de la PAC dans le Book System (proposé)

> **Version** 1.3 — **Status** Accepted — **Owner** Lead Engineer — **Last Update** 2026-08-09
> **Depends On:** [ADR-0000-adopter-les-adr.md](ADR-0000-adopter-les-adr.md), Book System (`knowledge_corpus/books/BOOK_SYSTEM.md`, Validated), Taxonomie (`docs/TAXONOMIE-METIERS.md`) — **Used By:** production éditoriale (Livres), Factory, Knowledge/Decision/Companion — **Niveau:** 2 · Gouvernance documentaire
>
> **Décision acceptée par le Product Owner (2026-08-09)** — validation humaine requise (Loi 7/18). La migration (Option B) est désormais autorisée ; elle procède en vagues (Wave 1 : 4 contenus tranchés ; Wave 2 : 11 arbitrages + 8 doublons).

## Statut
**Accepted** (2026-08-09, PO) — Option B retenue. La migration PAC (re-tag/re-home vers les activités réelles + projection `equipement:pac`) est autorisée ; la production éditoriale reprend selon ce modèle (« Livre PAC » = projection, jamais un Livre).

## Contexte
La construction d'un « Livre III — PAC » (parallèle aux Livres Plomberie et Chauffage) a produit 15 contenus taggés `metier:pac`. La Factory les a acceptés (0 bloquant) mais a émis **15 warnings `metier_hors_taxonomie`** : `pac` n'existe pas dans la taxonomie gelée des 62 activités. Ce warning révèle un conflit de fond entre l'intention « PAC = Livre » et les fondations documentaires.

## Problème
Quelle est la **représentation correcte et définitive** de la pompe à chaleur dans Artizen, de sorte qu'elle soit cohérente avec la taxonomie, le Book System, le Blueprint, le Domain Model, le Knowledge Corpus et la gouvernance — et qu'elle **n'introduise aucune incohérence future** sur les 62 Livres ?

---

## 1. Pourquoi PAC entre-t-il en conflit avec la taxonomie ?
- La taxonomie (`docs/TAXONOMIE-METIERS.md`, `catalog/trades/taxonomy.py`) est **gelée** : 6 familles → **62 activités** → qualifications. Les **slugs sont gelés** (« choisis une fois, jamais renommés »). `pac` **n'y figure pas** ; y figurent `chauffage`, `climatisation`, `geothermie`, `froid`, `electricite-generale`.
- Règle taxonomie n°1 : **« Un métier = une ou plusieurs activités. Le métier (ce que l'artisan *est*) n'est pas stocké ; les activités le sont. »** Un « installateur de PAC » n'est pas une activité : c'est un professionnel exerçant **plusieurs activités** (chauffage air/eau, climatisation air/air, géothermie, **froid/frigorifique** sous qualification F-Gaz, électricité).
- La PAC est déjà **officiellement modélisée comme un équipement** : `knowledge_corpus/taxonomy/EQUIPMENT_TYPES.md` définit l'axe `equipement:` et y liste **`pac`** (multi-valué).

**Conclusion** : PAC est un **équipement transversal**, pas une activité. La taxonomie l'a déjà tranché.

## 2. Quelle règle du Blueprint / quelles Lois sont concernées ?
- **Book System, Invariant n°1** (doc *Validated*) : « Collection = famille (6), **Livre = activité (62) — jamais une unité hors taxonomie**. »
- **Book System, Invariant n°5** : « **Évolution structurelle = ADR** (créer/…/ajouter une profession). » → toute élévation de PAC au rang de Livre **exige cet ADR**.
- **Book System, section « Cas transversal (ex. PAC) »** : nomme **explicitement** la PAC comme équipement `equipement:pac`, « **n'est donc pas un Livre** », traitée par les **relations entre Livres** (`BOOK_RELATIONSHIPS.md`) et l'axe équipement.
- **Loi 1** (zéro duplication) : un Livre **référence**, ne **détient** pas ; une carte peut être référencée par plusieurs Livres.
- **Loi 4** (versionné) · **Loi 5** (aucune destruction — append-only) · **Loi 6** (explicable) · **Loi 17** (évolutivité sans réécriture) encadrent toute migration.
- **Décision 7 (DECISIONS.md)** — Activités vs qualifications : renforce que ce qui est stocké/structurant, ce sont les **activités**.

## 3. Quels documents deviennent incohérents si PAC reste un Livre ?
Si l'on garde « PAC = Livre » (`metier:pac`) :
- `TAXONOMIE-METIERS.md` et `catalog/trades/taxonomy.py` — **62 activités** deviennent 63, slugs « gelés » enfreints.
- `BOOK_SYSTEM.md` — Invariant n°1 violé + sa propre section « Cas transversal (ex. PAC) » **contredite**.
- `CORPUS_PRODUCTION_PLAN.md`, `CORPUS_COVERAGE_MATRIX.md`, `EDITORIAL_OPERATIONS.md` — chiffrés sur **62 Livres** ; deviennent faux.
- `CORE_BUSINESS_INTELLIGENCE`, moteurs — la taxonomie est la « colonne vertébrale » ; un métier fantôme la fragilise.
- Chaque futur équipement transversal (ballon tampon, PAC hybride, VMC double flux, adoucisseur…) réclamerait le même passe-droit → **prolifération d'incohérences**.

## 4. Impacts par composant
| Composant | « PAC = Livre » (Option A) | « PAC = équipement + projection » (Option B) |
|---|---|---|
| **Knowledge** | slug métier hors taxonomie ; recherche par métier faussée | tags `equipement:pac` déjà supportés ; recherche native |
| **Books** | 63ᵉ Livre hors invariant ; duplication probable | projection par références (curation) — conforme Loi 1 |
| **Factory** | warning `metier_hors_taxonomie` **permanent** sur tout le Livre | plus de warning une fois re-taggé sous activités réelles |
| **Search** | axe métier pollué | filtre `equipement:pac` = vue transversale immédiate |
| **Decision Engine** | propose un métier inexistant | inchangé (consomme Knowledge) |
| **AI Companion** | risque d'exposer « métier PAC » (faux) | inchangé ; peut offrir une **vue PAC** par tag |

---

## 5. Comparatif des options

### Option A — PAC devient officiellement une activité (`metier:pac`)
- **Avantages** : « Livre PAC » autonome, simple mentalement.
- **Inconvénients** : casse la taxonomie gelée (62→63), viole Book System #1 et sa section PAC, faux au regard du réel (la PAC est multi-activités/qualifications), ouvre la porte à N équipements-métiers.
- **Lois** : ❌ Loi 1 (duplication inévitable), ❌ Loi 17 (réécriture massive).
- **ADR existants** : entre en conflit avec Décision 7 et le principe des slugs gelés.
- **Taxonomie** : modification structurelle d'un référentiel **gelé**.
- **Impact 62 Livres** : invariant « 62 » cassé partout (plan, matrice, ops, moteurs).
- **Moteurs** : métier fantôme dans Knowledge/Search/Decision/Companion.
- **Maintenance / évolutivité** : dette permanente ; précédent dangereux.
- **Coût migration** : **élevé** (taxonomie + code + tous les docs de planification + re-tests).
- **Risques** : incohérence systémique, perte de confiance dans la taxonomie.

### Option B — PAC reste un équipement transversal ; « Livre PAC » = projection documentaire (RECOMMANDÉE)
- **Principe** : le contenu PAC est **propriété de l'activité** qui le réalise, taggé `metier:<activité> equipement:pac`. Le « Livre PAC » est une **projection/vue transversale** construite par **requête sur `equipement:pac`** + relations inter-Livres — exactement la « curation par références » du Book System (un Livre référence, ne détient pas).
- **Répartition** : air/eau (hydraulique/émission) → `chauffage` ; air/air réversible → `climatisation` ; captage sol/eau → `geothermie` ; **circuit frigorifique / fluide (F-Gaz)** → `froid` ; raccordement → `electricite-generale`.
- **Avantages** : **conforme aux fondations existantes sans les modifier** ; zéro duplication ; recherche/vue natives ; extensible à tout équipement transversal (PAC hybride, VMC…).
- **Inconvénients** : le « Livre PAC » n'est pas un dossier physique mais une vue — nécessite d'assumer ce modèle ; suppose l'existence (ultérieure) des Livres Climatisation/Froid/Géothermie pour héberger certaines cartes.
- **Lois** : ✅ Loi 1, ✅ Loi 5, ✅ Loi 6, ✅ Loi 17.
- **ADR / Book System / taxonomie** : ✅ **aucune modification d'un document gelé** (le Book System le prescrit déjà).
- **Impact 62 Livres** : **nul** (invariant « 62 » préservé).
- **Moteurs** : **aucun changement logiciel** (tags déjà supportés).
- **Maintenance / évolutivité** : modèle unique et durable pour tous les transversaux.
- **Coût migration** : **faible** (re-tag/re-home des 15 fichiers + notes docs vivants).
- **Risques** : faibles ; principal point d'attention = pédagogie du concept « projection ».

### Option C — Autre architecture (« Dossier transversal » comme concept UX de premier plan)
- **Principe** : formaliser la projection de B en un objet de navigation nommé (« Dossier transversal PAC ») — sans jamais devenir un Livre ni un métier.
- **Évaluation** : c'est **B, nommé**. Utile côté UX/Companion, mais n'ajoute aucune donnée structurante. **Absorbé dans B** comme mécanisme de restitution (une « vue » par `equipement:pac`). Ne justifie pas une option distincte.

---

## Décision
**Retenir l'Option B.** PAC est un **`equipement:pac`** (axe équipement officiel). Le contenu PAC appartient à l'**activité** qui le réalise (`metier:<activité> equipement:pac`). Le **« Livre PAC » est une projection documentaire transversale** (vue par tag + relations inter-Livres), **jamais un Livre au sens taxonomie**. Aucune activité `pac` n'est créée ; la taxonomie et le Book System restent inchangés.

## Justification
- **Cohérence maximale, coût minimal** : B est déjà la position du Book System (*Validated*) — l'adopter **ne modifie aucun document gelé**, tandis que A les casse.
- **Vérité métier** : la PAC mobilise plusieurs activités et qualifications (dont **F-Gaz** pour le frigorifique) ; la modéliser en une seule activité serait faux.
- **Lois 1/5/6/17** respectées ; **Décision 7** et la règle des slugs gelés préservées.
- **Évolutivité** : un seul modèle règle *tous* les équipements transversaux futurs — pas de précédent à passe-droit.

## Conséquences
- **Positives** : fondations intactes, moteurs inchangés, zéro dette, extensible.
- **Négatives** : la restitution d'un « Livre PAC » passe par une **vue** (projection) et non un dossier ; certaines cartes PAC attendent l'ouverture des Livres Climatisation/Froid/Géothermie pour être hébergées au bon métier.

## Alternatives rejetées
- **Option A** (PAC = métier) : casse la taxonomie gelée et le Book System, dette permanente.
- **Option C** en tant qu'option distincte : repliée dans B (mécanisme de restitution).

---

## Migration après acceptation (livrable #5 — documents/artefacts à modifier)
> **Rien n'est un document *gelé*.** Le Book System et la taxonomie **ne changent pas** (déjà conformes à B).

1. **Contenu PAC produit (15 fichiers)** — re-tag + re-home (Loi 5 : déplacer/retagger, jamais détruire ; historiser) :
   - retirer `metier:pac`, poser `metier:<activité> equipement:pac` ;
   - air/eau (hydraulique, mise en service, désembouage, entretien accessible) → **`chauffage`** (Livre existant) → déplaçables **immédiatement** ;
   - frigorifique / F-Gaz, air/air, géothermique → **attendent** l'ouverture des Livres `froid`, `climatisation`, `geothermie` (rester en attente, non publiés).
2. **Docs de planification vivants** (non gelés) : ajouter dans `CORPUS_PRODUCTION_PLAN.md`, `CORPUS_COVERAGE_MATRIX.md`, `EDITORIAL_OPERATIONS.md` une note « **PAC = équipement transversal, restitué par projection `equipement:pac`**, pas un 63ᵉ Livre ».
3. **Index ADR** : référencer ADR-0024 dans `docs/blueprint/adr/README.md`.
4. **(Optionnel, hors ADR — logiciel V1.1)** : ajouter à la Factory/au Companion une **commande/vue de projection** `equipement:<x>` (regroupe les cartes d'un équipement transversal). Non requis pour la conformité ; simple confort de restitution.
5. **Convention éditoriale** : documenter (guides Factory) que tout équipement transversal (PAC, PAC hybride, VMC double flux, adoucisseur, ballon tampon…) suit ce modèle `equipement:` + relations.

## Impact
Aucun impact logiciel obligatoire, aucun impact sur les 62 Livres, aucune modification de document gelé. Migration éditoriale **faible** et **réversible**.

## Confirmation de reprise (livrable #6)
Une fois cet ADR **accepté** par le PO, la production éditoriale peut reprendre **sans risque** :
- la production « PAC » s'effectue **au sein des Livres d'activité** (à commencer par `chauffage` pour l'air/eau) avec `equipement:pac` ;
- la restitution transversale « PAC » se fait par **projection** (`equipement:pac`), sans créer de Livre ;
- les 15 contenus déjà produits sont **conservés** et **re-taggés/re-homés** selon la migration ci-dessus (aucune perte — Loi 5).

## Mise à jour (2026-08-09) — vérification de l'état du dépôt (décision inchangée)
Audit du dépôt réalisé avant présentation au PO. La **décision (Option B) reste valide et inchangée** ; ses prémisses sont confirmées comme **FAITS** :
- Taxonomie (`catalog/trades/taxonomy.py`) : **62 activités, aucune `pac`**. QualiPAC y est une *certification d'entreprise*, pas un métier ; F-Gaz (`fluides-frigorigenes`) y est une *qualification d'exercice*.
- `equipement:pac` est officiel (`taxonomy/EQUIPMENT_TYPES.md`).
- Le **Book System** (`books/BOOK_SYSTEM.md`, *Validated*) énonce déjà la clause « **Cas transversal (ex. PAC)** : une PAC n'est pas une activité, c'est un `equipement:pac` » et l'invariant « **Livre = activité (62)** ». **Option B est donc déjà la position écrite du Book System** ; l'accepter ne fait qu'aligner le corpus dessus.

**Deux éléments ont évolué depuis la rédaction (2026-08-04) :**
1. **Blocage de migration levé.** Les Livres `climatisation`, `froid`, `geothermie` sont **désormais ouverts** (dossiers `professions/*` + cartes existantes). Les cartes PAC frigorifique/F-Gaz, air/air et géothermique **n'attendent plus** leur création : le re-homing n'est **plus bloqué** par leur absence. Les mentions « en attente » des sections *Conséquences*, *Migration* (point 1) et *Confirmation de reprise* ci-dessus sont **caduques**.
2. **Anomalie `metier:pac` localisée** (c'est exactement ce que l'Option B corrige) : `professions/pac/README.md` et `professions/README.md` (tous deux *Validated*) déclarent un « **Dossier métier `metier:pac` — miroir de la taxonomie gelée** », ce qui est **faux** (aucun slug `pac` dans la taxonomie). Les ~15 contenus PAC sont **tous en Brouillon (v0)**, taggés `metier:pac equipement:pac`. Migration (après acceptation) : retirer `metier:pac`, retirer PAC de la liste des métiers de `professions/README.md`, re-homer chaque carte vers son activité réelle en conservant `equipement:pac` (Loi 5 : déplacer/retagger, jamais détruire).

**Vigilance doublons** (pour le re-homing, pas maintenant) : certaines cartes PAC recoupent thématiquement des cartes déjà présentes dans les Livres cibles — p.ex. `professions/pac/cards/controler-circuit-frigorifique-pac.md` vs `professions/climatisation/cards/controler-circuit-frigorifique-clim.md` (et le Livre `froid`). Arbitrer **fusion vs distinction PAC-spécifique** au cas par cas ; aucune perte (append-only).

**Nature de la migration — décision ≠ exécution mécanique.** L'acceptation tranche la **décision d'architecture** (prête). L'**exécution** se répartit en trois couches à ne pas confondre : **(a) migration technique** — **4/15** contenus ont une destination claire (3 → `chauffage` : `mettre-en-service-pac-air-eau`, `desembouer-circuit-pac-air-eau`, `pac-ne-chauffe-pas` ; 1 → `geothermie` : `controler-pac-geothermique`) ; **(b) arbitrages éditoriaux** — **11/15** contenus sont réellement transversaux (aérothermie, F-Gaz, cadres généraux) et exigent une décision métier d'activité-cible ; **(c) doublons** — **8** recoupements avec les Livres existants, dont **2 quasi-identiques** (`controler-circuit-frigorifique-pac` ≈ `…-clim` — qui porte déjà `equipement:pac` ; `securite-frigorifique-pac` ≈ `…-clim`/`…-froid`) à arbitrer fusion/distinction. Le coût **technique** (« faible » ci-dessus) vaut pour la partie (a) ; l'**arbitrage éditorial** (b)+(c) est le véritable travail. La transversalité de la majorité des contenus **confirme** le bien-fondé d'Option B.

**À ce stade : aucun contenu déplacé, aucun code modifié, aucun document gelé touché.**

## Historique
- 1.0 (2026-08-04) — Rédaction ; recommandation **Option B** ; statut **Proposed**, en attente d'acceptation PO.
- 1.1 (2026-08-09) — Mise à jour d'état du dépôt : Livres climatisation/froid/géothermie ouverts (migration débloquée) ; anomalie `metier:pac` localisée ; vigilance doublons. **Décision (Option B) inchangée ; statut toujours `Proposed`.**
- 1.2 (2026-08-09) — Précision de portée : distinction **décision d'architecture / migration technique (4/15 tranchés) / arbitrages éditoriaux (11/15 + 8 doublons)** ; « intégralement dès acceptation » ramené à « blocage levé ». **Décision (Option B) inchangée ; statut toujours `Proposed`.**
- 1.3 (2026-08-09) — **Acceptation PO** : statut `Proposed → Accepted`. Option B retenue. Migration autorisée en deux vagues (Wave 1 : 4 contenus tranchés ; Wave 2 : 11 arbitrages + 8 doublons).
