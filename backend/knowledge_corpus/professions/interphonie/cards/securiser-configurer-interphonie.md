# Sécuriser / configurer (cyber & RGPD)

> **Brouillon (v0) — proposé par IA, en attente de validation métier** (Loi 7/18). Modèle : [../../../cards/CARD_TEMPLATE.md](../../../cards/CARD_TEMPLATE.md).
> Niveaux de confiance : A normes/fabricant · B technique · C terrain validé · D hypothèse. Rien n'est publié comme certitude.

## Métadonnées
| Champ | Valeur |
|---|---|
| Identifiant | `securiser-configurer-interphonie` |
| Titre | Sécuriser / configurer (cyber & RGPD) |
| Profession | `metier:interphonie` |
| Famille | `famille:electricite` |
| Sous-famille | `sous-famille:interphonie` |
| Version | v0.1 |
| Auteur | IA (proposition) |
| Validateur | ⟦à valider métier⟧ |
| Statut | Brouillon |
| Indice de confiance | **C** |

## Cadrage
- **Objectif** : sécuriser une interphonie IP (cyber) et gérer les **images du visiophone** (RGPD/vie privée). `[C]`
- **Résumé** : changer les **mots de passe** par défaut, appliquer les **mises à jour**, segmenter le réseau et sécuriser les **renvois mobiles/cloud** ; côté **visiophonie**, limiter le **champ de la caméra** à l'entrée, encadrer tout **enregistrement d'images** (RGPD) — un visiophone n'est **pas** un système de vidéosurveillance (usage/cadre distincts). `[C]` ⟦mesures/enregistrement selon équipement à confirmer⟧

## Réalisation
- **Étapes** :
  1. Mots de passe / **MAJ** / segmentation (IP/SIP). `[A]`
  2. Sécuriser les **renvois mobiles/cloud**. `[C]`
  3. **Champ caméra** limité à l'entrée ; enregistrement encadré (RGPD). `[A]`
  4. Visiophone **≠ vidéosurveillance** (cadre distinct). `[C]` → [principe-videosurveillance](../../../professions/videosurveillance/cards/principe-videosurveillance.md)
- **Points critiques** : cyber (IP/SIP/cloud) ; **RGPD/vie privée** (caméra/enregistrement) ; distinction visiophone ≠ CCTV.
- **Sécurité** : cyber ; **RGPD/vie privée** ; données. **Consignation** si intervention sur l'**alimentation électrique** (bloc/transformateur) — par une personne **habilitée** (NF C 18-510). **Coexistence courants forts / courants faibles** : séparer le bus interphone du câblage de puissance (NF C 15-100). **Cybersécurité IP/SIP** : platines/moniteurs connectés = cibles → mots de passe, mises à jour, segmentation, protocoles sécurisés. **RGPD / protection de la vie privée** : un **visiophone comporte une caméra** — si des **images sont enregistrées/transmises**, ce sont des données personnelles (information, durée limitée, ne pas filmer au-delà de l'entrée/la voie publique). **Continuité de fonctionnement** : en collectif, prévoir le comportement en coupure (**alimentation secourue** si applicable) sans jamais entraver une issue de secours (le déverrouillage de sécurité relève du **Contrôle d'accès**). **Arrêt immédiat en cas de danger.** Interventions sur l'alimentation **réservées aux habilités**.** `[A]`

## Cadre & suites
- **Normes** : alimentation des équipements **NF C 15-100** ; consignation à l'intervention **NF C 18-510** ; systèmes d'interphonie de bâtiment **EN 62820**, communication **SIP** (IP), données/images (**RGPD**, **CNIL**) et cybersécurité (**ANSSI**) ⟦en prose, à confirmer⟧ `[B]` ⟦références/versions exactes à confirmer par le validateur⟧. `respecte-norme`
- **Maintenance** : `cite-carte` → [essayer-maintenir-interphonie](essayer-maintenir-interphonie.md)

## Relations & tags
- **Tags** : `metier:interphonie famille:electricite sous-famille:interphonie intervention:securiser cluster:visiophones cluster:ip complexite:avancee type:configuration securite:cyber securite:rgpd relation:videosurveillance`

## Historique
| Version | Date | Auteur | Validateur | Motif |
|---|---|---|---|---|
| v0.1 | 2026-08-05 | IA | ⟦—⟧ | proposition initiale (Brouillon) |
