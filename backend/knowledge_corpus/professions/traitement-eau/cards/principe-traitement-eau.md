# Principe du traitement de l'eau

> **Brouillon (v0) — proposé par IA, en attente de validation métier** (Loi 7/18). Modèle : [../../../cards/CARD_TEMPLATE.md](../../../cards/CARD_TEMPLATE.md).
> Niveaux de confiance : A normes/fabricant · B technique · C terrain validé · D hypothèse. Rien n'est publié comme certitude.

## Métadonnées
| Champ | Valeur |
|---|---|
| Identifiant | `principe-traitement-eau` |
| Titre | Principe du traitement de l'eau |
| Profession | `metier:traitement-eau` |
| Famille | `famille:fluides` |
| Sous-famille | `sous-famille:traitement-eau` |
| Version | v0.1 |
| Auteur | IA (proposition) |
| Validateur | ⟦à valider métier⟧ |
| Statut | Brouillon |
| Indice de confiance | **C** |

## Cadrage
- **Objectif** : comprendre la chaîne de traitement de l'eau (filtration, adoucissement, affinage, désinfection) selon la qualité visée. `[C]`
- **Résumé** : traiter l'eau, c'est adapter sa qualité à l'usage via une **chaîne** : **filtration** (sédiments), **adoucissement** (calcaire), **affinage** (charbon actif : goût/chlore), **désinfection** (**UV**) et, pour la boisson, **osmose inverse** ; toute chaîne repose sur un **diagnostic de qualité** (analyse) et sur un réseau protégé (retours d'eau). `[C]` ⟦chaîne selon analyse d'eau et usage à confirmer⟧

## Réalisation
- **Étapes** :
  1. **Analyse de l'eau** préalable (source : réseau / **forage**). `[C]` → [entretenir-controler-forage](../../../professions/forage/cards/entretenir-controler-forage.md)
  2. **Filtration sédiments** puis **adoucissement**. `[C]` → [installer-adoucisseur](installer-adoucisseur.md)
  3. **Affinage** (charbon actif) / **désinfection UV**. `[C]` → [installer-traitement-uv](installer-traitement-uv.md)
  4. Raccordement au **réseau sanitaire** (protection retours d'eau). `[C]` → [poser-robinet-arret](../../../professions/plomberie/cards/poser-robinet-arret.md)
- **Points critiques** : chaîne **adaptée à l'analyse** ; protection du réseau (retours d'eau) ; **entretien** (sinon développement microbiologique).
- **Sécurité** : sanitaire/microbiologique ; produits ; électricité (UV). **Qualité sanitaire de l'eau** : un traitement mal conçu/entretenu peut **dégrader** l'eau (développement **microbiologique** dans un filtre/adoucisseur, by-pass) → **entretien régulier obligatoire**, matériaux **ACS**. **Contamination** : désinfecter après intervention, ne pas laisser stagner. **Prévention des retours d'eau** : dispositif de **protection (disconnecteur/clapet)** sur les branchements de traitement (protection du réseau public). **Produits de traitement** (sel, réactifs, désinfectants) : EPI, stockage, dosage. **Pression** : réducteur/soupape, **purge avant intervention**. **Électricité des systèmes UV** : raccordement **réservé** à un professionnel. **Analyse d'eau** avant/après. **Arrêt immédiat en cas de danger.** Interventions réglementées **réservées aux professionnels compétents**.** `[A]`

## Cadre & suites
- **Normes** : installation sur réseau sanitaire **DTU 60.1** ; alimentation électrique des systèmes (UV) **NF C 15-100** ; protection contre les **retours d'eau** (**NF EN 1717**), qualité de l'eau (**arrêté du 11 janvier 2007**, Code de la santé), matériaux **ACS** ⟦en prose, à confirmer⟧ `[B]` ⟦références/versions exactes à confirmer par le validateur⟧. `respecte-norme`
- **Diagnostic / contrôle** : `cite-carte` → [entretenir-controler-traitement-eau](entretenir-controler-traitement-eau.md)

## Relations & tags
- **Tags** : `metier:traitement-eau famille:fluides sous-famille:traitement-eau intervention:comprendre cluster:filtres cluster:adoucisseurs cluster:charbon-actif cluster:osmose-inverse cluster:traitement-uv cluster:qualite-de-l-eau type:principe securite:sanitaire relation:forage relation:plomberie`

## Historique
| Version | Date | Auteur | Validateur | Motif |
|---|---|---|---|---|
| v0.1 | 2026-08-05 | IA | ⟦—⟧ | proposition initiale (Brouillon) |
