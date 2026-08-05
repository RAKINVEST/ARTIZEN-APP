# Installer un traitement UV (désinfection)

> **Brouillon (v0) — proposé par IA, en attente de validation métier** (Loi 7/18). Modèle : [../../../cards/CARD_TEMPLATE.md](../../../cards/CARD_TEMPLATE.md).
> Niveaux de confiance : A normes/fabricant · B technique · C terrain validé · D hypothèse. Rien n'est publié comme certitude.

## Métadonnées
| Champ | Valeur |
|---|---|
| Identifiant | `installer-traitement-uv` |
| Titre | Installer un traitement UV (désinfection) |
| Profession | `metier:traitement-eau` |
| Famille | `famille:fluides` |
| Sous-famille | `sous-famille:traitement-eau` |
| Version | v0.1 |
| Auteur | IA (proposition) |
| Validateur | ⟦à valider métier⟧ |
| Statut | Brouillon |
| Indice de confiance | **C** |

## Cadrage
- **Objectif** : installer un stérilisateur **UV** pour la désinfection de l'eau (bactéries/virus), sans produit chimique. `[C]`
- **Résumé** : poser le réacteur **UV** en fin de chaîne (après filtration/affinage pour une eau **claire**), dimensionné au **débit**, avec une **alimentation électrique réalisée par un professionnel** (protection) ; la lampe UV inactive les micro-organismes **sans effet rémanent** → pas de protection en aval, remplacement annuel de la lampe. `[C]` ⟦dose UV/débit selon appareil à confirmer⟧

## Réalisation
- **Étapes** :
  1. Poser en **fin de chaîne** (eau claire : filtrer avant). `[C]`
  2. Dimensionner au **débit** (dose UV suffisante). `[C]` ⟦à confirmer⟧
  3. **Alimentation électrique** = **professionnel** (protection). `[A]` → [controler-tableau-electrique](../../../professions/electricite-generale/cards/controler-tableau-electrique.md)
  4. Remplacer la **lampe** (annuel) ; pas d'effet rémanent. `[C]`
- **Points critiques** : eau **claire** avant l'UV (turbidité = inefficace) ; débit/dose ; **pas de rémanence** (recontamination en aval possible) ; élec réservée.
- **Sécurité** : **électricité (UV)** ; UV (protection yeux) ; sanitaire. **Qualité sanitaire de l'eau** : un traitement mal conçu/entretenu peut **dégrader** l'eau (développement **microbiologique** dans un filtre/adoucisseur, by-pass) → **entretien régulier obligatoire**, matériaux **ACS**. **Contamination** : désinfecter après intervention, ne pas laisser stagner. **Prévention des retours d'eau** : dispositif de **protection (disconnecteur/clapet)** sur les branchements de traitement (protection du réseau public). **Produits de traitement** (sel, réactifs, désinfectants) : EPI, stockage, dosage. **Pression** : réducteur/soupape, **purge avant intervention**. **Électricité des systèmes UV** : raccordement **réservé** à un professionnel. **Analyse d'eau** avant/après. **Arrêt immédiat en cas de danger.** Interventions réglementées **réservées aux professionnels compétents**.** `[A]`

## Cadre & suites
- **Normes** : installation sur réseau sanitaire **DTU 60.1** ; alimentation électrique des systèmes (UV) **NF C 15-100** ; protection contre les **retours d'eau** (**NF EN 1717**), qualité de l'eau (**arrêté du 11 janvier 2007**, Code de la santé), matériaux **ACS** ⟦en prose, à confirmer⟧ `[B]` ⟦références/versions exactes à confirmer par le validateur⟧. `respecte-norme`
- **Traitement inefficace** : `traite-diagnostic` → [traitement-inefficace-contamination](../../../diagnostics/traitement-eau/traitement-inefficace-contamination.md)

## Relations & tags
- **Tags** : `metier:traitement-eau famille:fluides sous-famille:traitement-eau intervention:poser cluster:traitement-uv cluster:desinfection complexite:avancee type:installation securite:electrique relation:electricite-generale`

## Historique
| Version | Date | Auteur | Validateur | Motif |
|---|---|---|---|---|
| v0.1 | 2026-08-05 | IA | ⟦—⟧ | proposition initiale (Brouillon) |
