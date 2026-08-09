# ADR-0025 — Catégorie « Product Decision Record » (PDR) dans le Blueprint (proposé)

> **Version** 1.0 — **Status** Proposed — **Owner** Lead Engineer — **Last Update** 2026-08-09
> **Depends On:** [ADR-0000-adopter-les-adr.md](ADR-0000-adopter-les-adr.md) — **Used By:** gouvernance documentaire du Blueprint — **Niveau:** 2 · Gouvernance documentaire
>
> **Décision recommandée, en attente d'acceptation par le Product Owner.** Aucune structure n'est créée tant que ce statut n'est pas passé à `Accepted` (Loi 7/18 : validation humaine). Aucune décision silencieuse.

<!-- Statuts ADR : Draft → Validated → Frozen → (Superseded par ADR-XXXX). Jamais supprimé (Loi 5). -->

## Statut
**Proposed** — recommandation motivée (Option 2 : **ne pas** créer de catégorie PDR distincte). Aucune modification du Blueprint tant que le PO n'a pas tranché.

## Contexte
Une exploration de gouvernance a proposé d'officialiser des **« Product Decision Records » (PDR)** : un jumeau produit des ADR, destiné aux décisions relevant du Product Owner / de la Bible Produit (par opposition aux décisions d'architecture, couvertes par les ADR).

Cette proposition n'a **jamais été matérialisée dans le dépôt** : aucun fichier `PDR`, aucune occurrence de « Product Decision Record » en code ou en doc, aucun commit l'ayant jamais introduite (vérifié par `git log -S`). Elle n'existait qu'à l'état de brouillon hors dépôt. Le présent ADR lui donne un **enregistrement traçable** (Lois 5/6) et **tranche** la question, conformément à ADR-0000 (« sans trace du *pourquoi*, une décision est ré-ouverte à chaque nouveau contributeur »).

## Problème
Le Blueprint a-t-il besoin d'une **catégorie documentaire distincte « PDR »** pour les décisions produit, en complément des ADR — ou les mécanismes existants suffisent-ils ?

## Options
1. **Créer une catégorie PDR complète** (répertoire `pdr/`, README, template, index) — jumeau des ADR côté produit.
2. **Ne pas créer de catégorie PDR** ; router les décisions produit vers les mécanismes existants — **ADR** pour la gouvernance structurante/documentaire, **versionnement de la Bible (Loi 4)** pour le contenu produit. *(RECOMMANDÉE)*
3. **Ne rien décider** — laisse la question ré-ouverte à chaque contributeur (ce que la Loi 17 et ADR-0000 cherchent précisément à éviter).

## Décision
**Retenir l'Option 2 : ne pas créer de catégorie PDR distincte.** Les décisions produit continuent d'être tracées par les deux canaux déjà en place ; la question n'est rouverte que si un **consommateur réel** apparaît (voir *Déclencheur de réouverture*).

## Justification
- **Discipline gelée d'ADR-0000** : *« Les 11 ADR proposés […] seront créés à mesure de leur consommateur réel. »* La catégorie PDR n'a **aucun consommateur** aujourd'hui (aucun code, doc ni test ne la référence). La créer serait de l'**infrastructure spéculative** — contraire à cette discipline et au principe *« Build Product, Not Infrastructure »* (DECISIONS.md), ainsi qu'à la règle d'extraction « deuxième consommateur = signal d'infrastructure ».
- **Les décisions produit sont déjà tracées** : (a) les **ADR** absorbent la gouvernance documentaire/produit-structurante — [ADR-0024](ADR-0024-representation-de-la-pac.md) en est la preuve vivante (une décision de représentation produit/éditoriale, classée « Niveau 2 · Gouvernance documentaire ») ; (b) la **Bible évolue « par décision du Product Owner et versionnement (Loi 4) »** (`product/README.md`), avec son propre changelog daté/versionné.
- **Étoile polaire** (Manifesto / BRAND.md) : une catégorie PDR **n'aide pas l'artisan à retrouver son identité** ; « sinon on ne développe pas ».
- **Lois 5/6/17** : la question reste **tracée et explicable** par cet ADR, **réouvrable sans réécriture** si le besoin devient réel.

## Conséquences
- **Positives** : zéro infrastructure inutile ; un seul système de décision (ADR) + le versionnement de la Bible ; cohérence avec la discipline gelée ; fin de la ré-ouverture perpétuelle de la question (la trace existe désormais).
- **Négatives** : si un besoin réel de séparer formellement « décisions produit » et « décisions d'architecture » émerge, il faudra un **ADR ultérieur (superseding)** pour introduire les PDR à ce moment — coût différé, assumé.

## Alternatives rejetées
- **Option 1** (créer la catégorie PDR maintenant) : infrastructure sans consommateur, contraire à ADR-0000 et à l'étoile polaire ; multiplie les canaux de décision sans besoin démontré.
- **Option 3** (ne rien décider) : laisse la question ré-ouverte, ce qu'ADR-0000 et la Loi 17 proscrivent.

## Impact
Aucun impact logiciel. **Aucun document gelé modifié.** Aucun fichier créé hors le présent ADR. L'index (`README.md`) sera mis à jour **à l'acceptation** — convention observée dans le dépôt (ADR-0024, également `Proposed`, n'y figure pas encore).

## Déclencheur de réouverture
Apparition d'un **consommateur réel** : par exemple un volume de décisions produit non-structurantes suffisamment élevé pour que le changelog de la Bible (Loi 4) et les ADR ne suffisent plus à les tracer lisiblement. À ce moment, un ADR *superseding* introduira la catégorie PDR avec son template et son index.

## Historique
- 1.0 (2026-08-09) — Rédaction ; recommandation **Option 2** (ne pas créer de catégorie PDR) ; statut **Proposed**, en attente d'acceptation PO.
