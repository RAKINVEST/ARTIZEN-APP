# Principe de la domotique (automatisation du bâtiment)

> **Brouillon (v0) — proposé par IA, en attente de validation métier** (Loi 7/18). Modèle : [../../../cards/CARD_TEMPLATE.md](../../../cards/CARD_TEMPLATE.md).
> Niveaux de confiance : A normes/fabricant · B technique · C terrain validé · D hypothèse. Rien n'est publié comme certitude.

## Métadonnées
| Champ | Valeur |
|---|---|
| Identifiant | `principe-domotique` |
| Titre | Principe de la domotique (automatisation du bâtiment) |
| Profession | `metier:domotique` |
| Famille | `famille:electricite` |
| Sous-famille | `sous-famille:domotique` |
| Version | v0.1 |
| Auteur | IA (proposition) |
| Validateur | ⟦à valider métier⟧ |
| Statut | Brouillon |
| Indice de confiance | **C** |

## Cadrage
- **Objectif** : comprendre l'architecture domotique : **capteurs** → **box/passerelle** → **actionneurs**, et le pilotage (scénarios). `[C]`
- **Résumé** : la domotique **automatise** le bâtiment : des **capteurs** (température, présence, ouverture) remontent des états à une **box/passerelle** qui commande des **actionneurs** (éclairage, volets, chauffage) via des **scénarios** ; en **filaire (KNX)** ou **radio** (Zigbee/Z-Wave/**Matter**), avec une logique de **GTB résidentielle** ; l'infrastructure réseau relève du **VDI** et le courant fort de l'**Électricité**. `[C]` ⟦protocole/architecture selon projet à confirmer⟧

## Réalisation
- **Étapes** :
  1. **Infrastructure réseau** (VDI : câblage/Wi-Fi). `[C]` → [cabler-rj45-reseau](../../../professions/reseaux-vdi/cards/cabler-rj45-reseau.md)
  2. **Box/passerelle** + **protocoles**. `[C]` → [choisir-protocole-passerelle](choisir-protocole-passerelle.md)
  3. **Capteurs** → **actionneurs** (courant fort = habilité). `[C]` → [installer-actionneurs](installer-actionneurs.md)
  4. **Scénarios / pilotage** (avec repli sûr). `[C]` → [creer-scenarios-pilotage](creer-scenarios-pilotage.md)
- **Points critiques** : interopérabilité (protocoles) ; **courant fort réservé habilité** ; **cybersécurité**/données ; scénarios à **repli sûr**.
- **Sécurité** : coexistence CF/CFa ; électrique (actionneurs) ; cyber. **Coexistence courant fort / courant faible** : le pilotage agit sur des **actionneurs** raccordés au réseau — toute intervention sur la partie **courant fort** (module au tableau, actionneur volet/éclairage) relève de la **sécurité électrique** et exige la **consignation** par une personne **habilitée** (NF C 18-510) — **réservé habilité**. **Cybersécurité des objets connectés** : changer les mots de passe par défaut, **segmenter le réseau** (VLAN/IoT), **mises à jour**, désactiver les services inutiles — un objet compromis = accès au logement. **Protection des données (RGPD)** : capteurs/assistants collectent des données personnelles → information de l'utilisateur, minimisation, hébergement maîtrisé. **Sécurité fonctionnelle** : un scénario ne doit jamais créer de situation dangereuse → **repli sûr** (incendie/coupure). **Arrêt immédiat en cas de danger.** Les interventions sur les circuits électriques sont **réservées aux professionnels habilités**.** `[A]`

## Cadre & suites
- **Normes** : circuits / **actionneurs** pilotés **NF C 15-100** ; consignation à proximité des courants forts **NF C 18-510** ; systèmes domotiques **KNX (ISO/IEC 14543-3)**, protocoles (Zigbee/Z-Wave/**Matter**/Thread), performance de l'automatisation **NF EN ISO 52120**, cybersécurité (**ANSSI**) et données (**RGPD**) ⟦en prose, à confirmer⟧ `[B]` ⟦références/versions exactes à confirmer par le validateur⟧. `respecte-norme`
- **Cybersécurité / maintenance** : `cite-carte` → [securiser-maintenir-domotique](securiser-maintenir-domotique.md)

## Relations & tags
- **Tags** : `metier:domotique famille:electricite sous-famille:domotique intervention:comprendre cluster:automatisation-du-batiment cluster:capteurs cluster:actionneurs cluster:gtb-residentielle cluster:protocoles-domotiques type:principe securite:coexistence relation:reseaux-vdi relation:electricite-generale`

## Historique
| Version | Date | Auteur | Validateur | Motif |
|---|---|---|---|---|
| v0.1 | 2026-08-05 | IA | ⟦—⟧ | proposition initiale (Brouillon) |
