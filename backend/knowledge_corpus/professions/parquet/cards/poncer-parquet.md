# Poncer un parquet

> **Brouillon (v0) — proposé par IA, en attente de validation métier** (Loi 7/18). Modèle : [../../../cards/CARD_TEMPLATE.md](../../../cards/CARD_TEMPLATE.md).
> Niveaux de confiance : A normes/fabricant · B technique · C terrain validé · D hypothèse. Rien n'est publié comme certitude.

## Métadonnées
| Champ | Valeur |
|---|---|
| Identifiant | `poncer-parquet` |
| Titre | Poncer un parquet |
| Profession | `metier:parquet` |
| Famille | `famille:finition` |
| Sous-famille | `sous-famille:parquet` |
| Version | v0.1 |
| Auteur | IA (proposition) |
| Validateur | ⟦à valider métier⟧ |
| Statut | Brouillon |
| Indice de confiance | **C** |

## Cadrage
- **Objectif** : poncer un parquet (massif/contrecollé rabotable) : dégrossissage → finition, à **aspiration**. `[C]`
- **Résumé** : poncer par passes de **grain croissant** (dégrossissage → intermédiaire → finition) à la **ponceuse à bande + bordureuse**, en **aspiration** (poussières de bois cancérogènes), dépoussiérer soigneusement entre passes et avant finition ; un contrecollé ne se ponçe que si le parement le permet. `[C]` ⟦grains/nombre de passes selon parquet à confirmer⟧

## Réalisation
- **Étapes** :
  1. Poncer par **grain croissant** (dégross. → finition). `[C]`
  2. **Aspiration** obligatoire (poussières cancérogènes). `[A]`
  3. Bordures/angles à la **bordureuse** ; dépoussiérer. `[C]`
  4. Contrôler l'état de surface avant finition. `[C]` → [finir-vitrifier-huiler-cirer](finir-vitrifier-huiler-cirer.md)
- **Points critiques** : grains croissants ; **aspiration** (bois cancérogène) ; dépoussiérage avant finition ; contrecollé = épaisseur limitée.
- **Sécurité** : **poussières de bois (cancérogène)** ; **bruit** ; machines électroportatives. **Poussières de bois** : classées **cancérogènes** (cancers naso-sinusiens) — ponçage/découpe à **aspiration**, masque adapté, ventilation ; ne pas balayer à sec. **Produits de finition (vernis, huiles, solvants)** : **COV / inflammabilité** — ventiler pendant/après, EPI, pas de flamme ; les **chiffons imbibés d'huile s'auto-enflamment** (auto-échauffement → immerger/étaler). **Bruit** (ponceuse) : protection auditive. **Machines électroportatives** : capots/entretien. **Humidité des supports** : bois/support trop humide = **tuilage/gonflement/décollement** → **mesurer avant pose**. **Manutention** (paquets de lames) : binôme/TMS. **Découpes** : coupures. **Électricité** : avant de **clouer/percer** (plancher chauffant, gaines), repérer/consigner (NF C 15-100) — ne pas clouer sur un tube chauffant. **Amiante en rénovation** : d'anciennes **colles** sous parquet peuvent contenir de l'amiante → **diagnostic avant travaux** ; en présence d'amiante, **arrêt**, retrait réservé à une **entreprise certifiée** (**jamais ici**). **Arrêt immédiat en cas de danger.** `[A]`

## Cadre & suites
- **Normes** : pose des parquets à clouer **DTU 51.1** ; parquets collés **DTU 51.2** ; pose flottante des parquets contrecollés **DTU 51.11** ; électricité (avant percement, plancher chauffant) **NF C 15-100** ; taux d'humidité du support et diagnostic **amiante** (colles anciennes) ⟦en prose, à confirmer⟧ `[B]` ⟦références/versions exactes à confirmer par le validateur⟧. `respecte-norme`
- **Diagnostic** : `traite-diagnostic` → [finition-degradee-usure](../../../diagnostics/parquet/finition-degradee-usure.md)

## Relations & tags
- **Tags** : `metier:parquet famille:finition sous-famille:parquet intervention:realiser cluster:poncage complexite:moyenne type:realisation securite:poussieres`

## Historique
| Version | Date | Auteur | Validateur | Motif |
|---|---|---|---|---|
| v0.1 | 2026-08-05 | IA | ⟦—⟧ | proposition initiale (Brouillon) |
