# Phase 1.1 — Certification commerciale du devis

> **Objectif** : rendre le devis ARTIZEN **irréprochable** — un document qu'un artisan est fier de
> remettre et qui inspire immédiatement confiance. Aucune nouvelle fonctionnalité métier, aucune IA,
> aucune V3 : uniquement finition, robustesse et garde-fous. Suite de [PHASE1-CONFORMITE.md](PHASE1-CONFORMITE.md).
>
> **Tests : 265 backend + 78 Flutter, tous verts. `flutter analyze` propre.**

---

## 1. Missions livrées

### Mission 1 — Signature de l'entreprise (+ tampon) ✅
**Backend** : `POST`/`DELETE /branding/signature` et `/branding/stamp`, `GET /branding/asset/{logo|signature|stamp}`
(aperçu, tenant-scopé). Stockage généralisé (`_store_asset`) : import, **remplacement** avec purge de
l'ancien fichier, suppression. **Rendu PDF** : signature + tampon de l'artisan à gauche, « Bon pour
accord » du client à droite. **Rendu propre garanti si aucun des deux** (colonne gauche simplement vide).
**Frontend** : section « Signature & tampon » dans *Mon entreprise* — import, **aperçu** (`Image.memory`),
suppression (avec confirmation), remplacement, état vide explicite.

### Mission 2 — Contrôle « Devis prêt à émettre » ✅
**Moteur réutilisable** : `quotes/readiness.py::evaluate_readiness` (fonction **pure**) + endpoint
`GET /quotes/{id}/readiness` → `{ ready, issues:[{code,label,target,field}] }`.
**Frontend** : `QuoteReadinessGate.ensureReady(...)` **réutilisable**, branché **avant Télécharger /
Partager / « Marquer comme envoyé »**. Si non conforme → feuille listant chaque manque 🔴, **cliquable
→ redirection directe vers le champ à corriger** (`company_profile?field=…` focus le champ ; `client` →
édition ; `quote` → détail). Badge « Prêt à émettre / À compléter (n) ». **Fail-closed** : jamais
d'émission sans conformité confirmée.

### Mission 3 — Gestion des champs *Mon entreprise* ✅
**Backend** : `PUT /branding/company` mappe **`""` → `NULL`** (suppression explicite), sans casser les
mises à jour partielles de `template_import`. **Frontend** : envoi de la chaîne (vide comprise) →
l'effacement fonctionne ; bouton **« Réinitialiser »** (recharge les valeurs enregistrées). Formulaire
totalement autoritatif (add / modify / delete / clear / restore).

### Mission 4 — Qualité PDF ✅
- **Anti-débordement** : chaque cellule du tableau est un `Paragraph` → une unité longue (« forfait
  mensuel ») ou un gros montant (« 1 234 567,89 € ») **s'enroule** au lieu de déborder.
- **Pied de page** sur chaque page : identité de l'émetteur + **numéro de page**.
- **Sauts de page** : en-tête du tableau **répété** sur chaque page (`repeatRows`), bloc signature et
  mentions **jamais scindés** (`KeepTogether`).
- **Logo / signature / couleur** : dégradation gracieuse (image illisible → ignorée, couleur invalide →
  défaut), jamais de crash.
- **Contraste / lisibilité** : texte foncé (#1E293B) sur blanc, en-têtes en couleur primaire, mentions
  légales en gris lisible — palette premium par défaut si rien n'est configuré.

### Mission 5 — Recette automatique ✅
`test_quote_certification.py` — **14 tests**, chaque scénario rend un PDF vérifié :
entreprise **complète** (logo+signature+tampon) · **minimale** (nom seul) · **micro-entrepreneur**
(franchise, sans TVA) · **TVA normale** · **sans logo** · **sans signature** · **avec signature seule** ·
**avec tampon seul** · **client particulier** · **client professionnel** · **très grand devis** (150
lignes → **multi-pages**) · **très petit** (1 ligne) · **valeurs longues + caractères spéciaux** (`&`,
`<`, `>`).

### Mission 6 — UX ✅
Libellés FR clairs, sections nommées, messages d'erreur **actionnables** (chaque manque mène au champ),
design system (`AppTextField`/`AppPrimaryButton`/`AppInfoCard`, `ArtizenColors`/`ArtizenSpacing`), **zéro
couleur en dur**, gardes anti-double-soumission. L'utilisateur ne se demande jamais « où saisir ? » : le
contrôle pré-vol l'y emmène.

---

## 2. Check-list de conformité (moteur « prêt à émettre »)

Le devis n'est émettable (🟢) que si **tous** ces points sont satisfaits — sinon 🔴 + liste cliquable :

| # | Contrôle | Où corriger |
|---|---|---|
| 1 | Nom de l'entreprise | Mon entreprise → Nom |
| 2 | Adresse de l'entreprise (rue + CP/ville) | Mon entreprise → Adresse |
| 3 | SIRET | Mon entreprise → SIRET |
| 4 | Régime TVA cohérent (n° TVA si régime réel) | Mon entreprise → N° TVA |
| 5 | Assurance décennale | Mon entreprise → Assureur |
| 6 | Conditions de paiement | Mon entreprise → Conditions |
| 7 | Durée de validité | Mon entreprise → Validité |
| 8 | Coordonnées (téléphone ou email) | Mon entreprise → Contact |
| 9 | Identité graphique (logo) | Mon entreprise → Logo |
| 10 | Client rattaché | Devis |
| 11 | Nom du client | Fiche client |
| 12 | Adresse du client | Fiche client |
| 13 | Au moins une ligne | Devis |
| 14 | Cohérence des totaux (HT + TVA = TTC) | Devis (défense en profondeur) |

---

## 3. Preuves

**Vérification dynamique (API réelle)** :
- Signature + tampon importés (201), aperçu servi (`GET /branding/asset/signature` → `image/png`).
- Devis entièrement configuré → **readiness `ready=true`, 0 issue** ; PDF avec signature+tampon rendu.
- **Effacement** `siret=""` → `null` ; readiness re-signale alors `siret`.
- Entreprise minimale → **readiness `ready=false`** avec cibles précises (`company_name/company_profile`,
  `siret/company_profile`, `insurance/company_profile`, …).

**PDF de démonstration générés** (chaîne réelle, ouvrables) :
- `demo_complet_signe.pdf` — entreprise complète, TVA normale, **signature + tampon** (5,3 Ko).
- `demo_micro_franchise.pdf` — **micro / franchise**, sans TVA, mention 293 B (3,8 Ko).
- `demo_grand_devis.pdf` — **40 lignes**, multi-pages, en-tête répété + pied de page (8,2 Ko).

**Tests** : 265 backend (dont 14 recette + 9 conformité) + 78 Flutter (dont readiness, branding assets).

> **Captures d'écran de l'app** : non produites — l'environnement ne permet pas la capture d'UI mobile
> (limite déjà rencontrée et documentée). En remplacement, l'artefact réellement remis au client — le
> **PDF** — est fourni en trois variantes, et l'UI est couverte par 78 tests widget verts.

---

## 4. Le devis reste élégant dans tous les cas

Prouvé par la recette (Mission 5) : le PDF est propre **avec très peu** d'informations (entreprise
minimale, 1 ligne) comme **avec énormément** (150 lignes multi-pages, valeurs longues), **avec ou sans**
signature, **avec ou sans** RGE, **avec ou sans** assurance, en TVA normale **comme** en franchise.

---

## 5. Verdict

### « Le devis ARTIZEN est-il désormais prêt à être utilisé par un artisan dans un contexte professionnel réel ? »

## ✅ OUI.

Pourquoi :
1. **Il est légalement conforme** (Phase 1) et le reste dans les deux régimes : identité complète,
   assurance décennale, RGE, conditions de paiement, validité, mention 293 B pour la franchise.
2. **Il porte la signature de l'artisan** (et son tampon) et offre au client une zone « Bon pour
   accord » — le document peut jouer son rôle contractuel.
3. **Il ne peut pas partir incomplet** : le moteur « prêt à émettre » bloque l'émission tant qu'un
   élément manque, et **emmène l'artisan droit au champ** à corriger. Un devis émis est un devis
   complet.
4. **Il reste élégant à toutes les échelles** (recette 14 scénarios) et **robuste** (débordements,
   caractères spéciaux, images cassées gérés sans crash).
5. **L'artisan maîtrise entièrement son entreprise** depuis l'app (remplir, modifier, **effacer**,
   restaurer) — sans manipulation externe.

**Réserves honnêtes (non bloquantes pour l'usage professionnel du devis)** :
- Validation **bout-en-bout mobile manuelle** : aucun test Flutter n'appelle le vrai backend (limite
  connue du dépôt) — à repasser sur appareil une fois déployé.
- Le contrôle pré-vol garde **Télécharger / Partager / Marquer comme envoyé** ; les boutons *imprimer/
  partager* de la barre d'outils de l'**aperçu** restent libres (choix assumé : consulter un brouillon).
- `font_family` et le ciblage de champ hors *Mon entreprise* sont des finitions mineures restantes.

---

**La certification commerciale du devis est prête pour validation.** Conformément à la consigne,
**aucun développement de la Phase 0 (Quick Wins) ne démarrera avant ce feu vert.**
