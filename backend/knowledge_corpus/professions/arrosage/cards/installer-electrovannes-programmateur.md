# Installer électrovannes et programmateur

> **Brouillon (v0) — proposé par IA, en attente de validation métier** (Loi 7/18). Modèle : [../../../cards/CARD_TEMPLATE.md](../../../cards/CARD_TEMPLATE.md).
> Niveaux de confiance : A normes/fabricant · B technique · C terrain validé · D hypothèse. Rien n'est publié comme certitude.

## Métadonnées
| Champ | Valeur |
|---|---|
| Identifiant | `installer-electrovannes-programmateur` |
| Titre | Installer électrovannes et programmateur |
| Profession | `metier:arrosage` |
| Famille | `famille:specialises` |
| Sous-famille | `sous-famille:arrosage` |
| Version | v0.1 |
| Auteur | IA (proposition) |
| Validateur | ⟦à valider métier⟧ |
| Statut | Brouillon |
| Indice de confiance | **C** |

## Cadrage
- **Objectif** : installer les **électrovannes** (une par secteur) et le **programmateur** de commande. `[C]`
- **Résumé** : poser les **électrovannes** dans leurs **regards** (une par secteur), tirer le **câble de commande** basse tension jusqu'au **programmateur**, poser le programmateur (intérieur/extérieur IP) et éventuellement une **sonde de pluie/hygrométrie** ; l'**alimentation électrique** (secteur, transfo, protection 30 mA) est raccordée par un **électricien** (interface Électricité), non traitée ici. `[C]` ⟦câblage/nb de voies selon installation à confirmer⟧

## Réalisation
- **Étapes** :
  1. Poser les **électrovannes** (regards, une/secteur). `[C]`
  2. Câbler la **commande** BT vers le programmateur. `[C]` → [secteur-narrose-plus](../../../diagnostics/arrosage/secteur-narrose-plus.md)
  3. Poser **programmateur** (IP si ext.) + sonde pluie. `[C]`
  4. **Alimentation électrique** = **Électricité** (interface). `[A]` → [remplacer-prise-courant](../../../professions/electricite-generale/cards/remplacer-prise-courant.md)
- **Points critiques** : une électrovanne/secteur ; câblage commandé correct ; **alimentation = interface** Élec ; sonde d'économie d'eau.
- **Sécurité** : électrique (interface) ; manutention ; — **Repérage des réseaux enterrés avant terrassement** (**DT-DICT**) : le réseau d'arrosage impose des **tranchées** → ne pas percer un câble/tuyau (électrocution, gaz, eau). **Tranchées** : effondrement des petites fouilles ; engins. **Risques électriques** : le **raccordement électrique** du **programmateur** et des **électrovannes** (alimentation secteur/transfo) est **réservé à un électricien** → voir Électricité (protection 30 mA, matériel extérieur IP). **Protection sanitaire de l'eau** : un réseau d'arrosage peut renvoyer de l'eau polluée vers le réseau potable → **disconnecteur / clapet anti-retour obligatoire** (**NF EN 1717**) — le raccordement détaillé relève de la **Plomberie**. **Manutention** (rouleaux PE, regards) ; **mise sous pression** : purge d'air, essais progressifs (coup de bélier). **Amiante** (rénovation, revêtements anciens) : diagnostic ; retrait réservé à une **entreprise certifiée** (**jamais ici**). **Arrêt immédiat en cas de danger.** `[A]`

## Cadre & suites
- **Normes** : raccordement à l'eau potable + **protection anti-retour** (**interface** plomberie) **DTU 60.1** ; alimentation du programmateur / électrovannes (**interface** électricité) **NF C 15-100** ; **protection contre les retours d'eau** (disconnecteur) **NF EN 1717**, tube **PE** **NF EN 12201**, réglementation **DT-DICT** (réseaux) et règlement du service des eaux ⟦en prose, à confirmer⟧ `[B]` ⟦références/versions exactes à confirmer par le validateur⟧. `respecte-norme`
- **Essais / réglages** : `cite-carte` → [essayer-regler-mettre-en-service](essayer-regler-mettre-en-service.md)

## Relations & tags
- **Tags** : `metier:arrosage famille:specialises sous-famille:arrosage intervention:realiser cluster:electrovannes cluster:programmateur complexite:avancee type:installation securite:electrique relation:electricite-generale`

## Historique
| Version | Date | Auteur | Validateur | Motif |
|---|---|---|---|---|
| v0.1 | 2026-08-05 | IA | ⟦—⟧ | proposition initiale (Brouillon) |
