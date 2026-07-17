# Guide des migrations — ARTIZEN V2 (Alembic)

Comment les migrations fonctionnent ici, comment en créer une, et les pièges
PostgreSQL qui ont réellement coûté du temps sur ce projet. Ancré sur
`backend/alembic/` du commit `v2.0.0-rc1`.

## Chaîne des migrations (autoritative)

Vérifiée dans le conteneur (`alembic history`) : chaîne linéaire, une seule
tête.

```
<base>
  → bd7d5c7f9cc8  add branding tables
  → c68fbf271bcb  add document_analyses table
  → 65a012f34084  add document_detection_results table
  → 6521371f0e54  add catalog, clients and quotes tables
  → 75aa1c39d0bf  add users table
  → 6cc7943bff6a  add quote status and numbering   (head — V2)
```

**6 migrations**, tête = `6cc7943bff6a`. La base compte **13 relations**
(12 tables métier + `alembic_version`), dont `quote_counters` ajoutée en V2.

## Fonctionnement au démarrage

L'entrypoint du conteneur (`backend/entrypoint.sh`) attend PostgreSQL, puis
exécute `alembic upgrade head` **avant** de lancer uvicorn. Une installation
neuve applique donc les 6 migrations automatiquement ; il n'y a rien à faire
manuellement en usage normal.

## Commandes

```bash
# état courant
docker compose exec backend alembic current

# historique complet
docker compose exec backend alembic history

# appliquer jusqu'à la tête (fait par l'entrypoint)
docker compose exec backend alembic upgrade head

# revenir en arrière d'un cran
docker compose exec backend alembic downgrade -1

# créer une migration (autogenerate) — À RELIRE, voir pièges
docker compose exec backend alembic revision --autogenerate -m "message"
```

## Créer une migration — la règle du projet

`alembic revision --autogenerate` est un **point de départ, pas un livrable**.
Sur ce dépôt, chaque migration autogénérée a dû être relue et corrigée. Son
« *please adjust!* » n'est pas décoratif.

### Piège 1 — colonnes `NOT NULL` sans défaut sur une table peuplée

Ajouter une colonne `NOT NULL` sans défaut échoue immédiatement dès qu'il
existe déjà des lignes. La migration V2 les ajoute **nullables**, les
**remplit** (backfill), puis pose la **contrainte** :

```
add column (nullable) → UPDATE de backfill → ALTER ... SET NOT NULL
```

### Piège 2 — backfill des données existantes

`6cc7943bff6a` numérote les devis existants par entreprise et par année dans
leur ordre de création, **et amorce les compteurs** (`quote_counters`) là où
ces numéros s'arrêtent. Sans cela, le devis suivant réclamerait
`DEV-2026-0001` déjà pris. *Vérifié à l'exécution contre 29 devis réels :
0 NULL, 0 doublon par entreprise, compteurs cohérents.*

### Piège 3 — PostgreSQL ne supprime pas un type ENUM avec la colonne

En PostgreSQL, `DROP COLUMN` **ne supprime pas** le type créé par
`CREATE TYPE`. Un `downgrade()` qui oublie de `DROP TYPE quote_status`
laisse le type en place, et le ré-`upgrade` meurt sur « type already exists ».
C'est le même défaut que l'audit V1 avait corrigé dans les quatre migrations
précédentes ; l'autogenerate le reproduit à chaque fois. Le `downgrade` de
`6cc7943bff6a` supprime explicitement le type.

## Rollback — testé

L'aller-retour complet a été vérifié en Docker sur données réelles :

```bash
docker compose exec backend alembic downgrade base   # défait tout
docker compose exec backend alembic upgrade head      # ré-applique tout
```

*Résultat : aller-retour propre, aucune erreur « type already exists », tête
`6cc7943bff6a` retrouvée.* La preuve est dans
`docs/release/evidence/alembic_upgrade.txt` (V1) et
`docs/release/07_V2_CERTIFICATION.md` (V2).

## Avant toute migration en production

1. **Sauvegarder la base** (`docs/BACKUP_RESTORE.md`).
2. Vérifier que la migration a un `downgrade()` réel (pas un `pass`).
3. L'appliquer, puis contrôler `alembic current` == tête attendue et
   `GET /health` → `{"database":"ok"}`.
