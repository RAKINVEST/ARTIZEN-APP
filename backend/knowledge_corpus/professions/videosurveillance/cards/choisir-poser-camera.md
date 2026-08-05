# Choisir et poser une caméra

> **Brouillon (v0) — proposé par IA, en attente de validation métier** (Loi 7/18). Modèle : [../../../cards/CARD_TEMPLATE.md](../../../cards/CARD_TEMPLATE.md).
> Niveaux de confiance : A normes/fabricant · B technique · C terrain validé · D hypothèse. Rien n'est publié comme certitude.

## Métadonnées
| Champ | Valeur |
|---|---|
| Identifiant | `choisir-poser-camera` |
| Titre | Choisir et poser une caméra |
| Profession | `metier:videosurveillance` |
| Famille | `famille:electricite` |
| Sous-famille | `sous-famille:videosurveillance` |
| Version | v0.1 |
| Auteur | IA (proposition) |
| Validateur | ⟦à valider métier⟧ |
| Statut | Brouillon |
| Indice de confiance | **C** |

## Cadrage
- **Objectif** : choisir le type de caméra (IP/analogique, objectif, champ) et la poser en respectant les zones autorisées. `[C]`
- **Résumé** : sélectionner la caméra (**IP** ou **analogique**, résolution, **objectif**/focale, dome/bullet), la positionner pour couvrir la **zone à protéger** **sans filmer** la voie publique/le voisinage/les parties privatives, régler le **champ**/l'angle et la fixation (hauteur), en prévoyant la **vision nocturne** si besoin. `[C]` ⟦type/focale/emplacement selon site à confirmer⟧

## Réalisation
- **Étapes** :
  1. Choisir caméra (IP/analogique, résolution, **objectif**). `[C]`
  2. Positionner sur la **zone autorisée** (pas voie publique/voisinage). `[A]`
  3. Régler champ/angle ; fixer (hauteur/travail en hauteur). `[C]`
  4. Prévoir **vision nocturne** si besoin. `[C]` → [regler-objectifs-vision-nocturne](regler-objectifs-vision-nocturne.md)
- **Points critiques** : **zones filmées limitées** (RGPD/droit à l'image) ; champ utile ; éviter contre-jour ; fixation/hauteur.
- **Sécurité** : hauteur (pose) ; RGPD/zones filmées ; électrique/PoE. **Consignation** si intervention sur l'**alimentation électrique** (switch PoE, injecteur, bloc) — par une personne **habilitée** (NF C 18-510). **Alimentation PoE** : basse tension sur le câble réseau, mais le **budget PoE** du switch et la longueur limitent — dimensionner (classe PoE/PoE+). **Cybersécurité** : les caméras IP sont des cibles fréquentes — **changer les mots de passe** par défaut, **mises à jour** firmware, **segmentation** (VLAN caméras), désactiver les services inutiles ; un flux compromis = atteinte à la vie privée. **Confidentialité / protection des enregistrements** : accès restreint, **durée de conservation** limitée. **RGPD / CNIL / droit à l'image** : **information** des personnes (panneaux), registre de traitement, **zones filmées** limitées (**pas la voie publique** sans autorisation préfectorale, ni les parties privatives/voisinage ; en entreprise, information CSE/salariés). **Travail en hauteur** possible. **Arrêt immédiat en cas de danger.** Interventions sur l'alimentation **réservées aux habilités**.** `[A]`

## Cadre & suites
- **Normes** : alimentation électrique / **PoE** **NF C 15-100** ; consignation à l'intervention **NF C 18-510** ; systèmes de vidéosurveillance **EN 62676**, protection des données (**RGPD**, **CNIL**), cadre voie publique (**Code de la sécurité intérieure**) et cybersécurité (**ANSSI**) ⟦en prose, à confirmer⟧ `[B]` ⟦références/versions exactes à confirmer par le validateur⟧. `respecte-norme`
- **Câblage / PoE** : `cite-carte` → [cabler-alimenter-poe](cabler-alimenter-poe.md)

## Relations & tags
- **Tags** : `metier:videosurveillance famille:electricite sous-famille:videosurveillance intervention:poser cluster:cameras-ip cluster:cameras-analogiques cluster:objectifs complexite:moyenne type:installation securite:rgpd`

## Historique
| Version | Date | Auteur | Validateur | Motif |
|---|---|---|---|---|
| v0.1 | 2026-08-05 | IA | ⟦—⟧ | proposition initiale (Brouillon) |
