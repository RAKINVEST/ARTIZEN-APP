# 06 — Triage de périmètre V2 (stabilisation)

**Écrit le 2026-07-17**, à la bascule vers la stabilisation de la Release
Candidate V2.

La consigne : chaque changement restant est évalué sur **valeur
utilisateur**, **risque de régression**, **impact sur la stabilité de la
RC** — puis classé *indispensable V2* / *reportable* / *V3*. L'objectif
n'est plus d'ajouter, c'est de stabiliser.

## Ce qui est livré et certifié (fait)

| Fonctionnalité | Preuve |
|---|---|
| Cycle de vie du devis (numéro `DEV-2026-0001`, statuts) | 201 pytest, casse 18/18 |
| Moteur PDF réutilisable + téléchargement | casse 14/14, `app/pdf/` sans dépendance métier |
| Interface Flutter (statuts, PDF, identité) | 63 flutter test, build web |
| Duplication d'un devis | casse 19/19 Docker |
| **Validation Docker de bout en bout** | 201 pytest conteneur, 21+19+11 QA HTTP |

La valeur phare de la V2 — **un artisan peut composer, numéroter, envoyer
et suivre un devis** — est délivrée et prouvée en conteneur.

## Triage des items restants

Chaque ligne applique littéralement les trois critères.

| Item | Valeur | Risque régression | Impact stabilité RC | **Verdict** |
|---|---|---|---|---|
| **Comptage exact du dashboard** (remplacer « 100+ ») | **Quasi nulle** — l'affichage « 100+ » est **déjà honnête** (corrigé en V1) ; et un artisan cible dépasse rarement 100 clients. Ce n'est plus une correction, c'est du confort. | Modéré — nouvel endpoint, nouvelle requête, écran visible touché. | Ajoute de la surface pour un gain que l'utilisateur ne verra presque jamais. | **V3** |
| **Remplacer `python-jose` par PyJWT** | Moyenne — retire une dépendance non maintenue (219 warnings). **Aucune** valeur fonctionnelle pour l'artisan. | **Élevé** — c'est la brique cryptographique qui porte **toute** l'authentification. Une erreur = personne ne se connecte, ou pire, un jeton invalide passe. | Rayon d'action maximal, sur le chemin le plus critique. | **V3** — cas d'école de la consigne : « peu de valeur, augmente le risque → reporté ». L'auth **fonctionne**, la crypto est vérifiée (`alg=none` rejeté, expiration honorée). Les warnings viennent de la lib, pas du code d'Artizen. |
| **Cookie `HttpOnly` pour le web** | Réelle en sécurité (le JWT est en localStorage sur web). | **Élevé** — refonte transverse de l'auth : le backend pose des cookies, Flutter cesse d'utiliser l'intercepteur, CORS `credentials`, flux de déconnexion. Touche **chaque** requête authentifiée. | Très large rayon d'action juste avant une RC. | **V3** — amélioration réelle mais c'est un refactor auth complet. La limite localStorage est documentée et atténuable (durée de vie du jeton courte). |
| **Rate limiting partagé (Redis)** | Faible pour un déploiement mono-instance. Le compteur en mémoire fonctionne (« ×4 par worker », documenté). | Ajoute une infrastructure (Redis) à opérer. | Ajoute une dépendance de run pour un produit sans déploiement. | **V3** |
| **Parsing IA tolérant aux réponses partielles** | Faible — cas rare (un article malformé sur N). | Change un comportement **testé** sur le chemin IA, avec effet de bord sur le score de confiance. | Risque > gain. | **V3** |
| **Double pénalité des doublons (scorer)** | Cosmétique (0.40 vs 0.85). | Deux tests figent le comportement actuel. | **Arbitrage produit**, pas réduction de risque. | **V3** |
| **Casser le cycle `users ↔ branding`** | Nulle côté utilisateur (propreté d'architecture). | Déplacer `Company` hors de `branding` touche l'inscription — le flux le plus critique. Aucun cycle à l'import aujourd'hui (prouvé). | Gros refactor pour zéro valeur visible avant RC. | **V3** |
| **`ApiClient` dans `core/api/`** | Nulle côté utilisateur. | Refactor des 7 repositories Flutter. | Surface large, gain interne. | **V3** |

## Conclusion

**Aucun item restant n'est indispensable à la V2.** Chacun est soit déjà
traité de façon adéquate, soit un cas « faible valeur / risque élevé » que
la consigne ordonne de reporter. Le périmètre fonctionnel de la V2 est
**complet**.

La suite n'est donc **pas** du développement mais de la stabilisation :

1. **Preuve consolidée** que toute la surface V2 tient ensemble (fait ce
   jour — voir `01_PROOF_OF_VALIDATION.md`).
2. **Synchronisation documentaire** (ROADMAP, README, CHANGELOG, guides).
3. **Audit final de cohérence code ↔ doc**, puis certification RC V2.

Ce triage est réversible : si un item ci-dessus doit rentrer dans la V2, il
suffit de le requalifier — mais la recommandation d'ingénierie, à ce stade,
est de figer le périmètre et de stabiliser.
