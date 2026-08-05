# Essayer, régler et mettre en service

> **Brouillon (v0) — proposé par IA, en attente de validation métier** (Loi 7/18). Modèle : [../../../cards/CARD_TEMPLATE.md](../../../cards/CARD_TEMPLATE.md).
> Niveaux de confiance : A normes/fabricant · B technique · C terrain validé · D hypothèse. Rien n'est publié comme certitude.

## Métadonnées
| Champ | Valeur |
|---|---|
| Identifiant | `essayer-regler-mettre-en-service` |
| Titre | Essayer, régler et mettre en service |
| Profession | `metier:arrosage` |
| Famille | `famille:specialises` |
| Sous-famille | `sous-famille:arrosage` |
| Version | v0.1 |
| Auteur | IA (proposition) |
| Validateur | ⟦à valider métier⟧ |
| Statut | Brouillon |
| Indice de confiance | **B** |

## Cadrage
- **Objectif** : raccorder l'alimentation (interface), **essayer** le réseau, **régler** les secteurs et **programmer**. `[B]`
- **Résumé** : faire raccorder l'**alimentation en eau potable** avec la **protection anti-retour obligatoire** (disconnecteur / clapet, **NF EN 1717**) — raccordement détaillé = **Plomberie**, mettre progressivement le réseau **sous pression** (purge d'air), contrôler l'étanchéité et la portée secteur par secteur, régler arroseurs et goutteurs, puis **programmer** les cycles (horaires/durées adaptés aux besoins et restrictions). `[B]` ⟦protection sanitaire/programmation selon réglementation à confirmer⟧

## Réalisation
- **Étapes** :
  1. **Alimentation + disconnecteur** anti-retour = Plomberie. `[A]` → [poser-robinet-arret](../../../professions/plomberie/cards/poser-robinet-arret.md)
  2. Mise sous **pression** progressive (purge d'air) ; étanchéité. `[B]`
  3. Régler portées/goutteurs secteur par secteur. `[C]`
  4. **Programmer** les cycles (besoins/restrictions). `[C]` → [secteur-narrose-plus](../../../diagnostics/arrosage/secteur-narrose-plus.md)
- **Points critiques** : **protection anti-retour** (NF EN 1717) ; mise sous pression maîtrisée ; réglages homogènes ; programmation économe.
- **Sécurité** : protection de l'eau (interface) ; pression (coup de bélier) ; — **Repérage des réseaux enterrés avant terrassement** (**DT-DICT**) : le réseau d'arrosage impose des **tranchées** → ne pas percer un câble/tuyau (électrocution, gaz, eau). **Tranchées** : effondrement des petites fouilles ; engins. **Risques électriques** : le **raccordement électrique** du **programmateur** et des **électrovannes** (alimentation secteur/transfo) est **réservé à un électricien** → voir Électricité (protection 30 mA, matériel extérieur IP). **Protection sanitaire de l'eau** : un réseau d'arrosage peut renvoyer de l'eau polluée vers le réseau potable → **disconnecteur / clapet anti-retour obligatoire** (**NF EN 1717**) — le raccordement détaillé relève de la **Plomberie**. **Manutention** (rouleaux PE, regards) ; **mise sous pression** : purge d'air, essais progressifs (coup de bélier). **Amiante** (rénovation, revêtements anciens) : diagnostic ; retrait réservé à une **entreprise certifiée** (**jamais ici**). **Arrêt immédiat en cas de danger.** `[A]`

## Cadre & suites
- **Normes** : raccordement à l'eau potable + **protection anti-retour** (**interface** plomberie) **DTU 60.1** ; alimentation du programmateur / électrovannes (**interface** électricité) **NF C 15-100** ; **protection contre les retours d'eau** (disconnecteur) **NF EN 1717**, tube **PE** **NF EN 12201**, réglementation **DT-DICT** (réseaux) et règlement du service des eaux ⟦en prose, à confirmer⟧ `[B]` ⟦références/versions exactes à confirmer par le validateur⟧. `respecte-norme`
- **Hivernage** : `cite-carte` → [hiverner-entretenir-diagnostiquer](hiverner-entretenir-diagnostiquer.md)

## Relations & tags
- **Tags** : `metier:arrosage famille:specialises sous-famille:arrosage intervention:regler cluster:essais cluster:reglages complexite:avancee type:reglage securite:eau relation:plomberie`

## Historique
| Version | Date | Auteur | Validateur | Motif |
|---|---|---|---|---|
| v0.1 | 2026-08-05 | IA | ⟦—⟧ | proposition initiale (Brouillon) |
