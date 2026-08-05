# Entretenir / vidanger une installation

> **Brouillon (v0) — proposé par IA, en attente de validation métier** (Loi 7/18). Modèle : [../../../cards/CARD_TEMPLATE.md](../../../cards/CARD_TEMPLATE.md).
> Niveaux de confiance : A normes/fabricant · B technique · C terrain validé · D hypothèse. Rien n'est publié comme certitude.

## Métadonnées
| Champ | Valeur |
|---|---|
| Identifiant | `entretenir-vidanger-assainissement` |
| Titre | Entretenir / vidanger une installation |
| Profession | `metier:assainissement` |
| Famille | `famille:gros-oeuvre` |
| Sous-famille | `sous-famille:assainissement` |
| Version | v0.1 |
| Auteur | IA (proposition) |
| Validateur | ⟦à valider métier⟧ |
| Statut | Brouillon |
| Indice de confiance | **C** |

## Cadrage
- **Objectif** : entretenir une installation (curage réseau, **vidange** de fosse/microstation) — la vidange relève d'un **vidangeur agréé**. `[C]`
- **Résumé** : planifier l'entretien (fréquence de **vidange des boues** selon la filière), faire réaliser la **vidange par un vidangeur agréé** (élimination tracée), curer les canalisations si besoin, et contrôler ventilation/regards **sans descendre** ; toute intervention en cuve = **espace confiné réservé**. `[C]` ⟦fréquence selon filière à confirmer⟧

## Réalisation
- **Étapes** :
  1. Planifier la **vidange** (fréquence selon filière). `[C]` ⟦à confirmer⟧
  2. Vidange par **vidangeur agréé** (bordereau/traçabilité). `[A]`
  3. Curer les canalisations (depuis la surface) si besoin. `[C]`
  4. Contrôler ventilation/regards **sans descendre**. `[A]` → [securite-espace-confine-assainissement](../../../procedures/assainissement/securite-espace-confine-assainissement.md)
- **Points critiques** : vidange = **vidangeur agréé** (élimination tracée) ; ne pas descendre en cuve ; entretien régulier (évite le colmatage).
- **Sécurité** : H₂S/espace confiné ; biologique/contamination ; tampons. **Espace confiné** (regard, poste de relevage, fosse) : **danger mortel** — **gaz toxiques (H₂S)**, **manque d'oxygène**, risque d'explosion → **jamais de descente sans procédure** (détection d'atmosphère, **ventilation forcée**, **surveillant** extérieur, harnais/treuil, autorisation) — opération **réservée à des intervenants formés/équipés**. **Risque biologique / contamination** (eaux usées) : EPI, hygiène, vaccination. **Levage des tampons** (lourds/coincés) : outil adapté, écrasement/dos. **Fouilles** : blindage (effondrement). **Réseaux enterrés** (DICT). **Arrêt immédiat en cas de danger.** Opérations réglementées (ANC, espace confiné) **réservées aux professionnels qualifiés**.** `[A]`

## Cadre & suites
- **Normes** : assainissement non collectif **DTU 64.1** ; évacuation EU/EP **DTU 60.11** ; mise en œuvre/essais des collecteurs **NF EN 1610**, réglementation ANC (**arrêté du 7 sept. 2009**, contrôle **SPANC**) ⟦en prose, à confirmer⟧ `[B]` ⟦références/versions exactes à confirmer par le validateur⟧. `respecte-norme`
- **Kit** : `utilise-kit` → [kit-assainissement](../../../kits/assainissement/kit-assainissement.md)

## Relations & tags
- **Tags** : `metier:assainissement famille:gros-oeuvre sous-famille:assainissement intervention:entretenir cluster:controle cluster:fosses-toutes-eaux cluster:microstations complexite:moyenne type:entretien securite:confine`

## Historique
| Version | Date | Auteur | Validateur | Motif |
|---|---|---|---|---|
| v0.1 | 2026-08-05 | IA | ⟦—⟧ | proposition initiale (Brouillon) |
