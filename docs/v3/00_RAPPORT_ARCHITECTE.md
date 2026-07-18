# ARTIZEN V3 — Rapport d'architecte (lancement)

**Date : 2026-07-18.** Auteur : rôle Architecte + Product Owner + Lead Dev.
Branche `develop/v3` (créée depuis la V2 figée `v2.0.0` / `a978eb0`).
Ce rapport clôt la **phase d'analyse** ; aucun développement métier n'a
commencé. Documents détaillés : `01_AUDIT.md`, `02_ROADMAP.md`,
`03_IA_VOICE_TO_QUOTE.md`, `04_CONVENTIONS.md`.

## 1. Audit complet (synthèse)

Base saine et professionnelle : backend **7 444 LOC** (9 modules verticaux,
214 tests), frontend **6 233 LOC** (feature-first, Design System unique, 68
tests), 44 endpoints, 12 tables, 6 migrations. La V2 couvre *catalogue → devis
→ PDF* avec des invariants forts (calcul monétaire centralisé, multi-tenant
404, IA qui n'invente rien). Détail : `01_AUDIT.md`.

## 2. État réel de l'architecture

**Monolithe modulaire** propre, à modules verticaux miroir (backend/frontend),
avec infrastructure transverse isolée et **abstractions de fournisseur**
(IA/stockage) qui rendent l'app fonctionnelle sans configuration. Le **moteur
PDF** et le **calculateur** sont réutilisables tels quels pour les factures.
C'est une fondation **capable d'accueillir la V3 sans réécriture** — à
condition d'ajouter la couche asynchrone qui manque.

## 3. Dette technique

Par ordre de criticité : `python-jose` non maintenu (auth) ; rate limiting en
mémoire par worker ; **absence de file de tâches asynchrones** (bloquant pour
l'IA) ; tests sans isolation ; cycle de modules `users ↔ branding` ; pas de
CI/CD ; parsing IA tout-ou-rien. Aucune n'est bloquante pour la V2, toutes sont
à traiter **avant ou pendant** les fondations V3.

## 4. Modules proposés (14)

IA vocale (priorité), Facturation, Paiement, Signature électronique, OCR, CRM,
Agenda, Chantier, Comptabilité, Dashboard BI, Notifications, Synchronisation
offline, Mobile natif, Administration/SaaS. Précédés d'un **socle de
fondations** (file async, Redis, auth durcie, module `companies`, S3, CI/CD,
isolation des tests). Détail par module : `02_ROADMAP.md`.

## 5. Roadmap détaillée

**Sprint 0 — Fondations** (F1 file de tâches, F2 Redis, F3 auth PyJWT+cookie)
→ **M1 IA vocale** → **M2 Facturation** → **M10 Dashboard + M11 Notifications**
→ **M3 Paiement + M6 CRM + M14 Admin** → **M4 Signature + M7 Agenda** → **M5
OCR + M8 Chantier** → **M9 Comptabilité + M12 Offline**. Une fonctionnalité à
la fois, terminée (archi→code→tests→casse→doc) avant la suivante.

## 6. Priorités

1. **Fondations asynchrones** (sans elles, l'IA gèle les requêtes).
2. **IA « devis vocal »** — la promesse produit différenciante.
3. **Facturation** — ferme la chaîne commerciale et répond à une obligation
   légale (numérotation sans trou, Factur-X).
Puis Dashboard/Notifications (ROI rapide), Paiement/CRM/Admin (monétisation),
le reste selon `02_ROADMAP.md`.

## 7. Vision V3

**Du premier appel au paiement, piloté par l'IA.** L'artisan parle, l'IA
comprend, associe le catalogue, construit le devis, propose des variantes,
prépare l'email ; le devis accepté devient facture, la facture est payée en
ligne et signée électroniquement ; le tableau de bord montre le pipeline et la
marge ; le tout utilisable sur le terrain, y compris hors ligne. ARTIZEN
devient l'outil unique de l'artisan — **la référence de son métier**.

## 8. Estimation globale

Fondations : ~4-6 SP. Modules métier : ~55-75 SP cumulés (voir estimations par
module). En séquence disciplinée (un module à la fois, qualité V2), la V3
« cœur commercial » (Fondations + IA + Facturation + Dashboard + Notifications
+ Paiement) représente l'essentiel de la valeur pour ~30-40 SP ; le reste
étend le produit. Ordre de grandeur, à réviser à chaque fin de module.

## 9. Risques

- **Latence/coût IA** et qualité de transcription en chantier → pipeline async,
  budgets, dégradation manuelle, re-validation catalogue.
- **Conformité facturation** (numérotation légale, Factur-X 2026-2027) →
  structurante, à cadrer tôt.
- **RGPD** (audio, transcriptions, données clients) → chiffrement, rétention,
  effacement.
- **Dette d'auth** (python-jose) → bloquante en cas d'audit sécurité.
- **Absence de CI/CD** → régressions à mesure que le périmètre croît.
- **Offline** = chantier à part entière (conflits de sync) — ne pas sous-estimer.

## 10. Recommandations

1. **Ne pas coder de module métier avant les fondations async** (F1/F2) : c'est
   le prérequis structurel de l'IA et de tout traitement lourd.
2. **Conserver les invariants et le Design System à la lettre** — c'est ce qui
   fait la qualité perçue « produit commercial ».
3. **Mettre en place la CI dès le sprint 0** pour tenir les portes vertes.
4. **Traiter l'auth (PyJWT) et l'isolation des tests** tôt (dette peu coûteuse
   maintenant, chère plus tard).
5. **Cadrer la conformité facturation** avec le besoin réel (statut e-invoicing
   FR) avant M2 — potentielle décision métier à confirmer.
6. **Livrer par valeur** : IA + Facturation + Dashboard donnent un produit
   vendable rapidement ; le reste est incrémental.

---

**Conclusion.** L'architecture V2 est saine et extensible ; moyennant une
couche asynchrone et le durcissement de quelques dettes, elle peut porter
ARTIZEN **plusieurs années sans remise en cause majeure**. La phase d'analyse
est terminée : le développement métier V3 peut démarrer par les fondations,
puis l'IA vocale, **sur validation de cette architecture**.
