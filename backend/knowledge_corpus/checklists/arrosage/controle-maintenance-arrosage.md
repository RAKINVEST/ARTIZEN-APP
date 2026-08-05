# Contrôle / maintenance arrosage

> **Brouillon (v0) — proposé par IA, en attente de validation métier** (Loi 7/18). Modèle : [../../cards/CARD_TEMPLATE.md](../../cards/CARD_TEMPLATE.md).
> Niveaux de confiance : A normes/fabricant · B technique · C terrain validé · D hypothèse.

## Métadonnées
| Champ | Valeur |
|---|---|
| Identifiant | `controle-maintenance-arrosage` |
| Titre | Contrôle / maintenance arrosage |
| Profession | `metier:arrosage` |
| Famille | `famille:specialises` |
| Sous-famille | `sous-famille:arrosage` |
| Version | v0.1 |
| Auteur | IA (proposition) |
| Validateur | ⟦à valider métier⟧ |
| Statut | Brouillon |
| Indice de confiance | **C** |

## Points à vérifier
- [ ] **Secteurs** : chacun se déclenche ; portée/recouvrement homogènes. `[C]`
- [ ] **Électrovannes** : ouverture/fermeture nettes ; pas de fuite. `[C]`
- [ ] **Filtration** : nettoyée ; goutteurs non colmatés. `[C]`
- [ ] **Programmateur** : horaires/durées adaptés ; sonde pluie ; pile. `[C]`
- [ ] **Protection anti-retour** (disconnecteur) présente/contrôlée (interface Plomberie). `[A]`
- [ ] **Hivernage** fait (purge/soufflage) ; rénovation : **amiante**. `[A]`

## Cadre
- **Normes** : raccordement à l'eau potable + **protection anti-retour** (**interface** plomberie) **DTU 60.1** ; alimentation du programmateur / électrovannes (**interface** électricité) **NF C 15-100** ; **protection contre les retours d'eau** (disconnecteur) **NF EN 1717**, tube **PE** **NF EN 12201**, réglementation **DT-DICT** (réseaux) et règlement du service des eaux ⟦en prose, à confirmer⟧ `[B]` ⟦référence exacte à confirmer⟧. `respecte-norme`
- **Relations** : `verifie` → [hiverner-entretenir-diagnostiquer](../../professions/arrosage/cards/hiverner-entretenir-diagnostiquer.md).
- **Tags** : `metier:arrosage famille:specialises sous-famille:arrosage type:checklist cluster:maintenance cluster:filtration securite:eau`

## Historique
| Version | Date | Auteur | Validateur | Motif |
|---|---|---|---|---|
| v0.1 | 2026-08-05 | IA | ⟦—⟧ | proposition initiale (Brouillon) |
