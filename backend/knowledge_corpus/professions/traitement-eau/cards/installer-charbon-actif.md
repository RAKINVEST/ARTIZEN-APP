# Installer un filtre à charbon actif

> **Brouillon (v0) — proposé par IA, en attente de validation métier** (Loi 7/18). Modèle : [../../../cards/CARD_TEMPLATE.md](../../../cards/CARD_TEMPLATE.md).
> Niveaux de confiance : A normes/fabricant · B technique · C terrain validé · D hypothèse. Rien n'est publié comme certitude.

## Métadonnées
| Champ | Valeur |
|---|---|
| Identifiant | `installer-charbon-actif` |
| Titre | Installer un filtre à charbon actif |
| Profession | `metier:traitement-eau` |
| Famille | `famille:fluides` |
| Sous-famille | `sous-famille:traitement-eau` |
| Version | v0.1 |
| Auteur | IA (proposition) |
| Validateur | ⟦à valider métier⟧ |
| Statut | Brouillon |
| Indice de confiance | **C** |

## Cadrage
- **Objectif** : installer un filtre à **charbon actif** pour l'affinage (goût, odeur, chlore, certains micro-polluants). `[C]`
- **Résumé** : poser le filtre à **charbon actif** en affinage (après filtration sédiments), pour retenir chlore/goûts/odeurs et certains COV, en respectant le **débit** et surtout le **remplacement régulier** de la cartouche : un charbon saturé devient une **niche microbiologique** (risque sanitaire). `[C]` ⟦type/débit/fréquence selon usage à confirmer⟧

## Réalisation
- **Étapes** :
  1. Poser en **affinage** (après sédiments). `[C]`
  2. Respecter le **débit** (temps de contact). `[C]`
  3. **Remplacement régulier** impératif (saturation = microbiologie). `[A]`
  4. Désinfecter à l'installation/l'entretien. `[C]` → [mise-en-service-desinfection-traitement](../../../procedures/traitement-eau/mise-en-service-desinfection-traitement.md)
- **Points critiques** : **remplacement régulier** (charbon saturé = niche bactérienne) ; débit/temps de contact ; désinfection.
- **Sécurité** : sanitaire/microbiologique ; produits. **Qualité sanitaire de l'eau** : un traitement mal conçu/entretenu peut **dégrader** l'eau (développement **microbiologique** dans un filtre/adoucisseur, by-pass) → **entretien régulier obligatoire**, matériaux **ACS**. **Contamination** : désinfecter après intervention, ne pas laisser stagner. **Prévention des retours d'eau** : dispositif de **protection (disconnecteur/clapet)** sur les branchements de traitement (protection du réseau public). **Produits de traitement** (sel, réactifs, désinfectants) : EPI, stockage, dosage. **Pression** : réducteur/soupape, **purge avant intervention**. **Électricité des systèmes UV** : raccordement **réservé** à un professionnel. **Analyse d'eau** avant/après. **Arrêt immédiat en cas de danger.** Interventions réglementées **réservées aux professionnels compétents**.** `[A]`

## Cadre & suites
- **Normes** : installation sur réseau sanitaire **DTU 60.1** ; alimentation électrique des systèmes (UV) **NF C 15-100** ; protection contre les **retours d'eau** (**NF EN 1717**), qualité de l'eau (**arrêté du 11 janvier 2007**, Code de la santé), matériaux **ACS** ⟦en prose, à confirmer⟧ `[B]` ⟦références/versions exactes à confirmer par le validateur⟧. `respecte-norme`
- **Désinfection UV** : `cite-carte` → [installer-traitement-uv](installer-traitement-uv.md)

## Relations & tags
- **Tags** : `metier:traitement-eau famille:fluides sous-famille:traitement-eau intervention:poser cluster:charbon-actif cluster:filtres complexite:simple type:installation securite:sanitaire`

## Historique
| Version | Date | Auteur | Validateur | Motif |
|---|---|---|---|---|
| v0.1 | 2026-08-05 | IA | ⟦—⟧ | proposition initiale (Brouillon) |
