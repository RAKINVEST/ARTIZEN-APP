# Installer un adoucisseur

> **Brouillon (v0) — proposé par IA, en attente de validation métier** (Loi 7/18). Modèle : [../../../cards/CARD_TEMPLATE.md](../../../cards/CARD_TEMPLATE.md).
> Niveaux de confiance : A normes/fabricant · B technique · C terrain validé · D hypothèse. Rien n'est publié comme certitude.

## Métadonnées
| Champ | Valeur |
|---|---|
| Identifiant | `installer-adoucisseur` |
| Titre | Installer un adoucisseur |
| Profession | `metier:traitement-eau` |
| Famille | `famille:fluides` |
| Sous-famille | `sous-famille:traitement-eau` |
| Version | v0.1 |
| Auteur | IA (proposition) |
| Validateur | ⟦à valider métier⟧ |
| Statut | Brouillon |
| Indice de confiance | **C** |

## Cadrage
- **Objectif** : installer un adoucisseur (échange d'ions) pour réduire la dureté (calcaire) et protéger les installations. `[C]`
- **Résumé** : poser l'adoucisseur sur l'arrivée d'eau **après un préfiltre**, avec un **by-pass** et une **protection contre les retours d'eau**, régler la dureté résiduelle (TH cible, sans adoucir à zéro), raccorder l'évacuation de régénération et gérer le **sel** ; laisser un point d'eau **non adouci** pour la boisson. `[C]` ⟦TH cible/dimensionnement selon usage à confirmer⟧

## Réalisation
- **Étapes** :
  1. Poser après **préfiltre sédiments** ; **by-pass** + **protection retours d'eau**. `[C]` → [installer-filtration-sediments](installer-filtration-sediments.md)
  2. Régler la **dureté résiduelle** (TH cible, pas zéro). `[C]` ⟦à confirmer⟧
  3. Raccorder l'évacuation de régénération ; gérer le **sel**. `[C]`
  4. Protège la **génération** (chaudière/ballon) de l'entartrage. `[C]` → [entretenir-chaudiere](../../../professions/chauffage/cards/entretenir-chaudiere.md)
- **Points critiques** : TH résiduel réglé (eau ni agressive ni entartrante) ; point non adouci pour boisson ; protection retours d'eau ; entretien (sel/désinfection).
- **Sécurité** : produits (sel) ; sanitaire (stagnation) ; pression. **Qualité sanitaire de l'eau** : un traitement mal conçu/entretenu peut **dégrader** l'eau (développement **microbiologique** dans un filtre/adoucisseur, by-pass) → **entretien régulier obligatoire**, matériaux **ACS**. **Contamination** : désinfecter après intervention, ne pas laisser stagner. **Prévention des retours d'eau** : dispositif de **protection (disconnecteur/clapet)** sur les branchements de traitement (protection du réseau public). **Produits de traitement** (sel, réactifs, désinfectants) : EPI, stockage, dosage. **Pression** : réducteur/soupape, **purge avant intervention**. **Électricité des systèmes UV** : raccordement **réservé** à un professionnel. **Analyse d'eau** avant/après. **Arrêt immédiat en cas de danger.** Interventions réglementées **réservées aux professionnels compétents**.** `[A]`

## Cadre & suites
- **Normes** : installation sur réseau sanitaire **DTU 60.1** ; alimentation électrique des systèmes (UV) **NF C 15-100** ; protection contre les **retours d'eau** (**NF EN 1717**), qualité de l'eau (**arrêté du 11 janvier 2007**, Code de la santé), matériaux **ACS** ⟦en prose, à confirmer⟧ `[B]` ⟦références/versions exactes à confirmer par le validateur⟧. `respecte-norme`
- **Anti-tartre (alternative)** : `cite-carte` → [installer-anti-tartre](installer-anti-tartre.md)

## Relations & tags
- **Tags** : `metier:traitement-eau famille:fluides sous-famille:traitement-eau intervention:poser cluster:adoucisseurs cluster:anti-tartre complexite:moyenne type:installation securite:sanitaire relation:chauffage`

## Historique
| Version | Date | Auteur | Validateur | Motif |
|---|---|---|---|---|
| v0.1 | 2026-08-05 | IA | ⟦—⟧ | proposition initiale (Brouillon) |
