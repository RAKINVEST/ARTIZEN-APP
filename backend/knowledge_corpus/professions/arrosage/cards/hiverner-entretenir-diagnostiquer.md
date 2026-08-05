# Hiverner, entretenir et diagnostiquer

> **Brouillon (v0) — proposé par IA, en attente de validation métier** (Loi 7/18). Modèle : [../../../cards/CARD_TEMPLATE.md](../../../cards/CARD_TEMPLATE.md).
> Niveaux de confiance : A normes/fabricant · B technique · C terrain validé · D hypothèse. Rien n'est publié comme certitude.

## Métadonnées
| Champ | Valeur |
|---|---|
| Identifiant | `hiverner-entretenir-diagnostiquer` |
| Titre | Hiverner, entretenir et diagnostiquer |
| Profession | `metier:arrosage` |
| Famille | `famille:specialises` |
| Sous-famille | `sous-famille:arrosage` |
| Version | v0.1 |
| Auteur | IA (proposition) |
| Validateur | ⟦à valider métier⟧ |
| Statut | Brouillon |
| Indice de confiance | **C** |

## Cadrage
- **Objectif** : assurer l'**hivernage** (purge/soufflage), la **remise en service**, l'entretien et le diagnostic du réseau. `[C]`
- **Résumé** : avant les gelées, **hiverner** : couper l'eau, **purger/souffler** le réseau (air comprimé basse pression) pour éviter l'éclatement des tubes/électrovannes, protéger le disconnecteur ; au printemps, **remettre en service** (remise en pression, contrôle, reprogrammation) ; entretenir filtres, buses et goutteurs (colmatage), et diagnostiquer les défauts ; en rénovation, **diagnostic amiante** éventuel. `[C]`

## Réalisation
- **Étapes** :
  1. **Hiverner** : couper, **purger/souffler** (anti-gel). `[A]`
  2. Protéger le disconnecteur ; consigner. `[C]`
  3. **Remise en service** (pression/contrôle/reprog). `[C]` → [essayer-regler-mettre-en-service](essayer-regler-mettre-en-service.md)
  4. Entretenir filtres/buses ; diagnostiquer. `[C]` → [fuite-surconsommation-reseau](../../../diagnostics/arrosage/fuite-surconsommation-reseau.md)
- **Points critiques** : **hivernage** (purge/soufflage) contre le gel ; remise en service contrôlée ; filtres/buses entretenus ; amiante (rénovation).
- **Sécurité** : pression (soufflage) ; manutention ; amiante (rénovation). **Repérage des réseaux enterrés avant terrassement** (**DT-DICT**) : le réseau d'arrosage impose des **tranchées** → ne pas percer un câble/tuyau (électrocution, gaz, eau). **Tranchées** : effondrement des petites fouilles ; engins. **Risques électriques** : le **raccordement électrique** du **programmateur** et des **électrovannes** (alimentation secteur/transfo) est **réservé à un électricien** → voir Électricité (protection 30 mA, matériel extérieur IP). **Protection sanitaire de l'eau** : un réseau d'arrosage peut renvoyer de l'eau polluée vers le réseau potable → **disconnecteur / clapet anti-retour obligatoire** (**NF EN 1717**) — le raccordement détaillé relève de la **Plomberie**. **Manutention** (rouleaux PE, regards) ; **mise sous pression** : purge d'air, essais progressifs (coup de bélier). **Amiante** (rénovation, revêtements anciens) : diagnostic ; retrait réservé à une **entreprise certifiée** (**jamais ici**). **Arrêt immédiat en cas de danger.** `[A]`

## Cadre & suites
- **Normes** : raccordement à l'eau potable + **protection anti-retour** (**interface** plomberie) **DTU 60.1** ; alimentation du programmateur / électrovannes (**interface** électricité) **NF C 15-100** ; **protection contre les retours d'eau** (disconnecteur) **NF EN 1717**, tube **PE** **NF EN 12201**, réglementation **DT-DICT** (réseaux) et règlement du service des eaux ⟦en prose, à confirmer⟧ `[B]` ⟦références/versions exactes à confirmer par le validateur⟧. `respecte-norme`
- **Kit** : `utilise-kit` → [kit-arrosage-automatique](../../../kits/arrosage/kit-arrosage-automatique.md)

## Relations & tags
- **Tags** : `metier:arrosage famille:specialises sous-famille:arrosage intervention:entretenir intervention:controler cluster:hivernage cluster:remise-en-service cluster:maintenance cluster:diagnostic complexite:moyenne type:entretien securite:eau`

## Historique
| Version | Date | Auteur | Validateur | Motif |
|---|---|---|---|---|
| v0.1 | 2026-08-05 | IA | ⟦—⟧ | proposition initiale (Brouillon) |
