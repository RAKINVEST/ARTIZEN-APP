# Limitations connues — ARTIZEN V2.0.0-RC1

Inventaire **honnête** des limites de la Release Candidate, chacune classée.
Aucune n'est **bloquante** ni **majeure** au sens produit (rien n'empêche un
artisan d'utiliser Artizen de bout en bout — prouvé en UAT). Les corrections
sont planifiées pour une V2.x ou la V3 ; **aucune n'est appliquée sur RC1**
(gel de la Release Candidate).

## Classification

- 🟢 **Mineure** : gêne cosmétique ou de confort, sans impact sur les
  données, la sécurité ni la promesse produit.
- 🔵 **Par conception** : ce n'est pas un défaut, c'est un choix assumé et
  documenté.

## Fonctionnel — application Flutter

| # | Limitation | Classe | Suite |
|---|---|---|---|
| 1 | ~~**Pas d'écran d'édition directe de l'identité d'entreprise**~~ — **✅ Résolu (déjà livré, constat 2026-07)** : l'écran « Mon entreprise » (`/company-profile`, atteignable depuis Paramètres, dashboard, app-shell, readiness gate) édite raison sociale, forme juridique, SIRET, RCS, APE, TVA, coordonnées, régime TVA, assurance décennale, RGE, conditions, validité + signature/tampon. Reste hors écran : **logo et couleurs** (→ #2). | 🟢 | **Fait** |
| 2 | ~~Pas de téléversement de logo~~ **✅ Logo livré** : import/remplacement/suppression du logo depuis « Mon entreprise » (section « Logo, signature & tampon »), en miroir du pattern signature/tampon. Reste : **édition des couleurs** (primaire/secondaire) détectées à l'import mais non ré-éditables — `updateBrandProfile` (PUT /branding/brand) existe déjà côté repository, seule l'UI manque. | 🟢 | Logo **fait** ; couleurs → **V1.x** |
| 3 | **Pas d'écran de détail client** : l'appui ouvre directement l'édition. | 🟢 | V1.x |
| 4 | **Catégories** : création + liste seulement, ni édition ni suppression en UI. | 🟢 | V1.x |
| 5 | ~~Pas de « mot de passe oublié »~~ **✅ Livré (constat 2026-07)** : bouton « Mot de passe oublié ? » (login) → `/forgot-password`, puis `/reset-password?token=`. Backend `app/email/` (providers **mock + smtp**, repli sans config), migration `add_user_password_reset_token`, `test_password_reset.py` + `test_email_smtp.py` ; 12 tests Flutter verts. Reste : activer un vrai SMTP au déploiement (config, pas code). | 🟢 | **Fait** (SMTP réel → G5) |
| 6 | **Aucune édition d'un devis en place** : modification = suppression-recréation (brouillon) ou duplication. | 🔵 | — (par conception) |
| 7 | **Écran Paramètres minimal** (serveur, version, import, déconnexion) — pas de préférences, thème, langue. | 🟢 | V1.x |

> **Règle de périmètre V1 (décision PO, 2026-07 — MEP G2-T01).** *Une fonctionnalité
> est requise en V1 si son absence empêche un artisan honnête d'utiliser ARTIZEN
> seul, de bout en bout, sans contacter le support ; sinon elle relève de la V1.x.*
> Appliquée au backlog : **#1 édition d'identité**, **#2 upload logo**, **#5 mot de
> passe oublié** → **V1 requis** (sans eux, l'artisan est bloqué : identité mal
> détectée non corrigeable, logo absent non ajoutable, compte verrouillé). #3, #4,
> #7 → V1.x (conforts, contournables). #6 est un choix de conception (dupliquer /
> recréer), pas un manque.

## Restitution d'identité — écart promesse / moteur (découverte 2026-07-27)

Découvert en traçant le flux d'identité de bout en bout (import → stockage →
devis généré). **Deux mondes coexistent et ne sont pas connectés :**

- **Le produit live** (parcours de l'artisan) : `document_analysis` +
  `document_detection` (pypdf + Pillow). Il capture et restitue réellement, sur
  chaque devis généré : le **logo** (`template_import/service.py:141-144` →
  `BrandProfile.logo_path` → `html_renderer.py:252`), les **couleurs** primaire/
  secondaire (`service.py:130-132` → renderer) et les **coordonnées** de
  l'entreprise (nom, SIRET, TVA, adresse… → en-tête/pied). Rien d'autre.
- **Le moteur P1 de clonage** (Platine sur 4 familles) — extracteur `.artizen`,
  comparateur, renderer déterministe de `document_clone/` — est **hors-ligne** :
  aucun routeur HTTP ne l'appelle, il ne sert qu'au corpus/benchmark. La
  typographie, la mise en page et le gabarit du document importé qu'il sait
  reproduire **ne sont ni captés, ni stockés, ni restitués par le produit**
  (le modèle `DetectionResult` n'a aucun champ police / signature ; le layout du
  PDF généré est un gabarit figé, `html_renderer.py:126-247`).

**Défaut corrigé (autonome, car vrai quel que soit le futur).** L'écran de
reconnaissance affichait en dur « Votre typographie retrouvée / Votre mise en
page retrouvée / Votre signature documentaire retrouvée » — trois promesses sans
aucune donnée derrière, au moment le plus émotionnel du parcours. C'était une
violation directe de la règle d'or (« je ne vois pas la différence avec le
mien »). La liste est désormais **pilotée par les données** : elle ne montre que
le logo, les couleurs et les coordonnées réellement retrouvés. Garde-fous :
deux tests widget échouent si un libellé non adossé réapparaît.

| # | Limitation | Classe | Suite |
|---|---|---|---|
| 16 | **Le produit restitue le logo, les couleurs et les coordonnées — pas la typographie, la mise en page ni la signature.** Le moteur qui sait les reproduire est hors-ligne (gelé jusqu'au Starter Corpus, ADR-021). L'écran ne promet plus que le réel. | 🔵 | **Décision PO** |
| 17 | **Couleur claire silencieusement remplacée** : `html_renderer.py:105-109` rebascule sur le navy/doré maison si la luminance sort d'une fenêtre (lisibilité). Une charte pastel importée peut donc ne pas être restituée alors que l'écran annonce « couleurs retrouvées ». | 🟢 | **Décision PO** (lisibilité vs fidélité) |

> **Ce qui reste à décider (stratégique, t'appartient).** Deux forks ouverts par
> cette découverte : **(A)** câbler le moteur P1 au produit pour restituer
> vraiment typographie + mise en page (majeur, dépend du Starter Corpus) ou
> **(B)** assumer un produit « logo + couleurs + coordonnées » et garder l'écran
> honnête tel qu'il est ; et la **politique couleur** du #17 (adapter
> lisiblement la couleur de l'artisan vs la remplacer par la charte maison).

## Cohérence des numéros de version (métadonnées)

| # | Limitation | Classe | Suite |
|---|---|---|---|
| 8 | ~~**Les numéros de version divergent** (backend `0.1.0`, frontend `1.0.0`, tag `2.0.0-rc1`)~~. **✅ Résolu en RC2** (`v2.0.0-rc2`) : backend `config.py::VERSION`, `pubspec.yaml` et écran Paramètres alignés sur **`2.0.0`**. Métadonnée d'affichage seule, aucun impact comportemental. | 🟢 | **Fait (RC2)** |

> Ces incohérences sont **cosmétiques** et n'affectent ni les données, ni la
> sécurité, ni le comportement. Elles sont laissées telles quelles sur RC1
> (gel), et signalées pour alignement dès la première itération autorisée.

## Sécurité (détail dans `SECURITY.md`)

| # | Limitation | Classe | Suite |
|---|---|---|---|
| 9 | **Rate limiting en mémoire par worker** (plafond réel ≈ 4× avec 4 workers) et fondé sur l'IP du socket (inopérant derrière un proxy sans `X-Forwarded-For`). Ferme néanmoins le trou d'énumération. | 🟢 | V3 (Redis) |
| 10 | **JWT en `localStorage`** sur le web : lisible par un XSS. Cookie `HttpOnly` prévu. | 🟢 | V3 |
| 11 | **`python-jose` non maintenu** (2021). Crypto vérifiée ; migration PyJWT prévue. | 🟢 | V3 |
| 12 | **Corps chunké non borné** : le garde lit `Content-Length`. Un reverse proxy le ferme. | 🟢 | V3 / proxy |

## Architecture &amp; qualité interne

| # | Limitation | Classe | Suite |
|---|---|---|---|
| 13 | **Cycle de modules `users ↔ branding`** (`Company` vit dans `branding`, mais l'inscription en crée une). Aucun cycle à l'import (l'app démarre, toute la suite le prouve) ; seule entorse au « sens unique ». | 🔵/🟢 | V3 (extraire `companies`) |
| 14 | **Tests backend sans isolation** : ils tournent contre la vraie base, sans rollback par test ; les lignes persistent entre exécutions. Limite assumée. | 🔵 | V3 |
| 15 | **Commentaire périmé** dans `branding_providers.dart` (affirme que Paramètres surveille `brandingProfileNotifierProvider` — faux ; ce provider n'est consommé que par l'import de modèle). | 🟢 | V2.x |
| 18 | **Reproductibilité binaire du PDF non garantie par défaut** : reportlab/weasyprint embarquent des métadonnées de génération (horodatage, identifiant). Le déterminisme est **fonctionnel** ; l'identité **octet-pour-octet** exige la neutralisation des métadonnées (MEP G5-T01), sinon l'identité est **perceptuelle**. Ne jamais dédupliquer par hash de PDF sans ce durcissement. | 🔵/🟢 | G5 (durcissement) |

## Dettes techniques acceptées au gel d'architecture (2026-07)

Au gel de l'architecture, les dettes suivantes sont **formellement acceptées** —
bornées, sans blocage du développement, avec propriétaire — plutôt que corrigées.
Les geler explicitement évite de les bénir silencieusement comme « correctes ».

| Dette | Pourquoi acceptable | Propriétaire |
|---|---|---|
| Cycle `users ↔ branding` (#13) | Aucun cycle à l'import ; l'app démarre, toute la suite le prouve. Correction = refactoring (`Company` hors `branding`), coûteux, non urgent. | V3 |
| Tests backend sans isolation (#14) | Documenté ; les tests passent ; l'isolation par test est un confort, pas une exigence de correction. | V3 |
| Rate-limit en mémoire par worker (#9) | Ferme le trou d'énumération ; suffisant en mono-worker. Redis attend l'échelle. | V3 / déploiement |
| Reproductibilité binaire du PDF (#18) | Le déterminisme fonctionnel suffit au produit ; l'identité binaire est un durcissement d'industrialisation, pas une refonte. | G5 |

## Non éprouvé (ni un défaut, ni une garantie)

- **Montée en charge sous concurrence réelle** : pas d'épreuve de charge (les
  chemins concurrents ont des tests `asyncio.gather` et ont tenu sous un
  rejeu réel double en UAT).
- **Multi-navigateur** : l'UAT a piloté Chrome ; Firefox/Safari non exercés.
- **Audit de sécurité externe** : non réalisé.

## Périmètre volontairement absent (pas des limitations — de la roadmap)

Factures, avoirs, bons de commande, statuts `FACTURÉ/PAYÉ/ARCHIVÉ` : **non
implémentés**, mais le moteur PDF et l'architecture de statuts sont conçus
pour les accueillir sans réécriture. Voir `docs/ROADMAP.md`.
