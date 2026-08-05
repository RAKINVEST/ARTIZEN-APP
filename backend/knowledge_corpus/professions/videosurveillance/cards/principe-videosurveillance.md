# Principe de la vidéosurveillance

> **Brouillon (v0) — proposé par IA, en attente de validation métier** (Loi 7/18). Modèle : [../../../cards/CARD_TEMPLATE.md](../../../cards/CARD_TEMPLATE.md).
> Niveaux de confiance : A normes/fabricant · B technique · C terrain validé · D hypothèse. Rien n'est publié comme certitude.

## Métadonnées
| Champ | Valeur |
|---|---|
| Identifiant | `principe-videosurveillance` |
| Titre | Principe de la vidéosurveillance |
| Profession | `metier:videosurveillance` |
| Famille | `famille:electricite` |
| Sous-famille | `sous-famille:videosurveillance` |
| Version | v0.1 |
| Auteur | IA (proposition) |
| Validateur | ⟦à valider métier⟧ |
| Statut | Brouillon |
| Indice de confiance | **C** |

## Cadrage
- **Objectif** : comprendre l'architecture vidéo : **caméras → enregistreur (NVR/DVR) → stockage/visualisation**, et le **cadre RGPD**. `[C]`
- **Résumé** : un système de vidéosurveillance capte des images via des **caméras** (**IP** ou **analogiques**), les **enregistre** sur un **NVR** (IP) ou **DVR** (analogique) avec un **stockage** dimensionné, pour visualisation/relecture ; toute installation est encadrée par le **RGPD/la CNIL** (information, durée, zones filmées). `[C]` ⟦architecture/nombre de caméras selon site à confirmer⟧

## Réalisation
- **Étapes** :
  1. **Caméras** (IP/analogiques) + objectifs/champ. `[C]` → [choisir-poser-camera](choisir-poser-camera.md)
  2. **NVR/DVR** + **enregistrement/stockage**. `[C]` → [installer-nvr-dvr-stockage](installer-nvr-dvr-stockage.md)
  3. **Alimentation PoE** / câblage (infra VDI). `[C]` → [cabler-alimenter-poe](cabler-alimenter-poe.md)
  4. **Conformité RGPD/CNIL** (obligatoire). `[A]` → [conformite-rgpd-videosurveillance](../../../procedures/videosurveillance/conformite-rgpd-videosurveillance.md)
- **Points critiques** : **RGPD/CNIL** dès la conception (zones/durée/information) ; dimensionnement stockage ; **cybersécurité** des caméras.
- **Sécurité** : alimentation (consignation) ; cyber ; RGPD/droit à l'image. **Consignation** si intervention sur l'**alimentation électrique** (switch PoE, injecteur, bloc) — par une personne **habilitée** (NF C 18-510). **Alimentation PoE** : basse tension sur le câble réseau, mais le **budget PoE** du switch et la longueur limitent — dimensionner (classe PoE/PoE+). **Cybersécurité** : les caméras IP sont des cibles fréquentes — **changer les mots de passe** par défaut, **mises à jour** firmware, **segmentation** (VLAN caméras), désactiver les services inutiles ; un flux compromis = atteinte à la vie privée. **Confidentialité / protection des enregistrements** : accès restreint, **durée de conservation** limitée. **RGPD / CNIL / droit à l'image** : **information** des personnes (panneaux), registre de traitement, **zones filmées** limitées (**pas la voie publique** sans autorisation préfectorale, ni les parties privatives/voisinage ; en entreprise, information CSE/salariés). **Travail en hauteur** possible. **Arrêt immédiat en cas de danger.** Interventions sur l'alimentation **réservées aux habilités**.** `[A]`

## Cadre & suites
- **Normes** : alimentation électrique / **PoE** **NF C 15-100** ; consignation à l'intervention **NF C 18-510** ; systèmes de vidéosurveillance **EN 62676**, protection des données (**RGPD**, **CNIL**), cadre voie publique (**Code de la sécurité intérieure**) et cybersécurité (**ANSSI**) ⟦en prose, à confirmer⟧ `[B]` ⟦références/versions exactes à confirmer par le validateur⟧. `respecte-norme`
- **Cybersécurité** : `cite-carte` → [securiser-camera-ip](securiser-camera-ip.md)

## Relations & tags
- **Tags** : `metier:videosurveillance famille:electricite sous-famille:videosurveillance intervention:comprendre cluster:cameras-ip cluster:cameras-analogiques cluster:nvr cluster:dvr cluster:enregistrement type:principe securite:rgpd`

## Historique
| Version | Date | Auteur | Validateur | Motif |
|---|---|---|---|---|
| v0.1 | 2026-08-05 | IA | ⟦—⟧ | proposition initiale (Brouillon) |
