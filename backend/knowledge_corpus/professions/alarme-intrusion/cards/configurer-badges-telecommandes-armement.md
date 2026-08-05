# Configurer badges, télécommandes & scénarios d'armement

> **Brouillon (v0) — proposé par IA, en attente de validation métier** (Loi 7/18). Modèle : [../../../cards/CARD_TEMPLATE.md](../../../cards/CARD_TEMPLATE.md).
> Niveaux de confiance : A normes/fabricant · B technique · C terrain validé · D hypothèse. Rien n'est publié comme certitude.

## Métadonnées
| Champ | Valeur |
|---|---|
| Identifiant | `configurer-badges-telecommandes-armement` |
| Titre | Configurer badges, télécommandes & scénarios d'armement |
| Profession | `metier:alarme-intrusion` |
| Famille | `famille:electricite` |
| Sous-famille | `sous-famille:alarme-intrusion` |
| Version | v0.1 |
| Auteur | IA (proposition) |
| Validateur | ⟦à valider métier⟧ |
| Statut | Brouillon |
| Indice de confiance | **C** |

## Cadrage
- **Objectif** : configurer les **badges/télécommandes** et les **scénarios d'armement** (total, partiel, par zones). `[C]`
- **Résumé** : créer les accès utilisateurs (**codes/badges/télécommandes**) avec droits adaptés, définir les **scénarios d'armement** (total / **partiel** nuit-présence / par zones) et les temporisations d'entrée/sortie, et documenter ; une **intégration domotique** éventuelle relève du Livre Domotique. `[C]` ⟦droits/scénarios selon usage à confirmer⟧

## Réalisation
- **Étapes** :
  1. Créer **codes/badges/télécommandes** (droits adaptés). `[C]`
  2. Définir **scénarios d'armement** (total/partiel/zones). `[C]`
  3. Régler temporisations entrée/sortie ; contraintes anti-erreur. `[C]`
  4. **Intégration domotique** éventuelle (pilotage). `[C]` → [creer-scenarios-pilotage](../../../professions/domotique/cards/creer-scenarios-pilotage.md)
- **Points critiques** : droits/badges maîtrisés (**confidentialité**) ; scénarios cohérents (éviter oublis/faux déclenchements) ; documentation.
- **Sécurité** : confidentialité/RGPD (codes/badges) ; cyber. **Consignation** si intervention sur l'**alimentation électrique** de la centrale/des équipements — par une personne **habilitée** (NF C 18-510). **Continuité de fonctionnement** : une alarme protège — la mettre hors service pendant une intervention laisse le site **non protégé** (prévenir, planifier), **batterie de secours** vérifiée. **Autoprotection (tamper) / sabotage** : ne jamais neutraliser les autoprotections ; toute ouverture de boîtier doit déclencher l'autoprotection. **Faux déclenchements** : emplacement/réglage des détecteurs (animaux, chaleur, courants d'air) pour éviter les alarmes intempestives. **Cybersécurité des systèmes connectés** : centrale/transmetteur IP → mots de passe, mises à jour, segmentation (système compromis = protection contournée). **Confidentialité / RGPD** : codes, badges, journaux d'événements = données à protéger. **Arrêt immédiat en cas de danger.** Les interventions sur l'alimentation électrique sont **réservées aux professionnels habilités**.** `[A]`

## Cadre & suites
- **Normes** : alimentation électrique de la centrale **NF C 15-100** ; consignation à l'intervention **NF C 18-510** ; systèmes d'alarme intrusion **EN 50131** (grades), règles **APSAD** (R81/R82) / certification **NF&A2P** (**CNPP**), données **RGPD** et cybersécurité (**ANSSI**) ⟦en prose, à confirmer⟧ `[B]` ⟦références/versions exactes à confirmer par le validateur⟧. `respecte-norme`
- **Sécurisation** : `cite-carte` → [securiser-systeme-connecte](securiser-systeme-connecte.md)

## Relations & tags
- **Tags** : `metier:alarme-intrusion famille:electricite sous-famille:alarme-intrusion intervention:configurer cluster:badges cluster:telecommandes cluster:scenarios-d-armement complexite:moyenne type:configuration securite:donnees relation:domotique`

## Historique
| Version | Date | Auteur | Validateur | Motif |
|---|---|---|---|---|
| v0.1 | 2026-08-05 | IA | ⟦—⟧ | proposition initiale (Brouillon) |
