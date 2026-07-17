# Quick Start — ARTIZEN V2

Démarrer la pile complète en local, en quelques minutes. Ces commandes sont
celles réellement exécutées pour valider la V2 (Docker Desktop sur Windows
11 + WSL 2, mais elles sont identiques sur macOS/Linux).

## Prérequis

- **Docker Desktop** (ou Docker Engine + Compose v2).
- Pour le frontend : **Flutter** (Dart 3.12.2, contrainte exacte du
  `pubspec.yaml`) — facultatif si vous n'ouvrez que l'API.

## 1. Backend + base de données (Docker)

```bash
cp .env.example .env      # requis avant le premier démarrage
docker compose up         # db + migrations Alembic + API sur :8000
```

À l'issue :

- API : http://localhost:8000
- Swagger : http://localhost:8000/docs
- Santé : http://localhost:8000/health — fait un vrai `SELECT 1` et renvoie
  `degraded` si la base est injoignable.

L'entrypoint attend que PostgreSQL soit prêt, applique les migrations, puis
lance uvicorn. **Aucune clé d'API n'est nécessaire** : sans
`ANTHROPIC_API_KEY`, le copilote IA bascule sur un provider mock déterministe
et l'application démarre normalement.

Pour réinitialiser complètement (y compris le volume PostgreSQL) :

```bash
docker compose down -v
```

## 2. Frontend (Flutter Web)

```bash
cd frontend
flutter pub get
flutter run -d web-server --web-port 3000
```

Le port **3000** est imposé : `CORS_ORIGINS` vaut `http://localhost:3000`
(valeur venant de `.env`, chargée par `docker-compose.yml` via `env_file`).
Servir le frontend sur un autre port exige de modifier `.env`.

Après toute modification d'un modèle Freezed :

```bash
dart run build_runner build --delete-conflicting-outputs
```

## 3. Premier usage

1. Ouvrir http://localhost:3000, créer un compte (l'inscription crée
   l'entreprise).
2. Renseigner un catalogue (catégories + articles) et un client.
3. Composer un devis, l'envoyer, l'accepter, le dupliquer, générer le PDF.

Le parcours artisan complet est décrit dans `docs/USER_GUIDE.md`.

## Vérifier que tout va bien

```bash
docker compose ps                          # db + backend "healthy"
docker compose exec backend pytest         # 208 passed
curl -s http://localhost:8000/health       # {"status":"ok", ...}
```

## En cas de souci

- **Le conteneur backend redémarre en boucle sur Windows** : voir la note
  CRLF / `.gitattributes` dans `docs/TROUBLESHOOTING.md`.
- **Upload de logo en `EACCES`** : volume préexistant détenu par root — voir
  `docs/DOCKER_GUIDE.md` (réparation de propriété).
- Autres symptômes : `docs/TROUBLESHOOTING.md`.
