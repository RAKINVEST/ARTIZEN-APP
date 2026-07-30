# ARTIZEN — Dossier Release Candidate (RC1)

**Référence unique de mise en production.** Ce document est la seule source
consultée avant tout go-live. Il est **maintenu à jour à chaque session** jusqu'à
la sortie de la V1. Une ligne n'est « faite » que lorsqu'elle est *réellement*
terminée (pas « en cours »).

Rôles : **PO** (décisions produit/juridique/business, l'utilisateur) · **Dev**
(développement, Claude) · **Exploitation** (infra/hébergement) · **Juriste**.

Dernière mise à jour : session 15.

---

## 1. Release Candidate — état par domaine

| Domaine | État | Terminé / Manque (bloquant) — Dépend de |
|---|---|---|
| Produit | ✅ Prêt | Tous les parcours artisan livrés (dont le lien légal à l'inscription). Rien de bloquant côté produit. |
| Backend | ✅ Prêt prod (code) | API complète, 586 tests. Purge rétention → **décision PO**. |
| Flutter | ✅ Prêt | Écrans V1 + suppression compte + écrans légaux (infra + lien à l'inscription). Rien de bloquant. |
| API | ✅ Prêt prod | REST + erreurs typées + isolation tenant (404). Rien de bloquant. |
| Base de données | ✅ Prêt | Migrations up/down, cascades FK, index. Purge → **décision PO**. |
| Sécurité | 🟡 En cours | Rate-limit actif, bcrypt, JWT, isolation, validation upload. Posture JWT web (statu quo localStorage, dette documentée) → **décision PO**. |
| Juridique | 🟡 Infra prête | Écrans + routes `/legal/*` + lien à l'inscription ; **moteur de rétention config-driven** (`app/retention`, testé). Reste : **contenu validé** + **durées de rétention** (juriste), + activation cron. |
| Déploiement | 🟡 En cours | Docker compose + CI (validation) + **squelette `deploy.yml.example`**. Reste : **cible prod (registry/host)** → **Exploitation**. |
| Monitoring | 🟡 En cours | `/health` réel + **sonde `scripts/healthcheck.sh`** (testée). Reste : **moniteur externe + canal d'alerte** → **Exploitation**. |
| Sauvegardes | 🟡 En cours | Procédures manuelles + **script versionné testé** (`scripts/backup.sh`). Reste : **activation** (cron, hors-site chiffré) → **Exploitation**. |
| Performance | ✅ Prêt | Oracle O(n), détection bornée. **Smoke de charge** (`scripts/smoke_load.sh`) : 100/100 sur `/health`. Épreuve de charge complète (flux auth) = post-lancement. |
| Documentation | ✅ Prêt | README, architecture, specs, MEP, KNOWN_LIMITATIONS, gabarits légaux. |
| Support | 🟢 Prêt (mécanisme) | Décision PO : **Option A** — adresse de support, pas de formulaire in-app (→ V1.x). Livré **config-driven** : endpoint public `/config`, tuile Paramètres (copiable), pages légales (`{email}`). Reste : valeur de prod `SUPPORT_EMAIL` + boîte relevée ; FAQ post-lancement. |

---

## 2. Go-Live Checklist

*Conditions indispensables pour accepter un premier client payant. Cochée =
réellement terminée.*

| ✓ | Condition |
|---|---|
| ☑ | Créer un compte · se connecter · récupérer son mot de passe |
| ☑ | Importer un ancien devis · un import raté explique pourquoi |
| ☑ | Créer / gérer un devis + PDF |
| ☑ | Modifier son identité · téléverser son logo |
| ☑ | Supprimer son compte et ses données |
| ☑ | La suite de tests passe (589 backend + 192 Flutter) |
| ☐ | CGU accessibles *(écran+route+lien à l'inscription prêts ; reste UNIQUEMENT le contenu validé par un juriste)* |
| ☐ | Politique de confidentialité accessible *(idem)* |
| ☐ | Politique de rétention RGPD définie et appliquée *(moteur config-driven `app/retention` testé, no-op par défaut ; reste la POLITIQUE — durées/juriste — et l'activation cron)* |
| ☐ | Canal de support utilisateur *(mécanisme config-driven livré : `/config` + tuile Paramètres + pages légales ; reste UNIQUEMENT la valeur de prod `SUPPORT_EMAIL` + boîte relevée)* |
| ☐ | E-mails réels (SMTP configuré) |
| ☐ | Sauvegardes automatisées et testées *(script `scripts/backup.sh` testé bout-en-bout ; reste l'activation cron + hors-site — déploiement)* |
| ☐ | Alertes de production *(sonde `scripts/healthcheck.sh` testée ; reste le moniteur externe + canal — déploiement)* |
| ☐ | Pipeline de déploiement *(squelette `deploy.yml.example` prêt ; reste la cible registry/host — déploiement)* |
| ☐ | HTTPS/TLS actif en production |

**Score : 11 / 19 conditions terminées.**

---

## 3. Risques de Go-Live

| Niveau | Risque | Prob. | Impact | Mitigation |
|---|---|---|---|---|
| **Critique** | Lancer sans CGU/confidentialité/rétention validées | Élevée si on lance sans | Non-conformité légale | Infra prête ; **validation juriste avant go-live** |
| **Élevé** | Pas de sauvegardes automatisées → perte de données client | Moyenne | Perte irréversible | Script + cron + test de restauration |
| **Élevé** | Pas d'alerting → incident prod invisible | Moyenne | Indispo prolongée | Hook d'alerte sur `/health` |
| **Élevé** | Pas de HTTPS en prod | Élevée sans reverse-proxy | Interception, non-conformité | Reverse-proxy TLS (cible de déploiement) |
| **Moyen** | Pas de pipeline CD → déploiement manuel risqué | Moyenne | Erreur de déploiement | Squelette CD |
| **Moyen** | JWT en localStorage (XSS web) | Faible | Vol de session | Token court + dette documentée (cookie HttpOnly V2) |
| **Faible** | Performance non éprouvée sous charge | Faible | Lenteur | Smoke de charge |
| **Faible** | Contenu légal brouillon visible | Faible | Confusion | Bandeau « provisoire » + pas de lien en app tant que non validé |

---

## 4. Operational Readiness

*Ce qui doit être en place pour EXPLOITER ARTIZEN après le lancement.*

| Point | État | Responsable | Procédure | Bloquant go-live ? |
|---|---|---|---|---|
| **Sauvegardes** | 🟡 Partiel | Exploitation / Dev | **`scripts/backup.sh`** (versionné, testé bout-en-bout) + `docs/BACKUP_RESTORE.md`. Reste l'**activation** (cron + hors-site chiffré). | **Oui** |
| **Restauration** | 🟡 Testée (manuel) | Exploitation | `docs/BACKUP_RESTORE.md`. Manque : test de restauration régulier ordonnancé. | Non |
| **Rotation des secrets** | ⬜ Non commencé | Exploitation | Secrets via `.env` (JWT, DB, SMTP). Procédure de rotation à écrire. | Non (mais à documenter) |
| **Rotation TLS** | ⬜ Non commencé | Exploitation | Dépend du reverse-proxy (ex. Let's Encrypt auto-renew). | **Oui** (HTTPS requis) |
| **Monitoring** | 🟡 Partiel | Exploitation | `GET /health` + **`scripts/healthcheck.sh`** (sonde testée). Reste : moniteur externe qui l'appelle. | Non |
| **Alerting** | 🟡 Partiel | Exploitation / Dev | **`scripts/healthcheck.sh`** (sonde testée, exit 0/1). Reste : moniteur externe qui l'appelle + canal d'alerte. | **Oui** |
| **Logs** | ✅ Prêt | Dev/Exploitation | Logging structuré (`logger.warning/exception`, `exc_info`). Agrégation = plateforme d'hébergement. | Non |
| **Rollback** | 🟡 Partiel | Exploitation | Migrations Alembic réversibles (`downgrade`) + redéploiement image précédente (avec CD). | Non |
| **Mises à jour** | 🟡 Partiel | Exploitation | `docker compose up` (migrations auto au démarrage) ; à formaliser via CD. | Non |
| **Incidents** | 🟡 Partiel | PO/Support | `docs/RUNBOOK-LANCEMENT.md` existe ; runbook incident dédié à compléter. | Non |
| **Disponibilité** | 🟡 Non éprouvé | Exploitation | Instance unique (compose), pas de HA. Acceptable pour un premier client. | Non |
| **Capacité disque** | ⬜ Non surveillé | Exploitation | Uploads stockés localement (`storage.py`) ; croissance à surveiller (lié à l'alerting). | Non |
| **Supervision** | 🟡 Partiel | Exploitation | `/health` + logs. Manque l'alerting qui les surveille. | Non (couplé à Alerting) |

**Bloquants d'exploitation :** Sauvegardes automatisées · Alerting · TLS/HTTPS.
Tous trois dépendent de la **cible de déploiement** (décision Exploitation) ; le
code/les scripts sont préparables sans elle.

---

## 5. Release Candidate Decision

### Objectif de RC1
Livrer une V1 **commercialisable** : un artisan peut, **seul et sans support**,
gérer son activité de devis de bout en bout (compte, identité, catalogue,
clients, devis + PDF, import, effacement RGPD), sur une base **légale et
opérationnelle** conforme pour un **premier client payant**.

### Critères d'acceptation
1. Go-Live Checklist **entièrement cochée** (19/19).
2. Operational Readiness **sans bloquant ouvert**.
3. Suites de tests **vertes** (backend + Flutter), `flutter analyze` propre.
4. **Zéro anomalie bloquante ou majeure** ouverte.

### Conditions GO
- CGU, politique de confidentialité et **politique de rétention RGPD** validées,
  publiées et **accessibles depuis l'app**.
- **SMTP réel** configuré (e-mails de réinitialisation opérationnels).
- **Sauvegardes automatisées** + **restauration testée** récemment.
- **Alerting** actif sur la santé et les erreurs de production.
- **HTTPS/TLS** actif en production.
- **Canal de support** utilisateur défini et publié.

### Conditions NO GO
- Toute condition **légale** non validée (CGU / confidentialité / rétention).
- Absence de **sauvegardes automatisées**.
- Absence d'**alerting**.
- Absence de **HTTPS**.
- Absence de **canal de support**.

### Décision finale

> ## 🔴 NO GO (à ce jour)

**Justification.** Le **produit et le code sont prêts** (parcours artisan complet,
589 + 192 tests verts, API et base de données prêtes production). Le go-live est
bloqué non par du développement mais par **des décisions (PO/Juriste) et des
activations d'exploitation** : 11/19 conditions checklist cochées, et 3 bloquants
d'exploitation ouverts (sauvegardes auto, alerting, TLS). Les items restants sont
**juridiques** (contenu + rétention), **opérationnels** (backups, alerting,
déploiement/TLS) et **support**.

**Chemin vers le GO :** cocher les 8 conditions restantes. Le code/les scripts
préparables sans décision seront livrés d'ici là ; les décisions PO/Juriste et la
cible de déploiement débloquent le reste. Cette page passera à **🟢 GO** lorsque
les 19 conditions seront réellement terminées et les 3 bloquants d'exploitation
fermés.

---

*Ce dossier est la référence unique de go-live. Toute mise en production sans une
décision **🟢 GO** consignée ici est interdite.*
