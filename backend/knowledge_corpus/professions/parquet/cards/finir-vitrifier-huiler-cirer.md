# Finir : vitrification, huilage, cirage

> **Brouillon (v0) — proposé par IA, en attente de validation métier** (Loi 7/18). Modèle : [../../../cards/CARD_TEMPLATE.md](../../../cards/CARD_TEMPLATE.md).
> Niveaux de confiance : A normes/fabricant · B technique · C terrain validé · D hypothèse. Rien n'est publié comme certitude.

## Métadonnées
| Champ | Valeur |
|---|---|
| Identifiant | `finir-vitrifier-huiler-cirer` |
| Titre | Finir : vitrification, huilage, cirage |
| Profession | `metier:parquet` |
| Famille | `famille:finition` |
| Sous-famille | `sous-famille:parquet` |
| Version | v0.1 |
| Auteur | IA (proposition) |
| Validateur | ⟦à valider métier⟧ |
| Statut | Brouillon |
| Indice de confiance | **C** |

## Cadrage
- **Objectif** : appliquer la finition du parquet : **vitrification**, **huilage** ou **cirage** selon l'usage et l'entretien souhaité. `[C]`
- **Résumé** : choisir la finition — **vitrification** (film protecteur, résistant), **huilage** (aspect naturel, entretien régulier), **cirage** (traditionnel) — sur un parquet **dépoussiéré**, appliquer les couches (fond dur + finition) en respectant le séchage et la ventilation ; **attention aux chiffons imbibés d'huile** (auto-échauffement). `[C]` ⟦système/nb de couches selon finition à confirmer⟧

## Réalisation
- **Étapes** :
  1. Choisir **vitrification / huilage / cirage** (usage/entretien). `[C]`
  2. Sur parquet **dépoussiéré** : fond dur + couches (séchage). `[C]` → [poncer-parquet](poncer-parquet.md)
  3. **Ventiler** (COV) ; **chiffons huile immergés** (auto-échauffement). `[A]`
  4. Contrôler l'aspect/l'uniformité. `[C]` → [finition-degradee-usure](../../../diagnostics/parquet/finition-degradee-usure.md)
- **Points critiques** : finition adaptée à l'usage/entretien ; support dépoussiéré ; séchage/ventilation ; **chiffons d'huile = risque d'incendie**.
- **Sécurité** : COV/solvants ; **chiffons huile (auto-échauffement)** ; ventilation. **Poussières de bois** : classées **cancérogènes** (cancers naso-sinusiens) — ponçage/découpe à **aspiration**, masque adapté, ventilation ; ne pas balayer à sec. **Produits de finition (vernis, huiles, solvants)** : **COV / inflammabilité** — ventiler pendant/après, EPI, pas de flamme ; les **chiffons imbibés d'huile s'auto-enflamment** (auto-échauffement → immerger/étaler). **Bruit** (ponceuse) : protection auditive. **Machines électroportatives** : capots/entretien. **Humidité des supports** : bois/support trop humide = **tuilage/gonflement/décollement** → **mesurer avant pose**. **Manutention** (paquets de lames) : binôme/TMS. **Découpes** : coupures. **Électricité** : avant de **clouer/percer** (plancher chauffant, gaines), repérer/consigner (NF C 15-100) — ne pas clouer sur un tube chauffant. **Amiante en rénovation** : d'anciennes **colles** sous parquet peuvent contenir de l'amiante → **diagnostic avant travaux** ; en présence d'amiante, **arrêt**, retrait réservé à une **entreprise certifiée** (**jamais ici**). **Arrêt immédiat en cas de danger.** `[A]`

## Cadre & suites
- **Normes** : pose des parquets à clouer **DTU 51.1** ; parquets collés **DTU 51.2** ; pose flottante des parquets contrecollés **DTU 51.11** ; électricité (avant percement, plancher chauffant) **NF C 15-100** ; taux d'humidité du support et diagnostic **amiante** (colles anciennes) ⟦en prose, à confirmer⟧ `[B]` ⟦références/versions exactes à confirmer par le validateur⟧. `respecte-norme`
- **Entretien** : `cite-carte` → [reparer-entretenir-parquet](reparer-entretenir-parquet.md)

## Relations & tags
- **Tags** : `metier:parquet famille:finition sous-famille:parquet intervention:realiser cluster:vitrification cluster:huilage cluster:cirage complexite:avancee type:realisation securite:cov`

## Historique
| Version | Date | Auteur | Validateur | Motif |
|---|---|---|---|---|
| v0.1 | 2026-08-05 | IA | ⟦—⟧ | proposition initiale (Brouillon) |
