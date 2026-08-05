# Contrôle / maintenance piscine

> **Brouillon (v0) — proposé par IA, en attente de validation métier** (Loi 7/18). Modèle : [../../cards/CARD_TEMPLATE.md](../../cards/CARD_TEMPLATE.md).
> Niveaux de confiance : A normes/fabricant · B technique · C terrain validé · D hypothèse.

## Métadonnées
| Champ | Valeur |
|---|---|
| Identifiant | `controle-maintenance-piscine` |
| Titre | Contrôle / maintenance piscine |
| Profession | `metier:piscine` |
| Famille | `famille:specialises` |
| Sous-famille | `sous-famille:piscine` |
| Version | v0.1 |
| Auteur | IA (proposition) |
| Validateur | ⟦à valider métier⟧ |
| Statut | Brouillon |
| Indice de confiance | **C** |

## Points à vérifier
- [ ] **Étanchéité** : niveau stable ; pas de fuite (brides/hydraulique). `[C]`
- [ ] **Filtration** : pression/débit ; filtre propre ; pompe OK. `[C]`
- [ ] **Équilibre de l'eau** : pH / désinfection / limpidité. `[C]`
- [ ] **Liaison équipotentielle** / différentiel : contrôle par l'**Électricité** (interface). `[A]`
- [ ] **Dispositif de sécurité** (barrière/alarme/couverture/abri) opérationnel. `[A]`
- [ ] **Hivernage** adapté (gel) ; rénovation : **amiante** vérifié. `[C]`

## Cadre
- **Normes** : sécurité électrique des piscines (volumes 0/1/2, liaison équipotentielle) **NF C 15-100** (partie 7-702) ; structure béton du bassin (**interface** maçonnerie) **DTU 21** ; **sécurité des piscines** — barrières / alarmes / couvertures / abris **NF P 90-306 à 90-309** et **obligation légale** (Code de la construction), norme européenne **NF EN 16582** ⟦en prose, à confirmer⟧ `[B]` ⟦référence exacte à confirmer⟧. `respecte-norme`
- **Relations** : `verifie` → [entretenir-hiverner-piscine](../../professions/piscine/cards/entretenir-hiverner-piscine.md).
- **Tags** : `metier:piscine famille:specialises sous-famille:piscine type:checklist cluster:maintenance cluster:filtration securite:produits-chimiques`

## Historique
| Version | Date | Auteur | Validateur | Motif |
|---|---|---|---|---|
| v0.1 | 2026-08-05 | IA | ⟦—⟧ | proposition initiale (Brouillon) |
