# Essayer / maintenir l'interphonie

> **Brouillon (v0) — proposé par IA, en attente de validation métier** (Loi 7/18). Modèle : [../../../cards/CARD_TEMPLATE.md](../../../cards/CARD_TEMPLATE.md).
> Niveaux de confiance : A normes/fabricant · B technique · C terrain validé · D hypothèse. Rien n'est publié comme certitude.

## Métadonnées
| Champ | Valeur |
|---|---|
| Identifiant | `essayer-maintenir-interphonie` |
| Titre | Essayer / maintenir l'interphonie |
| Profession | `metier:interphonie` |
| Famille | `famille:electricite` |
| Sous-famille | `sous-famille:interphonie` |
| Version | v0.1 |
| Auteur | IA (proposition) |
| Validateur | ⟦à valider métier⟧ |
| Statut | Brouillon |
| Indice de confiance | **C** |

## Cadrage
- **Objectif** : réaliser les **essais** (appel, audio, vidéo, ouverture) et la **maintenance** (alimentation, nettoyage, MAJ). `[C]`
- **Résumé** : tester l'**appel** depuis la platine, la **communication audio** et **vidéo** (jour/nuit), la **commande d'ouverture**, contrôler l'**alimentation** (et le secours si applicable), nettoyer l'optique/le clavier de la platine, appliquer les MAJ et documenter. `[C]`

## Réalisation
- **Étapes** :
  1. Tester **appel + audio + vidéo** (jour/nuit). `[C]` → [probleme-image-visiophone](../../../diagnostics/interphonie/probleme-image-visiophone.md)
  2. Tester la **commande d'ouverture** (interface gâche). `[C]` → [gache-ne-fonctionne-pas](../../../diagnostics/interphonie/gache-ne-fonctionne-pas.md)
  3. Contrôler l'**alimentation** (secours si applicable) ; nettoyer platine. `[C]`
  4. Appliquer MAJ (cyber) ; documenter. `[C]`
- **Points critiques** : appel/audio/vidéo fonctionnels ; ouverture OK ; alimentation ; optique platine propre ; MAJ.
- **Sécurité** : électrique (alim) ; cyber ; RGPD. **Consignation** si intervention sur l'**alimentation électrique** (bloc/transformateur) — par une personne **habilitée** (NF C 18-510). **Coexistence courants forts / courants faibles** : séparer le bus interphone du câblage de puissance (NF C 15-100). **Cybersécurité IP/SIP** : platines/moniteurs connectés = cibles → mots de passe, mises à jour, segmentation, protocoles sécurisés. **RGPD / protection de la vie privée** : un **visiophone comporte une caméra** — si des **images sont enregistrées/transmises**, ce sont des données personnelles (information, durée limitée, ne pas filmer au-delà de l'entrée/la voie publique). **Continuité de fonctionnement** : en collectif, prévoir le comportement en coupure (**alimentation secourue** si applicable) sans jamais entraver une issue de secours (le déverrouillage de sécurité relève du **Contrôle d'accès**). **Arrêt immédiat en cas de danger.** Interventions sur l'alimentation **réservées aux habilités**.** `[A]`

## Cadre & suites
- **Normes** : alimentation des équipements **NF C 15-100** ; consignation à l'intervention **NF C 18-510** ; systèmes d'interphonie de bâtiment **EN 62820**, communication **SIP** (IP), données/images (**RGPD**, **CNIL**) et cybersécurité (**ANSSI**) ⟦en prose, à confirmer⟧ `[B]` ⟦références/versions exactes à confirmer par le validateur⟧. `respecte-norme`
- **Kit** : `utilise-kit` → [kit-interphonie](../../../kits/interphonie/kit-interphonie.md)

## Relations & tags
- **Tags** : `metier:interphonie famille:electricite sous-famille:interphonie intervention:entretenir intervention:controler cluster:essais cluster:maintenance cluster:diagnostic complexite:moyenne type:entretien securite:coexistence`

## Historique
| Version | Date | Auteur | Validateur | Motif |
|---|---|---|---|---|
| v0.1 | 2026-08-05 | IA | ⟦—⟧ | proposition initiale (Brouillon) |
