# Choisir le protocole et la passerelle

> **Brouillon (v0) — proposé par IA, en attente de validation métier** (Loi 7/18). Modèle : [../../../cards/CARD_TEMPLATE.md](../../../cards/CARD_TEMPLATE.md).
> Niveaux de confiance : A normes/fabricant · B technique · C terrain validé · D hypothèse. Rien n'est publié comme certitude.

## Métadonnées
| Champ | Valeur |
|---|---|
| Identifiant | `choisir-protocole-passerelle` |
| Titre | Choisir le protocole et la passerelle |
| Profession | `metier:domotique` |
| Famille | `famille:electricite` |
| Sous-famille | `sous-famille:domotique` |
| Version | v0.1 |
| Auteur | IA (proposition) |
| Validateur | ⟦à valider métier⟧ |
| Statut | Brouillon |
| Indice de confiance | **C** |

## Cadrage
- **Objectif** : choisir le(s) **protocole(s)** domotique(s) et la **passerelle** selon l'interopérabilité, la pérennité et la sécurité. `[C]`
- **Résumé** : comparer les protocoles — **KNX** (filaire, pérenne), **Zigbee/Z-Wave** (radio maillé), **Wi-Fi**, **Matter/Thread** (interopérabilité) — et choisir la **passerelle/box** qui les fédère, en privilégiant l'**interopérabilité**, la maintenance dans le temps et la **sécurité** (pas de dépendance cloud non maîtrisée). `[C]` ⟦protocoles/passerelle selon écosystème à confirmer⟧

## Réalisation
- **Étapes** :
  1. **KNX** (filaire, pérenne) vs **radio** (Zigbee/Z-Wave). `[C]` ⟦à confirmer⟧
  2. **Matter/Thread** pour l'interopérabilité. `[C]`
  3. Choisir la **passerelle/box** qui fédère les protocoles. `[C]` → [installer-box-domotique](installer-box-domotique.md)
  4. Privilégier **interopérabilité** + maintenance + sécurité (local). `[C]`
- **Points critiques** : interopérabilité/pérennité ; éviter la dépendance à un **cloud** non maîtrisé ; sécurité des échanges.
- **Sécurité** : cyber (choix d'écosystème) ; données (cloud). **Coexistence courant fort / courant faible** : le pilotage agit sur des **actionneurs** raccordés au réseau — toute intervention sur la partie **courant fort** (module au tableau, actionneur volet/éclairage) relève de la **sécurité électrique** et exige la **consignation** par une personne **habilitée** (NF C 18-510) — **réservé habilité**. **Cybersécurité des objets connectés** : changer les mots de passe par défaut, **segmenter le réseau** (VLAN/IoT), **mises à jour**, désactiver les services inutiles — un objet compromis = accès au logement. **Protection des données (RGPD)** : capteurs/assistants collectent des données personnelles → information de l'utilisateur, minimisation, hébergement maîtrisé. **Sécurité fonctionnelle** : un scénario ne doit jamais créer de situation dangereuse → **repli sûr** (incendie/coupure). **Arrêt immédiat en cas de danger.** Les interventions sur les circuits électriques sont **réservées aux professionnels habilités**.** `[A]`

## Cadre & suites
- **Normes** : circuits / **actionneurs** pilotés **NF C 15-100** ; consignation à proximité des courants forts **NF C 18-510** ; systèmes domotiques **KNX (ISO/IEC 14543-3)**, protocoles (Zigbee/Z-Wave/**Matter**/Thread), performance de l'automatisation **NF EN ISO 52120**, cybersécurité (**ANSSI**) et données (**RGPD**) ⟦en prose, à confirmer⟧ `[B]` ⟦références/versions exactes à confirmer par le validateur⟧. `respecte-norme`
- **Sécurisation** : `cite-procedure` → [securiser-reseau-domotique](../../../procedures/domotique/securiser-reseau-domotique.md)

## Relations & tags
- **Tags** : `metier:domotique famille:electricite sous-famille:domotique intervention:choisir cluster:protocoles-domotiques cluster:passerelles complexite:moyenne type:reference securite:cyber`

## Historique
| Version | Date | Auteur | Validateur | Motif |
|---|---|---|---|---|
| v0.1 | 2026-08-05 | IA | ⟦—⟧ | proposition initiale (Brouillon) |
