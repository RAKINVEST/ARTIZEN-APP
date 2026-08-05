# Principe du parquet (massif, contrecollé, poses)

> **Brouillon (v0) — proposé par IA, en attente de validation métier** (Loi 7/18). Modèle : [../../../cards/CARD_TEMPLATE.md](../../../cards/CARD_TEMPLATE.md).
> Niveaux de confiance : A normes/fabricant · B technique · C terrain validé · D hypothèse. Rien n'est publié comme certitude.

## Métadonnées
| Champ | Valeur |
|---|---|
| Identifiant | `principe-parquet` |
| Titre | Principe du parquet (massif, contrecollé, poses) |
| Profession | `metier:parquet` |
| Famille | `famille:finition` |
| Sous-famille | `sous-famille:parquet` |
| Version | v0.1 |
| Auteur | IA (proposition) |
| Validateur | ⟦à valider métier⟧ |
| Statut | Brouillon |
| Indice de confiance | **C** |

## Cadrage
- **Objectif** : comprendre les types de parquet (**massif**, **contrecollé**) et leurs modes de pose (**cloué / collé / flottant**). `[C]`
- **Résumé** : le parquet est un revêtement **bois** : **massif** (pleine épaisseur, cloué/collé) ou **contrecollé** (parement bois sur support, collé/**flottant**) ; le choix de pose dépend du support, de l'usage et surtout de l'**humidité** ; le stratifié (revêtement décor) relève des **Revêtements de sol**, pas du parquet. `[C]` ⟦type/pose selon support et usage à confirmer⟧

## Réalisation
- **Étapes** :
  1. **Support** contrôlé (surtout **humidité**). `[C]` → [preparer-support-parquet](preparer-support-parquet.md)
  2. **Cloué** (massif/lambourdes) / **collé** (support stable). `[C]` → [poser-parquet-colle](poser-parquet-colle.md)
  3. **Flottant** (contrecollé + sous-couche). `[C]` → [poser-parquet-flottant](poser-parquet-flottant.md)
  4. Stratifié = **Revêtements de sol** (métier distinct). `[C]` → [poser-sol-flottant-clipsable](../../../professions/revetements-sol/cards/poser-sol-flottant-clipsable.md)
- **Points critiques** : **humidité** support/bois (le bois travaille) ; jeux de dilatation ; pose adaptée ; ≠ stratifié (revêtements de sol).
- **Sécurité** : poussières de bois (cancérogène) ; produits de finition ; humidité. **Poussières de bois** : classées **cancérogènes** (cancers naso-sinusiens) — ponçage/découpe à **aspiration**, masque adapté, ventilation ; ne pas balayer à sec. **Produits de finition (vernis, huiles, solvants)** : **COV / inflammabilité** — ventiler pendant/après, EPI, pas de flamme ; les **chiffons imbibés d'huile s'auto-enflamment** (auto-échauffement → immerger/étaler). **Bruit** (ponceuse) : protection auditive. **Machines électroportatives** : capots/entretien. **Humidité des supports** : bois/support trop humide = **tuilage/gonflement/décollement** → **mesurer avant pose**. **Manutention** (paquets de lames) : binôme/TMS. **Découpes** : coupures. **Électricité** : avant de **clouer/percer** (plancher chauffant, gaines), repérer/consigner (NF C 15-100) — ne pas clouer sur un tube chauffant. **Amiante en rénovation** : d'anciennes **colles** sous parquet peuvent contenir de l'amiante → **diagnostic avant travaux** ; en présence d'amiante, **arrêt**, retrait réservé à une **entreprise certifiée** (**jamais ici**). **Arrêt immédiat en cas de danger.** `[A]`

## Cadre & suites
- **Normes** : pose des parquets à clouer **DTU 51.1** ; parquets collés **DTU 51.2** ; pose flottante des parquets contrecollés **DTU 51.11** ; électricité (avant percement, plancher chauffant) **NF C 15-100** ; taux d'humidité du support et diagnostic **amiante** (colles anciennes) ⟦en prose, à confirmer⟧ `[B]` ⟦références/versions exactes à confirmer par le validateur⟧. `respecte-norme`
- **Finitions** : `cite-carte` → [finir-vitrifier-huiler-cirer](finir-vitrifier-huiler-cirer.md)

## Relations & tags
- **Tags** : `metier:parquet famille:finition sous-famille:parquet intervention:comprendre cluster:parquet-massif cluster:parquet-contrecolle cluster:parquet-flottant cluster:parquet-colle cluster:parquet-cloue type:principe securite:poussieres relation:revetements-sol`

## Historique
| Version | Date | Auteur | Validateur | Motif |
|---|---|---|---|---|
| v0.1 | 2026-08-05 | IA | ⟦—⟧ | proposition initiale (Brouillon) |
