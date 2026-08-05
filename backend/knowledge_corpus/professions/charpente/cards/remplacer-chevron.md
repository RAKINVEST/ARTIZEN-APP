# Remplacer un chevron

> **Brouillon (v0) — proposé par IA, en attente de validation métier** (Loi 7/18). Modèle : [../../../cards/CARD_TEMPLATE.md](../../../cards/CARD_TEMPLATE.md).
> Niveaux de confiance : A normes/fabricant · B technique · C terrain validé · D hypothèse. Rien n'est publié comme certitude.

## Métadonnées
| Champ | Valeur |
|---|---|
| Identifiant | `remplacer-chevron` |
| Titre | Remplacer un chevron |
| Profession | `metier:charpente` |
| Famille | `famille:enveloppe` |
| Sous-famille | `sous-famille:charpente` |
| Version | v0.1 |
| Auteur | IA (proposition) |
| Validateur | ⟦à valider métier⟧ |
| Statut | Brouillon |
| Indice de confiance | **C** |

## Cadrage
- **Objectif** : remplacer un chevron dégradé (attaque, casse) en préservant la stabilité et l'alignement de la couverture. `[C]`
- **Résumé** : étayer/soutenir localement, déposer le chevron atteint après dépose partielle de couverture (autre corps d'état), poser un chevron de section équivalente, fixer et contrôler l'alignement. `[C]` ⟦section/essence selon ouvrage à confirmer⟧

## Réalisation
- **Étapes** :
  1. Évaluer la stabilité et prévoir l'**étaiement/soutien**. `[A]` → [etaiement-avant-intervention](../../../procedures/charpente/etaiement-avant-intervention.md)
  2. Dépose partielle de couverture (**autre corps d'état**) pour accéder. `[C]`
  3. Déposer le chevron atteint ; contrôler pannes/appuis. `[C]`
  4. Poser un chevron de **section équivalente** (essence/classe), fixer. `[B]` ⟦à confirmer⟧
  5. Contrôler l'**alignement** (plan de couverture) ; traiter le bois. `[C]`
- **Points critiques** : section/essence équivalentes ; **alignement** du plan de couverture ; ne pas déstabiliser les pannes.
- **Sécurité** : hauteur ; étaiement ; dépose de couverture = coordination (interface couverture). **Travail en **hauteur** : risque de **chute** — EPI antichute, protections/échafaudage, **météo** (vent/gel/pluie) surveillée. **Stabilité de l'ouvrage** : évaluer **charges** et prévoir l'**étaiement** avant toute dépose/coupe d'un élément porteur — ne jamais affaiblir la structure sans étaiement/étude. **Arrêt immédiat en cas de danger** (fissuration, mouvement, doute structurel). Une intervention structurelle relève de **compétences charpente adaptées**.** `[A]`

## Cadre & suites
- **Normes** : charpente et escaliers en bois **DTU 31.1** ; charpentes assemblées par connecteurs **DTU 31.3** ; calcul des structures bois **Eurocode 5 (NF EN 1995)** `[B]` ⟦références/versions exactes à confirmer par le validateur⟧. `respecte-norme`
- **Étaiement** : `cite-procedure` → [etaiement-avant-intervention](../../../procedures/charpente/etaiement-avant-intervention.md)

## Relations & tags
- **Tags** : `metier:charpente equipement:chevron famille:enveloppe sous-famille:charpente intervention:remplacer cluster:chevrons cluster:remplacement cluster:reparation complexite:avancee type:remplacement securite:hauteur securite:structure relation:couverture`

## Historique
| Version | Date | Auteur | Validateur | Motif |
|---|---|---|---|---|
| v0.1 | 2026-08-04 | IA | ⟦—⟧ | proposition initiale (Brouillon) |
