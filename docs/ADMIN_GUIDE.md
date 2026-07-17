# Guide administrateur — ARTIZEN V2

Destiné à qui exploite une instance Artizen : modèle de compte, isolation des
données, configuration de l'identité d'entreprise, et opérations courantes.
Pour l'installation et le déploiement, voir `INSTALL.md` et
`DEPLOYMENT_GUIDE.md`.

## Modèle de compte et d'isolation

- **Une inscription = un utilisateur + une entreprise (`Company`).** L'email
  est unique (409 sinon). Le mot de passe est haché (passlib/bcrypt).
- **Tout est cloisonné par entreprise (multi-tenant).** Le `company_id` est
  porté par le JWT ; il n'est **jamais** accepté depuis le client. Une
  ressource d'une autre entreprise renvoie **404** (jamais 403 — pour ne pas
  confirmer son existence).
- **Il n'y a pas de rôle « admin » applicatif ni de back-office.** Chaque
  compte administre sa propre entreprise. L'administration de l'instance
  (base, volumes, migrations) se fait par l'exploitant, hors application.

## Authentification et session

- JWT signé `HS256`, durée `ACCESS_TOKEN_EXPIRE_MINUTES` (défaut **1440 min /
  24 h**).
- Côté web, le jeton est conservé dans le `localStorage` du navigateur ; un
  **401** (jeton expiré/invalide) rebascule automatiquement l'utilisateur
  vers l'écran de connexion.
- **Rate limiting** sur `login`/`register` (10 requêtes / 60 s par IP). Voir
  `SECURITY.md` pour ses limites (compteur par worker, IP du socket).

## Configurer l'identité d'entreprise — point important

L'identité (raison sociale, SIRET, N° TVA, coordonnées, couleurs, logo)
alimente les PDF. **Deux chemins, aux capacités inégales :**

### Par l'API (complet)

L'API expose la configuration complète :

- `PUT /api/branding/company` — raison sociale, SIRET, N° TVA, adresse,
  coordonnées.
- `PUT /api/branding/brand` — couleurs, police, slogan.
- `POST /api/branding/logo` — téléversement du logo (PNG/JPEG/SVG, ≤ 5 Mo).
- `GET /api/branding/profile` — l'état courant.

### Par l'application Flutter (partiel)

**Dans l'app, la seule façon de renseigner l'identité est le flux
« Importer un ancien devis »** (Paramètres → *Importer un ancien devis*) :

1. Choisir un ancien PDF de devis/facture.
2. L'app en **détecte** l'en-tête, le logo, les couleurs, le SIRET, le N° TVA…
3. Un formulaire de **prévisualisation** présente les valeurs détectées
   (pré-remplies), **modifiables** : raison sociale, SIRET, N° TVA, adresse,
   téléphone, email, site web, couleurs principale/secondaire.
4. **« Valider ce modèle »** applique la configuration — **rien n'est
   appliqué sans cette confirmation explicite** (invariant produit n°7).

> **Limites connues de l'app** (l'API ne les a pas) :
> - Pas de formulaire d'édition **directe** de l'identité hors de ce flux
>   d'import. La promesse « renommer plus tard depuis Paramètres » de l'écran
>   d'inscription **n'est pas tenue** dans l'UI actuelle.
> - Pas de **téléversement de logo** depuis l'app (le logo est seulement
>   *détecté*). Utilisez `POST /api/branding/logo` pour en poser un.
>
> Ces manques sont documentés dans `KNOWN_LIMITATIONS.md` (reportés V3).

## Copilote IA — configuration

- Sans `ANTHROPIC_API_KEY`, le copilote fonctionne en **mode mock**
  (déterministe, hors-ligne) : l'app démarre et répond, mais l'appariement se
  fait par mots-clés, pas par une vraie IA.
- Ajouter une clé réelle + redémarrer le backend suffit à passer en réel —
  aucun changement de code.
- Surveiller `quote_assistant.catalog_truncated` : une entreprise au-delà de
  1000 articles actifs dépasse ce que le copilote lit.

## Opérations courantes (exploitant)

```bash
# santé
curl -s http://localhost:8000/health        # {"database":"ok"}

# base de données
docker compose exec db psql -U artizen -d artizen
docker compose exec backend alembic current  # tête attendue : 6cc7943bff6a

# tests
docker compose exec backend pytest           # 208 passed
```

- **Sauvegarde / restauration** : `BACKUP_RESTORE.md` (procédures testées).
- **Migrations** : `MIGRATION_GUIDE.md`.
- **Réparer un volume de stockage détenu par root** (uploads en `EACCES`) :
  `DOCKER_GUIDE.md`.

## Journaux à surveiller

| Message | Signification |
|---|---|
| `quote_assistant.catalog_truncated` | > 1000 articles actifs pour une entreprise |
| `branding.previous_logo_delete_failed` | fuite de fichier (ancien logo non supprimé) |
| `anthropic.request_failed` | fournisseur IA indisponible (503) |
| Taux de **429** sur `/auth/*` | attaque d'énumération ou plafond trop bas |
| `Handled application error … not found` | accès inter-tenant refusé (404) — **normal**, pas une panne |
