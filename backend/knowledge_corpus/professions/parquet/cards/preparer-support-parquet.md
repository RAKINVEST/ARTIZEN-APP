# Préparer le support avant pose de parquet

> **Brouillon (v0) — proposé par IA, en attente de validation métier** (Loi 7/18). Modèle : [../../../cards/CARD_TEMPLATE.md](../../../cards/CARD_TEMPLATE.md).
> Niveaux de confiance : A normes/fabricant · B technique · C terrain validé · D hypothèse. Rien n'est publié comme certitude.

## Métadonnées
| Champ | Valeur |
|---|---|
| Identifiant | `preparer-support-parquet` |
| Titre | Préparer le support avant pose de parquet |
| Profession | `metier:parquet` |
| Famille | `famille:finition` |
| Sous-famille | `sous-famille:parquet` |
| Version | v0.1 |
| Auteur | IA (proposition) |
| Validateur | ⟦à valider métier⟧ |
| Statut | Brouillon |
| Indice de confiance | **C** |

## Cadrage
- **Objectif** : préparer le support : planéité, **mesure d'humidité**, ragréage éventuel et **sous-couche** selon la pose. `[C]`
- **Résumé** : contrôler la planéité et la cohésion, **mesurer l'humidité** du support (béton/chape — seuil strict pour le bois) et acclimater le parquet, ragréer si besoin (interface commune au carrelage), poser la **sous-couche** (flottant) ou vérifier l'aptitude au collage/clouage ; en rénovation, **diagnostic amiante** (colles). `[C]` ⟦humidité admissible/sous-couche selon pose à confirmer⟧

## Réalisation
- **Étapes** :
  1. Contrôler planéité/cohésion ; **mesurer l'humidité**. `[A]`
  2. Ragréer si besoin (interface). `[C]` → [preparer-support-ragreage](../../../professions/carrelage/cards/preparer-support-ragreage.md)
  3. **Sous-couche** (flottant) / aptitude collage-clouage. `[C]` ⟦à confirmer⟧
  4. Rénovation : **diagnostic amiante** (colles). `[A]` → [controle-humidite-amiante-avant-pose](../../../procedures/parquet/controle-humidite-amiante-avant-pose.md)
- **Points critiques** : **humidité du support** (seuil bois strict) + acclimatation du parquet ; planéité ; sous-couche adaptée ; **amiante** en rénovation.
- **Sécurité** : poussières (ragréage) ; humidité (mesure) ; amiante. **Poussières de bois** : classées **cancérogènes** (cancers naso-sinusiens) — ponçage/découpe à **aspiration**, masque adapté, ventilation ; ne pas balayer à sec. **Produits de finition (vernis, huiles, solvants)** : **COV / inflammabilité** — ventiler pendant/après, EPI, pas de flamme ; les **chiffons imbibés d'huile s'auto-enflamment** (auto-échauffement → immerger/étaler). **Bruit** (ponceuse) : protection auditive. **Machines électroportatives** : capots/entretien. **Humidité des supports** : bois/support trop humide = **tuilage/gonflement/décollement** → **mesurer avant pose**. **Manutention** (paquets de lames) : binôme/TMS. **Découpes** : coupures. **Électricité** : avant de **clouer/percer** (plancher chauffant, gaines), repérer/consigner (NF C 15-100) — ne pas clouer sur un tube chauffant. **Amiante en rénovation** : d'anciennes **colles** sous parquet peuvent contenir de l'amiante → **diagnostic avant travaux** ; en présence d'amiante, **arrêt**, retrait réservé à une **entreprise certifiée** (**jamais ici**). **Arrêt immédiat en cas de danger.** `[A]`

## Cadre & suites
- **Normes** : pose des parquets à clouer **DTU 51.1** ; parquets collés **DTU 51.2** ; pose flottante des parquets contrecollés **DTU 51.11** ; électricité (avant percement, plancher chauffant) **NF C 15-100** ; taux d'humidité du support et diagnostic **amiante** (colles anciennes) ⟦en prose, à confirmer⟧ `[B]` ⟦références/versions exactes à confirmer par le validateur⟧. `respecte-norme`
- **Pose flottante** : `cite-carte` → [poser-parquet-flottant](poser-parquet-flottant.md)

## Relations & tags
- **Tags** : `metier:parquet famille:finition sous-famille:parquet intervention:realiser cluster:preparation-du-support cluster:humidite-des-supports cluster:sous-couches complexite:moyenne type:realisation securite:poussieres relation:carrelage`

## Historique
| Version | Date | Auteur | Validateur | Motif |
|---|---|---|---|---|
| v0.1 | 2026-08-05 | IA | ⟦—⟧ | proposition initiale (Brouillon) |
