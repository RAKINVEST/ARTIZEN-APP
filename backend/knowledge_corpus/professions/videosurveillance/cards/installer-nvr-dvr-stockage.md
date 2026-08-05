# Installer NVR/DVR & stockage

> **Brouillon (v0) — proposé par IA, en attente de validation métier** (Loi 7/18). Modèle : [../../../cards/CARD_TEMPLATE.md](../../../cards/CARD_TEMPLATE.md).
> Niveaux de confiance : A normes/fabricant · B technique · C terrain validé · D hypothèse. Rien n'est publié comme certitude.

## Métadonnées
| Champ | Valeur |
|---|---|
| Identifiant | `installer-nvr-dvr-stockage` |
| Titre | Installer NVR/DVR & stockage |
| Profession | `metier:videosurveillance` |
| Famille | `famille:electricite` |
| Sous-famille | `sous-famille:videosurveillance` |
| Version | v0.1 |
| Auteur | IA (proposition) |
| Validateur | ⟦à valider métier⟧ |
| Statut | Brouillon |
| Indice de confiance | **C** |

## Cadrage
- **Objectif** : installer l'enregistreur (**NVR** IP / **DVR** analogique) et dimensionner le **stockage** (durée de conservation). `[C]`
- **Résumé** : poser le **NVR**/**DVR**, y ajouter les caméras (flux), configurer l'**enregistrement** (continu/sur événement) et dimensionner le **stockage** (disques) selon la résolution, le nombre de caméras et la **durée de conservation** (limitée — RGPD), avec accès restreint et sauvegarde/protection des enregistrements. `[C]` ⟦durée de conservation/volume selon RGPD à confirmer⟧

## Réalisation
- **Étapes** :
  1. Poser le **NVR/DVR** ; ajouter les flux caméras. `[C]`
  2. Configurer l'**enregistrement** (continu / sur détection). `[C]` → [configurer-detection-mouvement](configurer-detection-mouvement.md)
  3. Dimensionner le **stockage** + **durée de conservation** (RGPD). `[A]` ⟦à confirmer⟧
  4. **Accès restreint** + protection des enregistrements. `[A]`
- **Points critiques** : **durée de conservation limitée** (RGPD) ; stockage dimensionné ; accès restreint ; protection des images.
- **Sécurité** : confidentialité/RGPD (enregistrements) ; cyber ; électrique. **Consignation** si intervention sur l'**alimentation électrique** (switch PoE, injecteur, bloc) — par une personne **habilitée** (NF C 18-510). **Alimentation PoE** : basse tension sur le câble réseau, mais le **budget PoE** du switch et la longueur limitent — dimensionner (classe PoE/PoE+). **Cybersécurité** : les caméras IP sont des cibles fréquentes — **changer les mots de passe** par défaut, **mises à jour** firmware, **segmentation** (VLAN caméras), désactiver les services inutiles ; un flux compromis = atteinte à la vie privée. **Confidentialité / protection des enregistrements** : accès restreint, **durée de conservation** limitée. **RGPD / CNIL / droit à l'image** : **information** des personnes (panneaux), registre de traitement, **zones filmées** limitées (**pas la voie publique** sans autorisation préfectorale, ni les parties privatives/voisinage ; en entreprise, information CSE/salariés). **Travail en hauteur** possible. **Arrêt immédiat en cas de danger.** Interventions sur l'alimentation **réservées aux habilités**.** `[A]`

## Cadre & suites
- **Normes** : alimentation électrique / **PoE** **NF C 15-100** ; consignation à l'intervention **NF C 18-510** ; systèmes de vidéosurveillance **EN 62676**, protection des données (**RGPD**, **CNIL**), cadre voie publique (**Code de la sécurité intérieure**) et cybersécurité (**ANSSI**) ⟦en prose, à confirmer⟧ `[B]` ⟦références/versions exactes à confirmer par le validateur⟧. `respecte-norme`
- **Sécurisation** : `cite-carte` → [securiser-camera-ip](securiser-camera-ip.md)

## Relations & tags
- **Tags** : `metier:videosurveillance famille:electricite sous-famille:videosurveillance intervention:poser cluster:nvr cluster:dvr cluster:enregistrement cluster:stockage complexite:avancee type:installation securite:rgpd`

## Historique
| Version | Date | Auteur | Validateur | Motif |
|---|---|---|---|---|
| v0.1 | 2026-08-05 | IA | ⟦—⟧ | proposition initiale (Brouillon) |
