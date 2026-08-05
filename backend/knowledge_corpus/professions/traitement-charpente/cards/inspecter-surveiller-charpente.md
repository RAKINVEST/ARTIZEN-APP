# Inspecter et surveiller une charpente

> **Brouillon (v0) — proposé par IA, en attente de validation métier** (Loi 7/18). Modèle : [../../../cards/CARD_TEMPLATE.md](../../../cards/CARD_TEMPLATE.md).
> Niveaux de confiance : A normes/fabricant · B technique · C terrain validé · D hypothèse. Rien n'est publié comme certitude.

## Métadonnées
| Champ | Valeur |
|---|---|
| Identifiant | `inspecter-surveiller-charpente` |
| Titre | Inspecter et surveiller une charpente |
| Profession | `metier:traitement-charpente` |
| Famille | `famille:specialises` |
| Sous-famille | `sous-famille:traitement-charpente` |
| Version | v0.1 |
| Auteur | IA (proposition) |
| Validateur | ⟦à valider métier⟧ |
| Statut | Brouillon |
| Indice de confiance | **C** |

## Cadrage
- **Objectif** : organiser l'**inspection** d'une charpente et la **surveillance** périodique des attaques et de l'humidité. `[C]`
- **Résumé** : réaliser une **inspection visuelle et par sondage** de la charpente (bois d'œuvre, appuis, zones humides, aboutées), **mesurer l'humidité** du bois (humidimètre), repérer les indices d'attaque et les points sensibles, puis mettre en place une **surveillance** périodique ; l'inspection structurelle approfondie rejoint le **Charpentier** ; consigner les constats. `[C]` ⟦périodicité/points d'inspection à confirmer⟧

## Réalisation
- **Étapes** *(compréhension / diagnostic / organisation — aucun protocole d'application de biocides décrit)* :
  1. **Inspecter** (visuel + sondage) ; zones humides/appuis. `[C]` → [inspecter-charpente](../../../professions/charpente/cards/inspecter-charpente.md)
  2. **Mesurer l'humidité** du bois (humidimètre). `[C]`
  3. Repérer indices d'attaque / points sensibles. `[C]` → [diagnostiquer-attaques-biologiques](diagnostiquer-attaques-biologiques.md)
  4. Mettre en place une **surveillance** ; consigner. `[C]` → [controle-surveillance-charpente](../../../checklists/traitement-charpente/controle-surveillance-charpente.md)
- **Points critiques** : inspection méthodique ; **humidité mesurée** ; surveillance périodique ; inspection structurelle = Charpentier ; constats consignés.
- **Sécurité** : hauteur/combles (planchers fragiles) ; poussières ; électricité (combles). **Produits biocides** : les traitements du bois utilisent des **produits dangereux** (toxiques/irritants, parfois inflammables) — leur **application professionnelle** est **réglementée** (**Certibiocide**, Règlement Biocides), sous EPI, ventilation et protection des occupants ; **ce Livre ne décrit aucun protocole d'application** (présentation uniquement). **Travail en hauteur / combles** : accès difficile, planchers fragiles, chutes. **Poussières de bois** (cancérogènes, débris d'attaque) → aspiration/masque. **Électricité** en combles : prudence (câblage). **Amiante** (anciens traitements, matériaux en combles/calorifuge) : diagnostic ; retrait réservé à une **entreprise certifiée** (**jamais ici**). **Protection des occupants / animaux** pendant traitement (relais professionnel). **Structure affaiblie** par l'attaque = **risque d'effondrement** → **arrêt immédiat en cas de danger.** `[A]`

## Cadre & suites
- **Normes** : charpente / structure bois traitée (**interface** charpente) **DTU 31.1** ; humidité / remédiation du bâti (**interface** maçonnerie) **DTU 20.1** ; classes d'emploi / risque biologique **NF EN 335**, durabilité **NF EN 350**, efficacité des produits de préservation **NF EN 599**, diagnostic **termites** (Code de la construction, déclaration en mairie), **mérule** (obligation d'information) et **Règlement Biocides UE 528/2012 / Certibiocide** ⟦en prose, à confirmer⟧ `[B]` ⟦références/versions exactes à confirmer par le validateur⟧. `respecte-norme`
- **Prévention / entretien** : `cite-carte` → [prevenir-entretenir-documenter](prevenir-entretenir-documenter.md)

## Relations & tags
- **Tags** : `metier:traitement-charpente famille:specialises sous-famille:traitement-charpente intervention:controler cluster:inspection cluster:surveillance complexite:moyenne type:entretien securite:hauteur relation:charpente`

## Historique
| Version | Date | Auteur | Validateur | Motif |
|---|---|---|---|---|
| v0.1 | 2026-08-05 | IA | ⟦—⟧ | proposition initiale (Brouillon) |
