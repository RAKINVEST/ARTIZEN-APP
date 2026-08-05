# Contrôler liteaux et voliges

> **Brouillon (v0) — proposé par IA, en attente de validation métier** (Loi 7/18). Modèle : [../../../cards/CARD_TEMPLATE.md](../../../cards/CARD_TEMPLATE.md).
> Niveaux de confiance : A normes/fabricant · B technique · C terrain validé · D hypothèse. Rien n'est publié comme certitude.

## Métadonnées
| Champ | Valeur |
|---|---|
| Identifiant | `controler-liteaux-voliges` |
| Titre | Contrôler liteaux et voliges |
| Profession | `metier:charpente` |
| Famille | `famille:enveloppe` |
| Sous-famille | `sous-famille:charpente` |
| Version | v0.1 |
| Auteur | IA (proposition) |
| Validateur | ⟦à valider métier⟧ |
| Statut | Brouillon |
| Indice de confiance | **C** |

## Cadrage
- **Objectif** : contrôler l'état du support de couverture (liteaux/voliges) côté charpente. `[C]`
- **Résumé** : vérifier l'état, l'entraxe et la fixation des liteaux/voliges, repérer les éléments dégradés (humidité/insectes), en interface avec la couverture. `[C]`

## Réalisation
- **Étapes** :
  1. Contrôler l'état (humidité, attaque) des **liteaux/voliges**. `[C]` → [diagnostiquer-attaque-bois](diagnostiquer-attaque-bois.md)
  2. Vérifier l'**entraxe** (adapté à la couverture) et la fixation. `[C]` ⟦entraxe selon couverture à confirmer⟧
  3. Repérer les éléments à remplacer. `[C]`
  4. Coordonner avec la **couverture** (interface). `[C]`
- **Points critiques** : entraxe adapté à la couverture ; état sain du support ; interface couverture.
- **Sécurité** : hauteur ; dépose de couverture = autre corps d'état. **Travail en **hauteur** : risque de **chute** — EPI antichute, protections/échafaudage, **météo** (vent/gel/pluie) surveillée. **Stabilité de l'ouvrage** : évaluer **charges** et prévoir l'**étaiement** avant toute dépose/coupe d'un élément porteur — ne jamais affaiblir la structure sans étaiement/étude. **Arrêt immédiat en cas de danger** (fissuration, mouvement, doute structurel). Une intervention structurelle relève de **compétences charpente adaptées**.** `[A]`

## Cadre & suites
- **Normes** : charpente et escaliers en bois **DTU 31.1** ; charpentes assemblées par connecteurs **DTU 31.3** ; calcul des structures bois **Eurocode 5 (NF EN 1995)** `[B]` ⟦références/versions exactes à confirmer par le validateur⟧. `respecte-norme`
- **Interventions liées** : `cite-carte` → [remplacer-chevron](remplacer-chevron.md)

## Relations & tags
- **Tags** : `metier:charpente equipement:liteau equipement:volige famille:enveloppe sous-famille:charpente intervention:controler cluster:liteaux cluster:voliges cluster:controle complexite:moyenne type:controle securite:hauteur relation:couverture`

## Historique
| Version | Date | Auteur | Validateur | Motif |
|---|---|---|---|---|
| v0.1 | 2026-08-04 | IA | ⟦—⟧ | proposition initiale (Brouillon) |
