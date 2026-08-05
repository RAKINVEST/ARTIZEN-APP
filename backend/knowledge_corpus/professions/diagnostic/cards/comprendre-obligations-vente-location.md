# Comprendre les obligations (vente / location)

> **Brouillon (v0) — proposé par IA, en attente de validation métier** (Loi 7/18). Modèle : [../../../cards/CARD_TEMPLATE.md](../../../cards/CARD_TEMPLATE.md).
> Niveaux de confiance : A normes/fabricant · B technique · C terrain validé · D hypothèse. Rien n'est publié comme certitude.

## Métadonnées
| Champ | Valeur |
|---|---|
| Identifiant | `comprendre-obligations-vente-location` |
| Titre | Comprendre les obligations (vente / location) |
| Profession | `metier:diagnostic` |
| Famille | `famille:specialises` |
| Sous-famille | `sous-famille:diagnostic` |
| Version | v0.1 |
| Auteur | IA (proposition) |
| Validateur | ⟦à valider métier⟧ |
| Statut | Brouillon |
| Indice de confiance | **B** |

## Cadrage
- **Objectif** : comprendre **quels diagnostics sont obligatoires** selon la transaction (vente/location), le bien, son âge et sa zone. `[B]`
- **Résumé** : comprendre que les diagnostics exigibles dépendent du **type de transaction** (vente ou location), de la **nature/âge** du bien et de sa **localisation** (zones amiante/plomb/termites/ERP définies par arrêté) : DPE, amiante, plomb (CREP), état de l'installation gaz et électricité (selon ancienneté), ERP, mesurage, etc. ; ces obligations relèvent du **Code de la construction** — il s'agit de **savoir lesquels s'appliquent**, pas de les réaliser. `[B]` ⟦liste/seuils exacts selon réglementation à confirmer par un expert⟧

## Réalisation
- **Étapes** *(compréhension / lecture / décision — aucune méthode, mesure, prélèvement ni procédure de diagnostic décrite)* :
  1. Distinguer **vente / location** (diagnostics différents). `[A]`
  2. Tenir compte de l'**âge / nature / zone** du bien. `[A]`
  3. Constituer la **liste applicable** (DDT). `[C]` → [controle-dossier-diagnostic-technique](../../../checklists/diagnostic/controle-dossier-diagnostic-technique.md)
  4. Faire **réaliser** par un diagnostiqueur **certifié**. `[A]`
- **Points critiques** : diagnostics **applicables** identifiés (transaction/âge/zone) ; DDT complet ; réalisation = **certifié** ; jamais soi-même.
- **Sécurité** : risque juridique (diagnostic manquant) ; — ; — **Métier réglementé et certifié** : les diagnostics réglementaires (amiante, plomb, gaz, électricité, DPE, termites, ERP, mesurage) sont réalisés par des **diagnostiqueurs certifiés** (indépendance, assurance) — **ce Livre n'explique aucune méthode, mesure, prélèvement ni procédure de diagnostic**, il aide à **comprendre, organiser, lire et orienter**. **Les résultats révèlent des dangers** : présence d'**amiante** ou de **plomb** (→ travaux réservés / entreprises certifiées), **anomalies gaz/électricité** (→ risque incendie/électrisation, à faire lever par un professionnel), **termites** (→ traitement) — la **conduite à tenir** est d'**orienter** vers le professionnel compétent, jamais d'intervenir soi-même sur la base du rapport. **Ne jamais réaliser** un diagnostic réglementaire sans certification. **Documentation** : conserver le **dossier de diagnostic technique**. **Mise en sécurité immédiate** si un danger imminent est signalé. `[A]`

## Cadre & suites
- **Normes** : diagnostic de l'installation **électrique** intérieure **NF C 16-600** ; installation électrique de référence **NF C 15-100** ; cadre des diagnostics : **Code de la construction** (dossier de diagnostic technique / DDT), **Code de la santé publique** (amiante, plomb / CREP, ERP), **Code de l'énergie** (DPE, audit), **NF X46-020** (amiante), **NF P03-201** (termites), **Loi Carrez** (mesurage) et **certification des diagnostiqueurs** ⟦en prose, à confirmer⟧ `[B]` ⟦cadre réglementaire à confirmer par le validateur⟧. `respecte-norme`
- **Diagnostic manquant / périmé** : `cite-diagnostic` → [diagnostic-manquant-perime](../../../diagnostics/diagnostic/diagnostic-manquant-perime.md)

## Relations & tags
- **Tags** : `metier:diagnostic famille:specialises sous-famille:diagnostic intervention:comprendre cluster:obligations cluster:vente-location complexite:avancee type:principe securite:reglementaire`

## Historique
| Version | Date | Auteur | Validateur | Motif |
|---|---|---|---|---|
| v0.1 | 2026-08-05 | IA | ⟦—⟧ | proposition initiale (Brouillon) |
