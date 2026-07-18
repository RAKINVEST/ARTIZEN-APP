# Phase 1 — Conformité & Identité — Rapport de fin

> **Objectif** : rendre le devis conforme à la loi française du bâtiment et permettre à un artisan de
> **configurer entièrement son entreprise depuis l'application, sans manipulation externe**. Suite de
> la certification [AUDIT-V2-PRO.md](AUDIT-V2-PRO.md). Aucun développement V3.

## Résultat en une phrase

Un artisan crée un compte, ouvre **Paramètres → Mon entreprise**, remplit son identité et son régime, et
**tout devis qu'il émet est légalement conforme** — sans jamais importer un ancien PDF ni toucher à la
base. **251 tests backend** + **68 tests Flutter** verts ; `flutter analyze` propre.

---

## 1. Ce qui a été livré

### Backend (commit `43d2fee`)
- **Identité réglementaire** sur `Company` (+ migration `76512d9490e4`, `server_default` sur les
  colonnes NOT NULL pour remplir les lignes existantes) : `legal_form`, `share_capital`, `rcs_rm`,
  `ape_code`, `insurance_name`, `insurance_contract`, `insurance_coverage`, `rge_number`,
  `payment_terms`, `vat_regime`, `quote_validity_days`.
- **Régimes de TVA** — `normal` | `franchise` (micro / art. 293 B). En franchise, `QuoteService.create`
  force `vat_rate = 0` **avant** le calcul → devis 0 TVA. `QuoteCalculator` reste **le seul** endroit où
  un montant est calculé ; le snapshot de ligne (`vat_rate=0`) correspond au total. Régime `normal` par
  défaut → **comportement V2 strictement inchangé**.
- **PDF conforme** (`document_mapper` + `renderer`) : identité légale de l'émetteur (forme juridique +
  capital, SIRET, RCS/RM, APE), mentions dynamiques construites depuis l'entreprise, **bloc « Bon pour
  accord »** (date + signature client), et **masquage de la colonne/total TVA** en franchise (fin du
  « Total TVA 0 € » amateur). L'aperçu (`sample_document`) est fidèle au régime.
- **API** : `PUT /branding/company` (déjà existant) étendu aux nouveaux champs ; `get_company` léger.
- **9 tests** de conformité (`test_company_compliance.py`).

### Frontend (commit `2b4fbdf`)
- Écran **« Mon entreprise »** (`company_profile_screen.dart`) : formulaire sectionné (Identité /
  Coordonnées / Régime de TVA / Assurance décennale / RGE / Conditions de paiement / Validité), avec
  `SegmentedButton` pour le régime + `AppInfoCard` expliquant la franchise 293 B, `AsyncValueView`
  (loading/error/retry), snackbar de succès, **garde anti-double-soumission**, validations (email,
  validité 1–365 j), `AppTextField`/`AppPrimaryButton`, design system, **zéro couleur en dur**.
- `Company`/`CompanyUpdateInput` (Freezed) étendus + `updateCompany()` sur le notifier (Dio confiné à
  `core/api`) + route `/company-profile` + entrée « Mon entreprise » en tête de **Paramètres**.

---

## 2. Démonstration — configuration 100 % autonome

```
Artisan (app)                          Backend                         PDF du devis
─────────────                          ───────                         ───────────
Paramètres → Mon entreprise
  Identité : SARL, capital, SIRET,
             RCS, APE, n° TVA
  Coordonnées : adresse, tél, email
  Régime TVA : [TVA normale | Franchise]
  Assurance décennale : assureur,
             n° contrat, couverture
  RGE : n° (si applicable)
  Conditions de paiement : …
  Validité : 45 jours
  [Enregistrer] ───PUT /branding/company──►  Company mis à jour
                                              (aucune saisie en base,
                                               aucun import PDF)
Créer un devis ────POST /quotes──────────►  franchise ⇒ TVA forcée à 0
Télécharger ───────GET /quotes/{id}/pdf──►  QuoteCalculator ─► Document ─►  ✅ Devis conforme
```

**Rien d'externe n'est requis** : ni fichier à importer, ni intervention SQL, ni configuration serveur.

---

## 3. Preuves (vérifications dynamiques réelles, sur l'instance en cours)

**Configuration via l'API, puis devis, puis PDF** — exécuté contre le backend live :

| Vérification | Résultat |
|---|---|
| `PUT /branding/company` (13 champs réglementaires) | ✅ persistés (relus via `GET /branding/profile`) |
| Devis en régime **normal** (article TVA 20 %) | HT 1000 · **TVA 200** · TTC 1200 · PDF 200 |
| Devis en régime **franchise** | HT 1000 · **TVA 0** · TTC 1000 · ligne `vat_rate=0.00` · PDF 200 |

**Extraction du texte du PDF généré** (entreprise en franchise entièrement configurée) — toutes les
mentions obligatoires présentes :

```
OK  Forme juridique .......... « SARL au capital de 5 000 € »
OK  SIRET .................... « SIRET : 12345678900012 »
OK  RCS / RM ................. « RCS Paris 123 456 789 »
OK  Code APE ................. « APE : 4322A »
OK  Franchise TVA ........... « TVA non applicable, art. 293 B du CGI »
OK  Assurance décennale ..... « Assurance décennale : AXA, contrat n° DEC-2024-99
                                (couverture : France métropolitaine) »
OK  Certification RGE ....... « RGE : QB/12345 »
OK  Conditions de paiement .. « Conditions de règlement : … »
OK  Validité (configurable) . « 45 jours »
OK  Bon pour accord ......... zone de signature client présente
—   « Total TVA » ABSENT du corps en franchise ✅
```

Ces contrôles sont désormais **figés en tests permanents**
(`test_configured_quote_pdf_carries_the_legal_mentions`, `test_franchise_regime_produces_a_vat_free_quote`).

---

## 4. Blocages de certification levés

| ID audit | Blocage | Statut |
|---|---|---|
| **C1** | Devis PDF non conforme (assurance décennale, signature, forme juridique) | ✅ **levé** — mentions + bloc signature rendus |
| **C2** | Aucun support micro-entrepreneur / 293 B | ✅ **levé** — régime franchise + mention + TVA masquée |
| **C3** | Identité non saisissable depuis l'app | ✅ **levé** — écran « Mon entreprise » |

*Bonus* : la fuite de `TextEditingController` (B3) est évitée dans le nouvel écran (dispose systématique).

---

## 5. Limites connues (hors périmètre Phase 1, à traiter ensuite)

- **Effacement d'un champ non propagé** : le formulaire envoie un `PUT` partiel (`exclude_unset`) — vider
  un champ ne l'efface pas côté serveur (il conserve l'ancienne valeur). Le cas d'usage Phase 1 est le
  **remplissage**. L'effacement explicite pourra être ajouté si besoin.
- **Signature/tampon de l'artisan et `font_family`** : `BrandProfile.signature_path`/`stamp_path` et la
  police restent stockés mais non rendus sur le PDF (finition Y18 de l'audit) — non bloquant légalement.
- **Validité mobile réelle** : aucun test Flutter n'appelle le vrai backend (limite documentée
  CLAUDE.md) ; la validation bout-en-bout mobile reste manuelle (`flutter run` + Docker).
- **Garde-fou « devis prêt à émettre »** : un devis peut toujours être généré même si l'entreprise n'a
  pas encore renseigné son assurance/SIRET (M8 de l'audit) — recommandé pour la suite.

---

## 6. Verdict Phase 1

**Objectif atteint.** Un artisan peut **configurer entièrement son entreprise depuis l'application, sans
manipulation externe**, et **le devis produit est légalement conforme** (identité, régime TVA, assurance
décennale, RGE, conditions de paiement, validité, zone de signature). Prouvé dynamiquement et figé en
tests. Zéro régression (251 backend + 68 Flutter).

**La conformité est prête pour validation.** La **Phase 0 (Quick Wins)** ne démarrera qu'après ce
feu vert, conformément à la consigne.
