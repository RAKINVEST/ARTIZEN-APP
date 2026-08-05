# Flocage / calorifugeage suspect dégradé

> **Brouillon (v0) — proposé par IA, en attente de validation métier** (Loi 7/18). Modèle : [../../cards/CARD_TEMPLATE.md](../../cards/CARD_TEMPLATE.md).
> Niveaux de confiance : A normes/fabricant · B technique · C terrain validé · D hypothèse.

## Métadonnées
| Champ | Valeur |
|---|---|
| Identifiant | `flocage-calorifugeage-suspect` |
| Titre | Flocage / calorifugeage suspect dégradé |
| Profession | `metier:desamiantage` |
| Famille | `famille:specialises` |
| Sous-famille | `sous-famille:securite` |
| Version | v0.1 |
| Auteur | IA (proposition) |
| Validateur | ⟦à valider métier⟧ |
| Statut | Brouillon |
| Indice de confiance | **C** |

## Symptôme
- **Flocage** (projeté fibreux) ou **calorifugeage** de tuyauterie/chaudière **dégradé**, pulvérulent, qui s'effrite. `[C]`

> **Danger élevé** : matériaux **friables** = forte libération de fibres → **arrêt immédiat**, ne pas toucher, évacuer/isoler la zone. `[A]`

## Conduite à tenir
1. **Ne pas manipuler** ; couper les flux d'air dispersants ; baliser. `[A]` → [proteger-occupants-comprendre-dechets](../../professions/desamiantage/cards/proteger-occupants-comprendre-dechets.md)
2. **Signaler** ; faire repérer ; interface **Plomberie/Chauffage** (calorifuge). `[A]` → [controler-etancheite-reseau](../../professions/plomberie/cards/controler-etancheite-reseau.md)
3. **Orienter** vers une entreprise certifiée (SS3). `[A]`

> Aucun retrait/confinement décrit : opération réservée.

## Cadre
- **Normes** : **cadre réglementaire amiante** : **Code du travail** (R.4412-94 et s. — **SS3/SS4**), **Code de la santé publique** (repérage / DTA), **NF X46-020** (repérage avant travaux) et arrêtés (8 avril 2013, 26 juin 2019) ⟦références non détectées — à confirmer par un expert⟧ ; côté **interfaces** où l'amiante est fréquent : conduits / fumisterie **DTU 24.1**, anciens équipements électriques **NF C 15-100** ⟦interfaces, à confirmer⟧ `[B]` ⟦cadre réglementaire à confirmer⟧. `respecte-norme`
- **Relations** : `traite-diagnostic` → [reconnaitre-materiaux-mpca](../../professions/desamiantage/cards/reconnaitre-materiaux-mpca.md).
- **Tags** : `metier:desamiantage famille:specialises sous-famille:securite probleme:friable cluster:materiaux-mpca cluster:diagnostic type:diagnostic securite:amiante relation:plomberie`

## Historique
| Version | Date | Auteur | Validateur | Motif |
|---|---|---|---|---|
| v0.1 | 2026-08-05 | IA | ⟦—⟧ | proposition initiale (Brouillon) |
