# Sécurité — cyber & vie privée (interphonie)

> **Brouillon (v0) — proposé par IA, en attente de validation métier** (Loi 7/18). Modèle : [../../cards/CARD_TEMPLATE.md](../../cards/CARD_TEMPLATE.md).
> Niveaux de confiance : A normes/fabricant · B technique · C terrain validé · D hypothèse.

## Métadonnées
| Champ | Valeur |
|---|---|
| Identifiant | `securite-cyber-vie-privee-interphonie` |
| Titre | Sécurité — cyber & vie privée (interphonie) |
| Profession | `metier:interphonie` |
| Famille | `famille:electricite` |
| Sous-famille | `sous-famille:securite` |
| Version | v0.1 |
| Auteur | IA (proposition) |
| Validateur | ⟦à valider métier⟧ |
| Statut | Brouillon |
| Indice de confiance | **B** |

## Points à vérifier
- [ ] **Consignation** si intervention sur l'alimentation (**habilité**). `[A]`
- [ ] **Coexistence CF/CFa** : séparation du bus/câblage. `[A]`
- [ ] **Cybersécurité IP/SIP** : mots de passe, MAJ, segmentation, renvois sécurisés. `[A]`
- [ ] **RGPD / vie privée** (visiophone) : champ caméra limité, enregistrement encadré. `[A]`
- [ ] **Continuité** : alimentation secourue si applicable ; **pas d'entrave** à l'évacuation. `[A]`
- [ ] **Arrêt immédiat** en cas de danger. `[A]`

## Cadre
- **Normes** : alimentation des équipements **NF C 15-100** ; consignation à l'intervention **NF C 18-510** ; systèmes d'interphonie de bâtiment **EN 62820**, communication **SIP** (IP), données/images (**RGPD**, **CNIL**) et cybersécurité (**ANSSI**) ⟦en prose, à confirmer⟧ `[B]` ⟦référence exacte à confirmer⟧. `respecte-norme`
- **Relations** : `cite-procedure` → [mise-en-service-interphonie](../../procedures/interphonie/mise-en-service-interphonie.md).
- **Tags** : `metier:interphonie famille:electricite sous-famille:securite type:checklist cluster:visiophones securite:cyber securite:rgpd`

## Historique
| Version | Date | Auteur | Validateur | Motif |
|---|---|---|---|---|
| v0.1 | 2026-08-05 | IA | ⟦—⟧ | proposition initiale (Brouillon) |
