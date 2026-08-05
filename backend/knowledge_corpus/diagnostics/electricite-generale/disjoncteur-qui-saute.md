# Disjoncteur qui saute

> **Brouillon (v0) — proposé par IA, en attente de validation métier** (Loi 7/18). Modèle : [../../cards/CARD_TEMPLATE.md](../../cards/CARD_TEMPLATE.md).
> Niveaux de confiance : A normes/fabricant · B technique · C terrain validé · D hypothèse.

## Métadonnées
| Champ | Valeur |
|---|---|
| Identifiant | `disjoncteur-qui-saute` |
| Titre | Disjoncteur qui saute |
| Profession | `metier:electricite-generale` |
| Famille | `famille:electricite` |
| Sous-famille | `sous-famille:tableau` |
| Version | v0.1 |
| Auteur | IA (proposition) |
| Validateur | ⟦à valider métier⟧ |
| Statut | Brouillon |
| Indice de confiance | **C** |

## Symptôme
- Un disjoncteur **déclenche** (re)régulièrement. `[C]`

## Causes probables
1. **Surcharge** du circuit (trop d'appareils). `[C]`
2. **Court-circuit** sur le circuit ou un appareil. `[C]`
3. Disjoncteur sous-calibré / défectueux. `[C]` → [remplacer-disjoncteur](../../professions/electricite-generale/cards/remplacer-disjoncteur.md)

## Démarche
- Isoler les appareils, tester circuit par circuit, mesurer **hors tension**. `[C]` → [mesurer-continuite-circuit](../../professions/electricite-generale/cards/mesurer-continuite-circuit.md)

> Diagnostic/réparation au tableau : **électricien habilité**.

## Cadre
- **Normes** : installations électriques BT **NF C 15-100** ; opérations/consignation **NF C 18-510** `[B]` ⟦référence exacte à confirmer⟧. `respecte-norme`
- **Relations** : `traite-diagnostic` → [remplacer-disjoncteur](../../professions/electricite-generale/cards/remplacer-disjoncteur.md).
- **Tags** : `metier:electricite-generale famille:electricite sous-famille:tableau probleme:declenchement probleme:surcharge probleme:court-circuit cluster:diagnostic cluster:depannage cluster:disjoncteurs type:diagnostic securite:electrique`

## Historique
| Version | Date | Auteur | Validateur | Motif |
|---|---|---|---|---|
| v0.1 | 2026-08-04 | IA | ⟦—⟧ | proposition initiale (Brouillon) |
