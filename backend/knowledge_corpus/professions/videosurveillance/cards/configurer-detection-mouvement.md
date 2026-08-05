# Configurer la détection de mouvement

> **Brouillon (v0) — proposé par IA, en attente de validation métier** (Loi 7/18). Modèle : [../../../cards/CARD_TEMPLATE.md](../../../cards/CARD_TEMPLATE.md).
> Niveaux de confiance : A normes/fabricant · B technique · C terrain validé · D hypothèse. Rien n'est publié comme certitude.

## Métadonnées
| Champ | Valeur |
|---|---|
| Identifiant | `configurer-detection-mouvement` |
| Titre | Configurer la détection de mouvement |
| Profession | `metier:videosurveillance` |
| Famille | `famille:electricite` |
| Sous-famille | `sous-famille:videosurveillance` |
| Version | v0.1 |
| Auteur | IA (proposition) |
| Validateur | ⟦à valider métier⟧ |
| Statut | Brouillon |
| Indice de confiance | **C** |

## Cadrage
- **Objectif** : configurer la **détection de mouvement** (zones, sensibilité, notifications) pour l'enregistrement/l'alerte. `[C]`
- **Résumé** : définir des **zones de détection** (et masquages de confidentialité sur les parties non autorisées), régler la **sensibilité** pour limiter les faux positifs (végétation, ombres, animaux), paramétrer l'enregistrement/les **notifications**, et éventuellement la **levée de doute** couplée à l'alarme intrusion. `[C]` ⟦zones/sensibilité selon scène à confirmer⟧

## Réalisation
- **Étapes** :
  1. Définir **zones de détection** + **masquages** (confidentialité). `[A]`
  2. Régler la **sensibilité** (limiter faux positifs). `[C]`
  3. Paramétrer enregistrement sur événement / **notifications**. `[C]`
  4. Éventuelle **levée de doute** (couplage alarme). `[C]` → [principe-alarme-intrusion](../../../professions/alarme-intrusion/cards/principe-alarme-intrusion.md)
- **Points critiques** : **masquages de confidentialité** (zones non autorisées) ; sensibilité (faux positifs) ; couplage alarme éventuel.
- **Sécurité** : RGPD (masquages/zones) ; cyber ; faux positifs. **Consignation** si intervention sur l'**alimentation électrique** (switch PoE, injecteur, bloc) — par une personne **habilitée** (NF C 18-510). **Alimentation PoE** : basse tension sur le câble réseau, mais le **budget PoE** du switch et la longueur limitent — dimensionner (classe PoE/PoE+). **Cybersécurité** : les caméras IP sont des cibles fréquentes — **changer les mots de passe** par défaut, **mises à jour** firmware, **segmentation** (VLAN caméras), désactiver les services inutiles ; un flux compromis = atteinte à la vie privée. **Confidentialité / protection des enregistrements** : accès restreint, **durée de conservation** limitée. **RGPD / CNIL / droit à l'image** : **information** des personnes (panneaux), registre de traitement, **zones filmées** limitées (**pas la voie publique** sans autorisation préfectorale, ni les parties privatives/voisinage ; en entreprise, information CSE/salariés). **Travail en hauteur** possible. **Arrêt immédiat en cas de danger.** Interventions sur l'alimentation **réservées aux habilités**.** `[A]`

## Cadre & suites
- **Normes** : alimentation électrique / **PoE** **NF C 15-100** ; consignation à l'intervention **NF C 18-510** ; systèmes de vidéosurveillance **EN 62676**, protection des données (**RGPD**, **CNIL**), cadre voie publique (**Code de la sécurité intérieure**) et cybersécurité (**ANSSI**) ⟦en prose, à confirmer⟧ `[B]` ⟦références/versions exactes à confirmer par le validateur⟧. `respecte-norme`
- **Essais / maintenance** : `cite-carte` → [essayer-maintenir-videosurveillance](essayer-maintenir-videosurveillance.md)

## Relations & tags
- **Tags** : `metier:videosurveillance famille:electricite sous-famille:videosurveillance intervention:configurer cluster:detection-de-mouvement cluster:enregistrement complexite:moyenne type:configuration securite:rgpd relation:alarme-intrusion`

## Historique
| Version | Date | Auteur | Validateur | Motif |
|---|---|---|---|---|
| v0.1 | 2026-08-05 | IA | ⟦—⟧ | proposition initiale (Brouillon) |
