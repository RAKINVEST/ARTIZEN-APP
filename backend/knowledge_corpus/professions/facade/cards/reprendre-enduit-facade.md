# Reprendre un enduit de façade

> **Brouillon (v0) — proposé par IA, en attente de validation métier** (Loi 7/18). Modèle : [../../../cards/CARD_TEMPLATE.md](../../../cards/CARD_TEMPLATE.md).
> Niveaux de confiance : A normes/fabricant · B technique · C terrain validé · D hypothèse. Rien n'est publié comme certitude.

## Métadonnées
| Champ | Valeur |
|---|---|
| Identifiant | `reprendre-enduit-facade` |
| Titre | Reprendre un enduit de façade |
| Profession | `metier:facade` |
| Famille | `famille:enveloppe` |
| Sous-famille | `sous-famille:facade` |
| Version | v0.1 |
| Auteur | IA (proposition) |
| Validateur | ⟦à valider métier⟧ |
| Statut | Brouillon |
| Indice de confiance | **C** |

## Cadrage
- **Objectif** : réparer ou refaire un enduit de façade (mortier / monocouche) sur support maçonné. `[C]`
- **Résumé** : purger l'enduit non adhérent, préparer/humidifier le support, appliquer l'enduit (gobetis/corps/finition ou monocouche) dans les règles, en respectant les temps et la météo. `[C]` ⟦produit/épaisseur selon support à confirmer⟧

## Réalisation
- **Étapes** :
  1. **Purger** l'enduit non adhérent ; sonder le support. `[C]` → [controle-facade-avant-reprise](../../../procedures/facade/controle-facade-avant-reprise.md)
  2. Préparer/humidifier le support (**DTU 26.1**). `[B]` ⟦à confirmer⟧
  3. Appliquer l'enduit (gobetis/corps/finition ou **monocouche**). `[C]`
  4. Respecter temps de prise et **météo** (pas de gel/forte chaleur). `[B]`
- **Points critiques** : adhérence au support ; météo (gel, pluie, chaleur) ; épaisseurs/temps respectés.
- **Sécurité** : hauteur ; support ; produits (mortier). **Travail en **hauteur** : risque de **chute** — protections **collectives** (échafaudage/garde-corps) prioritaires, **EPI adaptés**, **météo** (vent/gel/pluie) surveillée. **Stabilité du support** : évaluer l'état du support (purge des parties non adhérentes) avant intervention. **Produits chimiques** (nettoyants, hydrofuges, traitements) : EPI, ventilation, protection de l'environnement. **Arrêt immédiat en cas de danger.** Une intervention en façade relève de **compétences adaptées**.** `[A]`

## Cadre & suites
- **Normes** : enduits de mortiers **DTU 26.1** ; réfection de façades par revêtements d'imperméabilité **DTU 42.1** ; maçonnerie de petits éléments **DTU 20.1** `[B]` ⟦références/versions exactes à confirmer par le validateur⟧. `respecte-norme`
- **Fissures liées** : `cite-carte` → [traiter-fissures-facade](traiter-fissures-facade.md)

## Relations & tags
- **Tags** : `metier:facade equipement:enduit famille:enveloppe sous-famille:facade intervention:reparer intervention:remplacer cluster:facades-enduites cluster:revetements cluster:reparation complexite:avancee type:reparation securite:hauteur`

## Historique
| Version | Date | Auteur | Validateur | Motif |
|---|---|---|---|---|
| v0.1 | 2026-08-04 | IA | ⟦—⟧ | proposition initiale (Brouillon) |
