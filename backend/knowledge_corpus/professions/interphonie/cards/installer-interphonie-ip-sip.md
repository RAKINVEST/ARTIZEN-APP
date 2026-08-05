# Installer une interphonie IP / SIP

> **Brouillon (v0) — proposé par IA, en attente de validation métier** (Loi 7/18). Modèle : [../../../cards/CARD_TEMPLATE.md](../../../cards/CARD_TEMPLATE.md).
> Niveaux de confiance : A normes/fabricant · B technique · C terrain validé · D hypothèse. Rien n'est publié comme certitude.

## Métadonnées
| Champ | Valeur |
|---|---|
| Identifiant | `installer-interphonie-ip-sip` |
| Titre | Installer une interphonie IP / SIP |
| Profession | `metier:interphonie` |
| Famille | `famille:electricite` |
| Sous-famille | `sous-famille:interphonie` |
| Version | v0.1 |
| Auteur | IA (proposition) |
| Validateur | ⟦à valider métier⟧ |
| Statut | Brouillon |
| Indice de confiance | **C** |

## Cadrage
- **Objectif** : installer une interphonie **IP** (éventuellement **SIP**) sur l'infrastructure réseau. `[C]`
- **Résumé** : raccorder la platine/les moniteurs **IP** au réseau (souvent **PoE**), configurer l'adressage IP et le **SIP** si intégration téléphonique/renvoi mobile, sur un **segment réseau maîtrisé** ; l'infrastructure réseau relève du **VDI**, l'IP impose une **cybersécurité** soignée. `[C]` ⟦SIP/renvoi mobile selon système à confirmer⟧

## Réalisation
- **Étapes** :
  1. Raccorder platine/moniteurs **IP** (PoE) au réseau. `[C]` → [cabler-rj45-reseau](../../../professions/reseaux-vdi/cards/cabler-rj45-reseau.md)
  2. Configurer adressage IP + **SIP** (si renvoi/intégration). `[C]` ⟦à confirmer⟧
  3. Placer sur un **segment maîtrisé** ; sécuriser. `[A]` → [securiser-configurer-interphonie](securiser-configurer-interphonie.md)
  4. Éventuelle **intégration domotique**. `[C]` → [creer-scenarios-pilotage](../../../professions/domotique/cards/creer-scenarios-pilotage.md)
- **Points critiques** : réseau maîtrisé (VDI) ; **cybersécurité** (IP/SIP) ; renvoi mobile sécurisé ; qualité de service.
- **Sécurité** : cyber (IP/SIP) ; électrique/PoE ; RGPD. **Consignation** si intervention sur l'**alimentation électrique** (bloc/transformateur) — par une personne **habilitée** (NF C 18-510). **Coexistence courants forts / courants faibles** : séparer le bus interphone du câblage de puissance (NF C 15-100). **Cybersécurité IP/SIP** : platines/moniteurs connectés = cibles → mots de passe, mises à jour, segmentation, protocoles sécurisés. **RGPD / protection de la vie privée** : un **visiophone comporte une caméra** — si des **images sont enregistrées/transmises**, ce sont des données personnelles (information, durée limitée, ne pas filmer au-delà de l'entrée/la voie publique). **Continuité de fonctionnement** : en collectif, prévoir le comportement en coupure (**alimentation secourue** si applicable) sans jamais entraver une issue de secours (le déverrouillage de sécurité relève du **Contrôle d'accès**). **Arrêt immédiat en cas de danger.** Interventions sur l'alimentation **réservées aux habilités**.** `[A]`

## Cadre & suites
- **Normes** : alimentation des équipements **NF C 15-100** ; consignation à l'intervention **NF C 18-510** ; systèmes d'interphonie de bâtiment **EN 62820**, communication **SIP** (IP), données/images (**RGPD**, **CNIL**) et cybersécurité (**ANSSI**) ⟦en prose, à confirmer⟧ `[B]` ⟦références/versions exactes à confirmer par le validateur⟧. `respecte-norme`
- **Réseau (VDI)** : `relation:reseaux-vdi`

## Relations & tags
- **Tags** : `metier:interphonie famille:electricite sous-famille:interphonie intervention:poser cluster:ip cluster:sip complexite:avancee type:installation securite:cyber relation:reseaux-vdi relation:domotique`

## Historique
| Version | Date | Auteur | Validateur | Motif |
|---|---|---|---|---|
| v0.1 | 2026-08-05 | IA | ⟦—⟧ | proposition initiale (Brouillon) |
