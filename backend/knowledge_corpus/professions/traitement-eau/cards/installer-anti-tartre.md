# Installer un anti-tartre (physique)

> **Brouillon (v0) — proposé par IA, en attente de validation métier** (Loi 7/18). Modèle : [../../../cards/CARD_TEMPLATE.md](../../../cards/CARD_TEMPLATE.md).
> Niveaux de confiance : A normes/fabricant · B technique · C terrain validé · D hypothèse. Rien n'est publié comme certitude.

## Métadonnées
| Champ | Valeur |
|---|---|
| Identifiant | `installer-anti-tartre` |
| Titre | Installer un anti-tartre (physique) |
| Profession | `metier:traitement-eau` |
| Famille | `famille:fluides` |
| Sous-famille | `sous-famille:traitement-eau` |
| Version | v0.1 |
| Auteur | IA (proposition) |
| Validateur | ⟦à valider métier⟧ |
| Statut | Brouillon |
| Indice de confiance | **C** |

## Cadrage
- **Objectif** : installer un dispositif anti-tartre (physique/magnétique/CO₂) comme alternative à l'adoucisseur (ne retire pas le calcium). `[C]`
- **Résumé** : poser le dispositif **anti-tartre** (magnétique/électronique/injection CO₂) qui vise à limiter l'entartrage **sans échange d'ions** (l'eau garde son calcium) ; solution sans sel/sans rejet, d'**efficacité variable selon la technologie** (à objectiver) ; pas de développement microbiologique lié au sel. `[C]` ⟦efficacité/technologie à objectiver et confirmer⟧

## Réalisation
- **Étapes** :
  1. Choisir la **technologie** (magnétique/électronique/CO₂). `[C]` ⟦efficacité à objectiver⟧
  2. Poser sur l'arrivée (selon notice) ; sans sel/sans rejet. `[C]`
  3. Ne **retire pas** le calcium (eau non adoucie). `[C]`
  4. Comparer à l'adoucisseur selon le besoin. `[D]` → [installer-adoucisseur](installer-adoucisseur.md)
- **Points critiques** : l'eau **garde son calcium** (pas d'adoucissement) ; efficacité **variable/à objectiver** ; ne pas sur-promettre au client.
- **Sécurité** : produits (CO₂) ; électricité (électronique) ; sanitaire. **Qualité sanitaire de l'eau** : un traitement mal conçu/entretenu peut **dégrader** l'eau (développement **microbiologique** dans un filtre/adoucisseur, by-pass) → **entretien régulier obligatoire**, matériaux **ACS**. **Contamination** : désinfecter après intervention, ne pas laisser stagner. **Prévention des retours d'eau** : dispositif de **protection (disconnecteur/clapet)** sur les branchements de traitement (protection du réseau public). **Produits de traitement** (sel, réactifs, désinfectants) : EPI, stockage, dosage. **Pression** : réducteur/soupape, **purge avant intervention**. **Électricité des systèmes UV** : raccordement **réservé** à un professionnel. **Analyse d'eau** avant/après. **Arrêt immédiat en cas de danger.** Interventions réglementées **réservées aux professionnels compétents**.** `[A]`

## Cadre & suites
- **Normes** : installation sur réseau sanitaire **DTU 60.1** ; alimentation électrique des systèmes (UV) **NF C 15-100** ; protection contre les **retours d'eau** (**NF EN 1717**), qualité de l'eau (**arrêté du 11 janvier 2007**, Code de la santé), matériaux **ACS** ⟦en prose, à confirmer⟧ `[B]` ⟦références/versions exactes à confirmer par le validateur⟧. `respecte-norme`
- **Diagnostic entartrage** : `traite-diagnostic` → [eau-dure-tartre](../../../diagnostics/traitement-eau/eau-dure-tartre.md)

## Relations & tags
- **Tags** : `metier:traitement-eau famille:fluides sous-famille:traitement-eau intervention:poser cluster:anti-tartre complexite:simple type:installation securite:sanitaire`

## Historique
| Version | Date | Auteur | Validateur | Motif |
|---|---|---|---|---|
| v0.1 | 2026-08-05 | IA | ⟦—⟧ | proposition initiale (Brouillon) |
