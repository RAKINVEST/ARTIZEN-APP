# Prévenir, entretenir et documenter

> **Brouillon (v0) — proposé par IA, en attente de validation métier** (Loi 7/18). Modèle : [../../../cards/CARD_TEMPLATE.md](../../../cards/CARD_TEMPLATE.md).
> Niveaux de confiance : A normes/fabricant · B technique · C terrain validé · D hypothèse. Rien n'est publié comme certitude.

## Métadonnées
| Champ | Valeur |
|---|---|
| Identifiant | `prevenir-entretenir-documenter` |
| Titre | Prévenir, entretenir et documenter |
| Profession | `metier:traitement-charpente` |
| Famille | `famille:specialises` |
| Sous-famille | `sous-famille:traitement-charpente` |
| Version | v0.1 |
| Auteur | IA (proposition) |
| Validateur | ⟦à valider métier⟧ |
| Statut | Brouillon |
| Indice de confiance | **C** |

## Cadrage
- **Objectif** : assurer la **prévention**, l'**entretien** et la **documentation** (réglementation termites/mérule, traçabilité). `[C]`
- **Résumé** : mettre en place la **prévention durable** (maîtrise de l'humidité, ventilation, abords sains, bois adapté), programmer l'**entretien/surveillance**, et **documenter** : constats d'inspection, état parasitaire, respect des **obligations réglementaires** (diagnostic **termites** et **déclaration en mairie** en zone concernée, **information mérule**), et traçabilité des interventions ; en rénovation, vigilance **amiante** (anciens matériaux). `[C]`

## Réalisation
- **Étapes** *(compréhension / diagnostic / organisation — aucun protocole d'application de biocides décrit)* :
  1. **Prévenir** (humidité/ventilation/abords/bois adapté). `[C]`
  2. Programmer **entretien/surveillance** ; consigner. `[C]` → [controle-surveillance-charpente](../../../checklists/traitement-charpente/controle-surveillance-charpente.md)
  3. **Obligations** : termites (déclaration mairie), info **mérule**. `[A]`
  4. Rénovation : matériaux anciens → **amiante** (arrêt/orientation). `[A]` → [arreter-signaler-en-cas-de-doute](../../../professions/desamiantage/cards/arreter-signaler-en-cas-de-doute.md)
- **Points critiques** : prévention durable (humidité) ; **obligations termites/mérule** respectées ; traçabilité ; **amiante** vigilance (renvoi).
- **Sécurité** : biocides ; hauteur ; amiante (rénovation). **Produits biocides** : les traitements du bois utilisent des **produits dangereux** (toxiques/irritants, parfois inflammables) — leur **application professionnelle** est **réglementée** (**Certibiocide**, Règlement Biocides), sous EPI, ventilation et protection des occupants ; **ce Livre ne décrit aucun protocole d'application** (présentation uniquement). **Travail en hauteur / combles** : accès difficile, planchers fragiles, chutes. **Poussières de bois** (cancérogènes, débris d'attaque) → aspiration/masque. **Électricité** en combles : prudence (câblage). **Amiante** (anciens traitements, matériaux en combles/calorifuge) : diagnostic ; retrait réservé à une **entreprise certifiée** (**jamais ici**). **Protection des occupants / animaux** pendant traitement (relais professionnel). **Structure affaiblie** par l'attaque = **risque d'effondrement** → **arrêt immédiat en cas de danger.** `[A]`

## Cadre & suites
- **Normes** : charpente / structure bois traitée (**interface** charpente) **DTU 31.1** ; humidité / remédiation du bâti (**interface** maçonnerie) **DTU 20.1** ; classes d'emploi / risque biologique **NF EN 335**, durabilité **NF EN 350**, efficacité des produits de préservation **NF EN 599**, diagnostic **termites** (Code de la construction, déclaration en mairie), **mérule** (obligation d'information) et **Règlement Biocides UE 528/2012 / Certibiocide** ⟦en prose, à confirmer⟧ `[B]` ⟦références/versions exactes à confirmer par le validateur⟧. `respecte-norme`
- **Kit** : `utilise-kit` → [kit-diagnostic-charpente](../../../kits/traitement-charpente/kit-diagnostic-charpente.md)

## Relations & tags
- **Tags** : `metier:traitement-charpente famille:specialises sous-famille:traitement-charpente intervention:entretenir intervention:controler cluster:prevention cluster:entretien cluster:documentation complexite:moyenne type:entretien securite:biocides relation:desamiantage`

## Historique
| Version | Date | Auteur | Validateur | Motif |
|---|---|---|---|---|
| v0.1 | 2026-08-05 | IA | ⟦—⟧ | proposition initiale (Brouillon) |
