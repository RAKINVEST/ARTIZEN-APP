# Poser des détecteurs volumétriques

> **Brouillon (v0) — proposé par IA, en attente de validation métier** (Loi 7/18). Modèle : [../../../cards/CARD_TEMPLATE.md](../../../cards/CARD_TEMPLATE.md).
> Niveaux de confiance : A normes/fabricant · B technique · C terrain validé · D hypothèse. Rien n'est publié comme certitude.

## Métadonnées
| Champ | Valeur |
|---|---|
| Identifiant | `poser-detecteurs-volumetriques` |
| Titre | Poser des détecteurs volumétriques |
| Profession | `metier:alarme-intrusion` |
| Famille | `famille:electricite` |
| Sous-famille | `sous-famille:alarme-intrusion` |
| Version | v0.1 |
| Auteur | IA (proposition) |
| Validateur | ⟦à valider métier⟧ |
| Statut | Brouillon |
| Indice de confiance | **C** |

## Cadrage
- **Objectif** : poser des **détecteurs volumétriques** (infrarouge/double techno) en évitant les faux déclenchements. `[C]`
- **Résumé** : positionner les détecteurs **volumétriques** (IRP / **double technologie** IR+hyperfréquence) à la hauteur/l'angle utiles pour couvrir le volume, en évitant les sources de **faux déclenchements** (soleil, chauffage, animaux → versions **anti-masquage/immunité animaux**), câbler/appairer et affecter aux zones. `[C]` ⟦type/hauteur/immunité selon local à confirmer⟧

## Réalisation
- **Étapes** :
  1. Positionner (hauteur/angle) pour couvrir le volume. `[C]`
  2. Éviter les sources de **faux déclenchements** (soleil/chaleur/animaux). `[C]`
  3. Choisir **double techno** / immunité animaux si besoin. `[C]` ⟦à confirmer⟧
  4. Câbler/appairer ; affecter aux zones ; tester. `[C]` → [fausses-alarmes](../../../diagnostics/alarme-intrusion/fausses-alarmes.md)
- **Points critiques** : emplacement anti-**faux déclenchements** (animaux/soleil) ; couverture du volume ; anti-masquage ; autoprotection.
- **Sécurité** : faux déclenchements ; autoprotection ; cyber (radio). **Consignation** si intervention sur l'**alimentation électrique** de la centrale/des équipements — par une personne **habilitée** (NF C 18-510). **Continuité de fonctionnement** : une alarme protège — la mettre hors service pendant une intervention laisse le site **non protégé** (prévenir, planifier), **batterie de secours** vérifiée. **Autoprotection (tamper) / sabotage** : ne jamais neutraliser les autoprotections ; toute ouverture de boîtier doit déclencher l'autoprotection. **Faux déclenchements** : emplacement/réglage des détecteurs (animaux, chaleur, courants d'air) pour éviter les alarmes intempestives. **Cybersécurité des systèmes connectés** : centrale/transmetteur IP → mots de passe, mises à jour, segmentation (système compromis = protection contournée). **Confidentialité / RGPD** : codes, badges, journaux d'événements = données à protéger. **Arrêt immédiat en cas de danger.** Les interventions sur l'alimentation électrique sont **réservées aux professionnels habilités**.** `[A]`

## Cadre & suites
- **Normes** : alimentation électrique de la centrale **NF C 15-100** ; consignation à l'intervention **NF C 18-510** ; systèmes d'alarme intrusion **EN 50131** (grades), règles **APSAD** (R81/R82) / certification **NF&A2P** (**CNPP**), données **RGPD** et cybersécurité (**ANSSI**) ⟦en prose, à confirmer⟧ `[B]` ⟦références/versions exactes à confirmer par le validateur⟧. `respecte-norme`
- **Sirènes / transmetteur** : `cite-carte` → [installer-sirenes-transmetteur](installer-sirenes-transmetteur.md)

## Relations & tags
- **Tags** : `metier:alarme-intrusion famille:electricite sous-famille:alarme-intrusion intervention:poser cluster:detecteurs-volumetriques cluster:detecteurs complexite:moyenne type:installation securite:autoprotection`

## Historique
| Version | Date | Auteur | Validateur | Motif |
|---|---|---|---|---|
| v0.1 | 2026-08-05 | IA | ⟦—⟧ | proposition initiale (Brouillon) |
