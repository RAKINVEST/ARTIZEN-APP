# Changelog

Format inspiré de [Keep a Changelog](https://keepachangelog.com/fr/1.1.0/).
Ce fichier commence à la V2 : la V1 a été construite en 10 étapes dont
`README.md` est le récit détaillé, et son historique Git tient en un seul
commit — un changelog rétroactif n'apporterait rien que `README.md` ne dise
déjà mieux.

## [Non publié] — V2 en cours (branche `v2`)

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
| `pytest` | **189 passed** (142 → 189) |
| Migration + rollback | ✅ aller-retour complet sur données réelles |
| Tentative de casse — cycle de vie | ✅ **18/18** |
| Tentative de casse — moteur PDF | ✅ **14/14** |
| Docker | ❌ **non exécuté** — voir ci-dessous |

**Limitation :** Docker Desktop est arrêté sur la machine de développement
(noyau WSL 2 installé sans redémarrage). Les validations Docker de la V2
n'ont donc pas été rejouées. Voir `docs/release/01_PROOF_OF_VALIDATION.md`.

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
