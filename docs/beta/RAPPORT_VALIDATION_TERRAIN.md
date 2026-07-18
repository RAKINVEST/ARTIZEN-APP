# ARTIZEN — Bêta 1 : Rapport de validation terrain

> **Mission** : vérifier qu'ARTIZEN est réellement prêt à être utilisé quotidiennement par des artisans.
> Critère unique : *« Est-ce que cela rend l'utilisation plus simple pour un artisan qui découvre le
> logiciel ? »* **Aucun développement** — analyse seule. Kit opérationnel : [PLAN_BETA.md](PLAN_BETA.md),
> [INSTRUMENTATION.md](INSTRUMENTATION.md).

---

## 1. État réel du produit

Le **cœur fonctionnel est mature** : devis légalement conforme (Phase 1/1.1), configuration d'entreprise
autonome, recherche instantanée et listes performantes (Phase 0), contrôle « prêt à émettre », signature.
Les gestes quotidiens (trouver, filtrer, créer sans doublon) sont fluides et testés (270 backend + 90
Flutter). Le blocage restant n'est **pas** dans le cœur : c'est **l'accueil du nouvel utilisateur**, la
**boucle d'envoi**, et l'**exploitation** (déploiement, récupération de compte). Autrement dit, ARTIZEN
est un bon logiciel ; il lui manque quelques marches pour devenir un produit qu'un débutant adopte seul.

---

## 2. Cartographie du parcours utilisateur

| Étape | Écrans | Taps (court) | Saisie | Frictions majeures |
|---|---|---|---|---|
| 1. Connexion | Login | ~3 | 2 champs | Pas de « mot de passe oublié », pas de voir-le-mdp |
| 1b. Inscription | Register | ~2 | 2–4 champs | **Pas de confirmation de mot de passe** ; entreprise placeholder créée en douce |
| 2. Premier lancement | Dashboard vide | 0 | — | **Aucun onboarding** ; 3 stats à 0 ; aucun « commencez ici » |
| 3. Mon entreprise | Paramètres → formulaire | 3 | **~20 champs** | Enterré dans Paramètres ; **rien n'indique les champs requis** ; le contrôle de conformité n'apparaît pas ici |
| 4. Catalogue | Liste (2 sous-onglets) → dialogue/form | ~7 | ~6 champs | **Catégorie obligatoire avant article**, mur bloquant sans lien direct |
| 5. Client | Liste → formulaire | 3 | 1+ champ | Faible ; « Nom » = nom de famille (Société séparé) |
| 6. Devis | Form + 2 bottom-sheets (avec recherche) | ~8 | quantités | **Aucun total affiché** avant validation ; Copilote IA caché |
| 7. Modifier | Détail (pas d'édition) | **~10** | tout | **Pas d'écran d'édition** : supprimer+recréer ou dupliquer (copie non éditable) |
| 8. PDF + gate | Détail → aperçu / téléchargement | 1 (+N si incomplet) | — | **Aperçu sans contrôle** vs **téléchargement bloqué** si non conforme |
| 9. Envoi | Détail → « Marquer envoyé » | 2 | — | **Statut « envoyé » ≠ envoi réel** ; **aucun email intégré** (partage OS) |
| 10. Retrouver | Liste devis → chip statut | 3 | — | **Pas de recherche texte** (ni par n°, ni par client) ; « archive » = statut terminal |

*Navigation : 5 onglets (Tableau de bord / Clients / Catalogue / Devis / Paramètres) ; les formulaires
s'ouvrent en plein écran et masquent la barre d'onglets pendant la saisie. Rien ne force le passage par
« Mon entreprise » après l'inscription.*

---

## 3. Liste exhaustive des points de friction (classés)

### 🔴 Critiques — un débutant peut se bloquer ou abandonner
- **C-1. Aucun onboarding.** Après inscription : dashboard vide, aucun guidage. L'artisan ne sait pas
  par où commencer ni qu'il doit d'abord configurer son entreprise. *Impact : paralysie du démarrage,
  premier devis jamais atteint.*
- **C-2. « Mon entreprise » enterrée + champs requis invisibles.** La config (SIRET, assurance, TVA…)
  est dans Paramètres, sans CTA, et le formulaire ne dit pas ce qui est obligatoire. L'artisan croit
  avoir fini, puis se fait bloquer à l'émission. *Impact : découverte tardive et frustrante de la
  conformité.*
- **C-3. Modifier un devis = le supprimer et tout recréer** (~10 taps, ré-sélection client + toutes les
  lignes). Aucun crayon d'édition ; « Dupliquer » ne permet pas non plus d'éditer les lignes. *Choix
  d'architecture assumé (invariant V2), mais friction quotidienne majeure pour un débutant.*
- **C-4. « Marquer envoyé » ≠ envoi réel + pas d'email intégré.** Deux actions décorrélées : le statut
  et le partage OS du PDF. L'artisan peut marquer « envoyé » sans que le client reçoive rien, ou
  l'inverse. *Impact : suivi faux, client sans devis.*
- **C-5. Pas de récupération de mot de passe.** Un oubli = compte verrouillé (aucun « mot de passe
  oublié »). *Impact : perte de compte dès la première semaine de bêta.*

### 🟠 Majeures — dégradent fortement l'expérience
- **M-1. Catalogue : dépendance catégorie→article** non signalée en amont ; mur bloquant sur le
  formulaire article, sans bouton pour créer la catégorie.
- **M-2. Pas de recherche texte dans la liste des devis** (présente pour Clients et Catalogue).
  Retrouver « DEV-2026-0042 » ou les devis d'un client est impossible sans scroller.
- **M-3. Aucun total affiché pendant le brouillon de devis** — l'artisan valide « à l'aveugle ».
- **M-4. Aperçu PDF sans contrôle de conformité** alors que le téléchargement est bloqué : incohérence
  qui peut faire croire un devis « bon » après aperçu.
- **M-5. Inscription sans confirmation de mot de passe** — typo indétectable, aggravée par C-5.

### 🟡 Mineures — finition
- Copilote IA masqué derrière une icône (tooltip seul) et renvoie au formulaire **sans client** pré-rempli.
- Bouton « Réinitialiser » (Mon entreprise) au libellé anxiogène (n'annule que les modifs non enregistrées).
- Barre d'onglets masquée pendant les formulaires longs.
- Pas de bascule afficher/masquer le mot de passe.
- Import de modèle / aperçu du rendu enterrés dans Paramètres.

---

## 4. Simulation d'une journée — 4 profils

**Scénario commun** : 3 clients, 5 devis, modifier un devis, retrouver un ancien devis, ajouter un
article, corriger une erreur, exporter un PDF.

| Profil | Où il hésite / trébuche | Verdict de la journée |
|---|---|---|
| **Artisan peu à l'aise (informatique)** | Bloqué dès le dashboard vide (C-1) ; ne trouve pas où mettre son SIRET (C-2) ; panique au mur « créez une catégorie » (M-1) ; ne comprend pas pourquoi il ne peut pas corriger une ligne (C-3) ; croit avoir envoyé en cliquant « envoyé » (C-4). | **Abandonne sans aide.** A besoin d'un accompagnement (guide + appel). |
| **Artisan expérimenté (à l'aise)** | Devine la config dans Paramètres ; grogne sur l'édition impossible (C-3) et l'absence de recherche devis (M-2) ; contourne l'envoi via le partage OS. | **S'en sort**, mais frustré par l'édition et l'envoi. |
| **Micro-entrepreneur (franchise TVA)** | Apprécie le régime franchise + mention 293 B ; même blocages onboarding (C-1/C-2) ; a surtout besoin d'**envoyer** vite (C-4). | **Convaincu par la conformité**, freiné par l'envoi et l'accueil. |
| **PME (plusieurs devis/jour, volume)** | Souffre le plus de **M-2** (retrouver un devis) et **C-3** (corriger) ; voudrait multi-utilisateur (hors périmètre). | **Volume = douleur** sur recherche et correction. |

**Constante des 4 profils** : les 5 mêmes moments de blocage — *démarrage à froid, config entreprise,
correction d'un devis, envoi réel, et (pour le volume) retrouver un devis.*

---

## 5. Tableau des priorités (recommandations — à ne PAS développer maintenant)

> Justifiées par le critère « rend l'usage plus simple pour un débutant ». Aucune n'est une nouvelle
> fonctionnalité **majeure** sauf indication contraire (P3).

### P0 — Bloquant commercial (à traiter **avant** d'ouvrir la bêta)
| # | Reco | Justification |
|---|---|---|
| P0-1 | **Instance hébergée** (HTTPS + `API_BASE_URL` au build) | Impossible de faire une bêta sur `localhost` ; aujourd'hui aucun déploiement. |
| P0-2 | **Chemin de récupération de compte** (au minimum procédure manuelle documentée ; idéalement « mot de passe oublié ») | Un oubli verrouille un testeur (C-5). |
| P0-3 | **Base de données propre** (purger la pollution de tests) | Doublons « Chauffe-eau Atlantic » → démo/bêta amateur. |

### P1 — Très important (dégrade fortement l'adoption)
| # | Reco | Justification |
|---|---|---|
| P1-1 | **Accueil guidé** : sur le dashboard vide, une check-list « 1. Mon entreprise → 2. Catalogue → 3. Client → 4. Devis » cliquable | Lève la paralysie du démarrage (C-1), petite UX, pas une fonction majeure. |
| P1-2 | **Champs requis visibles dans « Mon entreprise »** (marquer les obligatoires + rappel de conformité *sur cet écran*) | Fin de la découverte tardive au gate (C-2). |
| P1-3 | **Recherche texte dans la liste des devis** (n° + client) | Retrouver un devis au volume (M-2) ; le composant existe déjà ailleurs. |
| P1-4 | **Clarifier l'envoi** : lier « Marquer envoyé » au partage (ou renommer/expliquer), voire envoi email intégré (P3 si trop lourd) | Fin de la dissociation statut/envoi (C-4). |
| P1-5 | **Rendre « corriger un devis » explicite** : renommer/expliquer « Dupliquer » en « Corriger (créer une version) » + message clair | Atténue C-3 sans changer l'invariant. |
| P1-6 | **Confirmation du mot de passe à l'inscription** | Évite la typo irrattrapable (M-5). |

### P2 — Confort
| # | Reco | Justification |
|---|---|---|
| P2-1 | Aperçu PDF passant aussi par le contrôle de conformité (ou badge visible dans l'aperçu) | Cohérence (M-4). |
| P2-2 | **Total courant affiché** pendant le brouillon de devis | Rassure l'artisan (M-3). |
| P2-3 | Lien direct « créer une catégorie » depuis le mur du formulaire article | Fluidifie le 1er catalogue (M-1). |
| P2-4 | Bascule afficher/masquer le mot de passe ; renommer « Réinitialiser » en « Annuler les modifications » | Finitions. |

### P3 — Évolutions futures (fonctionnalités majeures — hors bêta)
Facturation (devis→facture), **envoi email intégré + suivi**, édition de lignes de devis, import CSV
clients/catalogue, multi-utilisateur, mode hors-ligne, instrumentation automatisée (palier 1).

---

## 6. Réponses aux trois questions

### 1. ARTIZEN est-il prêt pour une **bêta privée** ?
**Oui — pour une bêta privée, petite et accompagnée, une fois les 3 P0 traités.** Le cœur (conformité,
productivité, fiabilité) est mature et testé. Une bêta *ouverte/publique* serait prématurée (accueil non
guidé, envoi ambigu, pas de self-service de compte). En privé, avec le **guide de prise en main**, une
**procédure manuelle de reset**, une **instance hébergée** et un **suivi Customer Success**, ARTIZEN
peut être mis entre les mains de 5–10 artisans dès maintenant pour récolter des retours réels.

### 2. Les **cinq plus gros risques** avant commercialisation
1. **Pas de facturation** (devis→facture) : la raison d'achat d'un logiciel de gestion — sans elle,
   l'artisan garde un second outil.
2. **Adoption / onboarding** : démarrage à froid non guidé + config entreprise enterrée → taux
   d'activation faible sans accompagnement.
3. **Boucle d'envoi incomplète** : statut « envoyé » ≠ envoi réel, aucun email intégré → suivi faux et
   friction quotidienne.
4. **Édition de devis inexistante** : corriger = tout recréer ; douleur quotidienne, surtout au volume.
5. **Exploitation & sécurité** : pas de déploiement durci (HTTPS, Redis, quotas IA, sauvegardes) ni de
   récupération de compte → risques de coûts, de blocages et de pertes de données en production.

### 3. Que faudrait-il encore améliorer avant une **Release Candidate** ?
- **Traiter P0 + P1** (accueil guidé, champs requis visibles, recherche devis, envoi clarifié, reset
  mot de passe) — ce sont de petites marches, pas des fonctions majeures.
- **Facturation** si le positionnement est « gestion » (sinon assumer « devis seul » explicitement).
- **Durcir l'exploitation** : déploiement HTTPS, `RATE_LIMIT_BACKEND=redis` + `X-Forwarded-For`, quotas
  sur les endpoints IA, sauvegardes, purge des données de test.
- **Validation e2e mobile réelle** + quelques tests Flutter contre un vrai backend (la validation bout-
  en-bout reste manuelle aujourd'hui).
- **Boucler la bêta** : instrumentation palier 0 en place, retours classés (Bug/Compréhension/Ergonomie/
  Performance/Fonction manquante/Suggestion) et P0/P1 issus du terrain corrigés.

---

## 7. Conclusion

ARTIZEN a franchi le cap « logiciel fiable ». Pour devenir un **produit** qu'un artisan adopte seul, il
reste à **accueillir** (guidage), **envoyer** (clarifier/intégrer), **récupérer** (compte) et
**exploiter** (déployer). Ce sont des marches courtes et connues — aucune ne remet en cause le cœur.
**Recommandation : lancer une bêta privée accompagnée après les 3 P0, l'utiliser pour valider les P1 sur
le terrain, et viser la RC une fois P0+P1 traités et l'exploitation durcie.**
