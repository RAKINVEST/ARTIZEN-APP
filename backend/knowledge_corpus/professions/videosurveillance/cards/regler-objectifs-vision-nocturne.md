# Régler objectifs et vision nocturne

> **Brouillon (v0) — proposé par IA, en attente de validation métier** (Loi 7/18). Modèle : [../../../cards/CARD_TEMPLATE.md](../../../cards/CARD_TEMPLATE.md).
> Niveaux de confiance : A normes/fabricant · B technique · C terrain validé · D hypothèse. Rien n'est publié comme certitude.

## Métadonnées
| Champ | Valeur |
|---|---|
| Identifiant | `regler-objectifs-vision-nocturne` |
| Titre | Régler objectifs et vision nocturne |
| Profession | `metier:videosurveillance` |
| Famille | `famille:electricite` |
| Sous-famille | `sous-famille:videosurveillance` |
| Version | v0.1 |
| Auteur | IA (proposition) |
| Validateur | ⟦à valider métier⟧ |
| Statut | Brouillon |
| Indice de confiance | **C** |

## Cadrage
- **Objectif** : régler l'**objectif** (focale/mise au point) et la **vision nocturne** (IR) pour une image exploitable. `[C]`
- **Résumé** : régler la **focale**/le zoom et la **mise au point** pour le champ visé, gérer l'exposition/le contre-jour (WDR), et paramétrer la **vision nocturne** (IR/basse lumière) en évitant les reflets/halos (surfaces proches, insectes) ; une image d'identification exige une **définition suffisante** à la distance utile. `[C]` ⟦focale/portée IR selon scène à confirmer⟧

## Réalisation
- **Étapes** :
  1. Régler **focale/zoom** + **mise au point** (champ visé). `[C]`
  2. Gérer exposition/**contre-jour** (WDR). `[C]`
  3. Paramétrer **vision nocturne (IR)** ; éviter reflets/halos. `[C]`
  4. Vérifier une **définition suffisante** à la distance utile. `[C]` → [mauvaise-qualite-image](../../../diagnostics/videosurveillance/mauvaise-qualite-image.md)
- **Points critiques** : définition suffisante à la distance utile ; contre-jour maîtrisé ; IR sans halo ; champ conforme aux zones autorisées.
- **Sécurité** : hauteur (réglage) ; RGPD (champ) ; électrique. **Consignation** si intervention sur l'**alimentation électrique** (switch PoE, injecteur, bloc) — par une personne **habilitée** (NF C 18-510). **Alimentation PoE** : basse tension sur le câble réseau, mais le **budget PoE** du switch et la longueur limitent — dimensionner (classe PoE/PoE+). **Cybersécurité** : les caméras IP sont des cibles fréquentes — **changer les mots de passe** par défaut, **mises à jour** firmware, **segmentation** (VLAN caméras), désactiver les services inutiles ; un flux compromis = atteinte à la vie privée. **Confidentialité / protection des enregistrements** : accès restreint, **durée de conservation** limitée. **RGPD / CNIL / droit à l'image** : **information** des personnes (panneaux), registre de traitement, **zones filmées** limitées (**pas la voie publique** sans autorisation préfectorale, ni les parties privatives/voisinage ; en entreprise, information CSE/salariés). **Travail en hauteur** possible. **Arrêt immédiat en cas de danger.** Interventions sur l'alimentation **réservées aux habilités**.** `[A]`

## Cadre & suites
- **Normes** : alimentation électrique / **PoE** **NF C 15-100** ; consignation à l'intervention **NF C 18-510** ; systèmes de vidéosurveillance **EN 62676**, protection des données (**RGPD**, **CNIL**), cadre voie publique (**Code de la sécurité intérieure**) et cybersécurité (**ANSSI**) ⟦en prose, à confirmer⟧ `[B]` ⟦références/versions exactes à confirmer par le validateur⟧. `respecte-norme`
- **Détection de mouvement** : `cite-carte` → [configurer-detection-mouvement](configurer-detection-mouvement.md)

## Relations & tags
- **Tags** : `metier:videosurveillance famille:electricite sous-famille:videosurveillance intervention:regler cluster:objectifs cluster:vision-nocturne complexite:moyenne type:reglage securite:rgpd`

## Historique
| Version | Date | Auteur | Validateur | Motif |
|---|---|---|---|---|
| v0.1 | 2026-08-05 | IA | ⟦—⟧ | proposition initiale (Brouillon) |
