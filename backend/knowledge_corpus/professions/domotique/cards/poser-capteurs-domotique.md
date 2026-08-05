# Poser des capteurs domotiques

> **Brouillon (v0) — proposé par IA, en attente de validation métier** (Loi 7/18). Modèle : [../../../cards/CARD_TEMPLATE.md](../../../cards/CARD_TEMPLATE.md).
> Niveaux de confiance : A normes/fabricant · B technique · C terrain validé · D hypothèse. Rien n'est publié comme certitude.

## Métadonnées
| Champ | Valeur |
|---|---|
| Identifiant | `poser-capteurs-domotique` |
| Titre | Poser des capteurs domotiques |
| Profession | `metier:domotique` |
| Famille | `famille:electricite` |
| Sous-famille | `sous-famille:domotique` |
| Version | v0.1 |
| Auteur | IA (proposition) |
| Validateur | ⟦à valider métier⟧ |
| Statut | Brouillon |
| Indice de confiance | **C** |

## Cadrage
- **Objectif** : poser et appairer les **capteurs** (température, présence, ouverture, luminosité, fuite) au système. `[C]`
- **Résumé** : positionner chaque **capteur** à l'emplacement pertinent (éviter les faux positifs), l'alimenter (pile/bus), l'**appairer** à la box et vérifier la portée radio/le câblage ; certains capteurs (fuite d'eau, CO, fumée) participent à la **sécurité** — ne remplacent pas les détecteurs réglementaires. `[C]` ⟦type/emplacement selon usage à confirmer⟧

## Réalisation
- **Étapes** :
  1. Positionner le capteur (emplacement pertinent). `[C]`
  2. Alimenter (pile/bus) ; **appairer** à la box. `[C]`
  3. Vérifier portée radio / câblage ; état des piles. `[C]`
  4. Capteurs de sécurité ≠ **détecteurs réglementaires** (DAAF, etc.). `[C]`
- **Points critiques** : emplacement (éviter faux positifs) ; portée radio ; suivi des **piles** ; un capteur domotique ne remplace pas un détecteur réglementaire.
- **Sécurité** : cyber (appairage) ; données (présence). **Coexistence courant fort / courant faible** : le pilotage agit sur des **actionneurs** raccordés au réseau — toute intervention sur la partie **courant fort** (module au tableau, actionneur volet/éclairage) relève de la **sécurité électrique** et exige la **consignation** par une personne **habilitée** (NF C 18-510) — **réservé habilité**. **Cybersécurité des objets connectés** : changer les mots de passe par défaut, **segmenter le réseau** (VLAN/IoT), **mises à jour**, désactiver les services inutiles — un objet compromis = accès au logement. **Protection des données (RGPD)** : capteurs/assistants collectent des données personnelles → information de l'utilisateur, minimisation, hébergement maîtrisé. **Sécurité fonctionnelle** : un scénario ne doit jamais créer de situation dangereuse → **repli sûr** (incendie/coupure). **Arrêt immédiat en cas de danger.** Les interventions sur les circuits électriques sont **réservées aux professionnels habilités**.** `[A]`

## Cadre & suites
- **Normes** : circuits / **actionneurs** pilotés **NF C 15-100** ; consignation à proximité des courants forts **NF C 18-510** ; systèmes domotiques **KNX (ISO/IEC 14543-3)**, protocoles (Zigbee/Z-Wave/**Matter**/Thread), performance de l'automatisation **NF EN ISO 52120**, cybersécurité (**ANSSI**) et données (**RGPD**) ⟦en prose, à confirmer⟧ `[B]` ⟦références/versions exactes à confirmer par le validateur⟧. `respecte-norme`
- **Scénarios** : `cite-carte` → [creer-scenarios-pilotage](creer-scenarios-pilotage.md)

## Relations & tags
- **Tags** : `metier:domotique famille:electricite sous-famille:domotique intervention:poser cluster:capteurs complexite:moyenne type:installation securite:cyber`

## Historique
| Version | Date | Auteur | Validateur | Motif |
|---|---|---|---|---|
| v0.1 | 2026-08-05 | IA | ⟦—⟧ | proposition initiale (Brouillon) |
