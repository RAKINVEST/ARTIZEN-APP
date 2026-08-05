# Sécurité — réseaux, électricité & protection de l'eau (arrosage)

> **Brouillon (v0) — proposé par IA, en attente de validation métier** (Loi 7/18). Modèle : [../../cards/CARD_TEMPLATE.md](../../cards/CARD_TEMPLATE.md).
> Niveaux de confiance : A normes/fabricant · B technique · C terrain validé · D hypothèse.

## Métadonnées
| Champ | Valeur |
|---|---|
| Identifiant | `securite-reseaux-electrique-eau-arrosage` |
| Titre | Sécurité — réseaux, électricité & protection de l'eau (arrosage) |
| Profession | `metier:arrosage` |
| Famille | `famille:specialises` |
| Sous-famille | `sous-famille:securite` |
| Version | v0.1 |
| Auteur | IA (proposition) |
| Validateur | ⟦à valider métier⟧ |
| Statut | Brouillon |
| Indice de confiance | **B** |

## Points à vérifier
- [ ] **DT-DICT** : réseaux enterrés repérés avant tranchée. `[A]`
- [ ] **Tranchées** : effondrement, engins ; profondeur hors-gel. `[A]`
- [ ] **Électrique** : raccordement programmateur/électrovannes = **interface** ; 30 mA / IP ext. `[A]`
- [ ] **Protection de l'eau** : **disconnecteur anti-retour** (NF EN 1717) = Plomberie. `[A]`
- [ ] **Mise sous pression** progressive (purge d'air, coup de bélier). `[A]`
- [ ] **Manutention** (PE/regards) ; **amiante** (rénovation) = certifié. `[A]`

## Cadre
- **Normes** : raccordement à l'eau potable + **protection anti-retour** (**interface** plomberie) **DTU 60.1** ; alimentation du programmateur / électrovannes (**interface** électricité) **NF C 15-100** ; **protection contre les retours d'eau** (disconnecteur) **NF EN 1717**, tube **PE** **NF EN 12201**, réglementation **DT-DICT** (réseaux) et règlement du service des eaux ⟦en prose, à confirmer⟧ `[B]` ⟦référence exacte à confirmer⟧. `respecte-norme`
- **Relations** : `cite-procedure` → [dict-protection-eau-essais-avant-travaux-arrosage](../../procedures/arrosage/dict-protection-eau-essais-avant-travaux-arrosage.md).
- **Tags** : `metier:arrosage famille:specialises sous-famille:securite type:checklist cluster:securite securite:reseaux securite:eau`

## Historique
| Version | Date | Auteur | Validateur | Motif |
|---|---|---|---|---|
| v0.1 | 2026-08-05 | IA | ⟦—⟧ | proposition initiale (Brouillon) |
