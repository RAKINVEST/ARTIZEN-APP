# Remplacer la cartouche d'un mitigeur monocommande

> **Brouillon (v0) — proposé par IA, en attente de validation métier** (Loi 7/18). Modèle : [../../../cards/CARD_TEMPLATE.md](../../../cards/CARD_TEMPLATE.md).
> Niveaux de confiance : A normes/fabricant · B technique · C terrain validé · D hypothèse. Rien n'est publié comme certitude.

## Métadonnées
| Champ | Valeur |
|---|---|
| Identifiant | `remplacer-cartouche-mitigeur` |
| Titre | Remplacer la cartouche d'un mitigeur monocommande |
| Profession | `metier:plomberie` |
| Famille | `famille:fluides` |
| Sous-famille | `sous-famille:robinetterie` |
| Version | v0.1 |
| Auteur | IA (proposition) |
| Validateur | ⟦à valider métier⟧ |
| Statut | Brouillon |
| Indice de confiance | **C** (geste courant ; spécifs à confirmer) |

## Cadrage
- **Objectif** : Rétablir l'étanchéité et le fonctionnement d'un mitigeur monocommande dont la cartouche céramique est usée. `[C]`
- **Résumé** : Couper l'eau, démonter la manette et le dôme, extraire la cartouche usée, nettoyer/détartrer le corps, poser une cartouche compatible bien orientée, remonter et contrôler. `[C]`
- **Description complète** : ⟦à compléter/valider métier⟧ — variantes selon marque et type de cartouche (Ø 25/35/40 mm). `[D]`
- **Pré-requis** : accès au mitigeur ; cartouche de rechange **compatible** (marque/modèle). `[B]`
- **Difficulté** : `simple` à `moyenne` `[C]`
- **Temps moyen** : ~20–40 min `[C]` ⟦à confirmer⟧
- **Compétences nécessaires** : démontage robinetterie, détartrage. `[C]`

## Ressources
- **Outillage** : `outil:manuel` (clés Allen/plates, tournevis), `outil:controle` (contrôle étanchéité). `[C]`
- **Matériel** : cartouche céramique compatible. `[B]`
- **Consommables** : graisse silicone sanitaire, produit détartrant. `[C]`
- **Kit conseillé** : `utilise-kit` → [kit-robinetterie](../../../kits/plomberie/kit-robinetterie.md)

## Réalisation
- **Étapes** :
  1. Couper l'arrivée d'eau (EF **et** ECS) et **purger** en ouvrant le mitigeur. `[B]`
  2. Retirer le cache-repère et la vis de manette ; déposer la manette. `[C]`
  3. Dévisser le dôme/écrou de serrage ; extraire la cartouche. `[C]`
  4. Nettoyer et détartrer le logement ; vérifier les portées d'étanchéité. `[C]`
  5. Poser la cartouche neuve en respectant les **repères d'orientation** (ergots). `[B]`
  6. Remonter dôme + manette ; rouvrir l'eau **progressivement**. `[B]`
  7. Contrôler l'étanchéité et l'équilibre chaud/froid. `[C]` → [controler-etancheite-reseau](controler-etancheite-reseau.md)
- **Contrôles** : `a-checklist` → [controle-etancheite](../../../checklists/plomberie/controle-etancheite.md)
- **Points critiques** : compatibilité et **orientation** de la cartouche ; ne pas forcer (céramique fragile) ; détartrage du logement. `[C]`
- **Sécurité** : couper l'eau et **vérifier l'absence de pression** avant démontage ; attention à l'eau chaude résiduelle. `[B]`

## Cadre & suites
- **Normes** : installation sanitaire — **DTU 60.1** applicable au réseau `[B]` ⟦référence exacte/version à confirmer par le validateur⟧. `respecte-norme`
- **Garantie** : `cite-phrase` → [garantie-piece-main-oeuvre](../../../phrases/plomberie/garantie-piece-main-oeuvre.md)
- **Maintenance** : détartrage périodique selon dureté de l'eau. `[C]`
- **SAV** : recontrôle étanchéité à 24–48 h en cas de doute. `[C]`
- **Diagnostics liés** : `traite-diagnostic` → [fuite-mitigeur](../../../diagnostics/plomberie/fuite-mitigeur.md)

## Média & preuves
- **Photos / Vidéos** : ⟦à fournir — terrain, sans donnée personnelle⟧
- **Documents** : notice fabricant de la cartouche `[B]`

## Langage & réutilisation
- **Phrases associées** : garantie, conseil d'entretien anti-tartre.
- **FAQ** : « pourquoi ma cartouche fuit-elle à nouveau ? » ⟦à rédiger/valider⟧
- **Retours terrain** : `enrichie-par` ⟦à collecter⟧

## Relations & tags
- **Relations** : `utilise-kit`, `a-checklist`, `traite-diagnostic`, `cite-phrase`, `documentee-par`.
- **Tags** : `metier:plomberie famille:fluides sous-famille:robinetterie intervention:reparer intervention:remplacer probleme:fuite probleme:usure equipement:mitigeur piece:salle-de-bain piece:cuisine complexite:moyenne type:reparation`

## Historique
| Version | Date | Auteur | Validateur | Motif |
|---|---|---|---|---|
| v0.1 | 2026-08-02 | IA | ⟦—⟧ | proposition initiale (Brouillon) |
