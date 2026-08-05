# Buée / condensation sur vitrage

> **Brouillon (v0) — proposé par IA, en attente de validation métier** (Loi 7/18). Modèle : [../../cards/CARD_TEMPLATE.md](../../cards/CARD_TEMPLATE.md).
> Niveaux de confiance : A normes/fabricant · B technique · C terrain validé · D hypothèse.

## Métadonnées
| Champ | Valeur |
|---|---|
| Identifiant | `condensation-buee-vitrage` |
| Titre | Buée / condensation sur vitrage |
| Profession | `metier:menuiserie-exterieure` |
| Famille | `famille:enveloppe` |
| Sous-famille | `sous-famille:menuiserie-exterieure` |
| Version | v0.1 |
| Auteur | IA (proposition) |
| Validateur | ⟦à valider métier⟧ |
| Statut | Brouillon |
| Indice de confiance | **C** |

## Symptôme
- **Buée entre les vitres** (dans le double vitrage) ou condensation sur la face intérieure. `[C]`

## Causes probables
1. **Buée à l'intérieur du double vitrage** = **joint de scellement HS** → vitrage à remplacer. `[C]` → [remplacer-vitrage](../../professions/menuiserie-exterieure/cards/remplacer-vitrage.md)
2. Condensation en face intérieure = **excès d'humidité / défaut de ventilation** (voir Ventilation). `[C]`
3. Pont thermique du châssis/tableau. `[C]` → [traiter-ponts-thermiques](../../professions/isolation/cards/traiter-ponts-thermiques.md)

## Résolution
- Buée interne → remplacer le vitrage ; condensation interne → traiter humidité/ventilation. `[C]`

## Cadre
- **Normes** : mise en œuvre des fenêtres et portes extérieures **DTU 36.5** ; vitrerie-miroiterie **DTU 39** ; fermetures / volets **DTU 34.1** ; performance **classement AEV (Air-Eau-Vent)** ⟦à confirmer⟧ `[B]` ⟦référence exacte à confirmer⟧. `respecte-norme`
- **Relations** : `traite-diagnostic` → [remplacer-vitrage](../../professions/menuiserie-exterieure/cards/remplacer-vitrage.md).
- **Tags** : `metier:menuiserie-exterieure equipement:vitrage famille:enveloppe sous-famille:menuiserie-exterieure probleme:condensation cluster:vitrages cluster:diagnostic type:diagnostic securite:coupure relation:isolation`

## Historique
| Version | Date | Auteur | Validateur | Motif |
|---|---|---|---|---|
| v0.1 | 2026-08-05 | IA | ⟦—⟧ | proposition initiale (Brouillon) |
