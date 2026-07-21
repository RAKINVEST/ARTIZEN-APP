# 11 — Certification V1 Wizard (phase de stabilisation)

> Rapport de certification du Wizard V1, produit à l'issue de la phase de
> stabilisation demandée. Branche `develop/v3` · HEAD `c91fefc` (+ docs).
> Référence : [`10_V1_WIZARD_RELEASE.md`](10_V1_WIZARD_RELEASE.md).
>
> **Verdict : aucune anomalie bloquante.** Détail par axe ci-dessous.

## 1. Validation contre le VRAI backend (parcours complet)

Exécuté en HTTP réel contre le backend en marche (pas de fakes) — l'équivalent
automatisé du « manuel contre le vrai backend », qui attrape les écarts de
contrat que la suite de tests (fakes) peut masquer (piège historique
`company_id` → 422). Parcours : register → client → import métier → items
filtrés par catégorie → calculate → create → PDF → liste.

| Étape | Résultat |
|---|---|
| `POST /auth/register` | 201 |
| `POST /clients` (email inclus, **`company_id` omis**) | 201 (le piège 422 est bien absent) |
| `POST /catalog/activities/plomberie` | 200 · **162 articles** créés |
| `GET /catalog/categories/overview` | 200 · 9 dossiers |
| `GET /catalog/items?category_id=…&active_only=true` | 200 · 26 articles, **tous du dossier** (filtre serveur P4.4 OK) |
| `POST /quotes/calculate` | 200 · HT **140.56** / TVA **14.06** / TTC **154.62** (Decimal réel) |
| `POST /quotes` | 201 · numéro **`DEV-2026-0001`** · statut `draft` |
| `GET /quotes/{id}/pdf` | 200 · `application/pdf` · 3038 octets |
| `GET /quotes` | 200 · le nouveau devis **apparaît** |

**→ Contrat backend du wizard validé de bout en bout. ✅**

## 2. Audit UX

- Un objectif par étape ; progression lisible ; retour arrière libre, avance gatée.
- Retours immédiats : « ✔ Ajouté (× N) », recalcul live, checklist de contrôle qualité.
- **Cérémonie de fin** rassurante : « Votre devis existe » + numéro + PDF + retour liste.
- Garde de sortie (abandon confirmé) ; sortie libre une fois le devis sauvegardé.
- **RAS bloquant.** Observations reportées V1.1 : adresse client sur le récap, objet/chantier.

## 3. Audit de cohérence

- **Zéro calcul côté Flutter** vérifié (montants uniquement issus de `calculation`/quote backend).
- Séparation stricte : dossier = navigation (`selectedFolderProvider`), devis créé
  = `createdQuoteProvider`, brouillon = `QuoteDraft`. Décision P4.3 respectée.
- Ligne = photographie (décision 5) ; brouillon ≠ devis (décision 4). **RAS.**

## 4. Audit des états

- Chaque appel réseau a **loading / error+retry / empty / data** :
  clients, dossiers (overview), articles (picker), recalcul, création.
- **Cycle de vie du brouillon** : réinitialisé uniquement après abandon confirmé
  **ou** réussite complète (création → PDF → retour liste). Re-entrée toujours propre
  (reset de `createdQuote` au montage). **RAS.**

## 5. Audit des performances

- Recherche **serveur** (clients, articles) ; fetch **borné** (limit 100) ⇒ scalable
  (50 → 1000 articles) sans réécriture.
- Recalcul **débouncé** (400 ms) ; recherche **débouncée** (300 ms) ; overview **mis en cache**.
- Une seule requête `POST /quotes` à la création ; liste rechargée sans appel superflu.
- **RAS.** 🟡 mineur documenté : rendu jusqu'à 100 lignes construites d'un coup (pagination
  « charger plus » ajoutable sans réécriture si un dossier devenait énorme).

## 6. Revue de code finale

- `flutter analyze` **propre** ; **aucun** `TODO`/`print`/`debug` résiduel dans le wizard.
- Patterns homogènes entre étapes (mêmes helpers, mêmes états) ; mécanisme « mock » retiré.
- Erreurs async **toutes gérées** (try/catch création, `.when(error)` ailleurs). **RAS.**

## 7. Logs & erreurs

- Aucune erreur/exception backend pendant le parcours réel (logs inspectés).
- Toutes les réponses HTTP en 2xx ; PDF `application/pdf` non vide. **RAS.**

## 8. Non-régression globale

- **Backend : 481 tests verts.**
- **Frontend : 172 tests verts** (dont 61 wizard, un e2e) · `flutter analyze` **propre**.

## 9. Anomalies détectées

- **Bloquantes : 0.**
- **Mineures : 0 nouvelle.** (Rappels 🟡 déjà documentés : rendu ≤100 lignes ; adresse client
  au récap ; objet/chantier — tous reportés V1.1, sans impact fonctionnel.)

## 10. Conclusion

**Le Wizard V1 est certifié : aucune anomalie bloquante.** Le parcours complet fonctionne
contre le vrai backend, les montants restent 100 % backend, les états et le brouillon sont
cohérents de bout en bout, la non-régression est verte des deux côtés.

**Conséquence (règle du propriétaire)** : le critère « aucune anomalie bloquante » étant
rempli, le Wizard peut **devenir le flux principal** de création de devis et **remplacer
l'ancien `QuoteFormScreen`**. La bascule (router le bouton « Nouveau devis » `/quotes/new`
vers le Wizard, retirer/déprécier l'ancien formulaire) est **prête à être exécutée** — sur
validation finale du propriétaire.
