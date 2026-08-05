# Installer une osmose inverse (eau de boisson)

> **Brouillon (v0) — proposé par IA, en attente de validation métier** (Loi 7/18). Modèle : [../../../cards/CARD_TEMPLATE.md](../../../cards/CARD_TEMPLATE.md).
> Niveaux de confiance : A normes/fabricant · B technique · C terrain validé · D hypothèse. Rien n'est publié comme certitude.

## Métadonnées
| Champ | Valeur |
|---|---|
| Identifiant | `installer-osmose-inverse` |
| Titre | Installer une osmose inverse (eau de boisson) |
| Profession | `metier:traitement-eau` |
| Famille | `famille:fluides` |
| Sous-famille | `sous-famille:traitement-eau` |
| Version | v0.1 |
| Auteur | IA (proposition) |
| Validateur | ⟦à valider métier⟧ |
| Statut | Brouillon |
| Indice de confiance | **C** |

## Cadrage
- **Objectif** : installer un osmoseur (osmose inverse) au point d'usage pour une eau de boisson très pure. `[C]`
- **Résumé** : poser l'osmoseur **au point d'usage** (évier) avec préfiltres, **membrane** d'osmose, réservoir et robinet dédié, gérer le **rejet** (concentrat) à l'égout et la **protection retours d'eau** ; l'osmose retire la quasi-totalité des minéraux (eau très peu minéralisée) — usage à cadrer. `[C]` ⟦taux de rejet/entretien membrane selon fabricant à confirmer⟧

## Réalisation
- **Étapes** :
  1. Poser au **point d'usage** (préfiltres + **membrane** + réservoir). `[C]`
  2. Gérer le **rejet** (concentrat) à l'égout + protection retours d'eau. `[C]`
  3. Robinet dédié ; **désinfecter** à la pose. `[C]` → [mise-en-service-desinfection-traitement](../../../procedures/traitement-eau/mise-en-service-desinfection-traitement.md)
  4. Entretien : préfiltres/membrane. `[C]` → [controle-maintenance-traitement-eau](../../../checklists/traitement-eau/controle-maintenance-traitement-eau.md)
- **Points critiques** : eau **très peu minéralisée** (usage à cadrer) ; rejet géré ; protection retours d'eau ; entretien membrane/préfiltres.
- **Sécurité** : sanitaire (stagnation réservoir) ; pression ; rejet. **Qualité sanitaire de l'eau** : un traitement mal conçu/entretenu peut **dégrader** l'eau (développement **microbiologique** dans un filtre/adoucisseur, by-pass) → **entretien régulier obligatoire**, matériaux **ACS**. **Contamination** : désinfecter après intervention, ne pas laisser stagner. **Prévention des retours d'eau** : dispositif de **protection (disconnecteur/clapet)** sur les branchements de traitement (protection du réseau public). **Produits de traitement** (sel, réactifs, désinfectants) : EPI, stockage, dosage. **Pression** : réducteur/soupape, **purge avant intervention**. **Électricité des systèmes UV** : raccordement **réservé** à un professionnel. **Analyse d'eau** avant/après. **Arrêt immédiat en cas de danger.** Interventions réglementées **réservées aux professionnels compétents**.** `[A]`

## Cadre & suites
- **Normes** : installation sur réseau sanitaire **DTU 60.1** ; alimentation électrique des systèmes (UV) **NF C 15-100** ; protection contre les **retours d'eau** (**NF EN 1717**), qualité de l'eau (**arrêté du 11 janvier 2007**, Code de la santé), matériaux **ACS** ⟦en prose, à confirmer⟧ `[B]` ⟦références/versions exactes à confirmer par le validateur⟧. `respecte-norme`
- **Qualité d'eau** : `cite-carte` → [entretenir-controler-traitement-eau](entretenir-controler-traitement-eau.md)

## Relations & tags
- **Tags** : `metier:traitement-eau famille:fluides sous-famille:traitement-eau intervention:poser cluster:osmose-inverse cluster:qualite-de-l-eau complexite:avancee type:installation securite:sanitaire`

## Historique
| Version | Date | Auteur | Validateur | Motif |
|---|---|---|---|---|
| v0.1 | 2026-08-05 | IA | ⟦—⟧ | proposition initiale (Brouillon) |
