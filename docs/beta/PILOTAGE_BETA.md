# ARTIZEN — Pilotage de la bêta (tri, suivi, Go/No-Go, post-bêta)

> Le tableau de bord de décision de la bêta privée. Transforme les retours en décisions produit.
> Réunit : méthode de tri, tableau de suivi, critères Go/No-Go, plan d'action post-bêta, et le squelette
> du rapport final.

---

## 1. Méthode de tri des retours (Mission 5)

Chaque retour (email, questionnaire, séance, bug) suit **2 étiquettes** :

**A. Nature** — *ce que c'est* :
`Bug` · `Compréhension` · `Ergonomie` · `Performance` · `Fonction manquante` · `Suggestion`

**B. Priorité** — *l'urgence pour la vente/l'usage* :
| Niveau | Sens | Règle de décision |
|---|---|---|
| **P0 — Bloquant** | Empêche d'accomplir une tâche clé, fait perdre des données, ou tue la confiance | **Corriger avant la RC**, sans discussion |
| **P1 — Important** | Ralentit fortement / fait hésiter beaucoup d'artisans / frein d'adoption net | Corriger avant la V1 commerciale |
| **P2 — Confort** | Améliore l'expérience, plusieurs demandes | Backlog, planifié |
| **P3 — Suggestion** | Idée / évolution future, faible fréquence | Noté, non planifié |

**Règle de fréquence** : un retour cité par **≥ 3 artisans sur ~7** monte d'un cran de priorité
(un « confort » demandé par tout le monde devient « important »).

---

## 2. Modèle de tableau de suivi (Mission 5)

*(Une ligne par retour. À tenir dans un tableur partagé.)*

| ID | Date | Artisan | Source | Retour (résumé) | Nature | Priorité | Fréquence (nb artisans) | Statut | Décision / action | Informé ? |
|---|---|---|---|---|---|---|---|---|---|---|
| B-001 | | | séance / J+7 / email | | Bug | P0 | 3 | Ouvert / En cours / Corrigé / Refusé | | ✅/⬜ |
| B-002 | | | | | Ergonomie | P1 | 5 | | | |
| … | | | | | | | | | | |

**Colonnes clés** : *Fréquence* (pour la règle de montée), *Statut*, *Décision*, *Informé ?* (Customer
Success : on **répond** au testeur — un retour ignoré = un testeur perdu).

**Synthèse hebdo** (à tenir à jour) :
| Semaine | Retours reçus | P0 ouverts | P1 ouverts | Bugs corrigés | NPS moyen | Facilité moy. |
|---|---|---|---|---|---|---|
| S1 | | | | | | |
| S2 | | | | | | |

---

## 3. Critères Go / No-Go (Mission 6)

La bêta est **réussie → passage en Release Candidate** si **tous les seuils « minimum »** sont atteints.
(Cible = l'objectif, minimum = le plancher acceptable.)

| Critère | Minimum (Go) | Cible | Source |
|---|---|---|---|
| **Activation** — % d'artisans ayant fini un 1er devis conforme | **≥ 70 %** | ≥ 85 % | J+1 / séances |
| **Autonomie** — % l'ayant fait **sans aide** | ≥ 50 % | ≥ 70 % | séances |
| **Délai moyen du 1er devis** | **≤ 15 min** | ≤ 10 min | séances |
| **Bugs bloquants (P0) ouverts** en fin de bêta | **0** | 0 | tableau de suivi |
| **Retours P0 distincts** apparus | **≤ 3** (et tous corrigeables) | ≤ 1 | tableau de suivi |
| **Facilité d'utilisation** (moyenne finale /5) | **≥ 3,8** | ≥ 4,3 | questionnaire final |
| **Confiance** (devis fiables/aux normes, /5) | **≥ 4,0** | ≥ 4,5 | questionnaire final |
| **NPS** | **≥ 20** | ≥ 40 | questionnaire final |
| **Rétention** — % actifs en semaine 2 | **≥ 50 %** | ≥ 70 % | usage |
| **Intention** — % « je pourrais l'adopter » (oui/en partie) | **≥ 60 %** | ≥ 80 % | questionnaire final |
| **Volonté de payer** — % « oui / peut-être » | **≥ 40 %** | ≥ 60 % | questionnaire final |

**Décision** :
- **GO (RC)** : tous les minimums atteints, 0 P0 ouvert.
- **GO conditionnel** : 1 minimum manqué mais explicable/corrigeable rapidement → corriger puis
  re-mesurer sur un mini-lot.
- **NO-GO** : ≥ 2 minimums manqués, ou activation < 70 %, ou un P0 non résoluble → itérer avant de
  reparler de RC.

---

## 4. Plan d'action post-bêta — 3 scénarios (Mission 7)

### 🟢 Scénario A — La bêta est excellente (tous les seuils « cible » ou proches)
- **Décisions** : figer le périmètre RC ; corriger les rares P1 ; **lancer la préparation commerciale**
  (pricing/Stripe, légal, hébergement de prod, landing) ; recruter les **premiers témoignages** parmi
  les testeurs satisfaits.
- **Priorités** : RC → V1.0 selon le [GTM](../GO-TO-MARKET-V1.md) ; planifier la **facture (V1.1)**.
- **Impact feuille de route** : on accélère vers la commercialisation ; la voix (V3) reste la vision.

### 🟠 Scénario B — Quelques problèmes (minimums atteints, plusieurs P1)
- **Décisions** : **corriger les P1 les plus fréquents** avant la RC (typiquement : édition/correction de
  devis, recherche des devis, clarté envoi, guidage entreprise) ; **2ᵉ vague de test** sur un lot réduit
  pour valider les correctifs.
- **Priorités** : traiter le top 3–5 des frictions par fréquence ; ne rien ajouter de neuf.
- **Impact feuille de route** : RC décalée de quelques semaines ; périmètre inchangé.

### 🔴 Scénario C — La bêta est un échec (activation < 70 %, ou P0 non résoluble, ou NPS négatif)
- **Décisions** : **ne pas foncer vers la RC.** Comprendre la cause racine (mauvais segment ? valeur
  insuffisante ? blocage produit majeur ?). Faire des **entretiens qualitatifs** approfondis.
- **Priorités** : soit **repositionner** (segment/promesse), soit **retravailler le cœur** du parcours
  identifié comme cassant, puis **re-tester**.
- **Impact feuille de route** : pas de date de commercialisation tant que le problème racine n'est pas
  levé ; possible remise en cause du positionnement.

---

## 5. Squelette du rapport final de bêta (à remplir en fin de bêta)

1. **Résumé exécutif** : la bêta en 5 lignes + **verdict Go / No-Go**.
2. **Participants** : nb d'artisans, profils (micro/solo…), assiduité.
3. **Résultats vs critères Go/No-Go** : le tableau §3 rempli.
4. **Parcours** : activation, délai 1er devis, taux d'autonomie, points de friction confirmés.
5. **Top retours** : P0/P1 par fréquence (extrait du tableau de suivi).
6. **Voix des artisans** : verbatims marquants (anonymisés / avec accord).
7. **Ce qui marche** (à préserver) vs **ce qui casse** (à corriger).
8. **Décision** : Go RC / Go conditionnel / No-Go — et **pourquoi**.
9. **Plan d'action** : scénario retenu (A/B/C) + priorités datées.
10. **Prochaine étape** : ce qui déclenche la RC.

---

## 6. Rappel — la réussite se mesure aux **retours**, pas au code

Objectif de la mission : **des décisions produit fondées sur de vrais artisans**. Un bon résultat de
bêta = on sait précisément **quoi corriger, pour qui, et si on peut vendre** — même si (surtout si) on
n'a écrit aucune ligne de code pendant la bêta.
