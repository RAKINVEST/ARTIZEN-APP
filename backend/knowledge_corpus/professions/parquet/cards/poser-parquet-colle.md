# Poser un parquet collé

> **Brouillon (v0) — proposé par IA, en attente de validation métier** (Loi 7/18). Modèle : [../../../cards/CARD_TEMPLATE.md](../../../cards/CARD_TEMPLATE.md).
> Niveaux de confiance : A normes/fabricant · B technique · C terrain validé · D hypothèse. Rien n'est publié comme certitude.

## Métadonnées
| Champ | Valeur |
|---|---|
| Identifiant | `poser-parquet-colle` |
| Titre | Poser un parquet collé |
| Profession | `metier:parquet` |
| Famille | `famille:finition` |
| Sous-famille | `sous-famille:parquet` |
| Version | v0.1 |
| Auteur | IA (proposition) |
| Validateur | ⟦à valider métier⟧ |
| Statut | Brouillon |
| Indice de confiance | **C** |

## Cadrage
- **Objectif** : poser un parquet **collé** (massif/contrecollé) sur support stable selon le **DTU 51.2** — compatible plancher chauffant. `[C]`
- **Résumé** : sur un support **sec/plan/cohésif**, encoller au **peigne** (colle adaptée bois, souvent MS/polyuréthane), poser les lames à joints décalés en respectant les **jeux périphériques** et le temps ouvert ; sur **plancher chauffant**, respecter la mise en chauffe/le protocole (parquet compatible). `[C]` ⟦colle/protocole plancher chauffant à confirmer⟧

## Réalisation
- **Étapes** :
  1. Support **sec/plan** ; colle bois adaptée (peigne). `[C]`
  2. **Plancher chauffant** : parquet compatible + protocole. `[C]` → [purger-plancher-chauffant](../../../professions/chauffage/cards/purger-plancher-chauffant.md)
  3. Poser à joints décalés ; **jeux périphériques**. `[C]`
  4. Contrôler encollage/planéité (pas de creux). `[C]` → [parquet-tuile-gonfle](../../../diagnostics/parquet/parquet-tuile-gonfle.md)
- **Points critiques** : support sec (humidité) ; **colle adaptée** ; jeux de dilatation ; **plancher chauffant** compatible/protocole.
- **Sécurité** : COV (colle) ; poussières de bois ; genoux/TMS. **Poussières de bois** : classées **cancérogènes** (cancers naso-sinusiens) — ponçage/découpe à **aspiration**, masque adapté, ventilation ; ne pas balayer à sec. **Produits de finition (vernis, huiles, solvants)** : **COV / inflammabilité** — ventiler pendant/après, EPI, pas de flamme ; les **chiffons imbibés d'huile s'auto-enflamment** (auto-échauffement → immerger/étaler). **Bruit** (ponceuse) : protection auditive. **Machines électroportatives** : capots/entretien. **Humidité des supports** : bois/support trop humide = **tuilage/gonflement/décollement** → **mesurer avant pose**. **Manutention** (paquets de lames) : binôme/TMS. **Découpes** : coupures. **Électricité** : avant de **clouer/percer** (plancher chauffant, gaines), repérer/consigner (NF C 15-100) — ne pas clouer sur un tube chauffant. **Amiante en rénovation** : d'anciennes **colles** sous parquet peuvent contenir de l'amiante → **diagnostic avant travaux** ; en présence d'amiante, **arrêt**, retrait réservé à une **entreprise certifiée** (**jamais ici**). **Arrêt immédiat en cas de danger.** `[A]`

## Cadre & suites
- **Normes** : pose des parquets à clouer **DTU 51.1** ; parquets collés **DTU 51.2** ; pose flottante des parquets contrecollés **DTU 51.11** ; électricité (avant percement, plancher chauffant) **NF C 15-100** ; taux d'humidité du support et diagnostic **amiante** (colles anciennes) ⟦en prose, à confirmer⟧ `[B]` ⟦références/versions exactes à confirmer par le validateur⟧. `respecte-norme`
- **Support / humidité** : `cite-carte` → [preparer-support-parquet](preparer-support-parquet.md)

## Relations & tags
- **Tags** : `metier:parquet famille:finition sous-famille:parquet intervention:realiser cluster:parquet-colle cluster:parquet-massif complexite:avancee type:realisation securite:cov relation:chauffage`

## Historique
| Version | Date | Auteur | Validateur | Motif |
|---|---|---|---|---|
| v0.1 | 2026-08-05 | IA | ⟦—⟧ | proposition initiale (Brouillon) |
