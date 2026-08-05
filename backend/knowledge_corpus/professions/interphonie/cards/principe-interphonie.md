# Principe de l'interphonie / visiophonie

> **Brouillon (v0) — proposé par IA, en attente de validation métier** (Loi 7/18). Modèle : [../../../cards/CARD_TEMPLATE.md](../../../cards/CARD_TEMPLATE.md).
> Niveaux de confiance : A normes/fabricant · B technique · C terrain validé · D hypothèse. Rien n'est publié comme certitude.

## Métadonnées
| Champ | Valeur |
|---|---|
| Identifiant | `principe-interphonie` |
| Titre | Principe de l'interphonie / visiophonie |
| Profession | `metier:interphonie` |
| Famille | `famille:electricite` |
| Sous-famille | `sous-famille:interphonie` |
| Version | v0.1 |
| Auteur | IA (proposition) |
| Validateur | ⟦à valider métier⟧ |
| Statut | Brouillon |
| Indice de confiance | **C** |

## Cadrage
- **Objectif** : comprendre l'interphonie : **platine de rue ↔ moniteur/combiné intérieur**, en audio ou **visiophonie**, et ses technologies. `[C]`
- **Résumé** : l'interphonie permet de **communiquer** avec un visiteur à l'entrée et de **déverrouiller** la porte : une **platine de rue** (bouton, micro, éventuelle **caméra** = visiophonie) dialogue avec un **moniteur/combiné** intérieur, en **bus 2 fils** ou en **IP/SIP** ; la **gâche** commandée n'est vue qu'en **interface** (le contrôle d'accès est un métier distinct). `[C]` ⟦audio/vidéo, 2 fils/IP selon projet à confirmer⟧

## Réalisation
- **Étapes** :
  1. **Platine de rue** (audio / **visiophonie**). `[C]` → [installer-platine-rue](installer-platine-rue.md)
  2. **Moniteur / combiné** intérieur. `[C]` → [installer-moniteur-combine](installer-moniteur-combine.md)
  3. Technologie : **bus 2 fils** ou **IP/SIP**. `[C]` → [installer-interphonie-ip-sip](installer-interphonie-ip-sip.md)
  4. **Gâche** commandée = **interface** (Contrôle d'accès). `[C]` → [raccorder-commande-gache](raccorder-commande-gache.md)
- **Points critiques** : audio vs **visiophonie** (caméra → RGPD) ; **2 fils vs IP/SIP** ; gâche = interface ; ne pas absorber Contrôle d'accès/Vidéo.
- **Sécurité** : alimentation (consignation) ; cyber (IP) ; RGPD (visiophone). **Consignation** si intervention sur l'**alimentation électrique** (bloc/transformateur) — par une personne **habilitée** (NF C 18-510). **Coexistence courants forts / courants faibles** : séparer le bus interphone du câblage de puissance (NF C 15-100). **Cybersécurité IP/SIP** : platines/moniteurs connectés = cibles → mots de passe, mises à jour, segmentation, protocoles sécurisés. **RGPD / protection de la vie privée** : un **visiophone comporte une caméra** — si des **images sont enregistrées/transmises**, ce sont des données personnelles (information, durée limitée, ne pas filmer au-delà de l'entrée/la voie publique). **Continuité de fonctionnement** : en collectif, prévoir le comportement en coupure (**alimentation secourue** si applicable) sans jamais entraver une issue de secours (le déverrouillage de sécurité relève du **Contrôle d'accès**). **Arrêt immédiat en cas de danger.** Interventions sur l'alimentation **réservées aux habilités**.** `[A]`

## Cadre & suites
- **Normes** : alimentation des équipements **NF C 15-100** ; consignation à l'intervention **NF C 18-510** ; systèmes d'interphonie de bâtiment **EN 62820**, communication **SIP** (IP), données/images (**RGPD**, **CNIL**) et cybersécurité (**ANSSI**) ⟦en prose, à confirmer⟧ `[B]` ⟦références/versions exactes à confirmer par le validateur⟧. `respecte-norme`
- **Sécurisation / RGPD** : `cite-carte` → [securiser-configurer-interphonie](securiser-configurer-interphonie.md)

## Relations & tags
- **Tags** : `metier:interphonie famille:electricite sous-famille:interphonie intervention:comprendre cluster:interphones-audio cluster:visiophones cluster:platines-de-rue cluster:moniteurs-interieurs cluster:bus-2-fils type:principe securite:coexistence`

## Historique
| Version | Date | Auteur | Validateur | Motif |
|---|---|---|---|---|
| v0.1 | 2026-08-05 | IA | ⟦—⟧ | proposition initiale (Brouillon) |
