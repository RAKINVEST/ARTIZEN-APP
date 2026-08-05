# Contrôle / maintenance alarme intrusion

> **Brouillon (v0) — proposé par IA, en attente de validation métier** (Loi 7/18). Modèle : [../../cards/CARD_TEMPLATE.md](../../cards/CARD_TEMPLATE.md).
> Niveaux de confiance : A normes/fabricant · B technique · C terrain validé · D hypothèse.

## Métadonnées
| Champ | Valeur |
|---|---|
| Identifiant | `controle-maintenance-alarme` |
| Titre | Contrôle / maintenance alarme intrusion |
| Profession | `metier:alarme-intrusion` |
| Famille | `famille:electricite` |
| Sous-famille | `sous-famille:alarme-intrusion` |
| Version | v0.1 |
| Auteur | IA (proposition) |
| Validateur | ⟦à valider métier⟧ |
| Statut | Brouillon |
| Indice de confiance | **C** |

## Points à vérifier
- [ ] **Détecteurs** testés (contacts + volumétriques), zones correctes. `[C]`
- [ ] **Autoprotection** de tous les éléments OK. `[A]`
- [ ] **Batterie de secours** (autonomie) + piles radio. `[C]`
- [ ] **Sirènes** + **transmission** testées (double canal). `[C]`
- [ ] **Scénarios d'armement** / codes-badges à jour (confidentialité). `[C]`
- [ ] **Cyber** : mots de passe / mises à jour ; **RGPD** (journaux). `[A]`

> **Continuité** : prévenir avant mise hors service ; alimentation = **habilité**.

## Cadre
- **Normes** : alimentation électrique de la centrale **NF C 15-100** ; consignation à l'intervention **NF C 18-510** ; systèmes d'alarme intrusion **EN 50131** (grades), règles **APSAD** (R81/R82) / certification **NF&A2P** (**CNPP**), données **RGPD** et cybersécurité (**ANSSI**) ⟦en prose, à confirmer⟧ `[B]` ⟦référence exacte à confirmer⟧. `respecte-norme`
- **Relations** : `verifie` → [essayer-maintenir-alarme](../../professions/alarme-intrusion/cards/essayer-maintenir-alarme.md).
- **Tags** : `metier:alarme-intrusion famille:electricite sous-famille:alarme-intrusion type:checklist cluster:maintenance cluster:essais securite:autoprotection`

## Historique
| Version | Date | Auteur | Validateur | Motif |
|---|---|---|---|---|
| v0.1 | 2026-08-05 | IA | ⟦—⟧ | proposition initiale (Brouillon) |
