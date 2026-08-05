# Entretenir un chauffe-eau électrique (cumulus)

> **Brouillon (v0) — proposé par IA, en attente de validation métier** (Loi 7/18). Modèle : [../../../cards/CARD_TEMPLATE.md](../../../cards/CARD_TEMPLATE.md).
> Confiance : A normes/fabricant · B technique · C terrain · D hypothèse. **Point d'attention : présence d'électricité + eau chaude sous pression — sécurité renforcée.**

## Métadonnées
| Champ | Valeur |
|---|---|
| Identifiant | `entretenir-chauffe-eau-electrique` |
| Titre | Entretenir un chauffe-eau électrique (cumulus) |
| Profession | `metier:plomberie` |
| Famille | `famille:fluides` |
| Sous-famille | `sous-famille:production-ecs` |
| Version | v0.1 |
| Auteur | IA (proposition) |
| Validateur | ⟦à valider métier⟧ |
| Statut | Brouillon |
| Indice de confiance | **C** (spécifs fabricant à confirmer) |

## Cadrage
- **Objectif** : Maintenir le rendement et la durée de vie d'un chauffe-eau électrique (détartrage, contrôle anode, groupe de sécurité). `[C]`
- **Résumé** : Consigner (élec + eau), vidanger, détartrer la résistance/cuve, contrôler l'**anode** et le **groupe de sécurité**, remonter avec joint neuf, remettre en eau puis sous tension, contrôler. `[C]`
- **Pré-requis** : accès à l'appareil ; pièces d'usure éventuelles (joint, anode) compatibles. `[B]`
- **Difficulté** : `moyenne` `[C]`
- **Temps moyen** : ~1–2 h `[C]` ⟦à confirmer⟧

## Ressources
- **Outillage** : `outil:manuel`, `outil:controle` (contrôle électrique **hors tension**). `[B]`
- **Matériel** : joint de bride, anode (si à remplacer), groupe de sécurité (si à remplacer). `[B]`
- **Kit conseillé** : `utilise-kit` → [kit-chauffe-eau](../../../kits/plomberie/kit-chauffe-eau.md)

## Réalisation
- **Étapes** :
  1. **Consigner** : couper l'alimentation **électrique** et l'arrivée d'eau. `[A]` → [consignation-eau](../../../procedures/plomberie/consignation-eau.md)
  2. Vidanger la cuve (groupe de sécurité / vanne). `[C]`
  3. Déposer la bride ; détartrer résistance et cuve ; contrôler l'**anode** (magnésium) et la remplacer si usée. `[C]`
  4. Contrôler/remplacer le **groupe de sécurité** (organe de sécurité obligatoire). `[B]` ⟦à valider⟧
  5. Remonter avec **joint neuf** ; remettre en eau ; **purger l'air**. `[C]`
  6. Remettre sous tension ; contrôler chauffe et étanchéité. `[C]`
- **Contrôles** : `a-checklist` → [mise-en-service-ecs](../../../checklists/plomberie/mise-en-service-ecs.md)
- **Points critiques** : **consignation électrique** avant toute intervention ; groupe de sécurité fonctionnel ; purge d'air ; couple de serrage de la bride. `[B]`
- **Sécurité** : risque **électrique** et **brûlure** (eau chaude sous pression) ; ne jamais ouvrir sous tension/pression. `[A]`

## Cadre & suites
- **Normes** : installation ECS + **groupe de sécurité** ; sécurité électrique (**NF C 15-100** pour la partie électrique) `[B]` ⟦références exactes/versions à confirmer par le validateur⟧.
- **Maintenance** : périodicité selon dureté de l'eau et préconisations fabricant. `[B]`
- **Diagnostics liés** : `traite-diagnostic` → [absence-eau-chaude](../../../diagnostics/plomberie/absence-eau-chaude.md)

## Relations & tags
- **Relations** : `utilise-kit`, `a-checklist`, `traite-diagnostic`, `respecte-norme`.
- **Tags** : `metier:plomberie famille:fluides sous-famille:production-ecs intervention:entretenir intervention:controler probleme:usure equipement:chauffe-eau equipement:ballon-ecs piece:local-technique complexite:moyenne type:entretien`

## Historique
| Version | Date | Auteur | Validateur | Motif |
|---|---|---|---|---|
| v0.1 | 2026-08-02 | IA | ⟦—⟧ | proposition initiale (Brouillon) |
