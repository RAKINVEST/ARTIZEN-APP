# Installer le goutte-à-goutte et la filtration

> **Brouillon (v0) — proposé par IA, en attente de validation métier** (Loi 7/18). Modèle : [../../../cards/CARD_TEMPLATE.md](../../../cards/CARD_TEMPLATE.md).
> Niveaux de confiance : A normes/fabricant · B technique · C terrain validé · D hypothèse. Rien n'est publié comme certitude.

## Métadonnées
| Champ | Valeur |
|---|---|
| Identifiant | `installer-goutte-a-goutte-filtration` |
| Titre | Installer le goutte-à-goutte et la filtration |
| Profession | `metier:arrosage` |
| Famille | `famille:specialises` |
| Sous-famille | `sous-famille:arrosage` |
| Version | v0.1 |
| Auteur | IA (proposition) |
| Validateur | ⟦à valider métier⟧ |
| Statut | Brouillon |
| Indice de confiance | **C** |

## Cadrage
- **Objectif** : installer un réseau **goutte-à-goutte** (massifs/potager/haies) et la **filtration** qui le protège. `[C]`
- **Résumé** : déployer un réseau **goutte-à-goutte** (tuyau de distribution + **goutteurs** intégrés/piquables) adapté aux massifs, potager et haies, avec un **régulateur de pression** et surtout une **filtration** (filtre à tamis/disques) car les micro-goutteurs se **colmatent** sans filtre ; prévoir purge et rinçage ; le goutte-à-goutte économise l'eau et cible les racines. `[C]` ⟦débit goutteurs/filtration selon eau à confirmer⟧

## Réalisation
- **Étapes** :
  1. Poser **filtration** + régulateur de pression (tête de réseau). `[C]`
  2. Déployer le **goutte-à-goutte** (goutteurs adaptés). `[C]`
  3. Prévoir purge/rinçage (anti-colmatage). `[C]` → [arroseur-defaut-portee](../../../diagnostics/arrosage/arroseur-defaut-portee.md)
  4. Vérifier l'uniformité de distribution. `[C]` → [essayer-regler-mettre-en-service](essayer-regler-mettre-en-service.md)
- **Points critiques** : **filtration** (anti-colmatage) ; régulation de pression ; goutteurs adaptés ; économie d'eau/ciblage racinaire.
- **Sécurité** : — ; manutention ; — **Repérage des réseaux enterrés avant terrassement** (**DT-DICT**) : le réseau d'arrosage impose des **tranchées** → ne pas percer un câble/tuyau (électrocution, gaz, eau). **Tranchées** : effondrement des petites fouilles ; engins. **Risques électriques** : le **raccordement électrique** du **programmateur** et des **électrovannes** (alimentation secteur/transfo) est **réservé à un électricien** → voir Électricité (protection 30 mA, matériel extérieur IP). **Protection sanitaire de l'eau** : un réseau d'arrosage peut renvoyer de l'eau polluée vers le réseau potable → **disconnecteur / clapet anti-retour obligatoire** (**NF EN 1717**) — le raccordement détaillé relève de la **Plomberie**. **Manutention** (rouleaux PE, regards) ; **mise sous pression** : purge d'air, essais progressifs (coup de bélier). **Amiante** (rénovation, revêtements anciens) : diagnostic ; retrait réservé à une **entreprise certifiée** (**jamais ici**). **Arrêt immédiat en cas de danger.** `[A]`

## Cadre & suites
- **Normes** : raccordement à l'eau potable + **protection anti-retour** (**interface** plomberie) **DTU 60.1** ; alimentation du programmateur / électrovannes (**interface** électricité) **NF C 15-100** ; **protection contre les retours d'eau** (disconnecteur) **NF EN 1717**, tube **PE** **NF EN 12201**, réglementation **DT-DICT** (réseaux) et règlement du service des eaux ⟦en prose, à confirmer⟧ `[B]` ⟦références/versions exactes à confirmer par le validateur⟧. `respecte-norme`
- **Essais / mise en service** : `cite-carte` → [essayer-regler-mettre-en-service](essayer-regler-mettre-en-service.md)

## Relations & tags
- **Tags** : `metier:arrosage famille:specialises sous-famille:arrosage intervention:realiser cluster:goutte-a-goutte cluster:filtration complexite:moyenne type:installation securite:manutention`

## Historique
| Version | Date | Auteur | Validateur | Motif |
|---|---|---|---|---|
| v0.1 | 2026-08-05 | IA | ⟦—⟧ | proposition initiale (Brouillon) |
