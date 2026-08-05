# Sécurité — continuité, autoprotection & cyber (alarme)

> **Brouillon (v0) — proposé par IA, en attente de validation métier** (Loi 7/18). Modèle : [../../cards/CARD_TEMPLATE.md](../../cards/CARD_TEMPLATE.md).
> Niveaux de confiance : A normes/fabricant · B technique · C terrain validé · D hypothèse.

## Métadonnées
| Champ | Valeur |
|---|---|
| Identifiant | `securite-continuite-cyber-alarme` |
| Titre | Sécurité — continuité, autoprotection & cyber (alarme) |
| Profession | `metier:alarme-intrusion` |
| Famille | `famille:electricite` |
| Sous-famille | `sous-famille:securite` |
| Version | v0.1 |
| Auteur | IA (proposition) |
| Validateur | ⟦à valider métier⟧ |
| Statut | Brouillon |
| Indice de confiance | **B** |

## Points à vérifier
- [ ] **Consignation** si intervention sur l'alimentation électrique (**habilité**). `[A]`
- [ ] **Continuité** : prévenir avant mise hors service ; **batterie de secours** OK. `[A]`
- [ ] **Autoprotection (tamper)** jamais neutralisée ; anti-**sabotage**. `[A]`
- [ ] **Faux déclenchements** maîtrisés (emplacement/immunité). `[C]`
- [ ] **Cybersécurité** (mots de passe, MAJ, segmentation transmetteur IP). `[A]`
- [ ] **Confidentialité / RGPD** (codes/badges/journaux) ; **arrêt** si danger. `[A]`

## Cadre
- **Normes** : alimentation électrique de la centrale **NF C 15-100** ; consignation à l'intervention **NF C 18-510** ; systèmes d'alarme intrusion **EN 50131** (grades), règles **APSAD** (R81/R82) / certification **NF&A2P** (**CNPP**), données **RGPD** et cybersécurité (**ANSSI**) ⟦en prose, à confirmer⟧ `[B]` ⟦référence exacte à confirmer⟧. `respecte-norme`
- **Relations** : `cite-procedure` → [essai-reception-alarme](../../procedures/alarme-intrusion/essai-reception-alarme.md).
- **Tags** : `metier:alarme-intrusion famille:electricite sous-famille:securite type:checklist cluster:centrales-d-alarme securite:autoprotection securite:cyber`

## Historique
| Version | Date | Auteur | Validateur | Motif |
|---|---|---|---|---|
| v0.1 | 2026-08-05 | IA | ⟦—⟧ | proposition initiale (Brouillon) |
