# Principe de l'assainissement (EU/EV/EP, collectif / ANC)

> **Brouillon (v0) — proposé par IA, en attente de validation métier** (Loi 7/18). Modèle : [../../../cards/CARD_TEMPLATE.md](../../../cards/CARD_TEMPLATE.md).
> Niveaux de confiance : A normes/fabricant · B technique · C terrain validé · D hypothèse. Rien n'est publié comme certitude.

## Métadonnées
| Champ | Valeur |
|---|---|
| Identifiant | `principe-assainissement` |
| Titre | Principe de l'assainissement (EU/EV/EP, collectif / ANC) |
| Profession | `metier:assainissement` |
| Famille | `famille:gros-oeuvre` |
| Sous-famille | `sous-famille:assainissement` |
| Version | v0.1 |
| Auteur | IA (proposition) |
| Validateur | ⟦à valider métier⟧ |
| Statut | Brouillon |
| Indice de confiance | **C** |

## Cadrage
- **Objectif** : comprendre l'assainissement : collecte/traitement des eaux usées (EU/EV) et pluviales (EP), en collectif ou non collectif (ANC). `[C]`
- **Résumé** : l'assainissement collecte et évacue/traite les **eaux usées** (EU), **vannes** (EV) et **pluviales** (EP) ; en **collectif** (raccordement au réseau public) ou **non collectif** (**ANC** : fosse toutes eaux + épandage / microstation) ; principe clé : **séparation des eaux** et **ventilation** du réseau. `[C]` ⟦filière selon terrain/réglementation à confirmer⟧

## Réalisation
- **Étapes** :
  1. **Réseaux EU/EV/EP** (séparatif, pentes). `[C]` → [poser-reseau-eu-ep](poser-reseau-eu-ep.md)
  2. **ANC** : fosse toutes eaux + épandage. `[C]` → [installer-anc-fosse-epandage](installer-anc-fosse-epandage.md)
  3. **Ventilation** primaire/secondaire du réseau (égout). `[C]` → [poser-regards-ventilation](poser-regards-ventilation.md)
  4. **Collectif** : raccordement au réseau public (via VRD). `[C]` → [poser-reseau-humide](../../../professions/vrd/cards/poser-reseau-humide.md)
- **Points critiques** : **séparation EU/EP** ; pentes gravitaires ; **ventilation** du réseau (odeurs/décompression) ; ANC = filiere adaptée au sol.
- **Sécurité** : H₂S/espace confiné ; biologique ; fouilles. **Espace confiné** (regard, poste de relevage, fosse) : **danger mortel** — **gaz toxiques (H₂S)**, **manque d'oxygène**, risque d'explosion → **jamais de descente sans procédure** (détection d'atmosphère, **ventilation forcée**, **surveillant** extérieur, harnais/treuil, autorisation) — opération **réservée à des intervenants formés/équipés**. **Risque biologique / contamination** (eaux usées) : EPI, hygiène, vaccination. **Levage des tampons** (lourds/coincés) : outil adapté, écrasement/dos. **Fouilles** : blindage (effondrement). **Réseaux enterrés** (DICT). **Arrêt immédiat en cas de danger.** Opérations réglementées (ANC, espace confiné) **réservées aux professionnels qualifiés**.** `[A]`

## Cadre & suites
- **Normes** : assainissement non collectif **DTU 64.1** ; évacuation EU/EP **DTU 60.11** ; mise en œuvre/essais des collecteurs **NF EN 1610**, réglementation ANC (**arrêté du 7 sept. 2009**, contrôle **SPANC**) ⟦en prose, à confirmer⟧ `[B]` ⟦références/versions exactes à confirmer par le validateur⟧. `respecte-norme`
- **Diagnostic / contrôle** : `cite-carte` → [diagnostiquer-controler-assainissement](diagnostiquer-controler-assainissement.md)

## Relations & tags
- **Tags** : `metier:assainissement famille:gros-oeuvre sous-famille:assainissement intervention:comprendre cluster:eaux-usees cluster:eaux-vannes cluster:eaux-pluviales cluster:assainissement-collectif cluster:assainissement-non-collectif type:principe securite:confine relation:vrd`

## Historique
| Version | Date | Auteur | Validateur | Motif |
|---|---|---|---|---|
| v0.1 | 2026-08-05 | IA | ⟦—⟧ | proposition initiale (Brouillon) |
