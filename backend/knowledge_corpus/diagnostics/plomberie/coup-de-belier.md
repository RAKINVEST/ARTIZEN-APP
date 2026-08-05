# Coup de bélier

> **Brouillon (v0) — proposé par IA, en attente de validation métier** (Loi 7/18). Modèle : [../../cards/CARD_TEMPLATE.md](../../cards/CARD_TEMPLATE.md).
> Niveaux de confiance : A normes/fabricant · B technique · C terrain validé · D hypothèse.

## Métadonnées
| Champ | Valeur |
|---|---|
| Identifiant | `coup-de-belier` |
| Titre | Coup de bélier |
| Profession | `metier:plomberie` |
| Famille | `famille:fluides` |
| Version | v0.1 |
| Auteur | IA (proposition) |
| Statut | Brouillon |
| Indice de confiance | **C** |

## Symptôme
- **Bruit de choc** dans les canalisations à la fermeture rapide d'un robinet/électrovanne (lave-linge, mitigeur). `[C]`

## Cause probable
- Onde de surpression due à l'arrêt brusque du débit (fermeture rapide). `[B]`

## Démarche de diagnostic
- Identifier l'appareil déclencheur (électrovanne à fermeture rapide fréquente). `[C]`
- Vérifier la pression réseau et l'absence d'anti-bélier / ballon amortisseur. `[C]`

## Résolution
- Installer un **anti-bélier** près de l'appareil ; réduire la pression si excessive (réducteur). `[C]`
- Poser des robinets d'arrêt adaptés pour maîtriser la manœuvre. → [poser-robinet-arret](../../professions/plomberie/cards/poser-robinet-arret.md)

## Cadre
- **Normes** : dimensionnement des installations — **DTU 60.11** `[B]` ⟦référence exacte à confirmer⟧. `respecte-norme`
- **Relations** : `traite-diagnostic` ; voir [controler-etancheite-reseau](../../professions/plomberie/cards/controler-etancheite-reseau.md).
- **Tags** : `metier:plomberie famille:fluides probleme:coup-de-belier probleme:bruit probleme:surpression equipement:canalisation type:diagnostic`

## Historique
| Version | Date | Auteur | Validateur | Motif |
|---|---|---|---|---|
| v0.1 | 2026-08-04 | IA | ⟦—⟧ | proposition initiale (Brouillon) |
