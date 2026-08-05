# Câbler et alimenter (PoE)

> **Brouillon (v0) — proposé par IA, en attente de validation métier** (Loi 7/18). Modèle : [../../../cards/CARD_TEMPLATE.md](../../../cards/CARD_TEMPLATE.md).
> Niveaux de confiance : A normes/fabricant · B technique · C terrain validé · D hypothèse. Rien n'est publié comme certitude.

## Métadonnées
| Champ | Valeur |
|---|---|
| Identifiant | `cabler-alimenter-poe` |
| Titre | Câbler et alimenter (PoE) |
| Profession | `metier:videosurveillance` |
| Famille | `famille:electricite` |
| Sous-famille | `sous-famille:videosurveillance` |
| Version | v0.1 |
| Auteur | IA (proposition) |
| Validateur | ⟦à valider métier⟧ |
| Statut | Brouillon |
| Indice de confiance | **C** |

## Cadrage
- **Objectif** : câbler et alimenter les caméras IP en **PoE** (ou les analogiques en coaxial/alim), sur l'infrastructure réseau. `[C]`
- **Résumé** : pour l'**IP**, alimenter les caméras via **PoE** (switch PoE/injecteur) sur le câblage RJ45 en respectant la **classe PoE** et la longueur (100 m), et le **budget PoE** du switch ; pour l'analogique, coaxial + alimentation ; l'infrastructure réseau relève du **VDI**, l'alimentation du switch de l'**Électricité** (habilité). `[C]` ⟦classe PoE/budget selon caméras à confirmer⟧

## Réalisation
- **Étapes** :
  1. **IP** : alimenter en **PoE** (switch/injecteur) sur RJ45. `[C]` → [cabler-rj45-reseau](../../../professions/reseaux-vdi/cards/cabler-rj45-reseau.md)
  2. Respecter **classe PoE / budget** du switch + longueur. `[B]` ⟦à confirmer⟧
  3. **Analogique** : coaxial + alimentation dédiée. `[C]`
  4. Alimentation du switch/bloc = **habilité** (consignation). `[A]` → [controler-tableau-electrique](../../../professions/electricite-generale/cards/controler-tableau-electrique.md)
- **Points critiques** : **budget/classe PoE** ; longueur de câble ; séparation courants forts (VDI) ; alimentation switch **réservée habilité**.
- **Sécurité** : électrique (switch/alim) ; PoE ; hauteur. **Consignation** si intervention sur l'**alimentation électrique** (switch PoE, injecteur, bloc) — par une personne **habilitée** (NF C 18-510). **Alimentation PoE** : basse tension sur le câble réseau, mais le **budget PoE** du switch et la longueur limitent — dimensionner (classe PoE/PoE+). **Cybersécurité** : les caméras IP sont des cibles fréquentes — **changer les mots de passe** par défaut, **mises à jour** firmware, **segmentation** (VLAN caméras), désactiver les services inutiles ; un flux compromis = atteinte à la vie privée. **Confidentialité / protection des enregistrements** : accès restreint, **durée de conservation** limitée. **RGPD / CNIL / droit à l'image** : **information** des personnes (panneaux), registre de traitement, **zones filmées** limitées (**pas la voie publique** sans autorisation préfectorale, ni les parties privatives/voisinage ; en entreprise, information CSE/salariés). **Travail en hauteur** possible. **Arrêt immédiat en cas de danger.** Interventions sur l'alimentation **réservées aux habilités**.** `[A]`

## Cadre & suites
- **Normes** : alimentation électrique / **PoE** **NF C 15-100** ; consignation à l'intervention **NF C 18-510** ; systèmes de vidéosurveillance **EN 62676**, protection des données (**RGPD**, **CNIL**), cadre voie publique (**Code de la sécurité intérieure**) et cybersécurité (**ANSSI**) ⟦en prose, à confirmer⟧ `[B]` ⟦références/versions exactes à confirmer par le validateur⟧. `respecte-norme`
- **Enregistreur** : `cite-carte` → [installer-nvr-dvr-stockage](installer-nvr-dvr-stockage.md)

## Relations & tags
- **Tags** : `metier:videosurveillance famille:electricite sous-famille:videosurveillance intervention:realiser cluster:poe cluster:cameras-ip complexite:avancee type:installation securite:electrique relation:reseaux-vdi relation:electricite-generale`

## Historique
| Version | Date | Auteur | Validateur | Motif |
|---|---|---|---|---|
| v0.1 | 2026-08-05 | IA | ⟦—⟧ | proposition initiale (Brouillon) |
