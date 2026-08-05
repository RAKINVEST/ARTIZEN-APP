# Comprendre les diagnostics gaz et électricité

> **Brouillon (v0) — proposé par IA, en attente de validation métier** (Loi 7/18). Modèle : [../../../cards/CARD_TEMPLATE.md](../../../cards/CARD_TEMPLATE.md).
> Niveaux de confiance : A normes/fabricant · B technique · C terrain validé · D hypothèse. Rien n'est publié comme certitude.

## Métadonnées
| Champ | Valeur |
|---|---|
| Identifiant | `comprendre-gaz-electricite` |
| Titre | Comprendre les diagnostics gaz et électricité |
| Profession | `metier:diagnostic` |
| Famille | `famille:specialises` |
| Sous-famille | `sous-famille:diagnostic` |
| Version | v0.1 |
| Auteur | IA (proposition) |
| Validateur | ⟦à valider métier⟧ |
| Statut | Brouillon |
| Indice de confiance | **C** |

## Cadrage
- **Objectif** : comprendre les **états des installations intérieures de gaz et d'électricité** : contenu, anomalies, suites. `[C]`
- **Résumé** : comprendre que l'**état de l'installation électrique intérieure** (**NF C 16-600**, installations de plus de 15 ans) et l'**état de l'installation intérieure de gaz** relèvent des risques d'**électrisation/incendie** et d'**intoxication/explosion** ; savoir **lire les anomalies** signalées (et leur gravité) et en tirer les **suites** : faire **lever les anomalies** par un **électricien** ou un **professionnel gaz/chauffagiste** — le diagnostic constate, il ne répare pas ; danger imminent = **mise en sécurité**. `[C]` ⟦anomalies/gravité selon NF C 16-600 à confirmer⟧

## Réalisation
- **Étapes** *(compréhension / lecture / décision — aucune méthode, mesure, prélèvement ni procédure de diagnostic décrite)* :
  1. Comprendre l'**état électrique** (NF C 16-600, >15 ans). `[A]` → [controler-tableau-electrique](../../../professions/electricite-generale/cards/controler-tableau-electrique.md)
  2. Comprendre l'**état gaz** (risque intoxication/explosion). `[A]` → [entretenir-chaudiere](../../../professions/chauffage/cards/entretenir-chaudiere.md)
  3. **Lire** les anomalies et leur gravité. `[C]` → [anomalie-signalee-au-rapport](../../../diagnostics/diagnostic/anomalie-signalee-au-rapport.md)
  4. Suites : lever par **électricien / pro gaz** (danger = mise en sécurité). `[A]`
- **Points critiques** : anomalies **lues** (gravité) ; danger élec/gaz compris ; suites = **professionnel** ; danger imminent = mise en sécurité.
- **Sécurité** : électrisation/incendie ; gaz (intoxication/explosion) ; — **Métier réglementé et certifié** : les diagnostics réglementaires (amiante, plomb, gaz, électricité, DPE, termites, ERP, mesurage) sont réalisés par des **diagnostiqueurs certifiés** (indépendance, assurance) — **ce Livre n'explique aucune méthode, mesure, prélèvement ni procédure de diagnostic**, il aide à **comprendre, organiser, lire et orienter**. **Les résultats révèlent des dangers** : présence d'**amiante** ou de **plomb** (→ travaux réservés / entreprises certifiées), **anomalies gaz/électricité** (→ risque incendie/électrisation, à faire lever par un professionnel), **termites** (→ traitement) — la **conduite à tenir** est d'**orienter** vers le professionnel compétent, jamais d'intervenir soi-même sur la base du rapport. **Ne jamais réaliser** un diagnostic réglementaire sans certification. **Documentation** : conserver le **dossier de diagnostic technique**. **Mise en sécurité immédiate** si un danger imminent est signalé. `[A]`

## Cadre & suites
- **Normes** : diagnostic de l'installation **électrique** intérieure **NF C 16-600** ; installation électrique de référence **NF C 15-100** ; cadre des diagnostics : **Code de la construction** (dossier de diagnostic technique / DDT), **Code de la santé publique** (amiante, plomb / CREP, ERP), **Code de l'énergie** (DPE, audit), **NF X46-020** (amiante), **NF P03-201** (termites), **Loi Carrez** (mesurage) et **certification des diagnostiqueurs** ⟦en prose, à confirmer⟧ `[B]` ⟦cadre réglementaire à confirmer par le validateur⟧. `respecte-norme`
- **Termites / ERP** : `cite-carte` → [comprendre-termites-erp](comprendre-termites-erp.md)

## Relations & tags
- **Tags** : `metier:diagnostic famille:specialises sous-famille:diagnostic intervention:comprendre cluster:electricite cluster:gaz complexite:avancee type:principe securite:reglementaire relation:electricite-generale relation:chauffage`

## Historique
| Version | Date | Auteur | Validateur | Motif |
|---|---|---|---|---|
| v0.1 | 2026-08-05 | IA | ⟦—⟧ | proposition initiale (Brouillon) |
