# Contrôle avant saison de chauffe

> **Brouillon (v0) — proposé par IA, en attente de validation métier** (Loi 7/18). Modèle : [../../cards/CARD_TEMPLATE.md](../../cards/CARD_TEMPLATE.md).
> Niveaux de confiance : A normes/fabricant · B technique · C terrain validé · D hypothèse.

## Métadonnées
| Champ | Valeur |
|---|---|
| Identifiant | `controle-avant-saison-chauffe` |
| Titre | Contrôle avant saison de chauffe |
| Profession | `metier:chauffage` |
| Famille | `famille:fluides` |
| Version | v0.1 |
| Auteur | IA (proposition) |
| Statut | Brouillon |
| Indice de confiance | **C** |

## Points à vérifier
- [ ] Pression du circuit à froid dans la plage. `[B]`
- [ ] Radiateurs purgés (pas d'air en haut). `[C]`
- [ ] Absence de fuite aux raccords et au circulateur. `[C]`
- [ ] Écart départ/retour cohérent, émetteurs homogènes. `[C]`
- [ ] Vase d'expansion et soupape contrôlés. `[B]`
- [ ] Entretien annuel du générateur planifié (obligation). `[C]` ⟦préciser cadre réglementaire⟧

## Cadre
- **Normes** : sécurité des installations de chauffage central — **DTU 65.11** `[B]` ⟦référence exacte à confirmer⟧. `respecte-norme`
- **Relations** : `verifie` → [purger-radiateur](../../professions/chauffage/cards/purger-radiateur.md) ; `verifie` → [mise-en-service-chauffage](../../procedures/chauffage/mise-en-service-chauffage.md).
- **Tags** : `metier:chauffage famille:fluides type:checklist controle:pression controle:etancheite`

## Historique
| Version | Date | Auteur | Validateur | Motif |
|---|---|---|---|---|
| v0.1 | 2026-08-04 | IA | ⟦—⟧ | proposition initiale (Brouillon) |
