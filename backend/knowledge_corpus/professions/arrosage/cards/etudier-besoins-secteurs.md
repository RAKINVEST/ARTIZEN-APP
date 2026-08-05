# Étudier les besoins en eau et les secteurs

> **Brouillon (v0) — proposé par IA, en attente de validation métier** (Loi 7/18). Modèle : [../../../cards/CARD_TEMPLATE.md](../../../cards/CARD_TEMPLATE.md).
> Niveaux de confiance : A normes/fabricant · B technique · C terrain validé · D hypothèse. Rien n'est publié comme certitude.

## Métadonnées
| Champ | Valeur |
|---|---|
| Identifiant | `etudier-besoins-secteurs` |
| Titre | Étudier les besoins en eau et les secteurs |
| Profession | `metier:arrosage` |
| Famille | `famille:specialises` |
| Sous-famille | `sous-famille:arrosage` |
| Version | v0.1 |
| Auteur | IA (proposition) |
| Validateur | ⟦à valider métier⟧ |
| Statut | Brouillon |
| Indice de confiance | **C** |

## Cadrage
- **Objectif** : évaluer les **besoins en eau** et découper le jardin en **secteurs** homogènes (type, exposition, débit). `[C]`
- **Résumé** : estimer les **besoins** selon les végétaux (gazon/massifs/potager), l'exposition et le sol, mesurer la **pression** et le **débit** disponibles au point d'eau, puis découper en **secteurs** compatibles avec ce débit (on n'arrose pas tout en même temps) et adapter la diffusion (arroseurs vs goutte-à-goutte) ; le **choix des végétaux** relève du Paysagisme. `[C]` ⟦besoins/débit/secteurs selon site à confirmer⟧

## Réalisation
- **Étapes** :
  1. Estimer les **besoins** (végétaux/expo/sol). `[C]`
  2. Mesurer **pression/débit** au point d'eau. `[C]`
  3. Découper en **secteurs** (compatibles débit). `[C]` → [poser-arroseurs-escamotables](poser-arroseurs-escamotables.md)
  4. Adapter la diffusion (arroseurs / goutte-à-goutte). `[C]` → [installer-goutte-a-goutte-filtration](installer-goutte-a-goutte-filtration.md)
- **Points critiques** : secteurs **compatibles avec le débit** ; besoins réalistes ; diffusion adaptée ; végétaux = Paysagisme.
- **Sécurité** : — ; — ; — **Repérage des réseaux enterrés avant terrassement** (**DT-DICT**) : le réseau d'arrosage impose des **tranchées** → ne pas percer un câble/tuyau (électrocution, gaz, eau). **Tranchées** : effondrement des petites fouilles ; engins. **Risques électriques** : le **raccordement électrique** du **programmateur** et des **électrovannes** (alimentation secteur/transfo) est **réservé à un électricien** → voir Électricité (protection 30 mA, matériel extérieur IP). **Protection sanitaire de l'eau** : un réseau d'arrosage peut renvoyer de l'eau polluée vers le réseau potable → **disconnecteur / clapet anti-retour obligatoire** (**NF EN 1717**) — le raccordement détaillé relève de la **Plomberie**. **Manutention** (rouleaux PE, regards) ; **mise sous pression** : purge d'air, essais progressifs (coup de bélier). **Amiante** (rénovation, revêtements anciens) : diagnostic ; retrait réservé à une **entreprise certifiée** (**jamais ici**). **Arrêt immédiat en cas de danger.** `[A]`

## Cadre & suites
- **Normes** : raccordement à l'eau potable + **protection anti-retour** (**interface** plomberie) **DTU 60.1** ; alimentation du programmateur / électrovannes (**interface** électricité) **NF C 15-100** ; **protection contre les retours d'eau** (disconnecteur) **NF EN 1717**, tube **PE** **NF EN 12201**, réglementation **DT-DICT** (réseaux) et règlement du service des eaux ⟦en prose, à confirmer⟧ `[B]` ⟦références/versions exactes à confirmer par le validateur⟧. `respecte-norme`
- **Réseau enterré** : `cite-carte` → [poser-reseau-pe-enterre](poser-reseau-pe-enterre.md)

## Relations & tags
- **Tags** : `metier:arrosage famille:specialises sous-famille:arrosage intervention:comprendre cluster:etude-besoins cluster:secteurs complexite:moyenne type:conception securite:reseaux`

## Historique
| Version | Date | Auteur | Validateur | Motif |
|---|---|---|---|---|
| v0.1 | 2026-08-05 | IA | ⟦—⟧ | proposition initiale (Brouillon) |
