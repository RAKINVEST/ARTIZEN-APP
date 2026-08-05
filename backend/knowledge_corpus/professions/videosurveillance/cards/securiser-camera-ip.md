# Sécuriser les caméras IP (cyber & données)

> **Brouillon (v0) — proposé par IA, en attente de validation métier** (Loi 7/18). Modèle : [../../../cards/CARD_TEMPLATE.md](../../../cards/CARD_TEMPLATE.md).
> Niveaux de confiance : A normes/fabricant · B technique · C terrain validé · D hypothèse. Rien n'est publié comme certitude.

## Métadonnées
| Champ | Valeur |
|---|---|
| Identifiant | `securiser-camera-ip` |
| Titre | Sécuriser les caméras IP (cyber & données) |
| Profession | `metier:videosurveillance` |
| Famille | `famille:electricite` |
| Sous-famille | `sous-famille:videosurveillance` |
| Version | v0.1 |
| Auteur | IA (proposition) |
| Validateur | ⟦à valider métier⟧ |
| Statut | Brouillon |
| Indice de confiance | **C** |

## Cadrage
- **Objectif** : sécuriser les caméras/NVR IP (cybersécurité) et protéger les **enregistrements** (données personnelles). `[C]`
- **Résumé** : changer les **mots de passe** par défaut, appliquer les **mises à jour** firmware, **segmenter** le réseau (VLAN caméras isolé), désactiver les services/cloud inutiles, restreindre les accès distants, et **protéger les enregistrements** (accès/chiffrement, durée limitée) conformément au **RGPD** ; les caméras IP sont des cibles fréquentes. `[C]` ⟦mesures selon équipement à confirmer⟧

## Réalisation
- **Étapes** :
  1. **Mots de passe** (changer par défaut) + **mises à jour**. `[A]`
  2. **Segmenter** (VLAN caméras) ; désactiver cloud/services inutiles. `[A]` → [securiser-maintenir-domotique](../../../professions/domotique/cards/securiser-maintenir-domotique.md)
  3. Restreindre les accès distants ; journaliser. `[C]`
  4. **Protéger les enregistrements** (accès/durée/chiffrement) — **RGPD**. `[A]`
- **Points critiques** : caméras IP = cibles ; **segmentation**/MAJ ; protection des **enregistrements** (RGPD) ; accès restreint.
- **Sécurité** : cyber ; confidentialité/**RGPD** ; données. **Consignation** si intervention sur l'**alimentation électrique** (switch PoE, injecteur, bloc) — par une personne **habilitée** (NF C 18-510). **Alimentation PoE** : basse tension sur le câble réseau, mais le **budget PoE** du switch et la longueur limitent — dimensionner (classe PoE/PoE+). **Cybersécurité** : les caméras IP sont des cibles fréquentes — **changer les mots de passe** par défaut, **mises à jour** firmware, **segmentation** (VLAN caméras), désactiver les services inutiles ; un flux compromis = atteinte à la vie privée. **Confidentialité / protection des enregistrements** : accès restreint, **durée de conservation** limitée. **RGPD / CNIL / droit à l'image** : **information** des personnes (panneaux), registre de traitement, **zones filmées** limitées (**pas la voie publique** sans autorisation préfectorale, ni les parties privatives/voisinage ; en entreprise, information CSE/salariés). **Travail en hauteur** possible. **Arrêt immédiat en cas de danger.** Interventions sur l'alimentation **réservées aux habilités**.** `[A]`

## Cadre & suites
- **Normes** : alimentation électrique / **PoE** **NF C 15-100** ; consignation à l'intervention **NF C 18-510** ; systèmes de vidéosurveillance **EN 62676**, protection des données (**RGPD**, **CNIL**), cadre voie publique (**Code de la sécurité intérieure**) et cybersécurité (**ANSSI**) ⟦en prose, à confirmer⟧ `[B]` ⟦références/versions exactes à confirmer par le validateur⟧. `respecte-norme`
- **Conformité RGPD** : `cite-procedure` → [conformite-rgpd-videosurveillance](../../../procedures/videosurveillance/conformite-rgpd-videosurveillance.md)

## Relations & tags
- **Tags** : `metier:videosurveillance famille:electricite sous-famille:videosurveillance intervention:securiser cluster:cameras-ip cluster:nvr complexite:avancee type:configuration securite:cyber securite:rgpd`

## Historique
| Version | Date | Auteur | Validateur | Motif |
|---|---|---|---|---|
| v0.1 | 2026-08-05 | IA | ⟦—⟧ | proposition initiale (Brouillon) |
