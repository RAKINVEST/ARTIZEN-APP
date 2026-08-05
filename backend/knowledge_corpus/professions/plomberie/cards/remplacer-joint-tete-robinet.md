# Remplacer le joint/clapet d'une tête de robinet

> **Brouillon (v0) — proposé par IA, en attente de validation métier** (Loi 7/18). Modèle : [../../../cards/CARD_TEMPLATE.md](../../../cards/CARD_TEMPLATE.md).
> Niveaux de confiance : A normes/fabricant · B technique · C terrain validé · D hypothèse. Rien n'est publié comme certitude.

## Métadonnées
| Champ | Valeur |
|---|---|
| Identifiant | `remplacer-joint-tete-robinet` |
| Titre | Remplacer le joint/clapet d'une tête de robinet |
| Profession | `metier:plomberie` |
| Famille | `famille:fluides` |
| Sous-famille | `sous-famille:robinetterie` |
| Version | v0.1 |
| Auteur | IA (proposition) |
| Validateur | ⟦à valider métier⟧ |
| Statut | Brouillon |
| Indice de confiance | **C** (geste courant) |

## Cadrage
- **Objectif** : arrêter un goutte-à-goutte sur un robinet à tête classique (mélangeur) en remplaçant le joint/clapet de tête. `[C]`
- **Résumé** : couper l'eau, démonter la tête, remplacer le clapet (et le joint de tête si besoin), remonter et contrôler. `[C]`
- **Description complète** : ⟦à compléter/valider métier⟧ — sur mitigeur monocommande, c'est la **cartouche** qu'on remplace (voir carte dédiée). `[C]`
- **Pré-requis** : robinet à têtes démontables. `[C]`
- **Difficulté** : `simple` `[C]`
- **Temps moyen** : ~15–30 min `[C]` ⟦à confirmer⟧
- **Compétences nécessaires** : démontage robinetterie. `[C]`

## Ressources
- **Outillage** : `outil:manuel`. `[C]`
- **Matériel** : clapet/joint de tête compatible. `[C]`
- **Consommables** : graisse sanitaire. `[C]`
- **Kit conseillé** : `utilise-kit` → [kit-robinetterie](../../../kits/plomberie/kit-robinetterie.md)

## Réalisation
- **Étapes** :
  1. Couper l'eau et **purger** en ouvrant le robinet. `[B]`
  2. Déposer la croix/manette, dévisser la tête. `[C]`
  3. Remplacer le clapet en bout de tête (et le joint torique si usé). `[C]`
  4. Vérifier/nettoyer le siège dans le corps. `[C]`
  5. Remonter, rouvrir l'eau **progressivement**, contrôler l'étanchéité. `[C]` → [controle-etancheite](../../../checklists/plomberie/controle-etancheite.md)
- **Contrôles** : plus de goutte-à-goutte, manœuvre douce. `[C]`
- **Points critiques** : siège piqué = remplacement robinet ; ne pas forcer la tête. `[C]`
- **Sécurité** : vérifier l'absence de pression avant démontage. `[B]`

## Cadre & suites
- **Normes** : installation sanitaire — **DTU 60.1** `[B]` ⟦référence exacte à confirmer⟧. `respecte-norme`
- **Diagnostics liés** : `traite-diagnostic` → [robinet-qui-goutte](../../../diagnostics/plomberie/robinet-qui-goutte.md)
- **Interventions liées** : `cite-carte` → [remplacer-cartouche-mitigeur](remplacer-cartouche-mitigeur.md)

## Média & preuves
- **Photos / Vidéos** : ⟦à fournir⟧

## Relations & tags
- **Relations** : `utilise-kit`, `a-checklist`, `traite-diagnostic`, `cite-carte`.
- **Tags** : `metier:plomberie famille:fluides sous-famille:robinetterie intervention:reparer intervention:remplacer probleme:fuite probleme:usure equipement:robinet complexite:simple type:reparation`

## Historique
| Version | Date | Auteur | Validateur | Motif |
|---|---|---|---|---|
| v0.1 | 2026-08-04 | IA | ⟦—⟧ | proposition initiale (Brouillon) |
