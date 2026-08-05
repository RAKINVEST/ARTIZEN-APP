# Réparer / entretenir un parquet

> **Brouillon (v0) — proposé par IA, en attente de validation métier** (Loi 7/18). Modèle : [../../../cards/CARD_TEMPLATE.md](../../../cards/CARD_TEMPLATE.md).
> Niveaux de confiance : A normes/fabricant · B technique · C terrain validé · D hypothèse. Rien n'est publié comme certitude.

## Métadonnées
| Champ | Valeur |
|---|---|
| Identifiant | `reparer-entretenir-parquet` |
| Titre | Réparer / entretenir un parquet |
| Profession | `metier:parquet` |
| Famille | `famille:finition` |
| Sous-famille | `sous-famille:parquet` |
| Version | v0.1 |
| Auteur | IA (proposition) |
| Validateur | ⟦à valider métier⟧ |
| Statut | Brouillon |
| Indice de confiance | **C** |

## Cadrage
- **Objectif** : réaliser des **réparations localisées** (lame, rayure) et l'**entretien** adapté à la finition. `[C]`
- **Résumé** : diagnostiquer les défauts (lame abîmée, grincement, finition usée), remplacer une **lame** ou reboucher localement, rénover la finition (ponçage partiel + re-vitrification/huilage), et adapter l'**entretien** au type de finition (peu d'eau ; huile = entretien régulier ; vitrifié = nettoyage doux). `[C]`

## Réalisation
- **Étapes** :
  1. Diagnostiquer (lame/grincement/finition). `[C]` → [finition-degradee-usure](../../../diagnostics/parquet/finition-degradee-usure.md)
  2. **Remplacer une lame** / reboucher localement. `[C]`
  3. Rénover la finition (ponçage partiel + re-finition). `[C]` → [finir-vitrifier-huiler-cirer](finir-vitrifier-huiler-cirer.md)
  4. **Entretien** adapté (peu d'eau ; selon finition). `[C]` → [controle-maintenance-parquet](../../../checklists/parquet/controle-maintenance-parquet.md)
- **Points critiques** : reprise avec **même essence/finition** ; peu d'eau (le bois craint l'humidité) ; entretien selon vitrifié/huilé.
- **Sécurité** : poussières de bois (ponçage) ; COV (re-finition) ; — **Poussières de bois** : classées **cancérogènes** (cancers naso-sinusiens) — ponçage/découpe à **aspiration**, masque adapté, ventilation ; ne pas balayer à sec. **Produits de finition (vernis, huiles, solvants)** : **COV / inflammabilité** — ventiler pendant/après, EPI, pas de flamme ; les **chiffons imbibés d'huile s'auto-enflamment** (auto-échauffement → immerger/étaler). **Bruit** (ponceuse) : protection auditive. **Machines électroportatives** : capots/entretien. **Humidité des supports** : bois/support trop humide = **tuilage/gonflement/décollement** → **mesurer avant pose**. **Manutention** (paquets de lames) : binôme/TMS. **Découpes** : coupures. **Électricité** : avant de **clouer/percer** (plancher chauffant, gaines), repérer/consigner (NF C 15-100) — ne pas clouer sur un tube chauffant. **Amiante en rénovation** : d'anciennes **colles** sous parquet peuvent contenir de l'amiante → **diagnostic avant travaux** ; en présence d'amiante, **arrêt**, retrait réservé à une **entreprise certifiée** (**jamais ici**). **Arrêt immédiat en cas de danger.** `[A]`

## Cadre & suites
- **Normes** : pose des parquets à clouer **DTU 51.1** ; parquets collés **DTU 51.2** ; pose flottante des parquets contrecollés **DTU 51.11** ; électricité (avant percement, plancher chauffant) **NF C 15-100** ; taux d'humidité du support et diagnostic **amiante** (colles anciennes) ⟦en prose, à confirmer⟧ `[B]` ⟦références/versions exactes à confirmer par le validateur⟧. `respecte-norme`
- **Kit** : `utilise-kit` → [kit-parqueteur](../../../kits/parquet/kit-parqueteur.md)

## Relations & tags
- **Tags** : `metier:parquet famille:finition sous-famille:parquet intervention:reparer intervention:entretenir cluster:reparations-localisees cluster:entretien cluster:maintenance complexite:moyenne type:entretien securite:poussieres`

## Historique
| Version | Date | Auteur | Validateur | Motif |
|---|---|---|---|---|
| v0.1 | 2026-08-05 | IA | ⟦—⟧ | proposition initiale (Brouillon) |
