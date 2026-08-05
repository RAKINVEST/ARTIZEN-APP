# Sol engorgé / ruissellement

> **Brouillon (v0) — proposé par IA, en attente de validation métier** (Loi 7/18). Modèle : [../../cards/CARD_TEMPLATE.md](../../cards/CARD_TEMPLATE.md).
> Niveaux de confiance : A normes/fabricant · B technique · C terrain validé · D hypothèse.

## Métadonnées
| Champ | Valeur |
|---|---|
| Identifiant | `sol-engorge-ruissellement` |
| Titre | Sol engorgé / ruissellement |
| Profession | `metier:paysagisme` |
| Famille | `famille:specialises` |
| Sous-famille | `sous-famille:paysagisme` |
| Version | v0.1 |
| Auteur | IA (proposition) |
| Validateur | ⟦à valider métier⟧ |
| Statut | Brouillon |
| Indice de confiance | **C** |

## Symptôme
- Eau qui **stagne**, sol détrempé, **ruissellement**, ravinement, plantations qui asphyxient. `[C]`

## Causes probables
1. **Sol imperméable / compacté** (mauvaise infiltration). `[C]` → [preparer-ameliorer-sol](../../professions/paysagisme/cards/preparer-ameliorer-sol.md)
2. **Absence de drainage / pentes** mal gérées. `[C]` → [gerer-eaux-drainage-paysager](../../professions/paysagisme/cards/gerer-eaux-drainage-paysager.md)
3. Exutoire insuffisant → **réseau EP** (VRD). `[C]` → [poser-reseau-humide](../../professions/vrd/cards/poser-reseau-humide.md)

## Résolution
- Améliorer l'infiltration (décompactage/amendement), créer noues/drains/pentes douces ; exutoire enterré = VRD. `[C]`

## Cadre
- **Normes** : petits ouvrages maçonnés / soutènements légers (**interface** maçonnerie) **DTU 20.1** ; évacuation / gestion des **eaux pluviales** (**interface**) **DTU 60.11** ; **Règles professionnelles des travaux du paysage** (UNEP/QUALIPAYSAGE), supports de culture **NF U44-551**, réglementation **phytosanitaire** (Certiphyto, ZNT) et **périodes de taille** (Code de l'environnement, nidification) ⟦en prose, à confirmer⟧ `[B]` ⟦référence exacte à confirmer⟧. `respecte-norme`
- **Relations** : `traite-diagnostic` → [gerer-eaux-drainage-paysager](../../professions/paysagisme/cards/gerer-eaux-drainage-paysager.md).
- **Tags** : `metier:paysagisme famille:specialises sous-famille:paysagisme probleme:drainage cluster:drainage cluster:diagnostic type:diagnostic securite:outils-motorises relation:vrd`

## Historique
| Version | Date | Auteur | Validateur | Motif |
|---|---|---|---|---|
| v0.1 | 2026-08-05 | IA | ⟦—⟧ | proposition initiale (Brouillon) |
