# Sécuriser / maintenir une installation domotique

> **Brouillon (v0) — proposé par IA, en attente de validation métier** (Loi 7/18). Modèle : [../../../cards/CARD_TEMPLATE.md](../../../cards/CARD_TEMPLATE.md).
> Niveaux de confiance : A normes/fabricant · B technique · C terrain validé · D hypothèse. Rien n'est publié comme certitude.

## Métadonnées
| Champ | Valeur |
|---|---|
| Identifiant | `securiser-maintenir-domotique` |
| Titre | Sécuriser / maintenir une installation domotique |
| Profession | `metier:domotique` |
| Famille | `famille:electricite` |
| Sous-famille | `sous-famille:domotique` |
| Version | v0.1 |
| Auteur | IA (proposition) |
| Validateur | ⟦à valider métier⟧ |
| Statut | Brouillon |
| Indice de confiance | **C** |

## Cadrage
- **Objectif** : maintenir une installation domotique et assurer sa **cybersécurité** dans le temps (mises à jour, sauvegardes). `[C]`
- **Résumé** : appliquer les **mises à jour** (box/objets), vérifier la **segmentation réseau** et les mots de passe, tester les scénarios critiques et le **repli sûr**, contrôler les piles des capteurs, et maintenir des **sauvegardes** de la configuration ; documenter l'installation. `[C]`

## Réalisation
- **Étapes** :
  1. Appliquer les **mises à jour** (box/objets connectés). `[A]`
  2. Vérifier **segmentation** + mots de passe (cyber). `[A]` → [securiser-reseau-domotique](../../../procedures/domotique/securiser-reseau-domotique.md)
  3. Tester scénarios critiques / **repli sûr** ; piles capteurs. `[C]`
  4. Maintenir **sauvegardes** + documentation. `[C]`
- **Points critiques** : **mises à jour** = cybersécurité ; sauvegardes ; repli sûr testé ; documentation à jour (éviter le système « boîte noire »).
- **Sécurité** : cyber (obsolescence) ; données ; électrique. **Coexistence courant fort / courant faible** : le pilotage agit sur des **actionneurs** raccordés au réseau — toute intervention sur la partie **courant fort** (module au tableau, actionneur volet/éclairage) relève de la **sécurité électrique** et exige la **consignation** par une personne **habilitée** (NF C 18-510) — **réservé habilité**. **Cybersécurité des objets connectés** : changer les mots de passe par défaut, **segmenter le réseau** (VLAN/IoT), **mises à jour**, désactiver les services inutiles — un objet compromis = accès au logement. **Protection des données (RGPD)** : capteurs/assistants collectent des données personnelles → information de l'utilisateur, minimisation, hébergement maîtrisé. **Sécurité fonctionnelle** : un scénario ne doit jamais créer de situation dangereuse → **repli sûr** (incendie/coupure). **Arrêt immédiat en cas de danger.** Les interventions sur les circuits électriques sont **réservées aux professionnels habilités**.** `[A]`

## Cadre & suites
- **Normes** : circuits / **actionneurs** pilotés **NF C 15-100** ; consignation à proximité des courants forts **NF C 18-510** ; systèmes domotiques **KNX (ISO/IEC 14543-3)**, protocoles (Zigbee/Z-Wave/**Matter**/Thread), performance de l'automatisation **NF EN ISO 52120**, cybersécurité (**ANSSI**) et données (**RGPD**) ⟦en prose, à confirmer⟧ `[B]` ⟦références/versions exactes à confirmer par le validateur⟧. `respecte-norme`
- **Kit** : `utilise-kit` → [kit-domotique](../../../kits/domotique/kit-domotique.md)

## Relations & tags
- **Tags** : `metier:domotique famille:electricite sous-famille:domotique intervention:entretenir intervention:securiser cluster:automatisation-du-batiment cluster:gtb-residentielle complexite:moyenne type:entretien securite:cyber`

## Historique
| Version | Date | Auteur | Validateur | Motif |
|---|---|---|---|---|
| v0.1 | 2026-08-05 | IA | ⟦—⟧ | proposition initiale (Brouillon) |
