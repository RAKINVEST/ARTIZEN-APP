# Installer le ballon solaire et l'échangeur

> **Brouillon (v0) — proposé par IA, en attente de validation métier** (Loi 7/18). Modèle : [../../../cards/CARD_TEMPLATE.md](../../../cards/CARD_TEMPLATE.md).
> Niveaux de confiance : A normes/fabricant · B technique · C terrain validé · D hypothèse. Rien n'est publié comme certitude.

## Métadonnées
| Champ | Valeur |
|---|---|
| Identifiant | `installer-ballon-solaire-echangeur` |
| Titre | Installer le ballon solaire et l'échangeur |
| Profession | `metier:solaire-thermique` |
| Famille | `famille:fluides` |
| Sous-famille | `sous-famille:solaire-thermique` |
| Version | v0.1 |
| Auteur | IA (proposition) |
| Validateur | ⟦à valider métier⟧ |
| Statut | Brouillon |
| Indice de confiance | **C** |

## Cadrage
- **Objectif** : installer le ballon solaire (à échangeur) et organiser l'**appoint** pour l'ECS (CESI) ou l'ECS+chauffage (SSC). `[C]`
- **Résumé** : poser le **ballon solaire** (simple/double échangeur), raccorder l'**échangeur** au circuit primaire, l'eau sanitaire (avec **groupe de sécurité** et protection anti-brûlure/mitigeur) et l'**appoint** (électrique/chaudière) en partie haute, en respectant la stratification. `[C]` ⟦volume/échangeur selon besoins à confirmer⟧

## Réalisation
- **Étapes** :
  1. Poser le **ballon solaire** (échangeur bas = solaire). `[C]`
  2. Raccorder ECS + **groupe de sécurité** + mitigeur anti-brûlure. `[C]` → [remplacer-groupe-securite](../../../professions/plomberie/cards/remplacer-groupe-securite.md)
  3. Raccorder l'**appoint** (haut du ballon). `[C]`
  4. Respecter la **stratification** (solaire en bas). `[C]`
- **Points critiques** : stratification (solaire en partie basse) ; **groupe de sécurité** + **anti-brûlure** (eau très chaude possible) ; appoint coordonné.
- **Sécurité** : brûlures (eau chaude) ; pression ; manutention ballon. **Travail en toiture** : **risque de chute** — protections collectives / EPI antichute, **manutention des capteurs** (lourds, prise au vent) à plusieurs, météo. **Brûlures** : le **fluide caloporteur** et les capteurs atteignent de **hautes températures** (surchauffe/**stagnation**) → risque de brûlure et de **surpression** ; **purger/refroidir avant intervention**, ne jamais ouvrir un circuit chaud/sous pression. **Pression du circuit** : soupape/vase d'expansion, contrôle avant intervention. **Fluide caloporteur** (glycol) : EPI, élimination tracée. **Raccordement électrique de la régulation** : **réservé** à un professionnel. **Arrêt immédiat en cas de danger.** Interventions réservées à un **installateur qualifié (RGE)**.** `[A]`

## Cadre & suites
- **Normes** : installations de capteurs solaires à circulation de liquide **DTU 65.12** ; électricité de la régulation/circulateur **NF C 15-100** ; capteurs **NF EN 12975**, systèmes **NF EN 12976**, certification **Solar Keymark** / label **RGE QualiSol** ⟦en prose, à confirmer⟧ `[B]` ⟦références/versions exactes à confirmer par le validateur⟧. `respecte-norme`
- **Régulation** : `cite-carte` → [regler-regulation-solaire](regler-regulation-solaire.md)

## Relations & tags
- **Tags** : `metier:solaire-thermique famille:fluides sous-famille:solaire-thermique intervention:poser cluster:ballon-solaire cluster:echangeurs cluster:chauffe-eau-solaire-individuel complexite:avancee type:installation securite:brulure relation:plomberie`

## Historique
| Version | Date | Auteur | Validateur | Motif |
|---|---|---|---|---|
| v0.1 | 2026-08-05 | IA | ⟦—⟧ | proposition initiale (Brouillon) |
