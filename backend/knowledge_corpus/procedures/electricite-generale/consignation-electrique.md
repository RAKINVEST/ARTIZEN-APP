# Consignation électrique

> **Brouillon (v0) — proposé par IA, en attente de validation métier** (Loi 7/18). Modèle : [../../cards/CARD_TEMPLATE.md](../../cards/CARD_TEMPLATE.md).
> Niveaux de confiance : A normes/fabricant · B technique · C terrain validé · D hypothèse.

## Métadonnées
| Champ | Valeur |
|---|---|
| Identifiant | `consignation-electrique` |
| Titre | Consignation électrique |
| Profession | `metier:electricite-generale` |
| Famille | `famille:electricite` |
| Sous-famille | `sous-famille:securite` |
| Version | v0.1 |
| Auteur | IA (proposition) |
| Validateur | ⟦à valider métier⟧ |
| Statut | Brouillon |
| Indice de confiance | **B** |

## But
- Mettre et maintenir hors tension une installation avant intervention (protection des personnes). `[B]`

## Étapes (réservé habilité)
1. **Séparer** de la source (couper/verrouiller). `[A]`
2. **Condamner** (verrouillage + pancarte). `[A]`
3. **Identifier** l'ouvrage/circuit. `[B]`
4. **Vérifier l'absence de tension (VAT)** au plus près du point de travail. `[A]`
5. (Le cas échéant) mise à la terre et en court-circuit. `[A]` ⟦selon domaine de tension⟧

> **Opération réservée à un intervenant habilité (NF C 18-510).** `[A]`

## Cadre
- **Normes** : opérations sur ouvrages électriques **NF C 18-510** `[B]` ⟦référence exacte à confirmer⟧. `respecte-norme`
- **Relations** : `cite-procedure` → [securite-avant-intervention-electrique](../../checklists/electricite-generale/securite-avant-intervention-electrique.md).
- **Tags** : `metier:electricite-generale famille:electricite sous-famille:securite type:procedure cluster:consignation cluster:securite securite:electrique`

## Historique
| Version | Date | Auteur | Validateur | Motif |
|---|---|---|---|---|
| v0.1 | 2026-08-04 | IA | ⟦—⟧ | proposition initiale (Brouillon) |
