# Contrôle de réception d'un terrassement

> **Brouillon (v0) — proposé par IA, en attente de validation métier** (Loi 7/18). Modèle : [../../cards/CARD_TEMPLATE.md](../../cards/CARD_TEMPLATE.md).
> Niveaux de confiance : A normes/fabricant · B technique · C terrain validé · D hypothèse.

## Métadonnées
| Champ | Valeur |
|---|---|
| Identifiant | `controle-reception-terrassement` |
| Titre | Contrôle de réception d'un terrassement |
| Profession | `metier:terrassement` |
| Famille | `famille:gros-oeuvre` |
| Sous-famille | `sous-famille:terrassement` |
| Version | v0.1 |
| Auteur | IA (proposition) |
| Validateur | ⟦à valider métier⟧ |
| Statut | Brouillon |
| Indice de confiance | **C** |

## Points à vérifier
- [ ] **Implantation / altimétrie / cotes** conformes au projet. `[C]`
- [ ] **Fond de fouille** : portance, propreté, hors gel. `[C]`
- [ ] **Compactage** des remblais (essais) atteint. `[C]`
- [ ] **Pentes** d'évacuation / drainage fonctionnels. `[C]`
- [ ] **Blindage/talus** conformes tant que la fouille est ouverte. `[A]`
- [ ] **Réseaux** : lit de pose + **grillage avertisseur** en place. `[C]`

> Sécurité permanente : blindage, DICT, engins balisés, **arrêt** si mouvement de terrain.

## Cadre
- **Normes** : terrassements pour le bâtiment **DTU 12** ; fondations superficielles **DTU 13.11 / 13.12** ; réglementation réseaux (**DICT** / guichet unique, **AIPR**) et géotechnique **Eurocode 7 (NF EN 1997)** ⟦en prose, à confirmer⟧ `[B]` ⟦référence exacte à confirmer⟧. `respecte-norme`
- **Relations** : `verifie` → [diagnostiquer-controler-terrassement](../../professions/terrassement/cards/diagnostiquer-controler-terrassement.md).
- **Tags** : `metier:terrassement famille:gros-oeuvre sous-famille:terrassement type:checklist cluster:controle cluster:compactage cluster:nivellement securite:effondrement`

## Historique
| Version | Date | Auteur | Validateur | Motif |
|---|---|---|---|---|
| v0.1 | 2026-08-05 | IA | ⟦—⟧ | proposition initiale (Brouillon) |
