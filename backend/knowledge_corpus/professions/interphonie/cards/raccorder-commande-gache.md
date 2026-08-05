# Raccorder la commande de gâche (interface)

> **Brouillon (v0) — proposé par IA, en attente de validation métier** (Loi 7/18). Modèle : [../../../cards/CARD_TEMPLATE.md](../../../cards/CARD_TEMPLATE.md).
> Niveaux de confiance : A normes/fabricant · B technique · C terrain validé · D hypothèse. Rien n'est publié comme certitude.

## Métadonnées
| Champ | Valeur |
|---|---|
| Identifiant | `raccorder-commande-gache` |
| Titre | Raccorder la commande de gâche (interface) |
| Profession | `metier:interphonie` |
| Famille | `famille:electricite` |
| Sous-famille | `sous-famille:interphonie` |
| Version | v0.1 |
| Auteur | IA (proposition) |
| Validateur | ⟦à valider métier⟧ |
| Statut | Brouillon |
| Indice de confiance | **C** |

## Cadrage
- **Objectif** : raccorder la **commande d'ouverture** (gâche) depuis le moniteur/combiné — **interface uniquement** avec le Contrôle d'accès. `[C]`
- **Résumé** : câbler la **sortie de commande** de l'interphone vers l'organe d'ouverture (gâche/ventouse) pour déverrouiller à l'appui du bouton ; le **choix de l'organe**, le **mode de sécurité** (fail-safe) et la **sécurité incendie** relèvent du **Contrôle d'accès** — l'interphonie n'en fait que l'**interface de commande**. `[C]` ⟦tension/temporisation de gâche selon organe à confirmer⟧

## Réalisation
- **Étapes** :
  1. Câbler la **sortie commande** de l'interphone vers l'organe. `[C]`
  2. Régler la **temporisation** d'ouverture. `[C]` ⟦à confirmer⟧
  3. Organe / mode de sécurité / incendie = **Contrôle d'accès**. `[A]` → [poser-organe-verrouillage](../../../professions/controle-acces/cards/poser-organe-verrouillage.md)
  4. Tester l'ouverture depuis le moniteur. `[C]` → [gache-ne-fonctionne-pas](../../../diagnostics/interphonie/gache-ne-fonctionne-pas.md)
- **Points critiques** : **interface seulement** (ne pas absorber le Contrôle d'accès) ; sécurité incendie/organe = métier voisin ; temporisation.
- **Sécurité** : électrique ; sécurité incendie (renvoi au métier voisin) ; — **Consignation** si intervention sur l'**alimentation électrique** (bloc/transformateur) — par une personne **habilitée** (NF C 18-510). **Coexistence courants forts / courants faibles** : séparer le bus interphone du câblage de puissance (NF C 15-100). **Cybersécurité IP/SIP** : platines/moniteurs connectés = cibles → mots de passe, mises à jour, segmentation, protocoles sécurisés. **RGPD / protection de la vie privée** : un **visiophone comporte une caméra** — si des **images sont enregistrées/transmises**, ce sont des données personnelles (information, durée limitée, ne pas filmer au-delà de l'entrée/la voie publique). **Continuité de fonctionnement** : en collectif, prévoir le comportement en coupure (**alimentation secourue** si applicable) sans jamais entraver une issue de secours (le déverrouillage de sécurité relève du **Contrôle d'accès**). **Arrêt immédiat en cas de danger.** Interventions sur l'alimentation **réservées aux habilités**.** `[A]`

## Cadre & suites
- **Normes** : alimentation des équipements **NF C 15-100** ; consignation à l'intervention **NF C 18-510** ; systèmes d'interphonie de bâtiment **EN 62820**, communication **SIP** (IP), données/images (**RGPD**, **CNIL**) et cybersécurité (**ANSSI**) ⟦en prose, à confirmer⟧ `[B]` ⟦références/versions exactes à confirmer par le validateur⟧. `respecte-norme`
- **Gâche / organe (Contrôle d'accès)** : `relation:controle-acces`

## Relations & tags
- **Tags** : `metier:interphonie famille:electricite sous-famille:interphonie intervention:realiser cluster:gache-commandee cluster:communication-audio complexite:moyenne type:installation securite:electrique relation:controle-acces`

## Historique
| Version | Date | Auteur | Validateur | Motif |
|---|---|---|---|---|
| v0.1 | 2026-08-05 | IA | ⟦—⟧ | proposition initiale (Brouillon) |
