# Identifier les champignons lignivores et la mérule

> **Brouillon (v0) — proposé par IA, en attente de validation métier** (Loi 7/18). Modèle : [../../../cards/CARD_TEMPLATE.md](../../../cards/CARD_TEMPLATE.md).
> Niveaux de confiance : A normes/fabricant · B technique · C terrain validé · D hypothèse. Rien n'est publié comme certitude.

## Métadonnées
| Champ | Valeur |
|---|---|
| Identifiant | `identifier-champignons-merule` |
| Titre | Identifier les champignons lignivores et la mérule |
| Profession | `metier:traitement-charpente` |
| Famille | `famille:specialises` |
| Sous-famille | `sous-famille:traitement-charpente` |
| Version | v0.1 |
| Auteur | IA (proposition) |
| Validateur | ⟦à valider métier⟧ |
| Statut | Brouillon |
| Indice de confiance | **C** |

## Cadrage
- **Objectif** : reconnaître les **champignons lignivores** (pourritures) et la **mérule** (présentation) — danger lié à l'humidité. `[C]`
- **Résumé** : identifier les **pourritures** du bois (cubique/fibreuse) dues aux **champignons lignivores** et, en particulier, la **mérule pleureuse** (présentation) : filaments, fructifications rouille, odeur de champignon, bois qui s'effrite en cubes — elle se propage même dans la maçonnerie et impose une **obligation d'information** ; la cause est toujours l'**humidité** : la traiter est prioritaire. En cas de mérule, **arrêt** et recours à un **professionnel spécialisé**. `[C]` ⟦identification mérule / obligations à confirmer⟧

## Réalisation
- **Étapes** *(compréhension / diagnostic / organisation — aucun protocole d'application de biocides décrit)* :
  1. Reconnaître les **pourritures** (cubique/fibreuse). `[C]` → [bois-pourri-champignon](../../../diagnostics/traitement-charpente/bois-pourri-champignon.md)
  2. **Mérule** (présentation) : propagation, obligation d'information. `[A]`
  3. Traiter la **cause = humidité** en priorité. `[A]` → [comprendre-role-humidite](comprendre-role-humidite.md)
  4. Mérule avérée → **professionnel spécialisé**. `[C]`
- **Points critiques** : pourriture identifiée ; **mérule** = danger + obligation d'info ; **humidité = cause à traiter** ; recours spécialisé.
- **Sécurité** : spores/poussières ; structure affaiblie ; humidité. **Produits biocides** : les traitements du bois utilisent des **produits dangereux** (toxiques/irritants, parfois inflammables) — leur **application professionnelle** est **réglementée** (**Certibiocide**, Règlement Biocides), sous EPI, ventilation et protection des occupants ; **ce Livre ne décrit aucun protocole d'application** (présentation uniquement). **Travail en hauteur / combles** : accès difficile, planchers fragiles, chutes. **Poussières de bois** (cancérogènes, débris d'attaque) → aspiration/masque. **Électricité** en combles : prudence (câblage). **Amiante** (anciens traitements, matériaux en combles/calorifuge) : diagnostic ; retrait réservé à une **entreprise certifiée** (**jamais ici**). **Protection des occupants / animaux** pendant traitement (relais professionnel). **Structure affaiblie** par l'attaque = **risque d'effondrement** → **arrêt immédiat en cas de danger.** `[A]`

## Cadre & suites
- **Normes** : charpente / structure bois traitée (**interface** charpente) **DTU 31.1** ; humidité / remédiation du bâti (**interface** maçonnerie) **DTU 20.1** ; classes d'emploi / risque biologique **NF EN 335**, durabilité **NF EN 350**, efficacité des produits de préservation **NF EN 599**, diagnostic **termites** (Code de la construction, déclaration en mairie), **mérule** (obligation d'information) et **Règlement Biocides UE 528/2012 / Certibiocide** ⟦en prose, à confirmer⟧ `[B]` ⟦références/versions exactes à confirmer par le validateur⟧. `respecte-norme`
- **Rôle de l'humidité** : `cite-carte` → [comprendre-role-humidite](comprendre-role-humidite.md)

## Relations & tags
- **Tags** : `metier:traitement-charpente famille:specialises sous-famille:traitement-charpente intervention:comprendre cluster:champignons-lignivores cluster:merule cluster:humidite complexite:moyenne type:principe securite:biocides`

## Historique
| Version | Date | Auteur | Validateur | Motif |
|---|---|---|---|---|
| v0.1 | 2026-08-05 | IA | ⟦—⟧ | proposition initiale (Brouillon) |
