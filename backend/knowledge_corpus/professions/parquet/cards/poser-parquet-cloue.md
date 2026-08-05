# Poser un parquet cloué

> **Brouillon (v0) — proposé par IA, en attente de validation métier** (Loi 7/18). Modèle : [../../../cards/CARD_TEMPLATE.md](../../../cards/CARD_TEMPLATE.md).
> Niveaux de confiance : A normes/fabricant · B technique · C terrain validé · D hypothèse. Rien n'est publié comme certitude.

## Métadonnées
| Champ | Valeur |
|---|---|
| Identifiant | `poser-parquet-cloue` |
| Titre | Poser un parquet cloué |
| Profession | `metier:parquet` |
| Famille | `famille:finition` |
| Sous-famille | `sous-famille:parquet` |
| Version | v0.1 |
| Auteur | IA (proposition) |
| Validateur | ⟦à valider métier⟧ |
| Statut | Brouillon |
| Indice de confiance | **C** |

## Cadrage
- **Objectif** : poser un parquet **massif cloué** sur lambourdes/solives selon le **DTU 51.1**. `[C]`
- **Résumé** : poser (ou vérifier) les **lambourdes** à l'entraxe requis, clouer les lames massives (rainure-languette) en respectant le **sens de pose** et les **jeux périphériques**, en gérant l'humidité (bois acclimaté) ; **repérer les réseaux avant de clouer** (ne pas percer un tube/câble). `[C]` ⟦entraxe lambourdes/clouage selon parquet à confirmer⟧

## Réalisation
- **Étapes** :
  1. Vérifier/poser **lambourdes** (entraxe) ; support ventilé. `[C]`
  2. **Repérer les réseaux** avant clouage (élec/tubes). `[A]` → [controler-tableau-electrique](../../../professions/electricite-generale/cards/controler-tableau-electrique.md)
  3. Clouer les lames (rainure-languette) ; **jeux périphériques**. `[C]`
  4. Contrôler planéité/absence de jeu. `[C]` → [parquet-grince-joue](../../../diagnostics/parquet/parquet-grince-joue.md)
- **Points critiques** : entraxe lambourdes ; **jeux de dilatation** ; bois acclimaté ; **repérage réseaux** avant clouage.
- **Sécurité** : **électricité** (clouage/réseaux) ; poussières de bois ; bruit/machines. **Poussières de bois** : classées **cancérogènes** (cancers naso-sinusiens) — ponçage/découpe à **aspiration**, masque adapté, ventilation ; ne pas balayer à sec. **Produits de finition (vernis, huiles, solvants)** : **COV / inflammabilité** — ventiler pendant/après, EPI, pas de flamme ; les **chiffons imbibés d'huile s'auto-enflamment** (auto-échauffement → immerger/étaler). **Bruit** (ponceuse) : protection auditive. **Machines électroportatives** : capots/entretien. **Humidité des supports** : bois/support trop humide = **tuilage/gonflement/décollement** → **mesurer avant pose**. **Manutention** (paquets de lames) : binôme/TMS. **Découpes** : coupures. **Électricité** : avant de **clouer/percer** (plancher chauffant, gaines), repérer/consigner (NF C 15-100) — ne pas clouer sur un tube chauffant. **Amiante en rénovation** : d'anciennes **colles** sous parquet peuvent contenir de l'amiante → **diagnostic avant travaux** ; en présence d'amiante, **arrêt**, retrait réservé à une **entreprise certifiée** (**jamais ici**). **Arrêt immédiat en cas de danger.** `[A]`

## Cadre & suites
- **Normes** : pose des parquets à clouer **DTU 51.1** ; parquets collés **DTU 51.2** ; pose flottante des parquets contrecollés **DTU 51.11** ; électricité (avant percement, plancher chauffant) **NF C 15-100** ; taux d'humidité du support et diagnostic **amiante** (colles anciennes) ⟦en prose, à confirmer⟧ `[B]` ⟦références/versions exactes à confirmer par le validateur⟧. `respecte-norme`
- **Ponçage** : `cite-carte` → [poncer-parquet](poncer-parquet.md)

## Relations & tags
- **Tags** : `metier:parquet famille:finition sous-famille:parquet intervention:realiser cluster:parquet-cloue cluster:parquet-massif complexite:avancee type:realisation securite:electrique relation:electricite-generale`

## Historique
| Version | Date | Auteur | Validateur | Motif |
|---|---|---|---|---|
| v0.1 | 2026-08-05 | IA | ⟦—⟧ | proposition initiale (Brouillon) |
