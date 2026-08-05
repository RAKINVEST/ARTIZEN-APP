# Essayer / maintenir la vidéosurveillance

> **Brouillon (v0) — proposé par IA, en attente de validation métier** (Loi 7/18). Modèle : [../../../cards/CARD_TEMPLATE.md](../../../cards/CARD_TEMPLATE.md).
> Niveaux de confiance : A normes/fabricant · B technique · C terrain validé · D hypothèse. Rien n'est publié comme certitude.

## Métadonnées
| Champ | Valeur |
|---|---|
| Identifiant | `essayer-maintenir-videosurveillance` |
| Titre | Essayer / maintenir la vidéosurveillance |
| Profession | `metier:videosurveillance` |
| Famille | `famille:electricite` |
| Sous-famille | `sous-famille:videosurveillance` |
| Version | v0.1 |
| Auteur | IA (proposition) |
| Validateur | ⟦à valider métier⟧ |
| Statut | Brouillon |
| Indice de confiance | **C** |

## Cadrage
- **Objectif** : réaliser les **essais** et la **maintenance** (qualité image, enregistrement, stockage, nettoyage). `[C]`
- **Résumé** : vérifier chaque **caméra** (image jour/nuit, champ, mise au point), le bon **enregistrement** et l'état du **stockage** (disques/durée), nettoyer les optiques/capots, contrôler l'alimentation **PoE** et les mises à jour, et documenter ; toute intervention sur l'alimentation reste **réservée**. `[C]`

## Réalisation
- **Étapes** :
  1. Vérifier chaque caméra (image jour/nuit, champ). `[C]` → [mauvaise-qualite-image](../../../diagnostics/videosurveillance/mauvaise-qualite-image.md)
  2. Contrôler **enregistrement** + **stockage** (disques/durée). `[C]` → [enregistrement-manquant](../../../diagnostics/videosurveillance/enregistrement-manquant.md)
  3. Nettoyer optiques/capots ; contrôler **PoE**/MAJ. `[C]`
  4. Documenter ; vérifier la conformité RGPD. `[C]`
- **Points critiques** : image exploitable (jour/nuit) ; enregistrement/stockage OK ; optiques propres ; MAJ ; conformité maintenue.
- **Sécurité** : hauteur (nettoyage) ; électrique/PoE ; RGPD. **Consignation** si intervention sur l'**alimentation électrique** (switch PoE, injecteur, bloc) — par une personne **habilitée** (NF C 18-510). **Alimentation PoE** : basse tension sur le câble réseau, mais le **budget PoE** du switch et la longueur limitent — dimensionner (classe PoE/PoE+). **Cybersécurité** : les caméras IP sont des cibles fréquentes — **changer les mots de passe** par défaut, **mises à jour** firmware, **segmentation** (VLAN caméras), désactiver les services inutiles ; un flux compromis = atteinte à la vie privée. **Confidentialité / protection des enregistrements** : accès restreint, **durée de conservation** limitée. **RGPD / CNIL / droit à l'image** : **information** des personnes (panneaux), registre de traitement, **zones filmées** limitées (**pas la voie publique** sans autorisation préfectorale, ni les parties privatives/voisinage ; en entreprise, information CSE/salariés). **Travail en hauteur** possible. **Arrêt immédiat en cas de danger.** Interventions sur l'alimentation **réservées aux habilités**.** `[A]`

## Cadre & suites
- **Normes** : alimentation électrique / **PoE** **NF C 15-100** ; consignation à l'intervention **NF C 18-510** ; systèmes de vidéosurveillance **EN 62676**, protection des données (**RGPD**, **CNIL**), cadre voie publique (**Code de la sécurité intérieure**) et cybersécurité (**ANSSI**) ⟦en prose, à confirmer⟧ `[B]` ⟦références/versions exactes à confirmer par le validateur⟧. `respecte-norme`
- **Kit** : `utilise-kit` → [kit-videosurveillance](../../../kits/videosurveillance/kit-videosurveillance.md)

## Relations & tags
- **Tags** : `metier:videosurveillance famille:electricite sous-famille:videosurveillance intervention:entretenir intervention:controler cluster:essais cluster:maintenance cluster:diagnostic complexite:moyenne type:entretien securite:rgpd`

## Historique
| Version | Date | Auteur | Validateur | Motif |
|---|---|---|---|---|
| v0.1 | 2026-08-05 | IA | ⟦—⟧ | proposition initiale (Brouillon) |
