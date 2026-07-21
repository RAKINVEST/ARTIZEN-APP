# Protocole de test UI manuel — Audit « Utilisateur réel » avant bêta

> **À exécuter par un humain, dans Chrome, comme un artisan.** Aucun accès au
> code, aux API, à la base. Chaque constat = une action réellement faite.
>
> **Pourquoi manuel** : les bugs d'interface (spinner bloqué, bouton inactif,
> focus perdu, débordement, scroll impossible, clavier mobile masquant un
> bouton, double-clic passé côté UI mais pas côté API) **n'apparaissent pas**
> dans les tests automatisés. Seule une vraie session navigateur les révèle.

## Mise en route (une fois)

1. Backend : `docker compose up` (API sur `:8000`).
2. Frontend : `cd frontend && flutter run -d web-server --web-port 3000`
   (le port **3000** est imposé par `CORS_ORIGINS`).
3. Ouvrir **Chrome** sur `http://localhost:3000`. Ouvrir la **console DevTools**
   (F12 → onglets *Console* et *Network*) et la laisser ouverte toute la session
   pour repérer erreurs JS, requêtes en échec, requêtes doublées.
4. Tester **deux tailles** : bureau (large) **et** mobile (DevTools → Toggle
   device toolbar, ex. iPhone) — c'est là que sortent débordements et clavier masquant.

## Comment enregistrer un constat (pour chaque anomalie)

| Champ | Ex. |
|---|---|
| **Écran / action** | « Wizard → étape Articles, tap Ajouter » |
| **Reproduction** | étapes numérotées exactes |
| **Fréquence** | toujours / intermittent / 1 fois |
| **Impact** | ce que l'artisan ne peut plus faire |
| **Gravité** | 🔴 bloquant · 🟠 important · 🟡 mineur · 🔵 ergonomie |
| **Preuve** | capture d'écran + copier l'erreur console/Network |

---

## PHASE 1 — Première impression (30 s, ne rien cliquer d'abord)

Regarder : page d'accueil / login / dashboard, menus, couleurs, boutons,
vocabulaire, cohérence. **Question unique : « Ai-je confiance après 30 s ? »**
- ⚠️ Vérifier notamment le libellé du bouton principal de création (le mot
  « (aperçu) » doit-il encore être là ?), les fautes, les termes techniques.

## PHASE 2 — Clients

Créer **plusieurs** clients et éprouver chaque cas, en observant l'UI :
particulier · entreprise · **nom très long** (200+ car. → déborde-t-il ?) ·
**email invalide** (`abc` → message ? accepté ?) · téléphone · adresse ·
**Retour** en cours de saisie · **Annulation** · **Modification** ·
**Suppression** (confirmation ? la liste se met-elle à jour ?) · **Recherche**
(instantanée ? sans résultat ?) · **tri** · **scroll** d'une longue liste ·
**chargement** (spinner qui se termine bien ?).

## PHASE 3 — Wizard (≥ 10 devis, plusieurs métiers)

Pour chaque devis, varier : navigation avant/arrière · **abandon** (dialogue ?)
· **double-clic** rapide sur « Ajouter » / « Créer » (double ligne ? double
devis ? double PDF ?) · **changement de client** · **changement de dossier** ·
ajout / suppression d'articles · **quantités** (±, très grandes) · **calcul**
(le total suit-il ? spinner « Recalcul » qui se débloque ?) · **création**
(numéro attribué ?) · retour liste (le devis apparaît-il ?) · **réouverture** ·
**duplication** si disponible. Créer avec **0 ligne**, avec **1 client sans
email**, etc.

## PHASE 4 — Interface (pendant TOUTE la navigation)

Chasser en continu : bouton **bloqué inactif** · **spinner infini** · message
**incohérent** · **écran vide** inattendu · **scroll impossible** · **focus
clavier perdu** (Tab, Entrée) · **texte coupé** · **débordement** (surtout
mobile) · **chargement anormal** · **clic sans effet** · **double création** ·
**double PDF**. Noter chaque occurrence avec l'onglet Network (requête doublée ?).

## PHASE 5 — PDF (plusieurs)

Générer plusieurs PDF (avec et **sans** logo/identité complète) et contrôler
visuellement : logo · coordonnées émetteur (nom, adresse, SIRET, tél) · client ·
articles · quantités · TVA · HT · TTC · mise en page · **pagination** (devis à
20+ lignes → saut de page correct ?) · **impression** réelle (Ctrl+P : rendu
fidèle ? marges ? coupures ?) · **téléchargement** (nom de fichier ?).

## PHASE 6 — Utilisation continue (≥ 45 min sans interruption)

Enchaîner créations de clients/devis, modifications, changements d'écran
fréquents. Surveiller : **ralentissements** progressifs, **fuite mémoire**
(DevTools → Performance/Memory, la conso monte-t-elle sans redescendre ?),
comportements **incohérents** après longue session, **rafraîchissement
navigateur** en plein devis (que devient le brouillon ?), **retour navigateur**.

## PHASE 7 — Comportement utilisateur (tout du long)

Noter **chaque hésitation** : « Je ne comprends pas » · « Je cherche » · « Je
pensais que… » · « Je m'attendais à… ». Chaque hésitation = une amélioration.

---

## Gabarit de rapport final (à remplir après la session)

1. **Bugs bloquants** — 2. **Bugs importants** — 3. **Bugs mineurs** —
4. **Problèmes d'ergonomie** — 5. **Améliorations conseillées** —
6. **Points excellents**.
Chaque point : *reproduction · fréquence · impact · gravité*.

**Conclusion (une seule)** : ❌ NON PRÊT · 🟡 BÊTA PRIVÉE AVEC RÉSERVES ·
🟢 BÊTA PRIVÉE · 🚀 BÊTA PUBLIQUE. « Publique » **uniquement** si **aucun**
défaut susceptible d'entamer la confiance d'un artisan dès la première utilisation.
