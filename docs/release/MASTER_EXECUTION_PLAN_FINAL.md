# ARTIZEN — Master Execution Plan Final

**Document de référence unique jusqu'au lancement commercial.** Le développement est
terminé, l'architecture gelée (ADR-022/023, Décision 9), les tests verts (600 backend +
192 Flutter), les audits (complétude, sécurité, hygiène, exploitation) clos. Ce plan
n'analyse plus rien : il **ordonne parfaitement ce qui existe déjà** jusqu'au premier
client payant, puis au lancement public.

Responsables : **PO** · **Juriste** · **Infra** (hébergeur/exploitation) · **Code** (swap
mécanique de contenu déjà écrit) · **Marketing** · **Support**.

---

## Phases

### Phase 0 — Préparation (décisions PO + dépôt propre)
- **Objectif** : figer les dernières entrées PO et geler la ligne de code.
- **Livrables** : `SUPPORT_EMAIL` réel, prestataire de paiement, fournisseur object-storage EU ; `main` taguée. *(Domaine **déjà acquis** : `artizenapp.com` — site public en ligne sur `www.artizenapp.com`.)*
- **Prérequis** : aucun. **Responsable** : PO. **Durée** : 1 j.
- **Dépendances** : —. **Risques** : indécision PO (bloque tout l'aval).
- **GO** : les 3 décisions restantes posées. **NO GO** : une décision manquante → Phase 2 ne peut démarrer.

### Phase 1 — Activation juridique *(reportée après la bêta — décision PO 2026-07-31)*
- **Objectif** : contenu légal opposable + politique de rétention.
- **Livrables** : Mentions légales, CGU, Confidentialité validées ; durée de rétention fixée.
- **Prérequis** : gabarits fournis (`docs/legal/GABARITS-LEGAUX.md`) **+ V1 stabilisée** (déploiement + recette + bêta réalisés). **Responsable** : Juriste. **Durée** : 5–10 j ouvrés (externe). **Séquencement (décision PO 2026-07-31)** : le juriste n'intervient que sur une **V1 éprouvée**, donc **sérielle après la Phase 5** — la bêta privée (testeurs informés, bandeau « provisoire ») **n'est pas bloquée** par le légal ; le **premier client payant (T62)** le reste.
- **Dépendances** : T10. **Risques** : délai juriste = pôle long du calendrier.
- **GO** : contenu signé + durée posée. **NO GO** : contenu non validé → interdiction d'**ouverture commerciale** (le déploiement technique, lui, n'est pas bloqué).

### Phase 2 — Activation infrastructure *(parallèle à Phase 1)*
- **Objectif** : tous les comptes/ressources managés prêts.
- **Livrables** : compte Scalingo, bucket S3 EU (versioning), Brevo (SPF/DKIM), DNS, UptimeRobot.
- **Prérequis** : Phase 0. **Responsable** : Infra/PO. **Durée** : 1–2 j + propagation DNS/DKIM (jusqu'à 24-48 h).
- **Dépendances** : T01. **Risques** : propagation DNS, SPF/DKIM non validés (e-mails en spam).
- **GO** : comptes actifs, DNS résolu. **NO GO** : credentials indisponibles.

### Phase 3 — Premier déploiement
- **Objectif** : API + frontend en ligne sous HTTPS.
- **Livrables** : backend Scalingo (Postgres/Redis), migrations appliquées, frontend statique CDN, CORS bouclé.
- **Prérequis** : Phases 0+2. **Responsable** : Infra. **Durée** : 2–3 j.
- **Dépendances** : Phase 2. **Risques** : monorepo mal ciblé, `$PORT`, mapping DB.
- **GO** : `/api/health` = ok en HTTPS + login réel depuis `app.`. **NO GO** : health KO / CORS KO.

### Phase 4 — Vérifications production *(les ⚠ + supervision)*
- **Objectif** : prouver les intégrations réelles + armer la surveillance.
- **Livrables** : S3 réel OK, SMTP réel reçu, TLS/HSTS confirmés, **1 restauration testée**, supervision (health + livraison e-mail + 5xx + quota).
- **Prérequis** : Phase 3. **Responsable** : Infra. **Durée** : 1–2 j.
- **Dépendances** : Phase 3. **Risques** : e-mail silencieux non surveillé (G1), TLS base (contingence).
- **GO** : parcours critique rejoué en prod + supervision verte. **NO GO** : un ⚠ non levé.

### Phase 5 — Bêta privée
- **Objectif** : valider l'usage réel avec 1–3 artisans.
- **Livrables** : onboarding (kit `docs/beta/`), observation, corrections **de config** (pas de code).
- **Prérequis** : Phase 4 GO + process support/paiement prêts. **Responsable** : PO. **Durée** : 3–7 j.
- **Dépendances** : T45, T50. **Risques** : friction d'usage. **GO** : parcours de bout en bout sans blocage. **NO GO** : incident bloquant récurrent.

### Phase 6 — Premier client payant
- **Objectif** : encaisser et servir le premier client.
- **Livrables** : process de paiement activé (hors logiciel), bandeau « provisoire » retiré, compte ouvert.
- **Prérequis** : Phases 1+4+5 GO. **Responsable** : PO. **Durée** : 1 j.
- **Dépendances** : T60, T61. **Risques** : process de facturation non prêt.
- **GO** : légal validé + paiement opérationnel + prod stable. **NO GO** : légal DRAFT ou paiement absent.

### Phase 7 — Stabilisation (30 j)
- **Objectif** : exploitation quotidienne maîtrisée.
- **Livrables** : surveillance continue (e-mail/5xx/quota/coût), 1 test de restauration mensuel.
- **Prérequis** : Phase 6. **Responsable** : Infra/PO. **Durée** : 30 j.
- **GO** : 30 j sans incident critique. **NO GO** : incident récurrent non maîtrisé.

### Phase 8 — Lancement public
- **Objectif** : ouverture au marché.
- **Livrables** : go-to-market (kit `docs/KIT-LANCEMENT.md`, `GO-TO-MARKET-V1.md`), ouverture publique.
- **Prérequis** : Phase 7 GO. **Responsable** : Marketing/PO. **Durée** : selon plan commercial.
- **GO** : stabilité prouvée. **NO GO** : instabilité en exploitation.

---

## Tâches

| N° | Description | Resp. | Temps | Dépend | Parallèle ? | Bloque la suite ? |
|---|---|---|---|---|---|---|
| **T01** | Décisions PO : `SUPPORT_EMAIL`, prestataire paiement, object-storage EU *(domaine **acquis** : `artizenapp.com` ✅)* | PO | 1 j | — | oui | **Oui** (débloque Phase 2) |
| **T02** | Tag `main` (état gelé, arbre propre) | Code | 15 min | — | oui | non |
| **T10** | Briefer le juriste (gabarits + contexte RGPD/hébergement) | PO | 0,5 j | — | oui | Oui (aval juridique) |
| **T11** | Valider Mentions/CGU/Confidentialité (remplir `{…}`) | Juriste | 5–10 j | T10 | oui | Oui (commercialisation) |
| **T12** | Fixer la durée de rétention RGPD | Juriste | inclus T11 | T10 | oui | non |
| **T13** | Swap du contenu légal validé + poser `RETENTION_INACTIVE_ACCOUNT_DAYS` | Code | 1 h | T11,T12 | non | Oui (retrait bandeau) |
| **T20** | Ouvrir compte Scalingo (osc-fr1) | Infra | 0,5 j | T01 | oui | Oui |
| **T21** | Bucket object-storage EU + clés + versioning | Infra | 0,5 j | T01 | oui | Oui |
| **T22** | Ouvrir Brevo + vérifier SPF/DKIM | Infra/PO | 0,5–2 j | T01 | oui | Oui (e-mails) |
| **T23** | DNS — **domaine `artizenapp.com` acquis** ✅ ; reste la **configuration des enregistrements** `api.`/`app.` (vers les cibles Scalingo/CDN) | Infra | 0,25 j +propag. | T20,T34 | oui | Oui (TLS/CORS) |
| **T24** | Compte supervision (UptimeRobot) | Infra | 0,5 j | — | oui | non |
| **T30** | App Scalingo + addons Postgres + Redis | Infra | 0,5 j | T20 | non | Oui |
| **T31** | Poser les variables d'env (`.env.production.example`) | Infra | 0,5 j | T21,T22,T30 | non | Oui |
| **T32** | Déployer le backend (migrations auto au boot) | Infra | 0,5 j | T31 | non | Oui |
| **T33** | Domaine `api.` + TLS auto + confirmer HSTS | Infra | 0,5 j | T23,T32 | non | Oui |
| **T34** | Build + déployer le frontend statique (CDN) + domaine `app.` | Infra/Code | 0,5 j | T21,T23,T33 | non | Oui |
| **T35** | Boucler CORS + test login depuis le domaine réel | Infra | 0,25 j | T34 | non | Oui |
| **T40** | Vérifier persistance S3 réelle (logo → bucket) | Infra | 0,25 j | T35 | oui | Oui (parcours) |
| **T41** | Vérifier livraison SMTP réelle (reset reçu) | Infra | 0,25 j | T35 | oui | Oui (parcours) |
| **T42** | Supervision : health + alerte livraison e-mail + 5xx + quota Brevo (G1/G2/G3) | Infra | 0,5 j | T32 | oui | non (mais condition GO) |
| **T43** | Test de restauration réel (base managée + storage) | Infra | 0,5 j | T30 | oui | non (condition GO) |
| **T44** | Contingence TLS base (`connect_args` si requis) | Code/Infra | 0–0,5 j | T32 | oui | non |
| **T45** | Rejeu du parcours critique en prod (compte→…→PDF→suppression) | PO/Infra | 0,5 j | T40,T41 | non | Oui (bêta) |
| **T50** | Process support (canal + fallback reset manuel) + process paiement/remboursement | PO | 1 j | — | oui | Oui (payant) |
| **T51** | Onboarder 1–3 artisans bêta | PO | 3–7 j | T45 | non | Oui (payant) |
| **T52** | Observer + corriger la **config** selon retours | PO/Infra | continu | T51 | — | non |
| **T60** | Activer le paiement (hors logiciel : Stripe/facture) | PO | 0,5 j | T50 | oui | Oui |
| **T61** | Retirer le bandeau « provisoire » (T13 déployé) | Code/Infra | 0,25 j | T13 | non | Oui |
| **T62** | **Ouvrir au premier client payant** | PO | — | T51,T60,T61,GO P4 | non | — |
| **T70** | Exploitation/surveillance 30 j + 1 restauration mensuelle | Infra/PO | 30 j | T62 | — | Oui (public) |
| **T80** | Go-to-market (kits existants) | Marketing/PO | selon plan | T70 | oui | non |
| **T81** | Ouverture publique | PO | — | T80 | non | — |

---

## Diagramme des dépendances (hiérarchie logique)

```
T01 (PO — décisions)
├── T20 (Scalingo)
│   └── T30 (app + PG/Redis)
│       ├── T31 (env) ── requiert T21, T22
│       │   └── T32 (deploy backend)
│       │       ├── T33 (api. + TLS) ── requiert T23
│       │       │   └── T34 (deploy frontend) ── requiert T21, T23
│       │       │       └── T35 (CORS + login réel)
│       │       │           ├── T40 (S3 réel) ─┐
│       │       │           └── T41 (SMTP réel)┤
│       │       │                              └── T45 (parcours prod)
│       │       ├── T42 (supervision e-mail/5xx/quota)
│       │       └── T44 (contingence TLS base)
│       └── T43 (test restauration)
├── T21 (object storage EU)
├── T22 (Brevo + SPF/DKIM)
├── T23 (DNS api./app.)
└── T24 (UptimeRobot)

T10 (PO — brief juriste)            ← branche PARALLÈLE, indépendante de l'infra
└── T11 + T12 (Juriste — légal + rétention)
    └── T13 (swap contenu — Code)
        └── T61 (retrait bandeau)

T50 (PO — process paiement + support)   ← branche PARALLÈLE
└── T60 (activer paiement)

        [ T45 ]        [ T61 ]        [ T60 ]        [ GO Phase 4 ]
            └──────────────┴──────────────┴───────────────┘
                                   │
                               T51 (bêta)
                                   │
                          ★ T62 — PREMIER CLIENT PAYANT ★
                                   │
                               T70 (stabilisation 30 j)
                                   │
                               T80 → T81 (public)
```

---

## Chemin critique (le vrai — vers le premier client payant, pas le dev)

> **Amendement (décision PO 2026-07-31)** : la **validation juridique est reportée après la bêta** (Phase 1 séquencée post-Phase 5, sur V1 stabilisée). Le chemin critique n'a donc **plus deux pôles parallèles** mais une **séquence** : décisions PO → déploiement → recette → **bêta privée** → **légal** → paiement → **T62**. La bêta est atteignable **sans** le juriste ; le premier client **payant** ne l'est pas.

Structure initiale (avant amendement) — deux pôles longs convergeant sur **T62**, menés **en parallèle** :

- **Pôle juridique** (externe) : `T10 → T11/T12 → T13 → T61` — **5 à 10 jours ouvrés**, dicté par le juriste. **Bloque la commercialisation** (bandeau provisoire).
- **Pôle technique + bêta** : `T01 → T20 → T30 → T31 → T32 → T33 → T34 → T35 → T45 → T51 → T62` — **≈ 5 à 12 jours** (déploiement 2-3 j + bêta 3-7 j).

**Sur le chemin critique** : T01, T20, T30-T35, T45, T51, T62 (technique) **et** T10, T11, T13, T61 (juridique).
**Parallélisables** : toute la Phase 1 (juridique) avec la Phase 2-4 (infra) ; T21/T22/T23/T24 entre elles ; T42/T43/T44 pendant la vérif ; T50 dès J0.
**Délégables (hors Claude)** : T01/T10/T23/T50/T60 (PO), T11/T12 (Juriste), T20-T24/T30-T44 (Infra/Hébergeur), T80 (Marketing). **Claude ne peut exécuter aucune tâche du chemin critique** (voir estimations).

---

## Estimations (deux lectures séparées)

### 1. Temps calendaire minimum (plusieurs personnes en parallèle)
**≈ 7 à 12 jours ouvrés.** Le pôle juridique (juriste, 5-10 j) tourne **en parallèle** du pôle technique (déploiement 2-3 j + vérifications 1-2 j). Le facteur limitant est **le plus lent des deux** : le juriste, ou — si une bêta d'observation est exigée avant le premier payant — la bêta (3-7 j). Ajouter la propagation DNS/DKIM (jusqu'à 24-48 h). **Réaliste : ~2 semaines.** Le déploiement technique pur, isolé, tient en **2-3 jours**.

### 2. Temps réel si Claude travaille seul, 24/7, en autonomie
**≈ 2 à 4 heures, puis mur externe total.** Claude peut encore, sans humain, produire de la **documentation d'exploitation hors chemin critique** (consolider un runbook incident, écrire la procédure de fallback support). Mais Claude **ne peut** : ni **signer/valider** le juridique, ni **ouvrir un compte** (Scalingo/Brevo/S3/DNS), ni **fournir un credential**, ni **déployer**, ni **encaisser un paiement**. **Chaque tâche du chemin critique est détenue par un humain.** Conséquence directe : mettre Claude 24/7 sur le projet **ne raccourcit pas le délai d'un seul jour** — le plafond d'autonomie utile est atteint en quelques heures, ensuite l'avancement est **strictement égal à zéro** sans intervention humaine.

> **Le goulot n'est pas la puissance de travail. C'est l'accès humain aux comptes et la signature du juriste.**

---

## Dernière question

> « Si toutes les tâches ci-dessus sont exécutées dans l'ordre, existe-t-il encore une raison
> objective empêchant ARTIZEN d'être commercialisé ? »

**Non.**

**ARTIZEN est prêt pour sa commercialisation.**
