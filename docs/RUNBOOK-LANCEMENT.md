# ARTIZEN — Runbook de lancement (check-list opérationnelle)

> Transforme la check-list de lancement en **plan exécutable** : statut réel, responsable, dépendances,
> effort, chemin critique. Ancré sur l'état réel du produit (Phases 1/1.1/0 livrées) et la
> [validation terrain](beta/RAPPORT_VALIDATION_TERRAIN.md).
>
> **Lecture honnête** : ~6 items ne sont **pas** de simples cases à cocher — ce sont des
> **développements encore à faire** (reset mot de passe, emails, envoi intégré, onboarding, Stripe,
> analytics). Ouvrir la bêta n'est pas « un week-end » : c'est **votre setup externe + ~2–3 semaines de
> dev ciblé**.

**Légende statut** : ✅ fait · 🟡 partiel / contenu prêt · ⬜ à faire
**Type** : 🧑 Vous/Ops (action externe) · 🛠️ Dev (à construire) · 📝 Contenu (rédactionnel) · 🏁 Jalon

---

## 1. Tableau de bord des 21 items

| # | Item | Statut | Type | Dépend de | Effort | Note |
|---|---|---|---|---|---|---|
| 1 | **Hébergement opérationnel** | ⬜ | 🧑 Ops | Domaine | 0,5–1 j | Aucun déploiement aujourd'hui ; serveur Docker + reverse-proxy |
| 2 | **Domaine acheté** | ⬜ | 🧑 Vous | — | 15 min | Achat registrar (ex. `artizen.fr`) |
| 3 | **HTTPS** | ⬜ | 🧑 Ops | 1, 2 | inclus | Let's Encrypt via reverse-proxy (Caddy/Traefik) |
| 4 | **Sauvegardes** | ⬜ | 🧑 Ops | 1 | 0,5 j | `pg_dump` planifié + test de restauration |
| 5 | **Stripe connecté** | ⬜ | 🛠️ Dev + 🧑 | Compte Stripe (vous) | **~1 sem** | **Non construit** : abonnement/paiement à intégrer + page tarifs branchée |
| 6 | **Landing publiée** | 🟡 | 📝→🧑 | 1, 2, 3, 11, 12 | 1–2 j | **Copie prête** ([kit](KIT-LANCEMENT.md)) → intégrer + mettre en ligne |
| 7 | **Emails fonctionnels** | ⬜ | 🛠️ Dev + 🧑 | Compte email (Postmark/Brevo/SES) | **~2–3 j** | **Non construit** (aucune infra mail). Prérequis de #8 et des emails de cycle de vie |
| 8 | **Reset mot de passe** | ⬜ | 🛠️ Dev | 7 | **~2–3 j** | **Absent** (confirmé). Endpoints + token expirable + 2 écrans. **P0** |
| 9 | **Envoi du devis** | 🟡 | 🛠️/🧑 | (7 si email) | 0–4 j | Partage OS **déjà là** (télécharger + partager). Envoi **email intégré** = à construire (ou assumer le partage) |
| 10 | **Onboarding** | ⬜ | 🛠️ Dev | — | **~3–5 j** | **Aucun** (démarrage à froid). Check-list guidée « 1. Entreprise → 2. Catalogue → 3. Client → 4. Devis ». **P1 activation** |
| 11 | **CGU / CGV** | ⬜ | 📝 + juridique | — | 1–2 j | À rédiger (je fournis un gabarit) + **revue juridique** |
| 12 | **RGPD** | ⬜ | 📝 + juridique | — | 1–2 j | Politique de confidentialité + registre + base légale (gabarit + revue) |
| 13 | **Support** | ⬜ | 🧑 Vous | — | 1–2 h | Canal + `bonjour@`/`support@` relevé ; SLA 24 h |
| 14 | **Première vidéo** | 🟡 | 📝→🎬 | — | 1–2 j | **Script minuté prêt** (kit) → tournage/montage |
| 15 | **Premier tutoriel** | 🟡 | 📝 | 10 | 0,5 j | **Texte prêt** (kit) → in-app ou page ; idéalement dans l'onboarding |
| 16 | **Analytics** | ⬜ | 🧑/🛠️ | — | 0 j (palier 0) / ~1 j (palier 1) | Aucune aujourd'hui. **Palier 0 sans code** (sessions modérées + logs) ; palier 1 = table `ux_events` ([spec](beta/INSTRUMENTATION.md)) |
| 17 | **Monitoring** | ⬜ | 🧑 Ops | 1, 3 | 0,5 j | `GET /health` **existe** → brancher un uptime (UptimeRobot/BetterStack) + alertes erreurs |
| 18 | **Beta ouverte** | ⬜ | 🏁 Jalon | 1–13, 17 | — | Ouvre quand Vague 0+1+2 vertes |
| 19 | **Premier paiement** | ⬜ | 🏁 Jalon | 5, 18 | — | Dépend de Stripe + bêta |
| 20 | **Premier avis client** | ⬜ | 🏁 Jalon | 18 | — | Collecte active (email NPS après 5ᵉ devis) |
| 21 | **Premier témoignage** | ⬜ | 🏁 Jalon | 18 | — | Demande explicite aux design partners satisfaits |

**Bilan** : **7 actions à vous** · **~6 chantiers de dev** (dont 3 P0) · **5 contenus prêts à
finaliser** · **4 jalons/outcomes**.

---

## 2. Séquencement — 4 vagues (chemin le plus court vers un paiement)

### 🌊 Vague 0 — Fondations (vous / ops · ~1–3 j)
`Domaine (2)` → `Hébergement (1)` → `HTTPS (3)` → `Sauvegardes (4)` → `Monitoring (17)` → `Support (13)`.
*Sans ça, rien n'est accessible ni fiable.*

### 🌊 Vague 1 — Dev P0 avant bêta (~2–3 sem · **le vrai goulot**)
1. `Emails fonctionnels (7)` — infra transactionnelle (prérequis de tout le reste).
2. `Reset mot de passe (8)` — dépend de #7. *Sans lui, un oubli = compte perdu.*
3. `Onboarding (10)` — active la cible peu digitale.
4. *(Décision)* `Envoi du devis (9)` — email intégré **ou** assumer le partage OS pour la bêta.
5. `Stripe connecté (5)` — nécessaire pour un paiement (peut suivre la bêta si bêta = gratuite).
6. `Analytics (16)` — palier 0 (sans code) suffit pour la bêta.

### 🌊 Vague 2 — Légal & mise en ligne (~2–4 j, en parallèle de la Vague 1)
`CGU/CGV (11)` + `RGPD (12)` (gabarits → revue) → `Landing publiée (6)` → `Vidéo (14)` +
`Tutoriel (15)`.

### 🌊 Vague 3 — Bêta & preuve (jalons)
`Beta ouverte (18)` *(bêta **privée** d'abord, cf. validation terrain)* → collecte
`Avis (20)` + `Témoignage (21)` → `Premier paiement (19)` (après Stripe).

**Chemin critique vers le 1er paiement** :
`Domaine → Hébergement → HTTPS → Emails → Reset MDP → (Onboarding) → Légal → Landing → Stripe → Bêta → Paiement`.
Réaliste : **~3–4 semaines** (votre setup + ~2–3 sem de dev), sans compromettre la qualité.

---

## 3. Ce qui vous appartient vs ce que je peux construire

**À vous / ops (je ne peux pas les faire à votre place)** : acheter le domaine, ouvrir le compte
d'hébergement, créer le compte **Stripe** et le compte **fournisseur d'emails**, faire tourner le
reverse-proxy HTTPS + sauvegardes + monitoring, valider **juridiquement** les CGU/RGPD, tourner la
vidéo, ouvrir le canal de support.

**Constructible immédiatement en dépôt (si vous me donnez le go)** :
- 🛠️ **Reset mot de passe** (backend endpoints + token expirable + 2 écrans Flutter).
- 🛠️ **Infra email transactionnelle** (abstraction fournisseur + mock, comme l'IA/le storage : marche
  sans clé, bascule en réel avec la clé) → alimente reset + bienvenue + reçu.
- 🛠️ **Onboarding guidé** (check-list de démarrage sur le dashboard vide).
- 🛠️ **Envoi du devis par email** (si on veut l'intégré plutôt que le partage OS).
- 🛠️ **Analytics palier 1** (table `ux_events` + client léger) — optionnel.
- 📝 **Gabarits CGU / CGV / Politique de confidentialité** (à faire relire par un juriste).

---

## 4. Recommandation

1. **Vous, tout de suite** : achetez le domaine, provisionnez l'hébergement (Vague 0). ~1 jour.
2. **Moi, en parallèle (sur votre go)** : je construis les **3 dev P0** — **infra email → reset mot de
   passe → onboarding** — qui débloquent la bêta, plus les **gabarits légaux**. C'est le vrai chemin
   critique.
3. **Décision produit à trancher** : bêta avec **envoi par partage OS** (rapide) ou **envoi email
   intégré** (mieux, +2–4 j) ? Et **Stripe avant ou après** la bêta (bêta gratuite = Stripe après) ?
4. **Ne pas ouvrir en public** : rester en **bêta privée** tant que l'activation et la rétention ne sont
   pas prouvées (cf. validation terrain).

> **Prochaine action concrète** : dites-moi *« construis les dev P0 »* et je démarre par l'infra email +
> le reset mot de passe (avec tests, zéro régression), pendant que vous prenez le domaine et l'hébergement.
