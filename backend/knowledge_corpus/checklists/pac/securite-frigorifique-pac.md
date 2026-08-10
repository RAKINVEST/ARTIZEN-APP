# Sécurité frigorifère (F-Gaz)

> **Brouillon (v0) — proposé par IA, en attente de validation métier** (Loi 7/18). Modèle : [../../cards/CARD_TEMPLATE.md](../../cards/CARD_TEMPLATE.md).
> Niveaux de confiance : A normes/fabricant · B technique · C terrain validé · D hypothèse.
>
> **⚠️ DÉPRÉCIÉE (Wave 2, ADR-0024) — fusionnée dans [securite-frigorifique-clim](../climatisation/securite-frigorifique-clim.md).** Contenu conservé (Loi 5) ; la version froid (`securite-frigorifique-froid`, NF EN 378 / contrôle périodique) reste distincte.

## Métadonnées
| Champ | Valeur |
|---|---|
| Identifiant | `securite-frigorifique-pac` |
| Titre | Sécurité frigorifère (F-Gaz) |
| Profession | `metier:climatisation` |
| Famille | `famille:fluides` |
| Sous-famille | `sous-famille:frigorifique` |
| Version | v0.1 |
| Auteur | IA (proposition) |
| Validateur | ⟦à valider métier⟧ |
| Statut | Archive |
| Indice de confiance | **B** |

## Points à vérifier
- [ ] **Attestation de capacité F-Gaz** de l'intervenant. `[A]`
- [ ] Outillage frigorifère dédié (station de récupération, détecteur). `[B]`
- [ ] **Récupération** du fluide (jamais de rejet à l'atmosphère). `[A]`
- [ ] Fiche/registre d'intervention renseigné. `[B]` ⟦cadre exact à confirmer⟧
- [ ] EPI, ventilation, pression contrôlée. `[B]`

> **Toute manipulation du circuit frigorifère sans qualification F-Gaz est proscrite.** `[A]`

## Cadre
- **Normes** : réglementation **F-Gaz** (UE 517/2014) + PAC **DTU 65.16** `[B]` ⟦référence exacte à confirmer⟧. `respecte-norme`
- **Relations** : `cite-carte` → [controler-circuit-frigorifique-pac](../../professions/pac/cards/controler-circuit-frigorifique-pac.md).
- **Tags** : `metier:climatisation equipement:pac famille:fluides sous-famille:frigorifique type:checklist cluster:securite cluster:frigorifique cluster:normes securite:frigorifique`

## Historique
| Version | Date | Auteur | Validateur | Motif |
|---|---|---|---|---|
| v0.1 | 2026-08-04 | IA | ⟦—⟧ | proposition initiale (Brouillon) |
