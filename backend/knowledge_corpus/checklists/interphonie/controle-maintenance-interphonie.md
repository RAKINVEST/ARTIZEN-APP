# Contrôle / maintenance interphonie

> **Brouillon (v0) — proposé par IA, en attente de validation métier** (Loi 7/18). Modèle : [../../cards/CARD_TEMPLATE.md](../../cards/CARD_TEMPLATE.md).
> Niveaux de confiance : A normes/fabricant · B technique · C terrain validé · D hypothèse.

## Métadonnées
| Champ | Valeur |
|---|---|
| Identifiant | `controle-maintenance-interphonie` |
| Titre | Contrôle / maintenance interphonie |
| Profession | `metier:interphonie` |
| Famille | `famille:electricite` |
| Sous-famille | `sous-famille:interphonie` |
| Version | v0.1 |
| Auteur | IA (proposition) |
| Validateur | ⟦à valider métier⟧ |
| Statut | Brouillon |
| Indice de confiance | **C** |

## Points à vérifier
- [ ] **Appel** OK (chaque bouton → bon poste). `[C]`
- [ ] **Audio** (2 sens) et **vidéo** (jour/nuit) exploitables. `[C]`
- [ ] **Commande d'ouverture** (interface gâche) fonctionnelle. `[C]`
- [ ] **Alimentation** (secours si applicable) ; séparation CF/CFa. `[C]`
- [ ] **IP/SIP** : mots de passe, MAJ, segmentation. `[A]`
- [ ] **RGPD** (visiophone) : champ caméra/enregistrement encadrés. `[A]`

> Alimentation = **habilité** ; sécurité incendie de la porte → **Contrôle d'accès**.

## Cadre
- **Normes** : alimentation des équipements **NF C 15-100** ; consignation à l'intervention **NF C 18-510** ; systèmes d'interphonie de bâtiment **EN 62820**, communication **SIP** (IP), données/images (**RGPD**, **CNIL**) et cybersécurité (**ANSSI**) ⟦en prose, à confirmer⟧ `[B]` ⟦référence exacte à confirmer⟧. `respecte-norme`
- **Relations** : `verifie` → [essayer-maintenir-interphonie](../../professions/interphonie/cards/essayer-maintenir-interphonie.md).
- **Tags** : `metier:interphonie famille:electricite sous-famille:interphonie type:checklist cluster:maintenance cluster:essais securite:coexistence`

## Historique
| Version | Date | Auteur | Validateur | Motif |
|---|---|---|---|---|
| v0.1 | 2026-08-05 | IA | ⟦—⟧ | proposition initiale (Brouillon) |
