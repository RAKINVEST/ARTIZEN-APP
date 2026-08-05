# Principe de l'arrosage automatique

> **Brouillon (v0) — proposé par IA, en attente de validation métier** (Loi 7/18). Modèle : [../../../cards/CARD_TEMPLATE.md](../../../cards/CARD_TEMPLATE.md).
> Niveaux de confiance : A normes/fabricant · B technique · C terrain validé · D hypothèse. Rien n'est publié comme certitude.

## Métadonnées
| Champ | Valeur |
|---|---|
| Identifiant | `principe-arrosage` |
| Titre | Principe de l'arrosage automatique |
| Profession | `metier:arrosage` |
| Famille | `famille:specialises` |
| Sous-famille | `sous-famille:arrosage` |
| Version | v0.1 |
| Auteur | IA (proposition) |
| Validateur | ⟦à valider métier⟧ |
| Statut | Brouillon |
| Indice de confiance | **C** |

## Cadrage
- **Objectif** : comprendre la chaîne d'un arrosage automatique (besoins → secteurs → réseau → commande → diffusion) et ses frontières. `[C]`
- **Résumé** : un arrosage automatique enchaîne : **étude des besoins** en eau et découpage en **secteurs**, **réseau enterré** en **PE**, **électrovannes** commandées par un **programmateur**, diffusion par **arroseurs escamotables** ou **goutte-à-goutte**, **filtration**, puis **essais/réglages** et **hivernage** ; l'eau (plantes/sol) relève du **Paysagisme**, l'**alimentation potable** de la **Plomberie**, le **raccordement électrique** de l'**Électricité** — interfaces. `[C]` ⟦programme selon jardin à confirmer⟧

## Réalisation
- **Étapes** :
  1. **Étudier les besoins** (plantes/sol = Paysagisme). `[C]` → [analyser-terrain-implanter](../../../professions/paysagisme/cards/analyser-terrain-implanter.md)
  2. Découper en **secteurs** ; dimensionner. `[C]` → [etudier-besoins-secteurs](etudier-besoins-secteurs.md)
  3. Poser le **réseau PE** enterré ; électrovannes/programmateur. `[C]` → [poser-reseau-pe-enterre](poser-reseau-pe-enterre.md)
  4. **Essais / réglages** puis **hivernage**. `[C]` → [essayer-regler-mettre-en-service](essayer-regler-mettre-en-service.md)
- **Points critiques** : chaîne maîtrisée ; **frontières** (paysagisme/plomberie/élec/vrd/terrassement) ; **DICT** ; protection de l'eau potable.
- **Sécurité** : réseaux (DICT) ; électrique (interface) ; protection de l'eau. **Repérage des réseaux enterrés avant terrassement** (**DT-DICT**) : le réseau d'arrosage impose des **tranchées** → ne pas percer un câble/tuyau (électrocution, gaz, eau). **Tranchées** : effondrement des petites fouilles ; engins. **Risques électriques** : le **raccordement électrique** du **programmateur** et des **électrovannes** (alimentation secteur/transfo) est **réservé à un électricien** → voir Électricité (protection 30 mA, matériel extérieur IP). **Protection sanitaire de l'eau** : un réseau d'arrosage peut renvoyer de l'eau polluée vers le réseau potable → **disconnecteur / clapet anti-retour obligatoire** (**NF EN 1717**) — le raccordement détaillé relève de la **Plomberie**. **Manutention** (rouleaux PE, regards) ; **mise sous pression** : purge d'air, essais progressifs (coup de bélier). **Amiante** (rénovation, revêtements anciens) : diagnostic ; retrait réservé à une **entreprise certifiée** (**jamais ici**). **Arrêt immédiat en cas de danger.** `[A]`

## Cadre & suites
- **Normes** : raccordement à l'eau potable + **protection anti-retour** (**interface** plomberie) **DTU 60.1** ; alimentation du programmateur / électrovannes (**interface** électricité) **NF C 15-100** ; **protection contre les retours d'eau** (disconnecteur) **NF EN 1717**, tube **PE** **NF EN 12201**, réglementation **DT-DICT** (réseaux) et règlement du service des eaux ⟦en prose, à confirmer⟧ `[B]` ⟦références/versions exactes à confirmer par le validateur⟧. `respecte-norme`
- **Entretien / diagnostic** : `cite-carte` → [hiverner-entretenir-diagnostiquer](hiverner-entretenir-diagnostiquer.md)

## Relations & tags
- **Tags** : `metier:arrosage famille:specialises sous-famille:arrosage intervention:comprendre cluster:etude-besoins cluster:secteurs cluster:reseau-enterre type:principe securite:reseaux relation:paysagisme relation:plomberie relation:electricite-generale`

## Historique
| Version | Date | Auteur | Validateur | Motif |
|---|---|---|---|---|
| v0.1 | 2026-08-05 | IA | ⟦—⟧ | proposition initiale (Brouillon) |
