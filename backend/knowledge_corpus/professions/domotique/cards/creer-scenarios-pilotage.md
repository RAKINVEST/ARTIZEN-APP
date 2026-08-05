# Créer des scénarios et le pilotage

> **Brouillon (v0) — proposé par IA, en attente de validation métier** (Loi 7/18). Modèle : [../../../cards/CARD_TEMPLATE.md](../../../cards/CARD_TEMPLATE.md).
> Niveaux de confiance : A normes/fabricant · B technique · C terrain validé · D hypothèse. Rien n'est publié comme certitude.

## Métadonnées
| Champ | Valeur |
|---|---|
| Identifiant | `creer-scenarios-pilotage` |
| Titre | Créer des scénarios et le pilotage |
| Profession | `metier:domotique` |
| Famille | `famille:electricite` |
| Sous-famille | `sous-famille:domotique` |
| Version | v0.1 |
| Auteur | IA (proposition) |
| Validateur | ⟦à valider métier⟧ |
| Statut | Brouillon |
| Indice de confiance | **C** |

## Cadrage
- **Objectif** : créer des **scénarios** d'automatisation (conditions/actions) et le pilotage des équipements, avec un **repli sûr**. `[C]`
- **Résumé** : définir des scénarios (déclencheurs : horaire/capteur/présence → actions : éclairage/volets/chauffage), tester chaque cas, et garantir un **repli sûr** : un scénario ne doit **jamais créer de situation dangereuse** (ex. volets qui bloquent une issue en cas d'incendie, coupure de chauffage en gel). `[C]` ⟦scénarios selon besoins à confirmer⟧

## Réalisation
- **Étapes** :
  1. Définir déclencheurs (horaire/capteur/présence). `[C]`
  2. Définir actions (éclairage/volets/chauffage). `[C]`
  3. **Tester** chaque scénario (dont cas de défaut). `[C]`
  4. Garantir un **repli sûr** (incendie/coupure/perte réseau). `[A]`
- **Points critiques** : **repli sûr** prioritaire (jamais de situation dangereuse) ; tester les cas limites ; simplicité pour l'utilisateur.
- **Sécurité** : sécurité fonctionnelle (repli sûr) ; cyber ; électrique. **Coexistence courant fort / courant faible** : le pilotage agit sur des **actionneurs** raccordés au réseau — toute intervention sur la partie **courant fort** (module au tableau, actionneur volet/éclairage) relève de la **sécurité électrique** et exige la **consignation** par une personne **habilitée** (NF C 18-510) — **réservé habilité**. **Cybersécurité des objets connectés** : changer les mots de passe par défaut, **segmenter le réseau** (VLAN/IoT), **mises à jour**, désactiver les services inutiles — un objet compromis = accès au logement. **Protection des données (RGPD)** : capteurs/assistants collectent des données personnelles → information de l'utilisateur, minimisation, hébergement maîtrisé. **Sécurité fonctionnelle** : un scénario ne doit jamais créer de situation dangereuse → **repli sûr** (incendie/coupure). **Arrêt immédiat en cas de danger.** Les interventions sur les circuits électriques sont **réservées aux professionnels habilités**.** `[A]`

## Cadre & suites
- **Normes** : circuits / **actionneurs** pilotés **NF C 15-100** ; consignation à proximité des courants forts **NF C 18-510** ; systèmes domotiques **KNX (ISO/IEC 14543-3)**, protocoles (Zigbee/Z-Wave/**Matter**/Thread), performance de l'automatisation **NF EN ISO 52120**, cybersécurité (**ANSSI**) et données (**RGPD**) ⟦en prose, à confirmer⟧ `[B]` ⟦références/versions exactes à confirmer par le validateur⟧. `respecte-norme`
- **Comportement anormal** : `traite-diagnostic` → [scenario-comportement-anormal](../../../diagnostics/domotique/scenario-comportement-anormal.md)

## Relations & tags
- **Tags** : `metier:domotique famille:electricite sous-famille:domotique intervention:realiser cluster:scenarios cluster:pilotage-des-equipements complexite:avancee type:technique securite:coexistence relation:chauffage`

## Historique
| Version | Date | Auteur | Validateur | Motif |
|---|---|---|---|---|
| v0.1 | 2026-08-05 | IA | ⟦—⟧ | proposition initiale (Brouillon) |
