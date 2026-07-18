# ARTIZEN — Revue stratégique produit (Go / No-Go commercial)

> Revue **commerciale**, pas technique. Question centrale : *ARTIZEN est-il prêt à devenir un produit
> qu'un artisan **paie** ?* Casquettes : CEO SaaS, PM senior, expert du marché des logiciels artisans,
> UX Lead, responsable Go-To-Market. S'appuie sur l'état réel du produit (Phases 1 / 1.1 / 0 validées) et
> sur [la validation terrain](beta/RAPPORT_VALIDATION_TERRAIN.md).

---

## 1. Quelle est la promesse principale d'ARTIZEN ?

**Promesse réelle aujourd'hui** : *« Faites des devis **conformes** et **professionnels** en quelques
minutes, depuis votre téléphone, sans être un expert. »*

- Le différenciateur tangible et rare sur ce marché : **la conformité légale bâtiment** (assurance
  décennale, mention 293 B pour les micro, forme juridique, signature, « Bon pour accord ») **garantie
  par un contrôle « prêt à émettre »** — l'artisan ne peut pas envoyer un devis non conforme.
- La promesse **marketée à terme** (« créez un devis **à la voix**, en parlant sur le chantier ») est
  l'assistant IA vocal : c'est le futur *moat*, mais il est **gelé (V3, non construit)**. Il ne doit pas
  être vendu comme présent.

**En clair : la promesse V1 vendable = « le devis conforme, sans prise de tête ». La promesse
différenciante future = « le devis à la voix ».**

---

## 2. Cette promesse est-elle réellement tenue ?

**Oui pour le devis. Non pour le cycle complet.**

| La promesse… | Tenue ? |
|---|---|
| Devis **conforme** (mentions légales, régimes TVA) | ✅ oui — vérifié, testé, prouvé PDF à l'appui |
| Devis **professionnel** (rendu premium, signature, robuste) | ✅ oui |
| **Rapide / mobile** (recherche instantanée, création en ~8 clics) | ✅ oui — Phase 0 |
| **Autonome** (l'artisan se configure seul) | ⚠️ partiel — possible mais **non guidé** (démarrage à froid) |
| **De bout en bout** (créer → **envoyer** → suivre → **facturer**) | ❌ non — pas d'envoi intégré, pas de facture |

**Verdict** : le **noyau de la promesse (« un beau devis conforme, vite ») est tenu**. La promesse
implicite plus large (« gérez vos devis de A à Z ») ne l'est pas encore : il manque **l'envoi** et
**l'accueil**, et — selon le positionnement — **la facture**.

---

## 3. Fonctionnalités **indispensables** avant une V1 commerciale

Une V1 payante doit permettre à un artisan de **créer un devis conforme, de l'envoyer à son client, et
de le retrouver — seul, sans accompagnement**. Indispensables :

1. **Accueil guidé** (onboarding) — sinon la cible peu digitale n'active jamais. *(petite marche UX)*
2. **Envoi du devis au client** — email intégré (idéalement) **ou** partage fiable clairement relié au
   statut. Un devis qu'on ne peut pas envoyer proprement est un demi-produit.
3. **Récupération de compte** (« mot de passe oublié ») — sans quoi le premier oubli = client perdu.
4. **Retrouver un devis** (recherche par n° / client). *(le composant existe déjà ailleurs)*
5. **Exploitation commerciale** : instance **hébergée HTTPS**, sauvegardes, facturation **du SaaS**
   (paiement de l'abonnement), CGU/CGV + RGPD.
6. *(Déjà là)* Devis conforme, catalogue, clients, contrôle « prêt à émettre ».

> La **facturation (devis→facture)** est traitée séparément — voir Q5.

---

## 4. Fonctionnalités **repoussables** sans nuire à la valeur

| Repoussable | Vers | Pourquoi ça ne tue pas la valeur V1 |
|---|---|---|
| **Assistant IA vocal** (voix→devis) | V3 | Différenciateur *futur* ; un artisan paie déjà pour un bon devis conforme mobile. À garder comme **vision**, pas comme promesse V1. |
| **Édition ligne à ligne d'un devis** | V1.1 | Contournable par duplication/recréation ; à **clarifier** en UX plutôt qu'à construire. |
| **Relances automatiques, suivi d'ouverture** | V1.1 | Fort levier de CA mais non bloquant pour vendre. |
| **Import CSV clients/catalogue** | V1.1 | Accélère la migration ; peut être fait « à la main » au début. |
| **Multi-utilisateur / équipe** | V2 | Le cœur de cible V1 est le **solo/micro**. |
| **Mode hors-ligne** | V2 | Souhaitable chantier, mais lourd ; pas un frein à l'achat initial. |
| **Matching sémantique, KPI avancés, instrumentation auto** | V2/V3 | Confort/scale, invisibles pour la décision d'achat. |

---

## 5. La **facturation** doit-elle faire partie de la V1 ?

**Réponse : NON dans la première V1 payante — à condition d'assumer un positionnement « spécialiste du
devis conforme » — mais OUI en V1.1 rapprochée. Si le positionnement est « logiciel de gestion »,
alors OUI dès la V1.**

Justification selon le positionnement :

- **Positionnement A — « Le spécialiste du devis conforme » (recommandé pour aller vite au marché)** :
  la valeur vendue est *« votre devis, impeccable et légal, en 2 minutes »*. La facture n'est pas
  nécessaire pour tenir cette promesse. Avantage : **mise sur le marché plus rapide**, différenciateur
  net (conformité + simplicité + mobile), prix d'entrée bas → adoption. Risque : l'artisan garde un
  autre outil pour facturer → il faut livrer la facture **vite** (V1.1) pour ne pas plafonner la
  rétention.

- **Positionnement B — « Logiciel de gestion de l'artisan » (devis + facture)** : là, **la facture est
  obligatoire en V1**, car c'est *la raison d'achat* d'un logiciel de gestion (le devis accepté doit se
  transformer en facture pour être payé). Sans elle, on ne remplace pas Excel/le second outil.

**Recommandation CEO** : viser le **positionnement A pour la première V1 payante** (time-to-market,
différenciateur clair, cible solo/micro), avec la **facturation planifiée et communiquée comme V1.1**
(techniquement préparée : la numérotation `QuoteCounter` et le moteur PDF « FACTURE » existent déjà).
**Assumer explicitement** « devis d'abord, facture juste après » dans le discours commercial et le prix —
ne jamais la présenter comme un oubli.

---

## 6. Le plus petit produit commercialisable (MVP commercial)

**« Je crée un devis conforme et je l'envoie à mon client, depuis mon téléphone — et je le retrouve. »**

Contenu minimal qu'un artisan **accepterait de payer** :

- ✅ Configuration entreprise + **conformité** garantie *(fait)*
- ✅ Catalogue + clients + **création de devis** rapide *(fait)*
- ✅ **PDF professionnel** + contrôle « prêt à émettre » *(fait)*
- ➕ **Envoi du devis** au client (email intégré ou partage fiable relié au statut)
- ➕ **Accueil guidé** (1re utilisation) + **récupération de compte**
- ➕ **Recherche de devis** + **instance hébergée** + paiement de l'abonnement

**Hors MVP commercial** (upsell / V1.1+) : facturation, relances, import CSV, IA vocale, multi-utilisateur,
hors-ligne. **Le MVP se résume à : « le devis conforme, envoyé, retrouvé. »**

---

## 7. Les trois principaux **risques commerciaux** restants

1. **Différenciation sur un marché saturé.** Sans la voix (gelée), ARTIZEN est perçu comme *« un
   logiciel de devis de plus »* face à des acteurs installés (Tolteck, Obat, Henrri, Batappli, EBP…).
   Le différenciateur « conformité garantie + simplicité mobile » **est réel mais doit être le cœur du
   message** ; à défaut → guerre de prix perdue d'avance. *Mitigation : positionnement « devis conforme,
   zéro risque légal » + wedge segment (micro/BTP peu équipés), voix comme vision.*

2. **Valeur incomplète = rétention faible.** Sans **envoi intégré** ni **facture**, l'artisan garde un
   second outil → il **ne migre pas** et **churn**. *Mitigation : livrer l'envoi en V1 et la facture en
   V1.1 ; mesurer la rétention en bêta avant d'investir en acquisition.*

3. **Adoption & Go-To-Market sur une cible peu digitale.** Coût d'acquisition élevé, onboarding critique.
   Sans **accueil guidé** et sans **canal d'acquisition** (bouche-à-oreille, prescripteurs, fédérations
   d'artisans, comptables, distributeurs de matériaux), le CAC détruit l'unit economics. *Mitigation :
   onboarding guidé + freemium/essai + partenariats de distribution + preuve « devis conforme » comme
   accroche virale entre artisans.*

---

## 8. Feuille de route priorisée — jusqu'à la RC, puis la V1.0

> Orientée **valeur commerciale** : chaque jalon est justifié par « ce que ça débloque pour vendre/retenir ».

### Jalon A — **Release Candidate (RC)** : « prouver qu'un artisan crée et envoie un devis conforme, seul, et qu'il paierait »
Objectif business : **validation produit-marché** en bêta privée, avant tout budget d'acquisition.
1. **P0 exploitation** : instance hébergée HTTPS + build correct + base propre + récupération de compte.
   → *Sans ça, pas de bêta.*
2. **Accueil guidé** (check-list de démarrage) + **champs requis visibles**. → *Active la cible peu
   digitale.*
3. **Envoi du devis** (au minimum partage fiable relié au statut ; email intégré si faisable). →
   *Complète la promesse « je l'envoie à mon client ».*
4. **Recherche de devis** (n°/client). → *Utilisable au-delà de quelques devis.*
5. **Bêta privée accompagnée** (5–10 artisans) + **instrumentation palier 0** (temps devis, activation,
   NPS). → *Preuve de valeur + retours classés.*
**Sortie de RC = signal go/no-go** : les artisans créent, envoient, reviennent, et disent « je paierais ».

### Jalon B — **V1.0 commerciale** : « on peut le vendre et être payé »
Objectif business : **monétisation** et **rétention**.
6. **Facturation du SaaS** (abonnement Stripe) + **prix** + essai/freemium. → *On encaisse.*
7. **Positionnement & message** figés (« le devis conforme, zéro risque légal ») + **CGU/CGV, RGPD, support/CS**.
8. **Facturation devis→facture** *(si V1.1 planifiée : la communiquer comme imminente ; sinon l'inclure
   si positionnement « gestion »)*. → *Débloque la rétention et l'upsell.*
9. **Envoi email intégré + suivi** (relances). → *Levier de CA pour l'artisan = argument de vente.*
10. **Acquisition** : 1er canal (bouche-à-oreille outillé, prescripteurs, fédérations/matériaux) +
    validation e2e mobile réelle. → *On acquiert sans brûler le CAC.*

### Au-delà de la V1 (ne pas y toucher avant traction)
- **V1.1** : facture (si pas en V1), relances, import CSV, édition de devis clarifiée.
- **V2** : multi-utilisateur, hors-ligne, KPI.
- **V3** : **assistant IA vocal** (le vrai *moat* — à sortir quand la base d'utilisateurs et la traction
  le justifient).

---

## Conclusion — Go / No-Go

**ARTIZEN n'est pas encore un produit commercial, mais il en est proche — et le chemin est court et
non technique.** Le cœur (devis conforme, rapide, pro) est une **vraie valeur payante**. Il manque
**l'accueil, l'envoi, la récupération de compte et l'exploitation** pour transformer ce cœur en produit
qu'un artisan adopte et paie seul.

**Décision recommandée** : **ne pas lancer commercialement tout de suite** ; **finir la RC** (P0 +
accueil + envoi + recherche), **valider en bêta privée** que des artisans créent, envoient et
*reviennent*, **puis** décider la V1 avec un **positionnement « spécialiste du devis conforme »**, prix
d'entrée, **facturation en V1.1**, et l'**IA vocale comme vision** différenciante — pas comme promesse du
jour un.
