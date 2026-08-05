# Installer un poste de relevage

> **Brouillon (v0) — proposé par IA, en attente de validation métier** (Loi 7/18). Modèle : [../../../cards/CARD_TEMPLATE.md](../../../cards/CARD_TEMPLATE.md).
> Niveaux de confiance : A normes/fabricant · B technique · C terrain validé · D hypothèse. Rien n'est publié comme certitude.

## Métadonnées
| Champ | Valeur |
|---|---|
| Identifiant | `installer-poste-relevage` |
| Titre | Installer un poste de relevage |
| Profession | `metier:assainissement` |
| Famille | `famille:gros-oeuvre` |
| Sous-famille | `sous-famille:assainissement` |
| Version | v0.1 |
| Auteur | IA (proposition) |
| Validateur | ⟦à valider métier⟧ |
| Statut | Brouillon |
| Indice de confiance | **C** |

## Cadrage
- **Objectif** : installer un poste de relevage lorsque l'écoulement gravitaire est impossible (point bas). `[C]`
- **Résumé** : poser la cuve du poste, installer la/les **pompe(s)** de relevage et les flotteurs, raccorder le refoulement et la **ventilation**, faire réaliser l'**alimentation électrique** par un professionnel, et prévoir l'accès/entretien ; la cuve est un **espace confiné** (H₂S). `[C]` ⟦débit/HMT pompe selon projet à confirmer⟧

## Réalisation
- **Étapes** :
  1. Poser la cuve (assise, ancrage) au point bas. `[C]`
  2. Installer **pompe(s)** + flotteurs ; raccorder refoulement. `[C]`
  3. **Alimentation électrique** = professionnel (protection/alarme). `[A]` → [controler-tableau-electrique](../../../professions/electricite-generale/cards/controler-tableau-electrique.md)
  4. Ventilation ; accès/entretien ; test des flotteurs. `[C]`
- **Points critiques** : dimensionnement pompe (débit/HMT) ; alarme de niveau ; **cuve = espace confiné** (H₂S) ; raccordement élec réservé.
- **Sécurité** : H₂S/espace confiné ; électricité ; biologique. **Espace confiné** (regard, poste de relevage, fosse) : **danger mortel** — **gaz toxiques (H₂S)**, **manque d'oxygène**, risque d'explosion → **jamais de descente sans procédure** (détection d'atmosphère, **ventilation forcée**, **surveillant** extérieur, harnais/treuil, autorisation) — opération **réservée à des intervenants formés/équipés**. **Risque biologique / contamination** (eaux usées) : EPI, hygiène, vaccination. **Levage des tampons** (lourds/coincés) : outil adapté, écrasement/dos. **Fouilles** : blindage (effondrement). **Réseaux enterrés** (DICT). **Arrêt immédiat en cas de danger.** Opérations réglementées (ANC, espace confiné) **réservées aux professionnels qualifiés**.** `[A]`

## Cadre & suites
- **Normes** : assainissement non collectif **DTU 64.1** ; évacuation EU/EP **DTU 60.11** ; mise en œuvre/essais des collecteurs **NF EN 1610**, réglementation ANC (**arrêté du 7 sept. 2009**, contrôle **SPANC**) ⟦en prose, à confirmer⟧ `[B]` ⟦références/versions exactes à confirmer par le validateur⟧. `respecte-norme`
- **Sécurité confiné** : `cite-procedure` → [securite-espace-confine-assainissement](../../../procedures/assainissement/securite-espace-confine-assainissement.md)

## Relations & tags
- **Tags** : `metier:assainissement famille:gros-oeuvre sous-famille:assainissement intervention:poser cluster:postes-de-relevage complexite:avancee type:installation securite:confine relation:electricite-generale`

## Historique
| Version | Date | Auteur | Validateur | Motif |
|---|---|---|---|---|
| v0.1 | 2026-08-05 | IA | ⟦—⟧ | proposition initiale (Brouillon) |
