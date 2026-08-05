# Diagnostiquer / contrôler un assainissement

> **Brouillon (v0) — proposé par IA, en attente de validation métier** (Loi 7/18). Modèle : [../../../cards/CARD_TEMPLATE.md](../../../cards/CARD_TEMPLATE.md).
> Niveaux de confiance : A normes/fabricant · B technique · C terrain validé · D hypothèse. Rien n'est publié comme certitude.

## Métadonnées
| Champ | Valeur |
|---|---|
| Identifiant | `diagnostiquer-controler-assainissement` |
| Titre | Diagnostiquer / contrôler un assainissement |
| Profession | `metier:assainissement` |
| Famille | `famille:gros-oeuvre` |
| Sous-famille | `sous-famille:assainissement` |
| Version | v0.1 |
| Auteur | IA (proposition) |
| Validateur | ⟦à valider métier⟧ |
| Statut | Brouillon |
| Indice de confiance | **C** |

## Cadrage
- **Objectif** : diagnostiquer et contrôler une installation d'assainissement (écoulement, étanchéité, ANC, conformité SPANC). `[C]`
- **Résumé** : contrôler l'écoulement et l'étanchéité (essais, inspection caméra), l'état des regards/ouvrages, le fonctionnement de l'ANC (fosse/épandage/microstation) et la conformité au regard du **SPANC**, puis orienter la remise en état. `[C]`

## Réalisation
- **Étapes** :
  1. Contrôler **écoulement/étanchéité** (essais / **inspection caméra**). `[C]`
  2. Contrôler regards/ouvrages **sans descendre** (espace confiné). `[A]`
  3. Vérifier l'ANC (fosse/épandage/microstation) + **conformité SPANC**. `[C]` → [dysfonctionnement-anc](../../../diagnostics/assainissement/dysfonctionnement-anc.md)
  4. Orienter la remise en état / vidange. `[C]` → [entretenir-vidanger-assainissement](entretenir-vidanger-assainissement.md)
- **Points critiques** : contrôle **sans entrer** en espace confiné (caméra/depuis la surface) ; conformité SPANC ; localiser fuite/colmatage.
- **Sécurité** : H₂S/espace confiné (ne pas descendre) ; biologique ; tampons. **Espace confiné** (regard, poste de relevage, fosse) : **danger mortel** — **gaz toxiques (H₂S)**, **manque d'oxygène**, risque d'explosion → **jamais de descente sans procédure** (détection d'atmosphère, **ventilation forcée**, **surveillant** extérieur, harnais/treuil, autorisation) — opération **réservée à des intervenants formés/équipés**. **Risque biologique / contamination** (eaux usées) : EPI, hygiène, vaccination. **Levage des tampons** (lourds/coincés) : outil adapté, écrasement/dos. **Fouilles** : blindage (effondrement). **Réseaux enterrés** (DICT). **Arrêt immédiat en cas de danger.** Opérations réglementées (ANC, espace confiné) **réservées aux professionnels qualifiés**.** `[A]`

## Cadre & suites
- **Normes** : assainissement non collectif **DTU 64.1** ; évacuation EU/EP **DTU 60.11** ; mise en œuvre/essais des collecteurs **NF EN 1610**, réglementation ANC (**arrêté du 7 sept. 2009**, contrôle **SPANC**) ⟦en prose, à confirmer⟧ `[B]` ⟦références/versions exactes à confirmer par le validateur⟧. `respecte-norme`
- **Contrôle** : `a-checklist` → [controle-maintenance-assainissement](../../../checklists/assainissement/controle-maintenance-assainissement.md)

## Relations & tags
- **Tags** : `metier:assainissement famille:gros-oeuvre sous-famille:assainissement intervention:diagnostiquer intervention:controler cluster:diagnostic cluster:controle complexite:avancee type:diagnostic securite:confine`

## Historique
| Version | Date | Auteur | Validateur | Motif |
|---|---|---|---|---|
| v0.1 | 2026-08-05 | IA | ⟦—⟧ | proposition initiale (Brouillon) |
