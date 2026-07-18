# ARTIZEN — Plan de bêta-test (Bêta 1 privée)

> Kit opérationnel pour lancer une bêta privée avec de vrais artisans. Aucune nouvelle fonctionnalité :
> ce document prépare le terrain. À lire avec [RAPPORT_VALIDATION_TERRAIN.md](RAPPORT_VALIDATION_TERRAIN.md)
> (frictions + priorités) et [INSTRUMENTATION.md](INSTRUMENTATION.md) (métriques).

---

## 1. Check-list d'installation (pour l'équipe qui héberge)

> ⚠️ **Prérequis bloquant** : ARTIZEN n'a pas encore d'instance déployée (cf. rapport, P0). Une bêta
> exige une instance **hébergée et accessible** aux artisans (pas un `localhost`). Cette check-list
> couvre l'hébergement minimal.

**Backend + base**
- [ ] Serveur Linux (Docker installé) accessible en HTTPS (reverse-proxy TLS type Caddy/Traefik/Nginx).
- [ ] `cp .env.example .env` puis **régler** : `SECRET_KEY` (généré : `python -c "import secrets;
      print(secrets.token_urlsafe(64))"`), `POSTGRES_PASSWORD` fort, `ENVIRONMENT=production`,
      `DEBUG=false`, `CORS_ORIGINS=<URL du frontend>`, `RATE_LIMIT_BACKEND=redis`.
- [ ] `docker compose up -d` (db + migrations Alembic + API + worker + redis).
- [ ] Vérifier `GET /health` → `status: ok` (fait un vrai `SELECT 1`).
- [ ] Sauvegarde PostgreSQL planifiée (les devis des artisans sont des documents légaux).
- [ ] **Purger les données de test** de la base avant d'ouvrir (doublons « Chauffe-eau Atlantic »
      créés par la suite de tests — cf. rapport).

**Frontend**
- [ ] `flutter build web --release` avec `--dart-define=API_BASE_URL=https://<api>/api` (sinon l'app
      pointe sur `localhost` — cf. rapport, P0). Servir le bundle en HTTPS.
- [ ] (Mobile) `flutter build apk --release` signé, distribué via lien/Play Store interne.
- [ ] Vérifier le parcours complet sur un vrai appareil avant d'inviter (validation e2e manuelle : aucun
      test Flutter n'appelle le vrai backend).

**Comptes bêta**
- [ ] Créer un compte par artisan (l'inscription est ouverte : email + mot de passe).
- [ ] ⚠️ **Pas de « mot de passe oublié »** aujourd'hui (cf. rapport, P0) : prévoir une procédure
      manuelle de réinitialisation par l'équipe (SQL) + prévenir les bêta-testeurs.

---

## 2. Guide de prise en main (pour l'artisan) — « Votre premier devis en 6 étapes »

> À remettre à chaque bêta-testeur (1 page). Les écrans existent tous ; l'ordre ci-dessous est le
> chemin recommandé faute d'assistant de première connexion (cf. rapport, friction onboarding).

1. **Connexion** — Créez votre compte (email + mot de passe). Notez bien votre mot de passe : la
   récupération n'est pas encore automatique en bêta.
2. **Votre entreprise** — *Paramètres → Mon entreprise*. Renseignez : nom, SIRET, forme juridique,
   adresse, **régime de TVA** (normale ou franchise/micro), **assurance décennale**, conditions de
   paiement. Importez votre **logo** et votre **signature**. → C'est ce qui rend vos devis conformes.
3. **Votre catalogue** — *Catalogue*. Créez une **catégorie** (ex. « Plomberie »), puis vos **articles**
   (désignation, unité, prix HT, TVA). Vous pourrez les rechercher instantanément ensuite.
4. **Vos clients** — *Clients → +*. Nom, adresse (importante pour le devis), coordonnées.
5. **Votre devis** — *Devis → +*. Choisissez le client, ajoutez des articles (recherche dans le
   picker), ajustez les quantités. Créez.
6. **Vérifier & envoyer** — Ouvrez le devis : le bandeau **« Prêt à émettre »** vous dit s'il manque
   quelque chose (cliquez sur un manque pour aller le corriger). Puis **Télécharger / Partager** le
   PDF, et **Marquez-le « Envoyé »**.

*Astuce : « Dupliquer » un devis existant crée un brouillon identique — pratique pour un devis
similaire.*

---

## 3. Procédure de remontée des bugs

- **Canal** : un unique canal dédié (ex. groupe WhatsApp bêta, ou email `beta@…`, ou tableau partagé).
- **Un bug = un message**, avec :
  - Ce que je faisais (l'écran + l'action).
  - Ce qui s'est passé vs ce que j'attendais.
  - Capture d'écran si possible.
  - Appareil (téléphone/PC + navigateur) et heure approximative.
- **Sévérité auto-déclarée** : 🔴 « je suis bloqué » / 🟠 « gênant mais je continue » / 🟡 « détail ».
- **Côté équipe** : chaque remontée est **catégorisée** (voir grille §5), reproduite, priorisée (P0–P3),
  et l'artisan est **tenu informé** (Customer Success : un bêta-testeur qu'on ignore décroche).

---

## 4. Formulaire de retour utilisateur (kit de retour)

> À envoyer après **1 semaine** d'usage, puis en fin de bêta. Court exprès.

**A. Profil** : métier · statut (micro / société) · aisance informatique (1–5) · appareil principal.

**B. Le parcours (note 1–5 + un mot)**
- Créer mon compte et configurer mon entreprise : ⬜ / …
- Ajouter mes articles au catalogue : ⬜ / …
- Créer un client : ⬜ / …
- Créer un devis : ⬜ / …
- Obtenir le PDF et l'envoyer : ⬜ / …
- Retrouver un ancien devis : ⬜ / …

**C. Questions ouvertes**
- À quel moment vous êtes-vous demandé « comment je fais ? » ?
- Qu'avez-vous trouvé le plus **pénible** ?
- Qu'est-ce qui vous a **manqué** pour remplacer votre outil actuel ?
- Le **devis PDF** vous semble-t-il professionnel et prêt à être remis à un client ? (oui/non + pourquoi)
- Recommanderiez-vous ARTIZEN à un collègue ? (0–10) — *NPS*

**D. Catégorisation (remplie par l'équipe)** : chaque retour est étiqueté
`Bug` · `Compréhension` · `Ergonomie` · `Performance` · `Fonction manquante` · `Suggestion`.

---

## 5. Grille d'évaluation (synthèse hebdomadaire équipe)

| Dimension | Ce qu'on mesure | Cible bêta |
|---|---|---|
| **Activation** | % d'artisans ayant créé ≥ 1 devis conforme | > 80 % |
| **Autonomie** | % ayant tout configuré **sans aide** | à observer |
| **Fiabilité** | nb de bugs 🔴 / testeur / semaine | → 0 |
| **Compréhension** | nb de « où dois-je faire ça ? » | ↓ chaque semaine |
| **Performance ressentie** | note fluidité (1–5) | ≥ 4 |
| **Valeur** | % qui disent « je remplace mon outil actuel » | signal go/no-go |
| **NPS** | recommandation 0–10 | ≥ 30 |

Chaque retour classé en `Bug / Compréhension / Ergonomie / Performance / Fonction manquante / Suggestion`
puis priorisé `P0 / P1 / P2 / P3` (voir rapport).
