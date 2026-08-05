# Motoriser / régler un store ou une pergola (capteurs)

> **Brouillon (v0) — proposé par IA, en attente de validation métier** (Loi 7/18). Modèle : [../../../cards/CARD_TEMPLATE.md](../../../cards/CARD_TEMPLATE.md).
> Niveaux de confiance : A normes/fabricant · B technique · C terrain validé · D hypothèse. Rien n'est publié comme certitude.

## Métadonnées
| Champ | Valeur |
|---|---|
| Identifiant | `motoriser-regler-store-pergola` |
| Titre | Motoriser / régler un store ou une pergola (capteurs) |
| Profession | `metier:stores-pergolas` |
| Famille | `famille:enveloppe` |
| Sous-famille | `sous-famille:stores-pergolas` |
| Version | v0.1 |
| Auteur | IA (proposition) |
| Validateur | ⟦à valider métier⟧ |
| Statut | Brouillon |
| Indice de confiance | **C** |

## Cadrage
- **Objectif** : régler la motorisation et les capteurs (vent/pluie/soleil) d'un store ou d'une pergola — le **raccordement électrique** relève de l'électricité. `[C]`
- **Résumé** : paramétrer le moteur (sens, **fins de course**), appairer la télécommande, régler les **capteurs vent/pluie/soleil** (dont la **remontée de sécurité au vent**) ; le **raccordement électrique** au réseau est **réservé à un professionnel** (Électricité). `[C]` ⟦procédure moteur selon fabricant à confirmer⟧

## Réalisation
- **Étapes** :
  1. **Raccordement électrique** : réservé → Électricité. `[A]` → [controler-tableau-electrique](../../../professions/electricite-generale/cards/controler-tableau-electrique.md)
  2. Régler moteur (sens, **fins de course**) ; appairer télécommande. `[C]`
  3. Régler **capteurs vent/pluie/soleil**. `[C]`
  4. Vérifier la **remontée de sécurité au vent** (essentielle). `[A]`
- **Points critiques** : **capteur vent = sécurité** (repli auto, sinon arrachement) ; fins de course correctes ; raccordement électrique réservé.
- **Sécurité** : électricité (raccordement → pro) ; hauteur ; pincement (essais moteur). **Travail en **hauteur** (pose en façade) : protections collectives / EPI. **Manutention** de structures lourdes (armature de store banne **sous tension**, poteaux de pergola) : risque d'écrasement — levage/binôme. **Fixation & stabilité** : un ancrage sous-dimensionné = **arrachement au vent** (danger majeur) → fixation adaptée au support et aux **charges** (vent/neige). **Motorisation / capteurs** : raccordement électrique **réservé à un professionnel** (voir Électricité). **Pincement** (mécanisme articulé, lames orientables). **Météo** (vent) surveillée. **Arrêt immédiat en cas de danger.** Une intervention relève de **compétences adaptées**.** `[A]`

## Cadre & suites
- **Normes** : fermetures / stores **DTU 34.1** ; fixation sur support maçonné **DTU 20.1** ; stores extérieurs **NF EN 13561** (classes de résistance au vent) et pergolas dimensionnées selon les **Eurocodes** (charges vent/neige) ⟦à confirmer⟧ `[B]` ⟦références/versions exactes à confirmer par le validateur⟧. `respecte-norme`
- **Diagnostic panne** : `traite-diagnostic` → [store-ne-fonctionne-plus](../../../diagnostics/stores-pergolas/store-ne-fonctionne-plus.md)

## Relations & tags
- **Tags** : `metier:stores-pergolas famille:enveloppe sous-famille:stores-pergolas intervention:regler cluster:motorisations cluster:capteurs-vent-pluie cluster:reglages complexite:avancee type:reglage securite:electrique relation:electricite-generale`

## Historique
| Version | Date | Auteur | Validateur | Motif |
|---|---|---|---|---|
| v0.1 | 2026-08-05 | IA | ⟦—⟧ | proposition initiale (Brouillon) |
