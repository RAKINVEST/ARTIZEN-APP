# Entretenir / contrôler un traitement d'eau

> **Brouillon (v0) — proposé par IA, en attente de validation métier** (Loi 7/18). Modèle : [../../../cards/CARD_TEMPLATE.md](../../../cards/CARD_TEMPLATE.md).
> Niveaux de confiance : A normes/fabricant · B technique · C terrain validé · D hypothèse. Rien n'est publié comme certitude.

## Métadonnées
| Champ | Valeur |
|---|---|
| Identifiant | `entretenir-controler-traitement-eau` |
| Titre | Entretenir / contrôler un traitement d'eau |
| Profession | `metier:traitement-eau` |
| Famille | `famille:fluides` |
| Sous-famille | `sous-famille:traitement-eau` |
| Version | v0.1 |
| Auteur | IA (proposition) |
| Validateur | ⟦à valider métier⟧ |
| Statut | Brouillon |
| Indice de confiance | **C** |

## Cadrage
- **Objectif** : entretenir et contrôler une installation de traitement (cartouches, sel, membrane, lampe UV) et la **qualité de l'eau** (analyses). `[C]`
- **Résumé** : remplacer/rincer les **cartouches** et préfiltres, regarnir le **sel**, contrôler la régénération de l'adoucisseur, changer la **membrane**/la **lampe UV** aux échéances, désinfecter, et faire **analyser l'eau** (avant/après) pour vérifier l'efficacité et l'absence de dégradation. `[C]` ⟦fréquences selon appareils à confirmer⟧

## Réalisation
- **Étapes** :
  1. Remplacer/rincer **cartouches/préfiltres** ; sel ; membrane/lampe UV. `[C]`
  2. Contrôler régénération adoucisseur / TH de sortie. `[C]` → [eau-dure-tartre](../../../diagnostics/traitement-eau/eau-dure-tartre.md)
  3. **Désinfecter** ; vérifier la **protection retours d'eau**. `[C]`
  4. **Analyse d'eau** (efficacité / absence de dégradation). `[A]`
- **Points critiques** : entretien **régulier = qualité sanitaire** ; analyses de contrôle ; ne pas laisser un traitement dégrader l'eau.
- **Sécurité** : sanitaire/microbiologique ; produits ; électricité (UV). **Qualité sanitaire de l'eau** : un traitement mal conçu/entretenu peut **dégrader** l'eau (développement **microbiologique** dans un filtre/adoucisseur, by-pass) → **entretien régulier obligatoire**, matériaux **ACS**. **Contamination** : désinfecter après intervention, ne pas laisser stagner. **Prévention des retours d'eau** : dispositif de **protection (disconnecteur/clapet)** sur les branchements de traitement (protection du réseau public). **Produits de traitement** (sel, réactifs, désinfectants) : EPI, stockage, dosage. **Pression** : réducteur/soupape, **purge avant intervention**. **Électricité des systèmes UV** : raccordement **réservé** à un professionnel. **Analyse d'eau** avant/après. **Arrêt immédiat en cas de danger.** Interventions réglementées **réservées aux professionnels compétents**.** `[A]`

## Cadre & suites
- **Normes** : installation sur réseau sanitaire **DTU 60.1** ; alimentation électrique des systèmes (UV) **NF C 15-100** ; protection contre les **retours d'eau** (**NF EN 1717**), qualité de l'eau (**arrêté du 11 janvier 2007**, Code de la santé), matériaux **ACS** ⟦en prose, à confirmer⟧ `[B]` ⟦références/versions exactes à confirmer par le validateur⟧. `respecte-norme`
- **Kit** : `utilise-kit` → [kit-traitement-eau](../../../kits/traitement-eau/kit-traitement-eau.md)

## Relations & tags
- **Tags** : `metier:traitement-eau famille:fluides sous-famille:traitement-eau intervention:entretenir intervention:controler cluster:entretien cluster:maintenance cluster:analyses cluster:controle complexite:moyenne type:entretien securite:sanitaire`

## Historique
| Version | Date | Auteur | Validateur | Motif |
|---|---|---|---|---|
| v0.1 | 2026-08-05 | IA | ⟦—⟧ | proposition initiale (Brouillon) |
