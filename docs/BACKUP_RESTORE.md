# Sauvegarde &amp; restauration — ARTIZEN V2

> **État :** le dépôt fournit un **script de sauvegarde versionné et testé**
> (`scripts/backup.sh`, voir ci-dessous) ; il reste à l'**activer** côté
> exploitation (cron, rétention, stockage hors-site) — de la *configuration*, pas
> du code. Les procédures manuelles détaillées plus bas ont été **réellement
> exécutées** contre la pile Docker de validation (2026-07-17) et restent la
> référence de restauration.

## Script versionné (`scripts/backup.sh`)

Sauvegarde **cohérente** base + stockage, forme scriptée des procédures manuelles
ci-dessous : arrêt du backend (point-in-time cohérent) → `pg_dump -Fc` → `tar` du
volume storage → redémarrage (via un `trap`, même en cas d'erreur). Produit
`backups/db_<stamp>.dump` + `backups/storage_<stamp>.tgz` (le dossier `backups/`
est ignoré par git). **Testé de bout en bout** (dump `PGDMP` de 13 Mo + archive de
25 Mo, backend sain après coup).

```bash
./scripts/backup.sh                     # sauvegarde cohérente base + stockage
RETENTION_DAYS=30 ./scripts/backup.sh   # + purge des sauvegardes > 30 jours
```

Variables : `BACKUP_DIR`, `STORAGE_VOLUME`, `DB_USER`, `DB_NAME`, `RETENTION_DAYS`
(0 par défaut = tout garder, tant que la politique de rétention RGPD n'est pas
fixée). **Activation de production** (config, hors code) : ordonnancement
(cron/systemd timer), copie hors-site chiffrée, test de restauration régulier.

## Ce qu'il faut sauvegarder

Tout l'état persistant tient dans **deux volumes Docker** :

| Volume (nom compose réel) | Contenu |
|---|---|
| `artizen-app_artizen_postgres_data` | La base PostgreSQL (comptes, entreprises, catalogue, clients, devis, compteurs de numéros…) |
| `artizen-app_artizen_storage_data` | Fichiers : logos, modèles PDF, documents uploadés (`logos/`, `templates/`, `document_analysis/`) |

> Le préfixe `artizen-app_` est ajouté par Compose (nom du projet = nom du
> dossier). Vérifiez le vôtre : `docker volume ls | grep artizen`.

## Sauvegarde de la base — `pg_dump` (testé)

Dump logique, portable, restaurable sur une autre instance PostgreSQL 16 :

```bash
docker compose exec -T db pg_dump -U artizen -d artizen > artizen_db_$(date +%F).sql
```

*Testé : produit un dump SQL complet (13 tables, dont `alembic_version` et
`quote_counters`).* Pour un dump compressé au format custom (restauration
sélective possible) :

```bash
docker compose exec -T db pg_dump -U artizen -d artizen -Fc > artizen_db_$(date +%F).dump
```

## Restauration de la base

> ⚠️ Écrase les données courantes. Faites-le sur une base vide ou après un
> `down -v`.

Depuis un dump SQL :

```bash
# base fraîche (les migrations seront déjà incluses dans le dump)
docker compose up -d db
cat artizen_db_2026-07-17.sql | docker compose exec -T db psql -U artizen -d artizen
```

Depuis un dump custom (`-Fc`) :

```bash
docker compose exec -T db pg_restore -U artizen -d artizen --clean --if-exists < artizen_db_2026-07-17.dump
```

## Sauvegarde du volume de stockage — `tar` (testé)

Le stockage est un volume ; on l'archive via un conteneur jetable qui le
monte en lecture seule :

```bash
# Windows/Git Bash : export MSYS_NO_PATHCONV=1  (sinon les chemins sont convertis)
docker run --rm \
  -v artizen-app_artizen_storage_data:/data:ro \
  -v "$(pwd)":/backup \
  alpine tar czf /backup/artizen_storage_$(date +%F).tgz -C /data .
```

*Testé : archive `.tgz` produite, contenant l'arborescence
`document_analysis/…pdf`, `logos/`, `templates/`.*

## Restauration du volume de stockage

```bash
docker compose down                     # libère le volume
docker volume create artizen-app_artizen_storage_data
docker run --rm \
  -v artizen-app_artizen_storage_data:/data \
  -v "$(pwd)":/backup \
  alpine sh -c "rm -rf /data/* && tar xzf /backup/artizen_storage_2026-07-17.tgz -C /data"
docker compose up -d
```

> **Propriété des fichiers restaurés.** Le conteneur tourne en non-root
> (`artizen`). Après restauration, réparez la propriété si des uploads
> échouent en `EACCES` :
> ```bash
> docker compose run --rm --user root backend chown -R artizen /data/storage
> ```
> Voir `docs/DOCKER_GUIDE.md`.

## Sauvegarde cohérente (base + stockage ensemble)

La base référence des chemins de fichiers du volume de stockage. Pour un
point de restauration cohérent, sauvegardez les **deux au même moment**,
idéalement application arrêtée (`docker compose stop backend`) le temps des
dumps, puis relancez.

```bash
docker compose stop backend
docker compose exec -T db pg_dump -U artizen -d artizen -Fc > db_$(date +%F).dump
docker run --rm -v artizen-app_artizen_storage_data:/data:ro -v "$(pwd)":/backup \
  alpine tar czf /backup/storage_$(date +%F).tgz -C /data .
docker compose start backend
```

## Recommandations d'exploitation (à mettre en place)

- **Automatiser** (cron/scheduler) le couple dump-base + tar-stockage.
- **Rétention** (ex. 7 quotidiens + 4 hebdomadaires) et **copie hors-site**.
- **Tester la restauration** régulièrement sur un environnement jetable — une
  sauvegarde non restaurée n'est pas une sauvegarde.
- Chiffrer les archives si elles quittent l'hôte (elles contiennent des
  données clients).
