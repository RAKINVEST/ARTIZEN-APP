# ARTIZEN — Guide de déploiement (bêta / production)

> Rend exécutables les étapes **Hébergement** et **Déploiement** de la séquence de lancement. Procédure
> concrète, ancrée sur la stack réelle (`docker-compose.yml`, `.env.example`, `app/core/config.py`).
> Pas une nouvelle fonctionnalité : de l'exploitation.

> ✅ **Email** : le fournisseur **SMTP réel** existe (`SmtpEmailProvider`). Pour une bêta avec de vrais
> artisans, il suffit de passer `EMAIL_PROVIDER=smtp` et de renseigner les variables `SMTP_*` (voir §7) —
> aucun développement à faire. En `mock` (défaut), les emails sont seulement journalisés (pas d'envoi).

---

## 1. Prérequis serveur
- 1 serveur Linux (2 vCPU / 2–4 Go suffisent pour une bêta), Docker + Docker Compose installés.
- Un **domaine** pointant vers l'IP (ex. `app.artizen.fr` pour le front, `api.artizen.fr` pour l'API —
  ou un seul domaine avec chemins).
- Un reverse-proxy TLS (**Caddy** recommandé : HTTPS automatique via Let's Encrypt).

## 2. Configuration (`.env`)
`cp .env.example .env` puis régler **impérativement** pour la production :

```
ENVIRONMENT=production
DEBUG=false                      # refusé si true en prod (config.py)
SECRET_KEY=<64+ caractères>      # python -c "import secrets; print(secrets.token_urlsafe(64))"
POSTGRES_PASSWORD=<mot de passe fort>
CORS_ORIGINS=https://app.artizen.fr    # l'URL exacte du frontend, pas localhost
RATE_LIMIT_BACKEND=redis         # compteur partagé entre workers (sinon plafond ~x4)
REDIS_URL=redis://redis:6379/0
APP_BASE_URL=https://app.artizen.fr    # base des liens dans les emails (reset)
EMAIL_PROVIDER=mock              # -> à passer sur un vrai fournisseur avant la bêta (§7)
EMAIL_FROM=no-reply@artizen.fr
```
> Le guard de `config.py` **refuse de démarrer** en production avec le `SECRET_KEY` d'exemple ou un
> secret < 32 caractères, et avec `DEBUG=true` — c'est voulu.

## 3. Démarrage
```
docker compose up -d            # db + redis + backend (+ migrations Alembic au démarrage) + worker
docker compose ps               # tout doit être "healthy"
curl -fsS https://api.artizen.fr/health   # -> {"status":"ok", "database":"ok", "redis":"ok", ...}
```
> ⚠️ Le `command:` d'`uvicorn --reload` dans `docker-compose.yml` est le **mode développement**. En
> production, lancez l'**image sans override** (son `CMD` = plusieurs workers, sans reload), ou retirez
> la ligne `command:` + le bind-mount `./backend:/app`. Ne pas exposer `--reload` en prod.

## 4. Reverse-proxy HTTPS (exemple Caddy)
```
api.artizen.fr {
    reverse_proxy localhost:8000
}
app.artizen.fr {
    root * /srv/artizen-web      # le bundle Flutter web
    file_server
    try_files {path} /index.html
}
```
Caddy obtient et renouvelle le certificat TLS automatiquement. (HSTS appartient au proxy — l'API ne le
pose pas volontairement.)

## 5. Frontend web
```
cd frontend
flutter build web --release --dart-define=API_BASE_URL=https://api.artizen.fr/api
# déployer build/web/ vers /srv/artizen-web (servi par le proxy)
```
> Sans le `--dart-define`, l'app pointe sur `http://localhost:8000/api` et sera **morte** pour l'artisan.
> (Mobile : `flutter build apk --release --dart-define=...`, signé, distribué par lien.)

## 6. Sauvegardes (obligatoire — les devis sont des documents légaux)
```
# Cron quotidien : dump chiffré hors du serveur
docker compose exec -T db pg_dump -U $POSTGRES_USER $POSTGRES_DB | gzip > artizen-$(date +%F).sql.gz
```
- Tester **au moins une restauration** avant d'ouvrir la bêta.
- Le volume `artizen_storage_data` (logos, signatures) doit aussi être sauvegardé.

## 7. Email réel (avant d'ouvrir la bêta)
Le `SmtpEmailProvider` **existe** et fonctionne avec tout service SMTP standard (Brevo, Postmark,
Mailjet, Amazon SES… — la plupart offrent un palier gratuit). Pour l'activer, dans `.env` :
```
EMAIL_PROVIDER=smtp
EMAIL_FROM=no-reply@artizen.fr
SMTP_HOST=<smtp du fournisseur>
SMTP_PORT=587
SMTP_USERNAME=<identifiant / clé API>
SMTP_PASSWORD=<mot de passe / clé>
SMTP_USE_TLS=true        # 587 + STARTTLS (défaut). Pour 465 + SSL : SMTP_PORT=465, SMTP_USE_SSL=true, SMTP_USE_TLS=false
```
Puis `docker compose up -d` (ou redémarrer le backend). Un envoi qui échoue est **journalisé, jamais
bloquant** (le reset répond 204 quoi qu'il arrive) — surveillez `email.smtp_send_failed` dans les logs.
**Testez le reset de bout en bout** (demande → email reçu → nouveau mot de passe) avant d'inviter.

## 8. Monitoring
- **Uptime** : brancher UptimeRobot / BetterStack sur `https://api.artizen.fr/health` (alerte si ≠ 200
  ou `status != ok`).
- **Erreurs** : surveiller les logs `WARNING`/`ERROR` du backend ; (option) un collecteur de logs.
- Le worker Arq n'est pas critique pour la bêta (pas de tâche métier active) mais doit rester « up ».

## 9. Avant d'ouvrir — check-list de bascule
- [ ] `/health` = ok en HTTPS ; certificat valide.
- [ ] `SECRET_KEY` prod, `DEBUG=false`, `CORS_ORIGINS` = URL réelle, `RATE_LIMIT_BACKEND=redis`.
- [ ] Frontend buildé avec le bon `API_BASE_URL` ; parcours complet testé **sur un vrai téléphone**.
- [ ] **Email réel** branché (reset fonctionnel de bout en bout).
- [ ] Sauvegardes actives + **restauration testée**.
- [ ] **Base purgée** des données de test (doublons « Chauffe-eau Atlantic » créés par la suite pytest).
- [ ] Monitoring branché ; canal de support ouvert.
- [ ] CGU/RGPD publiées (voir `docs/legal/`).

## 10. Mises à jour
Les migrations Alembic s'appliquent au **démarrage** du conteneur (entrypoint). Pour déployer une
nouvelle version : `docker compose pull/build` puis `docker compose up -d` (les migrations passent
automatiquement). Sauvegarder **avant** toute mise à jour.
