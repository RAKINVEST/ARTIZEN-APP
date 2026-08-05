# Poser les arroseurs escamotables

> **Brouillon (v0) — proposé par IA, en attente de validation métier** (Loi 7/18). Modèle : [../../../cards/CARD_TEMPLATE.md](../../../cards/CARD_TEMPLATE.md).
> Niveaux de confiance : A normes/fabricant · B technique · C terrain validé · D hypothèse. Rien n'est publié comme certitude.

## Métadonnées
| Champ | Valeur |
|---|---|
| Identifiant | `poser-arroseurs-escamotables` |
| Titre | Poser les arroseurs escamotables |
| Profession | `metier:arrosage` |
| Famille | `famille:specialises` |
| Sous-famille | `sous-famille:arrosage` |
| Version | v0.1 |
| Auteur | IA (proposition) |
| Validateur | ⟦à valider métier⟧ |
| Statut | Brouillon |
| Indice de confiance | **C** |

## Cadrage
- **Objectif** : poser les **arroseurs escamotables** (tuyères, turbines) au bon espacement et à la bonne hauteur. `[C]`
- **Résumé** : positionner les **arroseurs escamotables** (**tuyères** pour petites surfaces, **turbines** pour grandes) avec un **recouvrement** (tête à tête) pour une pluviométrie homogène, les raccorder au PE sur cannes/colliers, régler la **hauteur** (affleurant le sol/gazon) et l'**aplomb** ; choisir les **buses** selon la portée et le débit du secteur. `[C]` ⟦espacement/buses selon débit et surface à confirmer⟧

## Réalisation
- **Étapes** :
  1. Positionner (recouvrement **tête à tête**). `[C]`
  2. Raccorder au PE (cannes/colliers) ; hauteur/aplomb. `[C]`
  3. Choisir les **buses** (portée/débit du secteur). `[C]` → [arroseur-defaut-portee](../../../diagnostics/arrosage/arroseur-defaut-portee.md)
  4. Vérifier l'homogénéité (pluviométrie). `[C]` → [essayer-regler-mettre-en-service](essayer-regler-mettre-en-service.md)
- **Points critiques** : **recouvrement** (pluviométrie homogène) ; buses adaptées au débit ; hauteur affleurante ; pas de zone sèche.
- **Sécurité** : manutention ; — ; — **Repérage des réseaux enterrés avant terrassement** (**DT-DICT**) : le réseau d'arrosage impose des **tranchées** → ne pas percer un câble/tuyau (électrocution, gaz, eau). **Tranchées** : effondrement des petites fouilles ; engins. **Risques électriques** : le **raccordement électrique** du **programmateur** et des **électrovannes** (alimentation secteur/transfo) est **réservé à un électricien** → voir Électricité (protection 30 mA, matériel extérieur IP). **Protection sanitaire de l'eau** : un réseau d'arrosage peut renvoyer de l'eau polluée vers le réseau potable → **disconnecteur / clapet anti-retour obligatoire** (**NF EN 1717**) — le raccordement détaillé relève de la **Plomberie**. **Manutention** (rouleaux PE, regards) ; **mise sous pression** : purge d'air, essais progressifs (coup de bélier). **Amiante** (rénovation, revêtements anciens) : diagnostic ; retrait réservé à une **entreprise certifiée** (**jamais ici**). **Arrêt immédiat en cas de danger.** `[A]`

## Cadre & suites
- **Normes** : raccordement à l'eau potable + **protection anti-retour** (**interface** plomberie) **DTU 60.1** ; alimentation du programmateur / électrovannes (**interface** électricité) **NF C 15-100** ; **protection contre les retours d'eau** (disconnecteur) **NF EN 1717**, tube **PE** **NF EN 12201**, réglementation **DT-DICT** (réseaux) et règlement du service des eaux ⟦en prose, à confirmer⟧ `[B]` ⟦références/versions exactes à confirmer par le validateur⟧. `respecte-norme`
- **Goutte-à-goutte** : `cite-carte` → [installer-goutte-a-goutte-filtration](installer-goutte-a-goutte-filtration.md)

## Relations & tags
- **Tags** : `metier:arrosage famille:specialises sous-famille:arrosage intervention:realiser cluster:arroseurs-escamotables cluster:reglages complexite:moyenne type:installation securite:manutention`

## Historique
| Version | Date | Auteur | Validateur | Motif |
|---|---|---|---|---|
| v0.1 | 2026-08-05 | IA | ⟦—⟧ | proposition initiale (Brouillon) |
