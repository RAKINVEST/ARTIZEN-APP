# ARTIZEN — Master Execution Plan → V1.0

**Document de pilotage. Pas d'architecture, pas de recherche.** Référence
opérationnelle unique jusqu'à la V1.0. On développe ARTIZEN en suivant ce
document ; on ne réinvente l'architecture que si une **mesure objective** prouve
qu'une décision existante est fausse.

## Décision de direction (elle commande tout)

> **V1 = Mode 1** (identité *appliquée* : logo + couleurs + coordonnées, sur le
> moteur de document ARTIZEN, cycle de vie du devis + PDF). **Livrable
> maintenant.** La **Capacité 2** (restitution fidèle) est **V2**, dont
> l'existence est décidée par le **référendum de valeur GV (H-003)**, mené **en
> parallèle** et qui **ne bloque jamais** la V1. Les 5 bloquants de la revue
> indépendante sont *tous* des bloquants de la Capacité 2 → aucun ne bloque la V1.

## Légende (utilisée dans toutes les tables)

- **Resp.** : `C` = Claude · `M` = Moi (PO) · `P` = Partagé
- **Auto.** : 🟢 = réalisable sans aucune question · 🔴 = arbitrage obligatoire
- **Déc.** : `—` aucune · `F` fonctionnelle · `P` produit · `J` juridique · `S` stratégique
- **DoD standard** (implicite partout, en plus des critères listés) :
  `[T]` suite de tests verte · `[A]` `flutter analyze` + lint backend propres ·
  `[0R]` zéro régression (suite complète) · `[0TODO]` zéro TODO bloquant ·
  `[D]` doc/CHANGELOG à jour
- **Tests** : `U` unitaire · `I` intégration · `E2E` bout-en-bout · `M` manuel

---

# GATE G0 — Gel & cadrage V1

**1. Objectif.** Figer le périmètre V1 = Mode 1 et sortir la Capacité 2 du chemin critique, pour que tout le reste avance sans ambiguïté.
**2. Livrables.** Décision de périmètre écrite (1 page) ; backlog reconcilié et affecté aux gates ; statut `.artizen` acté (jetable/ré-extractible) ; stratégie de sourcing du corpus GV.

| ID | Tâche | Resp | Auto | Dépend → Débloque | DoD / Tests | Déc |
|---|---|---|---|---|---|---|
| G0-T01 | Acter le périmètre V1 = Mode 1 (1 page) | P | 🔴 | (revue) → tout | Décision signée, périmètre figé | S |
| G0-T02 | Décider la stratégie de sourcing du corpus croisé | M | 🔴 | (revue) → GV | Stratégie écrite (qui/combien/axes) | S |
| G0-T03 | Acter `.artizen` = artefact jetable, non donnée client canonique | P | 🔴 | G0-T01 → G5, GV | Décision écrite ; PDF source conservé comme référence | F |
| G0-T04 | Reconcilier le backlog (KNOWN_LIMITATIONS + issues) → gates + A/B/C/D | C | 🟢 | G0-T01 → G2..G7 | Chaque item classé et affecté ou clos ; `[D]` | — |

**9. Risques.** Tentation de réintroduire la Capacité 2 dans la V1 → re-bloque tout. *Mitigation* : GV strictement parallèle, jamais dans les critères de sortie V1.

---

# GATE G1 — Vérité produit

**1. Objectif.** Aligner toute promesse (marque, marketing, UX) sur ce que Mode 1 livre réellement, sans jamais promettre la restitution fidèle.
**2. Livrables.** Copie/onboarding cadrés Mode 1 ; test-garde lexical automatique ; promesse de marque V1 validée.

| ID | Tâche | Resp | Auto | Dépend → Débloque | DoD / Tests | Déc |
|---|---|---|---|---|---|---|
| G1-T01 | Auditer tous les textes user-facing (Flutter + messages backend) pour mots réservés Mode 2 hors contexte | C | 🟢 | G0-T01 → G1-T02 | Liste exhaustive des occurrences ; `U` grep de garde | — |
| G1-T02 | Corriger les fuites claires de sur-promesse Mode 2 dans l'app | C | 🟢 | G1-T01 → G1-T03 | Zéro occurrence hors whitelist ; `[A][0R]` | — |
| G1-T03 | Implémenter le test-garde lexical (échoue si mot réservé Mode 2 hors whitelist) | C | 🟢 | G1-T02 → G7 | Test présent + vert + en CI ; `U` | — |
| G1-T04 | Valider la promesse de marque V1 (positionnement Mode 1) | M | 🔴 | G1-T02 → G7 | Promesse écrite validée | P |

**9. Risques.** Dissonance perçue « on vend moins de rêve ». *Mitigation* : l'honnêteté de l'écran de reconnaissance est déjà un actif de confiance ; documenter que la V2 étend la promesse plus tard.

---

# GATE G2 — Complétude fonctionnelle Mode 1

**1. Objectif.** Offrir un parcours artisan complet et commercialisable de bout en bout.
**2. Livrables.** Les écrans/flux jugés V1-bloquants comblés ; parcours signup → import (Mode 1) → catalogue → client → devis → PDF → envoi sans trou bloquant.

| ID | Tâche | Resp | Auto | Dépend → Débloque | DoD / Tests | Déc |
|---|---|---|---|---|---|---|
| G2-T01 | Classer les trous KNOWN_LIMITATIONS #1–#7 en V1-bloquant vs V1.x | P | 🔴 | G0-T04 → G2-T02.. | Chaque trou tranché | P |
| G2-T02 | Écran d'édition de l'identité d'entreprise (API `PUT /branding/company`,`/brand` existe) | C | 🟢 | G2-T01 → G2-T09 | Écran + `U`+`I`+widget ; `[A]` | — |
| G2-T03 | Upload de logo depuis l'app (API `POST /branding/logo` existe) | C | 🟢 | G2-T01 → G2-T09 | Upload fonctionnel ; `I` ; `[A]` | — |
| G2-T04 | Mot de passe oublié / réinitialisation | P | 🔴 | G2-T01 + infra email → G2-T09 | Flux complet ; `I` ; dépend du fournisseur email | F |
| G2-T05 | Écran réglages enrichi (si scopé V1) | C | 🟢 | G2-T01 | Écran ; widget ; `[A]` | — |
| G2-T06 | Écran détail client (si scopé V1) | C | 🟢 | G2-T01 | Écran ; widget ; `[A]` | — |
| G2-T07 | Édition/suppression catégories (si scopé V1) | C | 🟢 | G2-T01 | CRUD ; `U`+`I` | — |
| G2-T08 | Politique couleur claire (#17 : conserver vs remplacer par charte) + implémentation | P | 🔴 | G2-T01 → G2-T09 | Politique actée + implémentée + `U` | P |
| G2-T09 | E2E du parcours complet | C | 🟢 | G2-T02..08 → G3 | `E2E` vert du parcours entier | — |

**9. Risques.** Scope creep. *Mitigation* : G2-T01 fige la liste ; hors-liste = V1.x, jamais V1.

---

# GATE G3 — Robustesse & observabilité

**1. Objectif.** Aucun échec silencieux, aucun crash sur un document réel d'artisan.
**2. Livrables.** Motif d'échec d'import persisté + affiché ; gardes extracteur ; anonymiseur fail-safe ; tests d'entrées hostiles.

| ID | Tâche | Resp | Auto | Dépend → Débloque | DoD / Tests | Déc |
|---|---|---|---|---|---|---|
| G3-T01 | Persister + exposer le motif d'échec d'analyse (FAILED muet → motif actionnable) | C | 🟢 | G2-T09 → G5 | Champ motif persisté + affiché ; `U`+`I` | — |
| G3-T02 | Gardes extracteur (0-page, corrompu, chiffré) → message métier, pas d'IndexError | C | 🟢 | → G5 | `U` entrées hostiles verts ; jamais de 500 brut | — |
| G3-T03 | Anonymiseur fail-safe (si `fitz` échoue → ne pas stocker l'original en clair) | C | 🟢 | → G6 (corpus) | `U` ; document non stocké si non anonymisable | — |
| G3-T04 | Compléter les tests de robustesse upload (non-PDF, énorme, chunké) | C | 🟢 | → G4 | `I` verts | — |
| G3-T05 | Corriger le commentaire périmé (#15, `branding_providers.dart`) | C | 🟢 | — | `[A]` ; commentaire exact | — |

**9. Risques.** Un type de PDF réel non prévu. *Mitigation* : catch-all global déjà présent (jamais de stacktrace exposée) ; élargir le jeu d'entrées hostiles au fil de la bêta.

---

# GATE G4 — Sécurité & conformité RGPD

**1. Objectif.** Poser une posture sécurité et RGPD tenable pour un lancement commercial.
**2. Livrables.** Décisions JWT + rate-limit ; base légale/rétention/purge de la PII client ; CGU + politique de confidentialité ; tests d'isolation.

| ID | Tâche | Resp | Auto | Dépend → Débloque | DoD / Tests | Déc |
|---|---|---|---|---|---|---|
| G4-T01 | Décider la posture de stockage JWT (localStorage vs cookie HttpOnly) | M | 🔴 | → G4-T04 | Décision écrite + justif menace | S |
| G4-T02 | Décider la posture rate-limit selon déploiement (mono-worker vs Redis) | P | 🔴 | → G5 | Décision liée au déploiement | F |
| G4-T03 | RGPD : base légale, minimisation, rétention, purge de la PII client (destinataires) | M | 🔴 | → G4-T04 | Registre RGPD écrit | J |
| G4-T04 | Implémenter la purge/rétention décidée | C | 🟢 | G4-T01,T03 → G5 | Purge fonctionnelle ; `U`+`I` | — |
| G4-T05 | CGU + politique de confidentialité | M | 🔴 | → G7 | Documents publiés (probable revue juridique) | J |
| G4-T06 | Vérifier/compléter les tests d'isolation tenant (404 cross-tenant) | C | 🟢 | → G5 | `I` : accès cross-tenant → 404 | — |

**9. Risques.** RGPD sur PII de tiers (clients) sous-estimé. *Mitigation* : traiter la rétention comme bloquant de lancement ; DPA fournisseurs.

---

# GATE G5 — Industrialisation

**1. Objectif.** Rendre ARTIZEN déployable, sauvegardable, monitorable et reproductible.
**2. Livrables.** Rendu déterministe durci ; CI/CD ; backup/restore prouvé ; monitoring ; migrations vérifiées.

| ID | Tâche | Resp | Auto | Dépend → Débloque | DoD / Tests | Déc |
|---|---|---|---|---|---|---|
| G5-T01 | Rendu déterministe durci (stripping horodatage PDF, épinglage versions/police) | C | 🟢 | G3 → G6 | Deux rendus du même input identiques (hors méta) ; `U` | — |
| G5-T02 | CI/CD (build, tests, déploiement) | P | 🔴 | G3,G4 → G6 | Pipeline vert de bout en bout | F |
| G5-T03 | Backup/restore testé | P | 🔴 | G4 → G6 | Restore réel prouvé ; `M` | F |
| G5-T04 | Monitoring + alertes (health, taux d'erreur) | P | 🔴 | → G6 | Alertes live sur incident simulé | F |
| G5-T05 | Vérifier migrations Alembic up/down bout-en-bout | C | 🟢 | → G6 | `I` migration aller/retour verte | — |
| G5-T06 | Vérifier l'alignement des versions (backend/front/tag) | C | 🟢 | → G7 | Versions égales ; `U` | — |

**9. Risques.** Dérive du rendu binaire dans le temps (versions). *Mitigation* : G5-T01 épingle ; test de non-régression de rendu en CI.

---

# GATE G6 — Bêta réelle (+ amorçage corpus GV)

**1. Objectif.** Faire utiliser ARTIZEN par de vrais artisans et amorcer le corpus qui alimentera GV.
**2. Livrables.** Cohorte bêta active ; télémétrie ; corpus réel annoté (entreprise × métier × logiciel × époque) ; triage du feedback.

| ID | Tâche | Resp | Auto | Dépend → Débloque | DoD / Tests | Déc |
|---|---|---|---|---|---|---|
| G6-T01 | Critères d'acceptation bêta + protocole UAT | P | 🔴 | G5 → G6-T05 | Protocole écrit et validé | P |
| G6-T02 | Recruter la cohorte bêta | M | 🔴 | G5 → G6-T04 | Cohorte constituée | S |
| G6-T03 | Instrumenter la télémétrie (conforme RGPD) | C | 🟢 | G4-T03 → G6-T05 | Événements clés remontés ; `I` | — |
| G6-T04 | Collecter + annoter le corpus croisé (amorçage GV) | P | 🔴 | G6-T02 → GV-T02 | Corpus annoté sur les 4 axes | S |
| G6-T05 | Trier le feedback → bloquant vs V1.x | P | 🔴 | G6-T01,T03 → G7 | Backlog trié | P |

**9. Risques.** Corpus bêta biaisé (seuls les artisans ayant déjà un PDF). *Mitigation* : GV source *aussi* hors bêta (G0-T02).

---

# GATE G7 — Release Candidate → V1.0

**1. Objectif.** Certifier, packager et commercialiser ARTIZEN V1.0.
**2. Livrables.** Rapport de certification ; GTM/pricing/CGV ; tag V1.0 + release notes.

| ID | Tâche | Resp | Auto | Dépend → Débloque | DoD / Tests | Déc |
|---|---|---|---|---|---|---|
| G7-T01 | Certification finale (0 bloquant/majeur, suite verte, benchmark stable) | C | 🟢 | G6-T05 → G7-T03 | Rapport ; `[T][0R]` ; `[B]` inchangé | — |
| G7-T02 | GTM / pricing / CGV | M | 🔴 | G4-T05 → G7-T03 | Offre commerciale prête | J |
| G7-T03 | Tag V1.0 + release notes | P | 🔴 | G7-T01,T02 → **V1.0** | Tag posé, notes publiées | S |

**9. Risques.** Anomalie tardive en bêta. *Mitigation* : gel de périmètre à l'entrée de G7 ; correctifs bloquants uniquement.

---

# GATE GV — Référendum de valeur Capacité 2 (parallèle, NON bloquant)

**1. Objectif.** Décider, sur données réelles, si la Capacité 2 profonde (V2) mérite d'être construite — sans jamais bloquer la V1.
**2. Livrables.** Protocole préenregistré ; corpus croisé ; mesures (H-003 + arrondi + format + part natif/scan) ; décision GO/NO-GO.

| ID | Tâche | Resp | Auto | Dépend → Débloque | DoD / Tests | Déc |
|---|---|---|---|---|---|---|
| GV-T01 | Formaliser le protocole préenregistré (E-ADN-3 factoriel, auto-cohérence, prédiction générative) + seuils | C | 🟢 | G0-T02 → GV-T03 | Protocole + seuils écrits *avant* mesure | — |
| GV-T02 | Constituer le corpus croisé (axes + décorrélation auteur) | M | 🔴 | G6-T04 → GV-T03 | Corpus suffisant et annoté | S |
| GV-T03 | Exécuter les mesures | C | 🟢 | GV-T01,T02 → GV-T05 | Résultats vs seuils ; `[B]` | — |
| GV-T04 | Résoudre la contradiction d'arrondi (#3), si trajectoire GO | P | 🔴 | GV-T03 → V2 | Décision documentée | P |
| GV-T05 | **Décision GO / NO-GO Capacité 2** | M | 🔴 | GV-T03 → V2 (ou fermeture) | Décision signée | S |

**9. Risques.** Colinéarité → « indécidable ». *Mitigation* : par défaut **rester Mode 1** ; ne jamais financer V2 sans GO explicite.

---

# Graphe de dépendances (task-level)

```
G0-T01 ─┬─► G0-T04 ─► (G2-T01, G3, G4..)
        ├─► G1-T01 ─► G1-T02 ─► G1-T03 ─► G7
        ├─► G1-T04 ─► G7
        └─► G0-T03 ─► G5, GV
G0-T02 ─► GV-T01 ─► GV-T03
G2-T01 ─► {G2-T02,03,04,05,06,07,08} ─► G2-T09 ─► G3
G3-T01..T04 ─► G5
G4-T01,T03 ─► G4-T04 ─► G5 ;  G4-T02 ─► G5 ;  G4-T05 ─► G7
G5-T01..T06 ─► G6
G6-T02 ─► G6-T04 ─► GV-T02 ;  G6-T01,T03 ─► G6-T05 ─► G7
G7-T01 + G7-T02 ─► G7-T03 ─► ★ V1.0
GV-T02 + GV-T01 ─► GV-T03 ─► GV-T05 ─► (V2, post-V1)   [GV ⟂ chemin V1]
```

**Chemin critique V1** : `G0-T01 → G0-T04 → G2-T01 → G2-T0x → G2-T09 → G3 → G4-T04 → G5 → G6 → G7-T03`.
**Hors chemin critique** : G1 (vérité), GV (référendum). Ni l'un ni l'autre ne retarde la V1.

---

# Matrice d'autonomie — ce que Claude enchaîne seul (pendant que tu dors)

Tâches 🟢, réalisables sans aucune question, dans l'ordre de déblocage :

1. **G0-T04** — reconciliation du backlog.
2. **G1-T01 → G1-T02 → G1-T03** — audit + correction + test-garde lexical.
3. **G2-T02, T03, T05, T06, T07** — écrans dont l'API existe (une fois G2-T01 scopé).
4. **G2-T09** — E2E du parcours.
5. **G3-T01 → T05** — observabilité + robustesse + fix commentaire.
6. **G4-T04, T06** — purge (une fois posture décidée) + tests isolation.
7. **G5-T01, T05, T06** — rendu déterministe, migrations, versions.
8. **GV-T01** — formaliser le protocole préenregistré.
9. **GV-T03** — exécuter les mesures (une fois le corpus fourni).
10. **G7-T01** — rapport de certification.

> Règle d'enchaînement nocturne : Claude prend la prochaine tâche 🟢 dont toutes les dépendances sont satisfaites, la mène jusqu'à sa Definition of Done, commit, puis passe à la suivante. Il ne s'arrête que sur une tâche 🔴.

---

# Matrice de validation — les seules décisions qui te restent (minimales)

| ID | Décision | Type | Bloque |
|---|---|---|---|
| G0-T01 | Périmètre V1 = Mode 1 | S | tout |
| G0-T02 | Sourcing du corpus GV | S | GV |
| G1-T04 | Promesse de marque V1 | P | G7 |
| G2-T01 | Scope des trous UX (V1 vs V1.x) | P | G2 dev |
| G2-T04 | Fournisseur email (mot de passe oublié) | F | G2-T04 |
| G2-T08 | Politique couleur claire | P | G2-T09 |
| G4-T01 | Posture stockage JWT | S | G4-T04 |
| G4-T02 | Posture rate-limit / déploiement | F | G5 |
| G4-T03 | RGPD (base légale, rétention) | J | G4-T04 |
| G4-T05 | CGU / confidentialité | J | G7 |
| G5-T02/03/04 | Accès infra (CI, backup, monitoring) | F | G6 |
| G6-T02 | Recrutement bêta | S | GV corpus |
| G7-T02 | GTM / pricing / CGV | J | V1.0 |
| GV-T04 | Résolution arrondi (si GO) | P | V2 |
| GV-T05 | **GO/NO-GO Capacité 2** | S | V2 |

Tout le reste est autonome. **La seule décision structurelle restante est GV-T05.**

---

# Feuille de route finale — gate après gate

`G0` (gel & cadrage) → `G1` (vérité, //) → `G2` (complétude Mode 1) → `G3`
(robustesse) → `G4` (sécurité/RGPD) → `G5` (industrialisation) → `G6` (bêta +
amorçage corpus) → `G7` (RC → **★ V1.0**).
En parallèle permanent, non bloquant : `GV` (référendum Capacité 2) → décide V2 **après** la V1.

---

# Règle de gel (à partir de maintenant)

Aucune nouvelle architecture, théorie, abstraction ou chantier. Toute proposition
supplémentaire doit démontrer qu'elle modifie réellement le **produit**,
l'**architecture**, la **sécurité**, la **maintenabilité** ou l'**expérience
artisan** — sinon elle est rejetée. On ne rouvre une décision gelée que si une
**mesure objective** prouve qu'elle est fausse.

**Statut : v1.0 — plan de pilotage actif.**
