# Configurer un assistant vocal

> **Brouillon (v0) — proposé par IA, en attente de validation métier** (Loi 7/18). Modèle : [../../../cards/CARD_TEMPLATE.md](../../../cards/CARD_TEMPLATE.md).
> Niveaux de confiance : A normes/fabricant · B technique · C terrain validé · D hypothèse. Rien n'est publié comme certitude.

## Métadonnées
| Champ | Valeur |
|---|---|
| Identifiant | `configurer-assistant-vocal` |
| Titre | Configurer un assistant vocal |
| Profession | `metier:domotique` |
| Famille | `famille:electricite` |
| Sous-famille | `sous-famille:domotique` |
| Version | v0.1 |
| Auteur | IA (proposition) |
| Validateur | ⟦à valider métier⟧ |
| Statut | Brouillon |
| Indice de confiance | **C** |

## Cadrage
- **Objectif** : intégrer un **assistant vocal** à la domotique en maîtrisant cybersécurité et **données personnelles**. `[C]`
- **Résumé** : associer l'assistant vocal (ou l'app) à la box pour piloter les équipements, en informant l'utilisateur du **traitement de ses données** (micro toujours actif, cloud), en limitant les accès (comptes/pièces sensibles) et en privilégiant les traitements **locaux** ; conformité **RGPD**. `[C]` ⟦écosystème/paramètres de confidentialité à confirmer⟧

## Réalisation
- **Étapes** :
  1. Associer l'assistant/l'app à la box. `[C]`
  2. **Informer l'utilisateur** (données/micro/cloud) — RGPD. `[A]`
  3. Limiter les accès (comptes, pièces sensibles). `[C]`
  4. Privilégier le **local** ; désactiver l'inutile. `[C]`
- **Points critiques** : **données personnelles** (micro/cloud) : transparence RGPD ; limiter les accès ; préférer le local ; comptes sécurisés.
- **Sécurité** : **données (RGPD)** ; cyber ; dépendance cloud. **Coexistence courant fort / courant faible** : le pilotage agit sur des **actionneurs** raccordés au réseau — toute intervention sur la partie **courant fort** (module au tableau, actionneur volet/éclairage) relève de la **sécurité électrique** et exige la **consignation** par une personne **habilitée** (NF C 18-510) — **réservé habilité**. **Cybersécurité des objets connectés** : changer les mots de passe par défaut, **segmenter le réseau** (VLAN/IoT), **mises à jour**, désactiver les services inutiles — un objet compromis = accès au logement. **Protection des données (RGPD)** : capteurs/assistants collectent des données personnelles → information de l'utilisateur, minimisation, hébergement maîtrisé. **Sécurité fonctionnelle** : un scénario ne doit jamais créer de situation dangereuse → **repli sûr** (incendie/coupure). **Arrêt immédiat en cas de danger.** Les interventions sur les circuits électriques sont **réservées aux professionnels habilités**.** `[A]`

## Cadre & suites
- **Normes** : circuits / **actionneurs** pilotés **NF C 15-100** ; consignation à proximité des courants forts **NF C 18-510** ; systèmes domotiques **KNX (ISO/IEC 14543-3)**, protocoles (Zigbee/Z-Wave/**Matter**/Thread), performance de l'automatisation **NF EN ISO 52120**, cybersécurité (**ANSSI**) et données (**RGPD**) ⟦en prose, à confirmer⟧ `[B]` ⟦références/versions exactes à confirmer par le validateur⟧. `respecte-norme`
- **Cybersécurité** : `cite-procedure` → [securiser-reseau-domotique](../../../procedures/domotique/securiser-reseau-domotique.md)

## Relations & tags
- **Tags** : `metier:domotique famille:electricite sous-famille:domotique intervention:configurer cluster:assistants-vocaux cluster:protocoles-domotiques complexite:moyenne type:configuration securite:donnees`

## Historique
| Version | Date | Auteur | Validateur | Motif |
|---|---|---|---|---|
| v0.1 | 2026-08-05 | IA | ⟦—⟧ | proposition initiale (Brouillon) |
