# Installer des actionneurs (éclairage, volets, chauffage)

> **Brouillon (v0) — proposé par IA, en attente de validation métier** (Loi 7/18). Modèle : [../../../cards/CARD_TEMPLATE.md](../../../cards/CARD_TEMPLATE.md).
> Niveaux de confiance : A normes/fabricant · B technique · C terrain validé · D hypothèse. Rien n'est publié comme certitude.

## Métadonnées
| Champ | Valeur |
|---|---|
| Identifiant | `installer-actionneurs` |
| Titre | Installer des actionneurs (éclairage, volets, chauffage) |
| Profession | `metier:domotique` |
| Famille | `famille:electricite` |
| Sous-famille | `sous-famille:domotique` |
| Version | v0.1 |
| Auteur | IA (proposition) |
| Validateur | ⟦à valider métier⟧ |
| Statut | Brouillon |
| Indice de confiance | **C** |

## Cadrage
- **Objectif** : installer des **actionneurs** pilotant des charges — la partie **courant fort** est **réservée à un électricien habilité**. `[C]`
- **Résumé** : intégrer les **actionneurs** (modules encastrés, micromodules, modules DIN au tableau) pilotant éclairage/volets/chauffage : le **raccordement au courant fort** exige la **consignation** et une personne **habilitée** (NF C 18-510) ; côté domotique, appairage/paramétrage/intégration aux scénarios. `[C]` ⟦type d'actionneur/charge selon installation à confirmer⟧

## Réalisation
- **Étapes** :
  1. **Raccordement courant fort** : **consignation + habilité**. `[A]` → [controler-tableau-electrique](../../../professions/electricite-generale/cards/controler-tableau-electrique.md)
  2. Poser l'actionneur (micromodule / module DIN). `[C]`
  3. Appairer/paramétrer côté box. `[C]`
  4. Piloter le **chauffage** (fil pilote/thermostat). `[C]` → [remplacer-robinet-thermostatique](../../../professions/chauffage/cards/remplacer-robinet-thermostatique.md)
- **Points critiques** : **courant fort = habilité/consignation** (jamais improvisé) ; compatibilité charge/actionneur ; repli sûr en cas de perte de commande.
- **Sécurité** : **sécurité électrique** (courant fort) ; coexistence CF/CFa ; cyber. **Coexistence courant fort / courant faible** : le pilotage agit sur des **actionneurs** raccordés au réseau — toute intervention sur la partie **courant fort** (module au tableau, actionneur volet/éclairage) relève de la **sécurité électrique** et exige la **consignation** par une personne **habilitée** (NF C 18-510) — **réservé habilité**. **Cybersécurité des objets connectés** : changer les mots de passe par défaut, **segmenter le réseau** (VLAN/IoT), **mises à jour**, désactiver les services inutiles — un objet compromis = accès au logement. **Protection des données (RGPD)** : capteurs/assistants collectent des données personnelles → information de l'utilisateur, minimisation, hébergement maîtrisé. **Sécurité fonctionnelle** : un scénario ne doit jamais créer de situation dangereuse → **repli sûr** (incendie/coupure). **Arrêt immédiat en cas de danger.** Les interventions sur les circuits électriques sont **réservées aux professionnels habilités**.** `[A]`

## Cadre & suites
- **Normes** : circuits / **actionneurs** pilotés **NF C 15-100** ; consignation à proximité des courants forts **NF C 18-510** ; systèmes domotiques **KNX (ISO/IEC 14543-3)**, protocoles (Zigbee/Z-Wave/**Matter**/Thread), performance de l'automatisation **NF EN ISO 52120**, cybersécurité (**ANSSI**) et données (**RGPD**) ⟦en prose, à confirmer⟧ `[B]` ⟦références/versions exactes à confirmer par le validateur⟧. `respecte-norme`
- **Pilotage** : `cite-carte` → [creer-scenarios-pilotage](creer-scenarios-pilotage.md)

## Relations & tags
- **Tags** : `metier:domotique famille:electricite sous-famille:domotique intervention:poser cluster:actionneurs cluster:pilotage-des-equipements complexite:avancee type:installation securite:electrique relation:electricite-generale relation:chauffage`

## Historique
| Version | Date | Auteur | Validateur | Motif |
|---|---|---|---|---|
| v0.1 | 2026-08-05 | IA | ⟦—⟧ | proposition initiale (Brouillon) |
