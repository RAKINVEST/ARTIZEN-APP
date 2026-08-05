# Diagnostiquer les attaques biologiques

> **Brouillon (v0) — proposé par IA, en attente de validation métier** (Loi 7/18). Modèle : [../../../cards/CARD_TEMPLATE.md](../../../cards/CARD_TEMPLATE.md).
> Niveaux de confiance : A normes/fabricant · B technique · C terrain validé · D hypothèse. Rien n'est publié comme certitude.

## Métadonnées
| Champ | Valeur |
|---|---|
| Identifiant | `diagnostiquer-attaques-biologiques` |
| Titre | Diagnostiquer les attaques biologiques |
| Profession | `metier:traitement-charpente` |
| Famille | `famille:specialises` |
| Sous-famille | `sous-famille:traitement-charpente` |
| Version | v0.1 |
| Auteur | IA (proposition) |
| Validateur | ⟦à valider métier⟧ |
| Statut | Brouillon |
| Indice de confiance | **C** |

## Cadrage
- **Objectif** : identifier et diagnostiquer les **attaques biologiques** du bois (insectes, champignons, termites) et leur étendue. `[C]`
- **Résumé** : rechercher les **indices** d'attaque : trous d'envol, **vermoulure** (sciure), galeries, sons creux au **sondage**, bois qui s'effrite, taches/fructifications de champignons, cordons de **termites** ; évaluer l'**activité** (attaque active ou ancienne), l'étendue et l'**atteinte structurelle** ; en cas de doute sur l'espèce ou l'ampleur, faire appel à un **diagnostic** spécialisé. `[C]` ⟦méthode de diagnostic selon espèce à confirmer⟧

## Réalisation
- **Étapes** *(compréhension / diagnostic / organisation — aucun protocole d'application de biocides décrit)* :
  1. Rechercher les **indices** (trous/vermoulure/galeries/sondage). `[C]`
  2. Évaluer l'**activité** et l'atteinte structurelle. `[A]` → [charpente-affaissee-affaiblie](../../../diagnostics/traitement-charpente/charpente-affaissee-affaiblie.md)
  3. Distinguer **insectes / champignons / termites**. `[C]` → [identifier-insectes-xylophages](identifier-insectes-xylophages.md)
  4. Doute d'espèce/ampleur → **diagnostic** spécialisé (métier distinct). `[C]`
- **Points critiques** : **activité** de l'attaque évaluée ; atteinte structurelle jaugée ; espèce identifiée ; diagnostic spécialisé si doute.
- **Sécurité** : poussières/débris ; hauteur (combles) ; structure affaiblie. **Produits biocides** : les traitements du bois utilisent des **produits dangereux** (toxiques/irritants, parfois inflammables) — leur **application professionnelle** est **réglementée** (**Certibiocide**, Règlement Biocides), sous EPI, ventilation et protection des occupants ; **ce Livre ne décrit aucun protocole d'application** (présentation uniquement). **Travail en hauteur / combles** : accès difficile, planchers fragiles, chutes. **Poussières de bois** (cancérogènes, débris d'attaque) → aspiration/masque. **Électricité** en combles : prudence (câblage). **Amiante** (anciens traitements, matériaux en combles/calorifuge) : diagnostic ; retrait réservé à une **entreprise certifiée** (**jamais ici**). **Protection des occupants / animaux** pendant traitement (relais professionnel). **Structure affaiblie** par l'attaque = **risque d'effondrement** → **arrêt immédiat en cas de danger.** `[A]`

## Cadre & suites
- **Normes** : charpente / structure bois traitée (**interface** charpente) **DTU 31.1** ; humidité / remédiation du bâti (**interface** maçonnerie) **DTU 20.1** ; classes d'emploi / risque biologique **NF EN 335**, durabilité **NF EN 350**, efficacité des produits de préservation **NF EN 599**, diagnostic **termites** (Code de la construction, déclaration en mairie), **mérule** (obligation d'information) et **Règlement Biocides UE 528/2012 / Certibiocide** ⟦en prose, à confirmer⟧ `[B]` ⟦références/versions exactes à confirmer par le validateur⟧. `respecte-norme`
- **Champignons / mérule** : `cite-carte` → [identifier-champignons-merule](identifier-champignons-merule.md)

## Relations & tags
- **Tags** : `metier:traitement-charpente famille:specialises sous-famille:traitement-charpente intervention:comprendre cluster:diagnostic cluster:insectes-xylophages cluster:termites complexite:moyenne type:principe securite:biocides`

## Historique
| Version | Date | Auteur | Validateur | Motif |
|---|---|---|---|---|
| v0.1 | 2026-08-05 | IA | ⟦—⟧ | proposition initiale (Brouillon) |
