# Poser le réseau enterré (tuyauteries PE)

> **Brouillon (v0) — proposé par IA, en attente de validation métier** (Loi 7/18). Modèle : [../../../cards/CARD_TEMPLATE.md](../../../cards/CARD_TEMPLATE.md).
> Niveaux de confiance : A normes/fabricant · B technique · C terrain validé · D hypothèse. Rien n'est publié comme certitude.

## Métadonnées
| Champ | Valeur |
|---|---|
| Identifiant | `poser-reseau-pe-enterre` |
| Titre | Poser le réseau enterré (tuyauteries PE) |
| Profession | `metier:arrosage` |
| Famille | `famille:specialises` |
| Sous-famille | `sous-famille:arrosage` |
| Version | v0.1 |
| Auteur | IA (proposition) |
| Validateur | ⟦à valider métier⟧ |
| Statut | Brouillon |
| Indice de confiance | **C** |

## Cadrage
- **Objectif** : poser le **réseau enterré** d'arrosage en **PE** (tranchées, raccords, purges). `[C]`
- **Résumé** : après **DT-DICT**, ouvrir des **tranchées** à profondeur hors-gel, dérouler le **tube PE**, réaliser les **raccords** (à compression/électrosoudables), poser les **regards** d'électrovannes et prévoir les **purges** (points bas), puis remblayer soigneusement ; la **tranchée technique** partagée ou le réseau enterré général relève du **VRD/Terrassement**. `[C]` ⟦diamètres/profondeur selon réseau à confirmer⟧

## Réalisation
- **Étapes** :
  1. **DT-DICT** ; ouvrir les tranchées (hors-gel). `[A]` → [terrasser-reseaux-dict](../../../professions/terrassement/cards/terrasser-reseaux-dict.md)
  2. Dérouler le **tube PE** ; raccords étanches. `[C]`
  3. Poser **regards** + **purges** (points bas). `[C]` → [fuite-surconsommation-reseau](../../../diagnostics/arrosage/fuite-surconsommation-reseau.md)
  4. Tranchée technique / réseau général = VRD (frontière). `[C]` → [ouvrir-tranchee-technique](../../../professions/vrd/cards/ouvrir-tranchee-technique.md)
- **Points critiques** : **DICT** avant tranchée ; raccords PE étanches ; purges (hivernage) ; profondeur hors-gel ; frontière VRD.
- **Sécurité** : réseaux (DICT) ; effondrement de tranchée ; manutention (PE). **Repérage des réseaux enterrés avant terrassement** (**DT-DICT**) : le réseau d'arrosage impose des **tranchées** → ne pas percer un câble/tuyau (électrocution, gaz, eau). **Tranchées** : effondrement des petites fouilles ; engins. **Risques électriques** : le **raccordement électrique** du **programmateur** et des **électrovannes** (alimentation secteur/transfo) est **réservé à un électricien** → voir Électricité (protection 30 mA, matériel extérieur IP). **Protection sanitaire de l'eau** : un réseau d'arrosage peut renvoyer de l'eau polluée vers le réseau potable → **disconnecteur / clapet anti-retour obligatoire** (**NF EN 1717**) — le raccordement détaillé relève de la **Plomberie**. **Manutention** (rouleaux PE, regards) ; **mise sous pression** : purge d'air, essais progressifs (coup de bélier). **Amiante** (rénovation, revêtements anciens) : diagnostic ; retrait réservé à une **entreprise certifiée** (**jamais ici**). **Arrêt immédiat en cas de danger.** `[A]`

## Cadre & suites
- **Normes** : raccordement à l'eau potable + **protection anti-retour** (**interface** plomberie) **DTU 60.1** ; alimentation du programmateur / électrovannes (**interface** électricité) **NF C 15-100** ; **protection contre les retours d'eau** (disconnecteur) **NF EN 1717**, tube **PE** **NF EN 12201**, réglementation **DT-DICT** (réseaux) et règlement du service des eaux ⟦en prose, à confirmer⟧ `[B]` ⟦références/versions exactes à confirmer par le validateur⟧. `respecte-norme`
- **Électrovannes / programmateur** : `cite-carte` → [installer-electrovannes-programmateur](installer-electrovannes-programmateur.md)

## Relations & tags
- **Tags** : `metier:arrosage famille:specialises sous-famille:arrosage intervention:realiser cluster:reseau-enterre cluster:tuyauterie-pe complexite:avancee type:installation securite:reseaux relation:terrassement relation:vrd`

## Historique
| Version | Date | Auteur | Validateur | Motif |
|---|---|---|---|---|
| v0.1 | 2026-08-05 | IA | ⟦—⟧ | proposition initiale (Brouillon) |
