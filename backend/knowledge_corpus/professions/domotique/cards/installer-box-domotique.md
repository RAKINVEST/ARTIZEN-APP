# Installer la box / le contrôleur domotique

> **Brouillon (v0) — proposé par IA, en attente de validation métier** (Loi 7/18). Modèle : [../../../cards/CARD_TEMPLATE.md](../../../cards/CARD_TEMPLATE.md).
> Niveaux de confiance : A normes/fabricant · B technique · C terrain validé · D hypothèse. Rien n'est publié comme certitude.

## Métadonnées
| Champ | Valeur |
|---|---|
| Identifiant | `installer-box-domotique` |
| Titre | Installer la box / le contrôleur domotique |
| Profession | `metier:domotique` |
| Famille | `famille:electricite` |
| Sous-famille | `sous-famille:domotique` |
| Version | v0.1 |
| Auteur | IA (proposition) |
| Validateur | ⟦à valider métier⟧ |
| Statut | Brouillon |
| Indice de confiance | **C** |

## Cadrage
- **Objectif** : installer et raccorder la box/contrôleur central (cœur du système) sur l'infrastructure réseau. `[C]`
- **Résumé** : poser la box/contrôleur, la raccorder au **réseau** (VDI/RJ45 de préférence, sinon Wi-Fi), l'alimenter (secours/onduleur conseillé), l'intégrer sur un **segment réseau dédié (IoT)**, effectuer la configuration initiale et la **sauvegarde** ; le raccordement réseau relève du **VDI**. `[C]` ⟦modèle/alimentation selon système à confirmer⟧

## Réalisation
- **Étapes** :
  1. Raccorder au **réseau** (VDI/RJ45) ; alimentation (secours conseillé). `[C]` → [cabler-rj45-reseau](../../../professions/reseaux-vdi/cards/cabler-rj45-reseau.md)
  2. Placer sur un **segment IoT dédié** (sécurité). `[C]`
  3. Configuration initiale ; **changer les mots de passe** par défaut. `[A]`
  4. **Sauvegarder** la configuration. `[C]` → [securiser-reseau-domotique](../../../procedures/domotique/securiser-reseau-domotique.md)
- **Points critiques** : réseau fiable (filaire de préférence) ; **segment IoT** ; mots de passe/mises à jour ; **sauvegarde** de la config.
- **Sécurité** : cyber ; électrique (alimentation) ; données. **Coexistence courant fort / courant faible** : le pilotage agit sur des **actionneurs** raccordés au réseau — toute intervention sur la partie **courant fort** (module au tableau, actionneur volet/éclairage) relève de la **sécurité électrique** et exige la **consignation** par une personne **habilitée** (NF C 18-510) — **réservé habilité**. **Cybersécurité des objets connectés** : changer les mots de passe par défaut, **segmenter le réseau** (VLAN/IoT), **mises à jour**, désactiver les services inutiles — un objet compromis = accès au logement. **Protection des données (RGPD)** : capteurs/assistants collectent des données personnelles → information de l'utilisateur, minimisation, hébergement maîtrisé. **Sécurité fonctionnelle** : un scénario ne doit jamais créer de situation dangereuse → **repli sûr** (incendie/coupure). **Arrêt immédiat en cas de danger.** Les interventions sur les circuits électriques sont **réservées aux professionnels habilités**.** `[A]`

## Cadre & suites
- **Normes** : circuits / **actionneurs** pilotés **NF C 15-100** ; consignation à proximité des courants forts **NF C 18-510** ; systèmes domotiques **KNX (ISO/IEC 14543-3)**, protocoles (Zigbee/Z-Wave/**Matter**/Thread), performance de l'automatisation **NF EN ISO 52120**, cybersécurité (**ANSSI**) et données (**RGPD**) ⟦en prose, à confirmer⟧ `[B]` ⟦références/versions exactes à confirmer par le validateur⟧. `respecte-norme`
- **Assistant vocal** : `cite-carte` → [configurer-assistant-vocal](configurer-assistant-vocal.md)

## Relations & tags
- **Tags** : `metier:domotique famille:electricite sous-famille:domotique intervention:poser cluster:passerelles cluster:automatisation-du-batiment complexite:avancee type:installation securite:cyber relation:reseaux-vdi`

## Historique
| Version | Date | Auteur | Validateur | Motif |
|---|---|---|---|---|
| v0.1 | 2026-08-05 | IA | ⟦—⟧ | proposition initiale (Brouillon) |
