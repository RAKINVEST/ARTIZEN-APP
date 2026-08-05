# Installer une filtration sédiments

> **Brouillon (v0) — proposé par IA, en attente de validation métier** (Loi 7/18). Modèle : [../../../cards/CARD_TEMPLATE.md](../../../cards/CARD_TEMPLATE.md).
> Niveaux de confiance : A normes/fabricant · B technique · C terrain validé · D hypothèse. Rien n'est publié comme certitude.

## Métadonnées
| Champ | Valeur |
|---|---|
| Identifiant | `installer-filtration-sediments` |
| Titre | Installer une filtration sédiments |
| Profession | `metier:traitement-eau` |
| Famille | `famille:fluides` |
| Sous-famille | `sous-famille:traitement-eau` |
| Version | v0.1 |
| Auteur | IA (proposition) |
| Validateur | ⟦à valider métier⟧ |
| Statut | Brouillon |
| Indice de confiance | **C** |

## Cadrage
- **Objectif** : installer un filtre à sédiments (cartouche ou lavable) pour protéger l'installation des particules. `[C]`
- **Résumé** : poser le **filtre** (porte-cartouche ou filtre lavable) en tête d'installation, choisir la **finesse** adaptée (µm), prévoir un **by-pass** et l'accès pour le remplacement/rinçage, et planifier le changement régulier (colmatage = perte de pression et risque sanitaire). `[C]` ⟦finesse/débit selon eau à confirmer⟧

## Réalisation
- **Étapes** :
  1. Poser le filtre en **tête** ; by-pass ; sens de passage. `[C]`
  2. Choisir la **finesse** (µm) adaptée (sédiments/sable). `[C]` ⟦à confirmer⟧
  3. Prévoir l'accès (changement cartouche / rinçage). `[C]`
  4. Planifier le **remplacement** (colmatage). `[C]` → [controle-maintenance-traitement-eau](../../../checklists/traitement-eau/controle-maintenance-traitement-eau.md)
- **Points critiques** : finesse adaptée ; **changement régulier** (un filtre colmaté = perte de pression + niche microbiologique) ; by-pass.
- **Sécurité** : sanitaire (stagnation) ; pression ; produits. **Qualité sanitaire de l'eau** : un traitement mal conçu/entretenu peut **dégrader** l'eau (développement **microbiologique** dans un filtre/adoucisseur, by-pass) → **entretien régulier obligatoire**, matériaux **ACS**. **Contamination** : désinfecter après intervention, ne pas laisser stagner. **Prévention des retours d'eau** : dispositif de **protection (disconnecteur/clapet)** sur les branchements de traitement (protection du réseau public). **Produits de traitement** (sel, réactifs, désinfectants) : EPI, stockage, dosage. **Pression** : réducteur/soupape, **purge avant intervention**. **Électricité des systèmes UV** : raccordement **réservé** à un professionnel. **Analyse d'eau** avant/après. **Arrêt immédiat en cas de danger.** Interventions réglementées **réservées aux professionnels compétents**.** `[A]`

## Cadre & suites
- **Normes** : installation sur réseau sanitaire **DTU 60.1** ; alimentation électrique des systèmes (UV) **NF C 15-100** ; protection contre les **retours d'eau** (**NF EN 1717**), qualité de l'eau (**arrêté du 11 janvier 2007**, Code de la santé), matériaux **ACS** ⟦en prose, à confirmer⟧ `[B]` ⟦références/versions exactes à confirmer par le validateur⟧. `respecte-norme`
- **Affinage (charbon)** : `cite-carte` → [installer-charbon-actif](installer-charbon-actif.md)

## Relations & tags
- **Tags** : `metier:traitement-eau famille:fluides sous-famille:traitement-eau intervention:poser cluster:filtres cluster:filtration-sediments complexite:simple type:installation securite:sanitaire`

## Historique
| Version | Date | Auteur | Validateur | Motif |
|---|---|---|---|---|
| v0.1 | 2026-08-05 | IA | ⟦—⟧ | proposition initiale (Brouillon) |
