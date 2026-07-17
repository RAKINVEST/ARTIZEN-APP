# Changelog

Format inspiré de [Keep a Changelog](https://keepachangelog.com/fr/1.1.0/).
Ce fichier commence à la V2 : la V1 a été construite en 10 étapes dont
`README.md` est le récit détaillé, et son historique Git tient en un seul
commit — un changelog rétroactif n'apporterait rien que `README.md` ne dise
déjà mieux.

## [v2.0.0-rc1] — 2026-07-17 (branche `v2`)

**Release Candidate V2, gelée.** Périmètre figé, certifié, et validé en
conditions proches de la production. Aucune modification de code n'intervient
au-delà de ce tag ; toute anomalie découverte ouvre une RC2 (bloquante /
majeure) ou est reportée V2.x/V3 (mineure).

### Décision de périmètre (stabilisation, 2026-07-17)

Le périmètre fonctionnel de la V2 est **figé et complet** : cycle de vie du
devis, PDF, interface, duplication — tout livré et validé en Docker. Les
items restants de la roadmap initiale (PyJWT, cookie HttpOnly, rate limiting
partagé, comptage exact, qualité IA, refactors d'architecture) sont
**reportés V3** : chacun est « valeur faible / risque élevé sur un chemin
critique » à ce stade. Analyse : `docs/release/06_V2_SCOPE_TRIAGE.md`. La
suite est de la stabilisation, pas du développement.


### Ajouté

- **Cycle de vie du devis.** Un devis a désormais un numéro et un statut.
  - **Numérotation `DEV-2026-0001`** — préfixe, année, séquence remise à
    zéro chaque année. Unique **par entreprise**, garantie en base par
    `UNIQUE (company_id, quote_number)` : deux artisans ayant chacun leur
    `DEV-2026-0001` est normal.
    Le numéro vient d'une table `quote_counters` verrouillée `FOR UPDATE`,
    **jamais d'un `SELECT MAX+1`** — qui donnerait le même numéro à deux
    créations simultanées. *Vérifié : 20 créations concurrentes donnent 20
    numéros distincts et contigus.*
  - **Statuts `draft` / `sent` / `accepted` / `refused`**, avec
    `PUT /quotes/{id}/status`. Les transitions vivent dans une table
    (`QUOTE_TRANSITIONS`) ; **rien ne revient jamais à `draft`** — un devis
    envoyé est un document que le client détient.

- **Moteur PDF** (`app/pdf/`) et `GET /quotes/{id}/pdf`. Le trou du
  produit : un artisan pouvait composer un devis et pas l'envoyer.
  - **Générique par construction.** `app/pdf/` n'importe que `app.pdf.*` —
    vérifié mécaniquement. Il ne sait pas ce qu'est un devis, ce qui est la
    seule façon de servir aussi factures, avoirs et bons de commande sans
    une branche par type. Le `title` est une chaîne, pas un enum : les
    documents futurs n'exigeront aucune modification du moteur.
    *Prouvé : le même code rend DEVIS, FACTURE, AVOIR (montants négatifs
    inclus) et BON DE COMMANDE.*
  - **Il ne calcule rien.** Chaque montant arrive déjà calculé par
    `QuoteCalculator` — y compris le récapitulatif de TVA par taux, ajouté
    à `calculate_vat_breakdown()` plutôt qu'au moteur. Le PDF que reçoit le
    client porte, au centime, les totaux que l'artisan a validés à l'écran.
  - **reportlab** plutôt que WeasyPrint : pur Python, aucune bibliothèque
    système. WeasyPrint rend du HTML/CSS (plus agréable à styler) mais
    exige cairo et pango via apt, que `python:3.13-slim` n'a pas.
  - **Rendu à la demande, jamais stocké** : le PDF est une fonction pure du
    devis, et un devis ne change jamais (aucun chemin de modification).
  - **Hors event loop** (`asyncio.to_thread`) : reportlab est CPU-bound,
    comme pypdf que l'audit V1 avait trouvé en train de geler toutes les
    autres requêtes.
  - **Dégradation systématique** : logo illisible, couleur invalide, aucune
    identité configurée — l'artisan perd le logo, jamais son document.

- **Interface Flutter du cycle de vie et du PDF.** Le jalon n'était pas
  livrable sans elle : le backend savait tout faire, l'artisan ne pouvait
  rien en faire.
  - **Le numéro remplace le décompte de lignes** partout — liste, détail,
    dashboard. « Devis · 3 ligne(s) » ne distinguait aucune ligne d'une
    autre ; `DEV-2026-0042` est ce que l'artisan cherche des yeux et dit au
    téléphone.
  - **`QuoteStatusChip`** : couleur *et* libellé, jamais la couleur seule
    — lisible en plein soleil comme par un artisan daltonien.
  - **Actions pilotées par `QuoteStatus.nextStates`**, miroir de la table
    de transitions du backend. Un devis terminal n'affiche **aucun** bouton
    plutôt que des boutons grisés qui font douter l'artisan.
  - **Confirmation sur « Marquer comme envoyé » seulement** : c'est l'étape
    irréversible. Enregistrer la réponse du client n'en demande pas — il
    rapporte un fait.
  - **Garde anti-double-clic** : le backend refuse la seconde transition
    (409), mais un artisan ne doit pas rencontrer cette erreur pour un
    doigt qui glisse.
  - **PDF via `printing`** : aperçu, impression et partage dans une seule
    feuille — l'artisan veut regarder, imprimer *ou* envoyer, et cela
    dépend du moment. Les octets transitent par Dio (`responseType.bytes`)
    parce que l'endpoint exige l'en-tête `Authorization` : un simple lien
    aurait pris un 403.

- **Duplication d'un devis** (`POST /quotes/{id}/duplicate`, backend +
  Flutter). Le chemin d'édition qu'un devis n'a pas : puisqu'un devis ne se
  modifie pas, le corriger ou le réutiliser, c'est le dupliquer en nouveau
  brouillon et éditer la copie. Disponible dans **tous** les statuts — le
  cas courant est de réviser un devis déjà envoyé ou refusé.
  - **Copie de l'instantané, pas de re-tarification.** Les lignes sont
    reprises telles quelles (désignation, quantité, prix, TVA), *pas*
    recalculées depuis le catalogue courant. « Dupliquer » veut dire
    « faire une copie » : l'artisan attend les mêmes montants. Et surtout,
    c'est **robuste** — re-tarifer échouerait dès qu'un article a été
    désactivé entre-temps, précisément sur les vieux devis les plus dignes
    d'être dupliqués. *Vérifié : la duplication réussit même après
    désactivation de l'article source.*
  - **Les totaux sont recalculés** via `QuoteCalculator`, jamais copiés
    de la ligne source : « le calculateur est le seul endroit où un montant
    est calculé » reste vrai.
  - **Numéro neuf via le même compteur verrouillé** que la création :
    *vérifié, 10 duplications concurrentes donnent 10 numéros distincts.*
  - **UX** : un devis terminal (accepté/refusé) n'était qu'un cul-de-sac ;
    il offre désormais « Dupliquer en nouveau brouillon », qui mène
    directement à la copie éditable.

### Modifié

- **`DELETE /quotes/{id}` n'accepte plus que les brouillons** (409 sinon).
  Supprimer un brouillon reste la façon de corriger une erreur — il n'y a
  toujours ni `PUT` ni `PATCH` sur un devis, délibérément. Passé `draft`,
  la trace doit survivre.

### Corrigé

- **Mise à jour perdue sur les transitions concurrentes**, trouvée en
  cherchant à casser la fonctionnalité — pas en la relisant. Deux requêtes
  simultanées lisaient toutes deux `sent`, validaient chacune leur
  transition, et écrivaient : « accepté » répondait **200** tout en perdant
  face à « refusé ». La ligne du devis est maintenant verrouillée
  `FOR UPDATE` dans `change_status` et `delete`. *Vérifié : le perdant
  reçoit 409, le gagnant 200.*

### Corrigé — trouvé par la validation Docker (jamais visible en local)

- **`PermissionError` sur l'upload de logo, dans Docker uniquement.**
  L'auto-réparation du volume (V1) ne vérifiait que la propriété de la
  **racine** `/data/storage`. Sur un volume initialisé à vide, la racine
  appartient à `artizen` et le contrôle passait — mais les
  **sous-répertoires** créés à la demande par `LocalStorageProvider.save`
  (`logos/`, `templates/`, `document_analysis/`), s'ils avaient été créés
  par un conteneur root antérieur, restaient détenus par root. Le processus
  non-root échouait alors en `EACCES` sur le sous-répertoire, la racine
  paraissant saine. **Latent depuis la V1** ; le PDF l'a révélé en lisant le
  logo. `entrypoint.sh` vérifie désormais l'arbre entier
  (`find -not -user`), pas seulement la racine. *Reproduit contre un volume
  corrompu, puis auto-réparé ; 5 tests de stockage ajoutés.*

### Migration `6cc7943bff6a`

Réécrite à la main sur trois points qu'`alembic revision --autogenerate`
avait manqués (son « please adjust! » n'est pas décoratif) :

1. Colonnes déclarées `NOT NULL` sans défaut — échec immédiat sur toute
   base contenant déjà des devis. Elles sont ajoutées nullables, remplies,
   puis contraintes.
2. Aucun backfill. Les devis existants sont numérotés par entreprise et par
   année dans leur ordre de création, et les compteurs sont amorcés là où
   ces numéros s'arrêtent — sans quoi le devis suivant réclamerait
   `DEV-2026-0001` déjà pris.
3. `downgrade()` ne supprimait pas le type ENUM `quote_status`. En
   PostgreSQL, `DROP COLUMN` ne supprime pas un type créé par `CREATE TYPE`
   — le ré-upgrade mourait sur « type already exists ». Même défaut que
   l'audit V1 avait corrigé dans les quatre migrations précédentes ;
   l'autogenerate le reproduit à chaque fois.

*Vérifié à l'exécution contre 29 devis réels : 0 NULL, 0 doublon par
entreprise, compteurs cohérents, et `downgrade` → `upgrade` complet.*

### Validations

| Porte | Résultat |
|---|---|
| `pytest` | **208 passed** (142 → 208) |
| `flutter analyze` | ✅ **No issues found!** |
| `flutter test` | **63 passed** (53 → 63) |
| `flutter build web --release` | ✅ construit avec `printing` |
| Migration + rollback | ✅ aller-retour complet sur données réelles |
| Tentative de casse — cycle de vie | ✅ **18/18** |
| Tentative de casse — moteur PDF | ✅ **14/14** |
| **pytest dans le conteneur** | ✅ **208 passed** |
| **QA fonctionnelle HTTP contre Docker** | ✅ **21/21** (V2.1) + **19/19** (duplication) |
| **Build image (reportlab)** | ✅ wheel universelle, aucune lib système |
| **Migration + rollback en Docker** | ✅ 6 migrations à vide, aller-retour propre |

**Docker : validé.** Après réparation de l'environnement WSL, toute la pile
V2 a été rejouée en conteneur — build avec `reportlab`, installation neuve
(6 migrations), pytest **208** dans le conteneur, QA fonctionnelle (21/21), rollback. Un bug
spécifique à Docker a été trouvé et corrigé au passage (voir ci-dessus).

### User Acceptance Test (UAT)

Le parcours artisan complet (17 étapes : connexion → devis → PDF → envoi →
acceptation → duplication → PDF → déconnexion) a été **piloté dans un vrai
navigateur Chrome** contre la pile Docker réelle, ses effets vérifiés en
base, dans les logs et sous l'angle multi-tenant. **13/13** vérifications
d'invariants backend. Deux anomalies rencontrées, toutes deux dans le
harnais de test (aucune dans le produit) ; corrigées, scénario rejoué au
vert. Comble le dernier trou de validation de la V2 (« personne n'a cliqué
de bout en bout »). Détail : `docs/release/08_USER_ACCEPTANCE_TEST.md`.

### Documentation de release (Release Manager)

Livrables de publication ajoutés sous `docs/` (RELEASE_NOTES, QUICK_START,
INSTALL, DEPLOYMENT_GUIDE, DOCKER_GUIDE, BACKUP_RESTORE, MIGRATION_GUIDE,
USER_GUIDE, ADMIN_GUIDE, API_REFERENCE, SECURITY, KNOWN_LIMITATIONS,
TROUBLESHOOTING, ARCHITECTURE) et à la racine (LICENSE, CONTRIBUTING).
Package de release assemblé dans `docs/release/package/`. Toute la
documentation correspond au code tagué `v2.0.0-rc1`.

## [v1.0.0-rc1] — 2026-07-17

Release Candidate de la V1. 48 anomalies fermées, 219 vérifications
automatisées. Le détail — chaque anomalie, sa cause racine, son correctif
et sa preuve — est dans `docs/AUDIT-V1.md` et `docs/release/`.

Faits marquants :

- **Une quantité était tronquée en base** : le calculateur travaillait en
  précision pleine, PostgreSQL arrondissait la quantité stockée. Une ligne
  de devis fausse, injustifiable devant un client.
- **Le copilote IA était aveugle au-delà de 100 articles**, sans erreur ni
  log — il paraissait mauvais alors qu'il était mutilé.
- **La virgule décimale française rendait impossible la saisie d'un prix.**
- **`docker compose up` n'a jamais fonctionné sur un poste Windows**
  (CRLF dans `entrypoint.sh`) — invisible sur macOS/Linux.
- **Aucun rate limiting** : la base d'utilisateurs était énumérable.
