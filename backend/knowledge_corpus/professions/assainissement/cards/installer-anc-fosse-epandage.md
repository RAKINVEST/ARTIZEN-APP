# Installer un ANC (fosse toutes eaux + épandage)

> **Brouillon (v0) — proposé par IA, en attente de validation métier** (Loi 7/18). Modèle : [../../../cards/CARD_TEMPLATE.md](../../../cards/CARD_TEMPLATE.md).
> Niveaux de confiance : A normes/fabricant · B technique · C terrain validé · D hypothèse. Rien n'est publié comme certitude.

## Métadonnées
| Champ | Valeur |
|---|---|
| Identifiant | `installer-anc-fosse-epandage` |
| Titre | Installer un ANC (fosse toutes eaux + épandage) |
| Profession | `metier:assainissement` |
| Famille | `famille:gros-oeuvre` |
| Sous-famille | `sous-famille:assainissement` |
| Version | v0.1 |
| Auteur | IA (proposition) |
| Validateur | ⟦à valider métier⟧ |
| Statut | Brouillon |
| Indice de confiance | **C** |

## Cadrage
- **Objectif** : installer une filière d'assainissement non collectif : **fosse toutes eaux** + traitement par le sol (épandage), selon le **DTU 64.1**. `[C]`
- **Résumé** : sur la base de l'**étude de sol/de filière** (aévalée par le SPANC), poser la **fosse toutes eaux** (ventilée), réaliser le **traitement** (tranchées d'**épandage**/filtre à sable selon le sol) et le répartiteur, en respectant pentes, distances et volumes ; filière **soumise à contrôle SPANC**. `[C]` ⟦dimensionnement (nb pièces)/filière selon étude et arrêté à confirmer⟧

## Réalisation
- **Étapes** :
  1. Étude de sol/filière + accord **SPANC** (réglementaire). `[A]` ⟦obligatoire⟧
  2. Poser la **fosse toutes eaux** (assise, ventilation, volume). `[C]`
  3. Réaliser l'**épandage** (tranchées/filtre à sable) + répartiteur. `[C]` → [realiser-fouille-tranchee](../../../professions/terrassement/cards/realiser-fouille-tranchee.md)
  4. Respecter pentes/distances ; remblai adapté ; contrôle SPANC. `[C]`
- **Points critiques** : filière **adaptée au sol** (étude) ; volumes/distances réglementaires ; **ventilation** de la fosse ; contrôle SPANC obligatoire.
- **Sécurité** : H₂S (fosse = espace confiné) ; biologique ; fouilles (épandage). **Espace confiné** (regard, poste de relevage, fosse) : **danger mortel** — **gaz toxiques (H₂S)**, **manque d'oxygène**, risque d'explosion → **jamais de descente sans procédure** (détection d'atmosphère, **ventilation forcée**, **surveillant** extérieur, harnais/treuil, autorisation) — opération **réservée à des intervenants formés/équipés**. **Risque biologique / contamination** (eaux usées) : EPI, hygiène, vaccination. **Levage des tampons** (lourds/coincés) : outil adapté, écrasement/dos. **Fouilles** : blindage (effondrement). **Réseaux enterrés** (DICT). **Arrêt immédiat en cas de danger.** Opérations réglementées (ANC, espace confiné) **réservées aux professionnels qualifiés**.** `[A]`

## Cadre & suites
- **Normes** : assainissement non collectif **DTU 64.1** ; évacuation EU/EP **DTU 60.11** ; mise en œuvre/essais des collecteurs **NF EN 1610**, réglementation ANC (**arrêté du 7 sept. 2009**, contrôle **SPANC**) ⟦en prose, à confirmer⟧ `[B]` ⟦références/versions exactes à confirmer par le validateur⟧. `respecte-norme`
- **Microstation (alternative)** : `cite-carte` → [installer-microstation](installer-microstation.md)

## Relations & tags
- **Tags** : `metier:assainissement famille:gros-oeuvre sous-famille:assainissement intervention:poser cluster:assainissement-non-collectif cluster:fosses-toutes-eaux cluster:epandage complexite:expert type:installation securite:confine`

## Historique
| Version | Date | Auteur | Validateur | Motif |
|---|---|---|---|---|
| v0.1 | 2026-08-05 | IA | ⟦—⟧ | proposition initiale (Brouillon) |
