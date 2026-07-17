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
| 1 | **Pas d'écran d'édition directe de l'identité d'entreprise** (raison sociale, SIRET, N° TVA, coordonnées, couleurs). Possible seulement via le flux « Importer un ancien devis ». L'API, elle, l'expose (`PUT /api/branding/company`, `/brand`). La promesse « renommer depuis Paramètres » de l'inscription n'est pas tenue en UI. | 🟢 | V3 |
| 2 | **Pas de téléversement de logo depuis l'app** (le logo est seulement *détecté* à l'import). L'API le permet (`POST /api/branding/logo`). | 🟢 | V3 |
| 3 | **Pas d'écran de détail client** : l'appui ouvre directement l'édition. | 🟢 | V2.x/V3 |
| 4 | **Catégories** : création + liste seulement, ni édition ni suppression en UI. | 🟢 | V2.x/V3 |
| 5 | **Pas de « mot de passe oublié » / réinitialisation.** | 🟢 | V3 |
| 6 | **Aucune édition d'un devis en place** : modification = suppression-recréation (brouillon) ou duplication. | 🔵 | — |
| 7 | **Écran Paramètres minimal** (serveur, version, import, déconnexion) — pas de préférences, thème, langue. | 🟢 | V3 |

## Cohérence des numéros de version (métadonnées)

| # | Limitation | Classe | Suite |
|---|---|---|---|
| 8 | **Les numéros de version divergent** (trois valeurs distinctes sur quatre emplacements) : backend `settings.VERSION = "0.1.0"` (Swagger, `/`, `/health`) ; frontend `pubspec.yaml` `version: 1.0.0+1` **et** écran Paramètres codé en dur **« 1.0.0 (MVP) »** ; tag Git **`v2.0.0-rc1`**. Purement métadonnée/affichage — aucun impact comportemental. À aligner sur `2.0.0` avant la publication finale. | 🟢 | V2.0 finale |

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
