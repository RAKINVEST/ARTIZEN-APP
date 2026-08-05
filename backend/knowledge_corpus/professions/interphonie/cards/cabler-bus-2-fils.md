# Câbler un bus 2 fils

> **Brouillon (v0) — proposé par IA, en attente de validation métier** (Loi 7/18). Modèle : [../../../cards/CARD_TEMPLATE.md](../../../cards/CARD_TEMPLATE.md).
> Niveaux de confiance : A normes/fabricant · B technique · C terrain validé · D hypothèse. Rien n'est publié comme certitude.

## Métadonnées
| Champ | Valeur |
|---|---|
| Identifiant | `cabler-bus-2-fils` |
| Titre | Câbler un bus 2 fils |
| Profession | `metier:interphonie` |
| Famille | `famille:electricite` |
| Sous-famille | `sous-famille:interphonie` |
| Version | v0.1 |
| Auteur | IA (proposition) |
| Validateur | ⟦à valider métier⟧ |
| Statut | Brouillon |
| Indice de confiance | **C** |

## Cadrage
- **Objectif** : câbler une interphonie **bus 2 fils** (platine ↔ moniteurs) en respectant polarité et distances. `[C]`
- **Résumé** : tirer le **bus 2 fils** entre la platine et les moniteurs (souvent non polarisé selon fabricant, mais à vérifier), respecter la **section**/la **longueur maximale** et les dérivations autorisées, séparer des courants forts, et adresser les postes ; le 2 fils simplifie le câblage vs l'IP. `[C]` ⟦section/longueur/topologie selon fabricant à confirmer⟧

## Réalisation
- **Étapes** :
  1. Tirer le **bus 2 fils** (section/longueur max). `[C]` ⟦à confirmer⟧
  2. Respecter la **topologie** (étoile/chaîne selon fabricant). `[C]`
  3. **Séparer** des courants forts (coexistence). `[C]`
  4. Adresser les postes ; tester. `[C]` → [pas-de-communication-audio](../../../diagnostics/interphonie/pas-de-communication-audio.md)
- **Points critiques** : section/longueur respectées ; topologie fabricant ; **séparation courants forts** ; adressage correct.
- **Sécurité** : coexistence CF/CFa ; électrique ; — **Consignation** si intervention sur l'**alimentation électrique** (bloc/transformateur) — par une personne **habilitée** (NF C 18-510). **Coexistence courants forts / courants faibles** : séparer le bus interphone du câblage de puissance (NF C 15-100). **Cybersécurité IP/SIP** : platines/moniteurs connectés = cibles → mots de passe, mises à jour, segmentation, protocoles sécurisés. **RGPD / protection de la vie privée** : un **visiophone comporte une caméra** — si des **images sont enregistrées/transmises**, ce sont des données personnelles (information, durée limitée, ne pas filmer au-delà de l'entrée/la voie publique). **Continuité de fonctionnement** : en collectif, prévoir le comportement en coupure (**alimentation secourue** si applicable) sans jamais entraver une issue de secours (le déverrouillage de sécurité relève du **Contrôle d'accès**). **Arrêt immédiat en cas de danger.** Interventions sur l'alimentation **réservées aux habilités**.** `[A]`

## Cadre & suites
- **Normes** : alimentation des équipements **NF C 15-100** ; consignation à l'intervention **NF C 18-510** ; systèmes d'interphonie de bâtiment **EN 62820**, communication **SIP** (IP), données/images (**RGPD**, **CNIL**) et cybersécurité (**ANSSI**) ⟦en prose, à confirmer⟧ `[B]` ⟦références/versions exactes à confirmer par le validateur⟧. `respecte-norme`
- **Alternative IP/SIP** : `cite-carte` → [installer-interphonie-ip-sip](installer-interphonie-ip-sip.md)

## Relations & tags
- **Tags** : `metier:interphonie famille:electricite sous-famille:interphonie intervention:realiser cluster:bus-2-fils cluster:communication-audio complexite:moyenne type:installation securite:coexistence`

## Historique
| Version | Date | Auteur | Validateur | Motif |
|---|---|---|---|---|
| v0.1 | 2026-08-05 | IA | ⟦—⟧ | proposition initiale (Brouillon) |
