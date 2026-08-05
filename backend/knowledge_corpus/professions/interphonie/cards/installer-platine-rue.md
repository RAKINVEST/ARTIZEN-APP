# Installer une platine de rue

> **Brouillon (v0) — proposé par IA, en attente de validation métier** (Loi 7/18). Modèle : [../../../cards/CARD_TEMPLATE.md](../../../cards/CARD_TEMPLATE.md).
> Niveaux de confiance : A normes/fabricant · B technique · C terrain validé · D hypothèse. Rien n'est publié comme certitude.

## Métadonnées
| Champ | Valeur |
|---|---|
| Identifiant | `installer-platine-rue` |
| Titre | Installer une platine de rue |
| Profession | `metier:interphonie` |
| Famille | `famille:electricite` |
| Sous-famille | `sous-famille:interphonie` |
| Version | v0.1 |
| Auteur | IA (proposition) |
| Validateur | ⟦à valider métier⟧ |
| Statut | Brouillon |
| Indice de confiance | **C** |

## Cadrage
- **Objectif** : installer la **platine de rue** (audio ou visiophonie) à l'entrée, accessible et protégée. `[C]`
- **Résumé** : poser la **platine** à hauteur/accessibilité (PMR) et à l'abri (encastrée/saillie), raccorder les **boutons d'appel** (mono/collectif), le micro/HP et, en visiophonie, la **caméra** (champ limité à l'entrée — vie privée) ; câblage vers le moniteur (2 fils/IP). `[C]` ⟦hauteur/accessibilité/champ caméra à confirmer⟧

## Réalisation
- **Étapes** :
  1. Poser la platine (hauteur/**accessibilité PMR**) ; à l'abri. `[C]` ⟦à confirmer⟧
  2. Raccorder **boutons d'appel** (individuel/collectif), micro/HP. `[C]`
  3. Visiophonie : **caméra** — champ limité à l'entrée (vie privée). `[A]`
  4. Câbler vers le moniteur. `[C]` → [cabler-bus-2-fils](cabler-bus-2-fils.md)
- **Points critiques** : accessibilité (PMR) ; **champ caméra limité** (vie privée/RGPD) ; protection mécanique/intempéries ; lisibilité des appels.
- **Sécurité** : hauteur (pose) ; RGPD (caméra) ; électrique. **Consignation** si intervention sur l'**alimentation électrique** (bloc/transformateur) — par une personne **habilitée** (NF C 18-510). **Coexistence courants forts / courants faibles** : séparer le bus interphone du câblage de puissance (NF C 15-100). **Cybersécurité IP/SIP** : platines/moniteurs connectés = cibles → mots de passe, mises à jour, segmentation, protocoles sécurisés. **RGPD / protection de la vie privée** : un **visiophone comporte une caméra** — si des **images sont enregistrées/transmises**, ce sont des données personnelles (information, durée limitée, ne pas filmer au-delà de l'entrée/la voie publique). **Continuité de fonctionnement** : en collectif, prévoir le comportement en coupure (**alimentation secourue** si applicable) sans jamais entraver une issue de secours (le déverrouillage de sécurité relève du **Contrôle d'accès**). **Arrêt immédiat en cas de danger.** Interventions sur l'alimentation **réservées aux habilités**.** `[A]`

## Cadre & suites
- **Normes** : alimentation des équipements **NF C 15-100** ; consignation à l'intervention **NF C 18-510** ; systèmes d'interphonie de bâtiment **EN 62820**, communication **SIP** (IP), données/images (**RGPD**, **CNIL**) et cybersécurité (**ANSSI**) ⟦en prose, à confirmer⟧ `[B]` ⟦références/versions exactes à confirmer par le validateur⟧. `respecte-norme`
- **Moniteur** : `cite-carte` → [installer-moniteur-combine](installer-moniteur-combine.md)

## Relations & tags
- **Tags** : `metier:interphonie famille:electricite sous-famille:interphonie intervention:poser cluster:platines-de-rue cluster:visiophones cluster:communication-audio complexite:moyenne type:installation securite:rgpd`

## Historique
| Version | Date | Auteur | Validateur | Motif |
|---|---|---|---|---|
| v0.1 | 2026-08-05 | IA | ⟦—⟧ | proposition initiale (Brouillon) |
