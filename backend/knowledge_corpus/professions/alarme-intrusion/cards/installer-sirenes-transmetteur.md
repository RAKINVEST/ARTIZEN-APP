# Installer sirènes et transmetteur

> **Brouillon (v0) — proposé par IA, en attente de validation métier** (Loi 7/18). Modèle : [../../../cards/CARD_TEMPLATE.md](../../../cards/CARD_TEMPLATE.md).
> Niveaux de confiance : A normes/fabricant · B technique · C terrain validé · D hypothèse. Rien n'est publié comme certitude.

## Métadonnées
| Champ | Valeur |
|---|---|
| Identifiant | `installer-sirenes-transmetteur` |
| Titre | Installer sirènes et transmetteur |
| Profession | `metier:alarme-intrusion` |
| Famille | `famille:electricite` |
| Sous-famille | `sous-famille:alarme-intrusion` |
| Version | v0.1 |
| Auteur | IA (proposition) |
| Validateur | ⟦à valider métier⟧ |
| Statut | Brouillon |
| Indice de confiance | **C** |

## Cadrage
- **Objectif** : installer les **sirènes** (alerte locale) et le **transmetteur** (alerte à distance / télésurveillance). `[C]`
- **Résumé** : poser une **sirène extérieure** (autoprototégée, avec flash) et éventuellement intérieure, et un **transmetteur** (GSM/IP) pour la **notification**/la télésurveillance ; le transmetteur IP s'appuie sur l'infrastructure **VDI** — sécuriser la liaison et prévoir un **secours** (GSM). `[C]` ⟦canaux de transmission/protocole selon système à confirmer⟧

## Réalisation
- **Étapes** :
  1. Poser sirène(s) **autoprotégée(s)** (ext. avec flash). `[C]`
  2. Installer le **transmetteur** (GSM/IP) ; **secours** de transmission. `[C]`
  3. Transmetteur IP → infrastructure **VDI** (sécurisée). `[C]` → [cabler-rj45-reseau](../../../professions/reseaux-vdi/cards/cabler-rj45-reseau.md)
  4. Paramétrer notifications / télésurveillance. `[C]`
- **Points critiques** : sirène **autoprotégée** ; **transmission secourue** (double canal) ; liaison IP sécurisée ; conformité sonore (règlement).
- **Sécurité** : autoprotection ; cyber (transmetteur IP) ; électrique. **Consignation** si intervention sur l'**alimentation électrique** de la centrale/des équipements — par une personne **habilitée** (NF C 18-510). **Continuité de fonctionnement** : une alarme protège — la mettre hors service pendant une intervention laisse le site **non protégé** (prévenir, planifier), **batterie de secours** vérifiée. **Autoprotection (tamper) / sabotage** : ne jamais neutraliser les autoprotections ; toute ouverture de boîtier doit déclencher l'autoprotection. **Faux déclenchements** : emplacement/réglage des détecteurs (animaux, chaleur, courants d'air) pour éviter les alarmes intempestives. **Cybersécurité des systèmes connectés** : centrale/transmetteur IP → mots de passe, mises à jour, segmentation (système compromis = protection contournée). **Confidentialité / RGPD** : codes, badges, journaux d'événements = données à protéger. **Arrêt immédiat en cas de danger.** Les interventions sur l'alimentation électrique sont **réservées aux professionnels habilités**.** `[A]`

## Cadre & suites
- **Normes** : alimentation électrique de la centrale **NF C 15-100** ; consignation à l'intervention **NF C 18-510** ; systèmes d'alarme intrusion **EN 50131** (grades), règles **APSAD** (R81/R82) / certification **NF&A2P** (**CNPP**), données **RGPD** et cybersécurité (**ANSSI**) ⟦en prose, à confirmer⟧ `[B]` ⟦références/versions exactes à confirmer par le validateur⟧. `respecte-norme`
- **Cybersécurité** : `cite-carte` → [securiser-systeme-connecte](securiser-systeme-connecte.md)

## Relations & tags
- **Tags** : `metier:alarme-intrusion famille:electricite sous-famille:alarme-intrusion intervention:poser cluster:sirenes cluster:transmetteurs complexite:avancee type:installation securite:cyber relation:reseaux-vdi`

## Historique
| Version | Date | Auteur | Validateur | Motif |
|---|---|---|---|---|
| v0.1 | 2026-08-05 | IA | ⟦—⟧ | proposition initiale (Brouillon) |
