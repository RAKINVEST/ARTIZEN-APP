# ARTIZEN — Dossier de recette V1 (T40 → T45)

Document **de recette** (hors référentiel gelé). Il **n'ajoute aucun code** et ne
teste que le **périmètre V1 gelé**. Il s'exécute **sur l'environnement de
production réel** juste après le déploiement (`DEPLOY-EXECUTION-T20-T35.md`).
Cadre : Master Execution Plan (T40-T45), `RC1_DOSSIER.md`, `EXPLOITATION-V1.md`.

---

## 1. Objectif de la recette

Prouver, **de bout en bout sur la production réelle**, qu'un artisan peut utiliser
ARTIZEN **seul et sans support** (compte → identité → devis + PDF → effacement),
et que **l'infrastructure** (HTTPS, DNS, CORS, S3, SMTP, PostgreSQL, Redis,
sauvegardes, monitoring) est opérationnelle. La recette **autorise ou refuse** le
passage en **bêta privée**. Elle ne valide **pas** le contenu légal (reporté après
la bêta — décision PO) ; le bandeau « provisoire » reste acceptable en bêta.

## 2. Prérequis

- Déploiement T20-T35 **terminé et GO** (backend `api.artizenapp.com`, frontend `app.artizenapp.com`).
- `GET https://api.artizenapp.com/api/health` = `status:ok` (`database`+`redis` ok).
- Comptes actifs : Scalingo, Scaleway (bucket + versioning), Brevo (SPF/DKIM verts), UptimeRobot.
- Une **boîte e-mail de test réelle** (pour recevoir reset + devis).
- Accès à : dashboard Scalingo (logs), console Scaleway (bucket), dashboard Brevo, UptimeRobot.

## 3. Environnement attendu

- **Frontend** : `https://app.artizenapp.com` (bundle statique, `API_BASE_URL=https://api.artizenapp.com/api` injecté).
- **Backend** : `https://api.artizenapp.com/api` (HTTPS, HSTS, `ENVIRONMENT=production`, `/docs` désactivé).
- **Navigateurs** : Chrome desktop (référence) ; **contrôle responsive** mobile + tablette (mise en page utilisable). Firefox/Safari en vérification best-effort.
- **Données** : comptes de test créés puis **supprimés** en fin de recette (RGPD).

## 4. Matrice complète des scénarios de recette

*(Fonctionnels `REC-*`. Colonnes : prérequis · étapes · résultat attendu · preuve · GO/NO GO. Chaque scénario se joue depuis `https://app.artizenapp.com`.)*

| ID | Prérequis | Étapes | Résultat attendu | Preuve à conserver | GO/NO GO |
|---|---|---|---|---|---|
| **REC-01** Création de compte (nominal) | Aucun compte | S'inscrire (e-mail + mot de passe) | Compte créé, connecté, arrivée dashboard | Capture dashboard | ☐ |
| **REC-01E** Création — cas d'erreur | REC-01 fait | Réinscrire le même e-mail ; tester un mot de passe trop court | Refus clair (e-mail déjà pris / mot de passe invalide), sans 500 | Capture message d'erreur | ☐ |
| **REC-02** Connexion (nominal) | REC-01 | Se déconnecter puis se reconnecter | Accès rétabli, token stocké | Capture session | ☐ |
| **REC-02E** Connexion — mauvais mot de passe / rate-limit | REC-01 | Mauvais mot de passe ×N | 401 ; au-delà du seuil, 429 (rate-limit actif) | Capture 401/429 | ☐ |
| **REC-03** Mot de passe oublié | REC-01, boîte réelle | « Mot de passe oublié ? » → e-mail → lien → nouveau mot de passe | **E-mail reçu** (SPF/DKIM verts) ; reset effectif ; reconnexion OK | E-mail reçu (en-têtes) + capture | ☐ |
| **REC-04** Identité entreprise | REC-02 | « Mon entreprise » : saisir/éditer raison sociale, SIRET, TVA, coordonnées | Champs enregistrés et relus | Capture avant/après | ☐ |
| **REC-05** Logo | REC-04 | Téléverser un logo (PNG/JPG) | Logo affiché **et objet présent dans le bucket S3** | Capture + objet S3 (console Scaleway) | ☐ |
| **REC-06** Import ancien devis | REC-02, un PDF de devis | Importer un ancien devis PDF | Reconnaissance : logo/couleurs/coordonnées **réellement retrouvés** restitués (écran honnête) | Capture écran de reconnaissance | ☐ |
| **REC-07** Création devis | REC-04, catalogue/client | Créer un brouillon, ajouter des lignes, laisser le **backend calculer**, créer le devis | Devis **numéroté** (`DEV-2026-xxxx`), totaux HT/TVA/TTC cohérents (calcul serveur) | Capture devis créé | ☐ |
| **REC-08** Génération PDF | REC-07 | Générer/télécharger le PDF du devis | PDF produit, identité (logo/couleurs/coordonnées) présente, montants = écran | PDF conservé | ☐ |
| **REC-09** Envoi e-mail du devis | REC-07, boîte réelle | Envoyer le devis par e-mail | Statut passe à « Envoyé » **ET e-mail réellement reçu** avec PDF *(vigilance G1 : vérifier la réception réelle, pas seulement le statut)* | E-mail reçu + capture statut | ☐ |
| **REC-10** Suppression compte RGPD | REC-01 | Paramètres → Supprimer mon compte → confirmer | 204 ; retour login ; **données effacées** (compte + entreprise + devis) | Capture + vérif absence en base (`psql`) | ☐ |

## 5. Parcours critique complet (bout en bout, un seul enchaînement)

Exécuter dans l'ordre, **sur un même compte de test**, pour prouver le parcours nominal continu :

`REC-01 (création) → REC-02 (connexion) → REC-03 (mot de passe oublié) → REC-04 (identité) → REC-05 (logo) → REC-06 (import) → REC-07 (création devis) → REC-08 (PDF) → REC-09 (envoi e-mail) → REC-10 (suppression RGPD)`.

**GO parcours critique** = les 10 étapes GO **d'affilée** sur le domaine réel, sans erreur bloquante. **NO GO** = tout échec bloquant sur une étape.

## 6. Vérifications Infrastructure

| ID | Vérification | Résultat attendu | Preuve | GO/NO GO |
|---|---|---|---|---|
| **INF-01** HTTPS/TLS | `curl -I https://api.artizenapp.com/api/health` | 200, certificat valide, en-tête **HSTS** | Sortie curl | ☐ |
| **INF-02** DNS | `dig api.artizenapp.com` / `dig app.artizenapp.com` | CNAME résolvent vers Scalingo / CDN | Sortie dig | ☐ |
| **INF-03** CORS | Login depuis `app.artizenapp.com` | Aucune erreur CORS (origine = `https://app.artizenapp.com`) | Console réseau navigateur | ☐ |
| **INF-04** S3 | Après REC-05 | Objet logo présent dans le bucket **stockage** (privé) ; **versioning Enabled** | Console Scaleway | ☐ |
| **INF-05** SMTP | Après REC-03/REC-09 | E-mails réellement délivrés ; SPF/DKIM verts ; quota Brevo non saturé | Dashboard Brevo + e-mails reçus | ☐ |
| **INF-06** PostgreSQL | `/api/health` | `database:ok` ; migrations à `head` | `/health` + logs | ☐ |
| **INF-07** Redis | `/api/health` | `redis:ok` ; `RATE_LIMIT_BACKEND=redis` actif | `/health` + REC-02E (429) | ☐ |
| **INF-08** Sauvegardes | Backups managés + versioning | Backup PG présent + **1 restauration testée** avec succès | Dashboard Scalingo + preuve de restauration | ☐ |
| **INF-09** Monitoring | UptimeRobot + alertes | Sonde verte ; alerte `email.smtp_send_failed` + 5xx armées | Capture UptimeRobot + config alertes | ☐ |

## 7. Procédure de validation finale

1. Exécuter **tous** les `REC-*` (nominaux + cas d'erreur) et **tous** les `INF-*`.
2. Consigner chaque résultat (GO/NO GO) et **conserver les preuves**.
3. Reporter toute anomalie dans le **tableau §10**.
4. Rejouer les scénarios corrigés après traitement d'une anomalie bloquante.
5. Nettoyer : supprimer les comptes/données de test (REC-10) — aucune donnée de recette ne subsiste.

## 8. Critères objectifs autorisant le passage en bêta privée

Passage en bêta **autorisé si et seulement si** :

- [ ] **Tous** les `REC-*` = GO (parcours critique complet passé d'affilée).
- [ ] **Tous** les `INF-*` = GO.
- [ ] **E-mails réellement délivrés** (REC-03 + REC-09), SPF/DKIM verts.
- [ ] Logo **réellement stocké dans S3** (REC-05 / INF-04).
- [ ] **1 restauration** testée avec succès (INF-08).
- [ ] Supervision armée (INF-09) — sonde + alerte e-mail + 5xx.
- [ ] **Zéro anomalie bloquante ou majeure** ouverte (§10).

**Note de périmètre :** le **contenu légal validé** n'est **pas** un critère de passage en bêta (reporté après la bêta — décision PO) ; le bandeau « provisoire » est accepté pour des testeurs informés. Il **redeviendra bloquant** pour le **premier client payant** (T61/T62).

## 9. Procédure de clôture de recette

- [ ] Toutes les preuves archivées (captures, e-mails, PDF, sorties commandes).
- [ ] Tableau §10 à jour ; **aucune anomalie bloquante/majeure ouverte**.
- [ ] Décision **GO bêta** / **NO GO** consignée, datée, avec justification.
- [ ] Comptes/données de test supprimés.
- [ ] En cas de GO : déclencher l'onboarding bêta (T51). En cas de NO GO : traiter les anomalies, rejouer la recette.

## 10. Tableau de suivi des anomalies

| ID | Scénario | Gravité (Bloquante/Majeure/Mineure) | Description | Statut (Ouverte/Corrigée/Acceptée) | Résolution / renvoi |
|---|---|---|---|---|---|
| ANO-01 | | | | | |
| … | | | | | |

*(Toute anomalie **bloquante ou majeure** interdit le passage en bêta jusqu'à résolution. Les mineures peuvent être **acceptées et journalisées** — jamais corrigées en rouvrant l'architecture ; renvoi éventuel en Future Ideas / V1.x.)*

---

*Dossier de recette. Ne modifie ni le code, ni l'architecture, ni le référentiel gelé, ni le Master Execution Plan. À exécuter le jour du déploiement, sur la production réelle.*
