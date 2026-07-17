# Package de release — ARTIZEN V2.0.0-RC1

Point d'entrée unique du dossier de livraison. Tag **`v2.0.0-rc1`** (branche
`v2`, HEAD `7f68131`), 2026-07-17.

> **Principe d'assemblage.** Ce package **référence** les documents
> autoritatifs (dans `docs/` et `docs/release/`) plutôt que de les dupliquer :
> une seule source de vérité, aucune divergence possible. Les fichiers
> **propres au package** (versions, dépendances, inventaire, matrice, rapport
> final) sont ici.

## À lire en premier

| Document | Contenu |
|---|---|
| **[FINAL_REPORT.md](FINAL_REPORT.md)** | **Le rapport final unique** — résumé exécutif, archi, fonctionnalités, validations, risques, recommandations prod, roadmap V3. **Commencer ici.** |
| [CONSISTENCY_AUDIT.md](CONSISTENCY_AUDIT.md) | Audit final de cohérence — les 11 dimensions vérifiées, anomalies classées |
| [VALIDATION_MATRIX.md](VALIDATION_MATRIX.md) | Toutes les portes de validation, résultats, rejeu |
| [VERSIONS.md](VERSIONS.md) | Versions (release, pile, migrations, tags) |
| [DEPENDENCIES.md](DEPENDENCIES.md) | Dépendances backend + frontend, notes d'épinglage |
| [INVENTORY.md](INVENTORY.md) | Fichiers, modules, routes (44), tables (13) — mesurés |

## Notes de version &amp; guides (dans `docs/`)

| Livrable | Chemin |
|---|---|
| Release Notes | `../../RELEASE_NOTES.md` |
| Quick Start | `../../QUICK_START.md` |
| Installation | `../../INSTALL.md` |
| Déploiement (prod) | `../../DEPLOYMENT_GUIDE.md` |
| Guide Docker | `../../DOCKER_GUIDE.md` |
| Sauvegarde / restauration | `../../BACKUP_RESTORE.md` |
| Guide des migrations | `../../MIGRATION_GUIDE.md` |
| Guide utilisateur (artisan) | `../../USER_GUIDE.md` |
| Guide administrateur | `../../ADMIN_GUIDE.md` |
| Référence API (44 endpoints) | `../../API_REFERENCE.md` |
| Sécurité | `../../SECURITY.md` |
| Limitations connues | `../../KNOWN_LIMITATIONS.md` |
| Dépannage | `../../TROUBLESHOOTING.md` |
| Architecture | `../../ARCHITECTURE.md` |
| Licence | `../../../LICENSE.md` |
| Contribuer | `../../../CONTRIBUTING.md` |
| Changelog | `../../../CHANGELOG.md` |

## Rapports de validation (dans `docs/release/`)

| Rapport | Chemin | Objet |
|---|---|---|
| **Rapport UAT** | `../08_USER_ACCEPTANCE_TEST.md` | Parcours artisan 17 étapes, vrai navigateur |
| **Rapport de certification V2** (9 axes, QA, Docker, sécurité) | `../07_V2_CERTIFICATION.md` | Preuves exécutées de l'audit final V2 |
| **Rapport d'architecture** | `../../ARCHITECTURE.md` | Carte de l'architecture V2 |
| **Rapport de sécurité** | `../../SECURITY.md` | Modèle de sécurité en place |
| Triage de périmètre V2 | `../06_V2_SCOPE_TRIAGE.md` | Ce qui est livré / reporté V3 |
| Preuves brutes (scripts + sorties) | `../evidence/` | pytest, flutter, QA HTTP, casse, migrations |

## Artefacts « rapport QA » et « rapport Docker »

Les résultats QA et Docker ne sont pas des documents séparés : ils sont
consolidés dans **VALIDATION_MATRIX.md** (résultats + rejeu) et détaillés
dans **`../07_V2_CERTIFICATION.md`** (§ preuves exécutées, § validation
Docker). Les scripts rejouables sont dans **`../evidence/`**.

## Roadmap V3

`../../ROADMAP.md` (+ triage `../06_V2_SCOPE_TRIAGE.md`) et la section 10 du
`FINAL_REPORT.md`.

## État de publication

**Rien n'est poussé sur `origin`.** Le tag `v2.0.0-rc1` est local. La
publication attend l'autorisation explicite du propriétaire.
