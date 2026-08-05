# Lire, interpréter un rapport et donner les suites

> **Brouillon (v0) — proposé par IA, en attente de validation métier** (Loi 7/18). Modèle : [../../../cards/CARD_TEMPLATE.md](../../../cards/CARD_TEMPLATE.md).
> Niveaux de confiance : A normes/fabricant · B technique · C terrain validé · D hypothèse. Rien n'est publié comme certitude.

## Métadonnées
| Champ | Valeur |
|---|---|
| Identifiant | `lire-interpreter-rapport-suites` |
| Titre | Lire, interpréter un rapport et donner les suites |
| Profession | `metier:diagnostic` |
| Famille | `famille:specialises` |
| Sous-famille | `sous-famille:diagnostic` |
| Version | v0.1 |
| Auteur | IA (proposition) |
| Validateur | ⟦à valider métier⟧ |
| Statut | Brouillon |
| Indice de confiance | **C** |

## Cadrage
- **Objectif** : savoir **lire** un rapport de diagnostic, en **interpréter** les conclusions et sa **durée de validité**, et donner les **suites**. `[C]`
- **Résumé** : savoir repérer dans un rapport les **conclusions** (conforme / anomalies / présence), la **localisation**, la **gravité** éventuelle et la **durée de validité** (variable selon le diagnostic), vérifier que le diagnostic est à jour, et en tirer les **suites** : information de l'acquéreur/locataire, **orientation** vers le corps d'état compétent (élec, gaz, désamiantage, traitement, isolation…), et coordination des travaux/nettoyage éventuels ; **le diagnostic informe, il ne répare pas**. `[C]` ⟦durées de validité selon diagnostic à confirmer⟧

## Réalisation
- **Étapes** *(compréhension / lecture / décision — aucune méthode, mesure, prélèvement ni procédure de diagnostic décrite)* :
  1. Repérer **conclusions / localisation / gravité**. `[C]`
  2. Vérifier la **durée de validité** (à jour ?). `[A]` → [diagnostic-manquant-perime](../../../diagnostics/diagnostic/diagnostic-manquant-perime.md)
  3. **Orienter** vers le corps d'état compétent. `[C]` → [anomalie-signalee-au-rapport](../../../diagnostics/diagnostic/anomalie-signalee-au-rapport.md)
  4. Coordonner travaux / **nettoyage** de fin de chantier. `[C]` → [principe-nettoyage](../../../professions/nettoyage/cards/principe-nettoyage.md)
- **Points critiques** : conclusions **interprétées** ; validité vérifiée ; **suites orientées** (bon professionnel) ; le diagnostic informe (ne répare pas).
- **Sécurité** : résultats révélant des dangers ; — ; — **Métier réglementé et certifié** : les diagnostics réglementaires (amiante, plomb, gaz, électricité, DPE, termites, ERP, mesurage) sont réalisés par des **diagnostiqueurs certifiés** (indépendance, assurance) — **ce Livre n'explique aucune méthode, mesure, prélèvement ni procédure de diagnostic**, il aide à **comprendre, organiser, lire et orienter**. **Les résultats révèlent des dangers** : présence d'**amiante** ou de **plomb** (→ travaux réservés / entreprises certifiées), **anomalies gaz/électricité** (→ risque incendie/électrisation, à faire lever par un professionnel), **termites** (→ traitement) — la **conduite à tenir** est d'**orienter** vers le professionnel compétent, jamais d'intervenir soi-même sur la base du rapport. **Ne jamais réaliser** un diagnostic réglementaire sans certification. **Documentation** : conserver le **dossier de diagnostic technique**. **Mise en sécurité immédiate** si un danger imminent est signalé. `[A]`

## Cadre & suites
- **Normes** : diagnostic de l'installation **électrique** intérieure **NF C 16-600** ; installation électrique de référence **NF C 15-100** ; cadre des diagnostics : **Code de la construction** (dossier de diagnostic technique / DDT), **Code de la santé publique** (amiante, plomb / CREP, ERP), **Code de l'énergie** (DPE, audit), **NF X46-020** (amiante), **NF P03-201** (termites), **Loi Carrez** (mesurage) et **certification des diagnostiqueurs** ⟦en prose, à confirmer⟧ `[B]` ⟦cadre réglementaire à confirmer par le validateur⟧. `respecte-norme`
- **Kit** : `utilise-kit` → [kit-organisation-diagnostics](../../../kits/diagnostic/kit-organisation-diagnostics.md)

## Relations & tags
- **Tags** : `metier:diagnostic famille:specialises sous-famille:diagnostic intervention:controler cluster:lecture-rapport cluster:duree-validite cluster:orientation complexite:moyenne type:controle securite:reglementaire relation:nettoyage`

## Historique
| Version | Date | Auteur | Validateur | Motif |
|---|---|---|---|---|
| v0.1 | 2026-08-05 | IA | ⟦—⟧ | proposition initiale (Brouillon) |
