# BETA_READINESS_REPORT — Wizard V1

> Audit qualité pré-bêta, mené comme un QA senior, **par preuves** :
> parcours HTTP réel contre le backend en marche + **extraction du contenu PDF**
> + audit du code des écrans que verra un bêta-testeur. **Aucun développement.**
> Branche `develop/v3` · HEAD `e0b274a`.

## Méthodologie & périmètre

| Axe demandé | Méthode | Verdict |
|---|---|---|
| 1. Clients (création/modif/email/tél/adresse/recherche) | Parcours HTTP réel (create complet → update → search → search vide) | ✅ Conforme |
| 2. Catalogues (métiers/dossiers/articles/recherche/vides) | HTTP réel (catalogue vide → import → overview → items filtrés) + code | ✅ Conforme |
| 3. Devis complet (client→…→numéro→PDF) | HTTP réel de bout en bout | ✅ Conforme |
| 4. PDF (présentation/lisibilité/logo/coordonnées/pagination/montants) | Génération + **extraction pypdf** du texte | ✅ Conforme (1 réserve, §Recommandées) |
| 5. Messages (erreurs/chargement/confirmations/libellés/fautes/technique) | Audit code + grep | ⚠️ 3 fuites techniques (§Recommandées) |
| 6. Nettoyage (démo/TODO/temporaire/placeholders) | Grep exhaustif | ⚠️ 1 libellé + 1 commentaire périmés (§Importantes) |
| 7. UX (écrans confus/clics inutiles) | Revue des parcours | ✅ Conforme (confort, §Confort) |

**Preuve clé** : un devis créé en HTTP réel — `DEV-2026-0001`, HT 335,00 / TVA 33,50 /
TTC 368,50 — produit un **PDF propre** : en-tête entreprise, `DEVIS`, numéro, date,
bloc **ÉMETTEUR** + **CLIENT** (nom, adresse, email), tableau
`Désignation / Qté / Unité / P.U. HT / TVA / Total HT` au format français
(`35,00 € · 10 % · 105,00 €`). **Aucun placeholder** (ni `lorem`, ni `DEV-2026-0042`,
ni « Martin Dubois », ni `exemple@`).

---

## 🔴 Anomalies bloquantes

**Aucune.** Le parcours complet de création de devis fonctionne de bout en bout contre
le vrai backend ; le PDF est correct ; les montants sont exacts ; le Wizard gère
chargement/erreur/vide proprement.

---

## 🟠 Anomalies importantes (à corriger avant d'exposer à de vrais artisans)

1. **Le bouton principal du tableau de bord annonce le Wizard comme un « aperçu ».**
   [`dashboard_screen.dart:47`](../../frontend/lib/features/dashboard/presentation/dashboard_screen.dart#L47) :
   libellé **« Nouveau devis guidé (aperçu) »** + commentaire périmé ligne 44
   « *Lot 2 preview: the guided quote assistant (mock data for now)* ».
   Or le Wizard est **terminé, certifié, flux principal**. Le mot **« (aperçu) »**
   contredit la certification et **abîme la confiance** dès l'écran d'accueil
   (« ce n'est pas fini / pas fiable »). Correctif attendu : retirer « (aperçu) »
   (→ « Nouveau devis guidé ») et le commentaire périmé. *Impact première impression :
   élevé ; effort : trivial.*

---

## 🟡 Améliorations recommandées (avant ou pendant la bêta)

1. **Messages d'erreur techniques exposés à l'utilisateur** — 3 écrans montrent
   l'exception brute au lieu d'un message clair :
   - [`quote_detail_screen.dart:44`](../../frontend/lib/features/quotes/presentation/quote_detail_screen.dart#L44) — « *…: $error* » (gestion d'un devis : statut, PDF, suppression) — **le plus visible en bêta**.
   - [`quote_assistant_screen.dart:159`](../../frontend/lib/features/quote_assistant/presentation/quote_assistant_screen.dart#L159) — « *Échec de la préparation du devis : $error* » (copilote IA).
   - [`client_form_screen.dart`](../../frontend/lib/features/clients/presentation/client_form_screen.dart) — « *Échec de l'enregistrement : $error* » (création client inline, atteinte depuis le Wizard).
   > Le Wizard lui-même est **propre** (« La création a échoué. Vérifiez votre connexion,
   > puis réessayez. »). À aligner les écrans adjacents sur ce standard.

2. **Émetteur du PDF clairsemé si l'identité n'est pas configurée.** Une entreprise
   fraîchement inscrite sans adresse ni logo produit un bloc ÉMETTEUR minimal
   (« *Menuiserie Durand / France* »). C'est une **dégradation gracieuse** voulue,
   mais elle nuit à l'« image professionnelle ». Atténué par l'onboarding
   « Configurer mon entreprise ». Recommandé : **rendre le nom d'entreprise requis à
   l'inscription** ([`register_screen.dart`](../../frontend/lib/features/auth/presentation/register_screen.dart) l'accepte vide) et inciter fortement à compléter
   identité + logo **avant** le premier devis.

3. **Polish de la landing** (si les bêta-testeurs y passent) :
   [`landing_screen.dart`](../../frontend/lib/features/landing/presentation/landing_screen.dart) affiche des **captures « Aperçu à venir »** (§1365+) et un
   lien de pied de page **« Bientôt disponible. »** (§1793). Acceptable pour une bêta
   fermée ; à finaliser avant une ouverture large.

---

## 🟢 Améliorations de confort (post-bêta / V1.1)

1. **Saisie directe de la quantité** à l'étape Personnaliser (aujourd'hui `−/+` seuls) —
   utile pour de grandes quantités.
2. **Adresse du client sur le récapitulatif** (le nom seul y figure ; l'adresse existe
   sur la fiche client).
3. **Pagination « charger plus »** des articles pour un dossier très volumineux
   (aujourd'hui borné à 100, suffisant pour un dossier réel).
4. Ces trois points sont déjà tracés dans [`12_V1.1_BACKLOG.md`](12_V1.1_BACKLOG.md).

---

## Ce qui est explicitement CONFORME (rassurant pour la bêta)

- **Clients** : création complète (email/tél/adresse), modification, recherche,
  recherche sans résultat → liste vide. ✅
- **Catalogue** : état vide → import → dossiers lisibles → articles filtrés **côté
  serveur** par dossier. ✅
- **Devis** : client → dossier → articles → quantités → calcul **backend** → création
  → **numéro `DEV-AAAA-NNNN`** → PDF. ✅
- **PDF** : numéro, client (nom/adresse/email), entreprise, montants HT/TVA/TTC,
  format français, pagination correcte, **zéro placeholder**. ✅
- **Wizard** : messages propres, cérémonie de fin rassurante, brouillon réinitialisé
  seulement après succès complet. ✅
- **Nettoyage du Wizard** : aucun TODO/mock/placeholder dans le parcours certifié. ✅

---

## Conclusion

Le parcours certifié (Wizard V1) est **fonctionnellement prêt** : validé de bout en
bout contre le vrai backend, PDF professionnel, messages propres, zéro anomalie
bloquante. La seule anomalie **importante** est un **libellé** (« (aperçu) ») et un
commentaire périmés sur le tableau de bord — trivial à corriger, mais **à faire avant**
d'exposer à de vrais artisans (première impression). Les fuites de messages techniques
sur les écrans adjacents et le PDF « émetteur » clairsemé sont des **recommandations**,
non bloquantes.

**PRÊT POUR UNE BÊTA**

*(sous réserve de la correction pré-bêta du libellé « (aperçu) » du tableau de bord —
1 mot — qui n'ouvre aucun chantier de développement.)*
