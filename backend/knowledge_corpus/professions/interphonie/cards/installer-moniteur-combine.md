# Installer moniteur / combiné intérieur

> **Brouillon (v0) — proposé par IA, en attente de validation métier** (Loi 7/18). Modèle : [../../../cards/CARD_TEMPLATE.md](../../../cards/CARD_TEMPLATE.md).
> Niveaux de confiance : A normes/fabricant · B technique · C terrain validé · D hypothèse. Rien n'est publié comme certitude.

## Métadonnées
| Champ | Valeur |
|---|---|
| Identifiant | `installer-moniteur-combine` |
| Titre | Installer moniteur / combiné intérieur |
| Profession | `metier:interphonie` |
| Famille | `famille:electricite` |
| Sous-famille | `sous-famille:interphonie` |
| Version | v0.1 |
| Auteur | IA (proposition) |
| Validateur | ⟦à valider métier⟧ |
| Statut | Brouillon |
| Indice de confiance | **C** |

## Cadrage
- **Objectif** : installer le **moniteur** (visiophonie) ou le **combiné** (audio) intérieur et son alimentation. `[C]`
- **Résumé** : poser le moniteur/combiné à un emplacement pratique, le raccorder au bus (2 fils/IP) et à son **alimentation** (bloc/transformateur dédié), configurer l'appel/la sonnerie et, en collectif, l'adressage ; l'alimentation relève d'un **habilité**. `[C]` ⟦alimentation/adressage selon système à confirmer⟧

## Réalisation
- **Étapes** :
  1. Poser le **moniteur/combiné** (emplacement pratique). `[C]`
  2. Raccorder au bus (2 fils/IP) + **alimentation** dédiée. `[C]` → [controler-tableau-electrique](../../../professions/electricite-generale/cards/controler-tableau-electrique.md)
  3. Configurer appel/sonnerie ; **adressage** (collectif). `[C]`
  4. Tester la communication. `[C]` → [mise-en-service-interphonie](../../../procedures/interphonie/mise-en-service-interphonie.md)
- **Points critiques** : alimentation correcte (habilité) ; adressage (collectif) ; qualité audio/vidéo ; séparation courants forts.
- **Sécurité** : électrique (alim) ; coexistence CF/CFa ; — **Consignation** si intervention sur l'**alimentation électrique** (bloc/transformateur) — par une personne **habilitée** (NF C 18-510). **Coexistence courants forts / courants faibles** : séparer le bus interphone du câblage de puissance (NF C 15-100). **Cybersécurité IP/SIP** : platines/moniteurs connectés = cibles → mots de passe, mises à jour, segmentation, protocoles sécurisés. **RGPD / protection de la vie privée** : un **visiophone comporte une caméra** — si des **images sont enregistrées/transmises**, ce sont des données personnelles (information, durée limitée, ne pas filmer au-delà de l'entrée/la voie publique). **Continuité de fonctionnement** : en collectif, prévoir le comportement en coupure (**alimentation secourue** si applicable) sans jamais entraver une issue de secours (le déverrouillage de sécurité relève du **Contrôle d'accès**). **Arrêt immédiat en cas de danger.** Interventions sur l'alimentation **réservées aux habilités**.** `[A]`

## Cadre & suites
- **Normes** : alimentation des équipements **NF C 15-100** ; consignation à l'intervention **NF C 18-510** ; systèmes d'interphonie de bâtiment **EN 62820**, communication **SIP** (IP), données/images (**RGPD**, **CNIL**) et cybersécurité (**ANSSI**) ⟦en prose, à confirmer⟧ `[B]` ⟦références/versions exactes à confirmer par le validateur⟧. `respecte-norme`
- **Bus / IP** : `cite-carte` → [cabler-bus-2-fils](cabler-bus-2-fils.md)

## Relations & tags
- **Tags** : `metier:interphonie famille:electricite sous-famille:interphonie intervention:poser cluster:moniteurs-interieurs cluster:combines cluster:alimentation complexite:moyenne type:installation securite:electrique relation:electricite-generale`

## Historique
| Version | Date | Auteur | Validateur | Motif |
|---|---|---|---|---|
| v0.1 | 2026-08-05 | IA | ⟦—⟧ | proposition initiale (Brouillon) |
