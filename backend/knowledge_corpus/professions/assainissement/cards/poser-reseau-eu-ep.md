# Poser un réseau EU / EV / EP

> **Brouillon (v0) — proposé par IA, en attente de validation métier** (Loi 7/18). Modèle : [../../../cards/CARD_TEMPLATE.md](../../../cards/CARD_TEMPLATE.md).
> Niveaux de confiance : A normes/fabricant · B technique · C terrain validé · D hypothèse. Rien n'est publié comme certitude.

## Métadonnées
| Champ | Valeur |
|---|---|
| Identifiant | `poser-reseau-eu-ep` |
| Titre | Poser un réseau EU / EV / EP |
| Profession | `metier:assainissement` |
| Famille | `famille:gros-oeuvre` |
| Sous-famille | `sous-famille:assainissement` |
| Version | v0.1 |
| Auteur | IA (proposition) |
| Validateur | ⟦à valider métier⟧ |
| Statut | Brouillon |
| Indice de confiance | **C** |

## Cadrage
- **Objectif** : poser un réseau d'évacuation EU/EV/EP en séparatif, avec pente gravitaire et essais. `[C]`
- **Résumé** : poser les canalisations sur lit de pose à la **pente** requise, en **séparatif** (EU/EV vs EP), assembler raccords et regards de visite, raccorder aux évacuations intérieures (plomberie) et au réseau/ANC aval, puis réaliser les **essais d'étanchéité**. `[C]` ⟦pentes/diamètres selon DTU 60.11 à confirmer⟧

## Réalisation
- **Étapes** :
  1. Poser à la **pente** requise, en **séparatif** (EU/EV ≠ EP). `[B]` ⟦à confirmer⟧
  2. Poser regards de visite (changements de direction/pente). `[C]` → [poser-regards-ventilation](poser-regards-ventilation.md)
  3. Raccorder l'évacuation intérieure (**plomberie**) et l'aval. `[C]` → [deboucher-evacuation-sanitaire](../../../professions/plomberie/cards/deboucher-evacuation-sanitaire.md)
  4. **Essais d'étanchéité** avant remblai. `[C]` → [diagnostiquer-controler-assainissement](diagnostiquer-controler-assainissement.md)
- **Points critiques** : **pente gravitaire** correcte ; séparatif EU/EP ; regards de visite ; essais avant remblai ; tranchée (VRD) sécurisée.
- **Sécurité** : fouilles (effondrement) ; biologique ; réseaux enterrés. **Espace confiné** (regard, poste de relevage, fosse) : **danger mortel** — **gaz toxiques (H₂S)**, **manque d'oxygène**, risque d'explosion → **jamais de descente sans procédure** (détection d'atmosphère, **ventilation forcée**, **surveillant** extérieur, harnais/treuil, autorisation) — opération **réservée à des intervenants formés/équipés**. **Risque biologique / contamination** (eaux usées) : EPI, hygiène, vaccination. **Levage des tampons** (lourds/coincés) : outil adapté, écrasement/dos. **Fouilles** : blindage (effondrement). **Réseaux enterrés** (DICT). **Arrêt immédiat en cas de danger.** Opérations réglementées (ANC, espace confiné) **réservées aux professionnels qualifiés**.** `[A]`

## Cadre & suites
- **Normes** : assainissement non collectif **DTU 64.1** ; évacuation EU/EP **DTU 60.11** ; mise en œuvre/essais des collecteurs **NF EN 1610**, réglementation ANC (**arrêté du 7 sept. 2009**, contrôle **SPANC**) ⟦en prose, à confirmer⟧ `[B]` ⟦références/versions exactes à confirmer par le validateur⟧. `respecte-norme`
- **Tranchée (VRD/Terrassement)** : `cite-carte` → [poser-reseau-humide](../../../professions/vrd/cards/poser-reseau-humide.md)

## Relations & tags
- **Tags** : `metier:assainissement famille:gros-oeuvre sous-famille:assainissement intervention:poser cluster:eaux-usees cluster:eaux-pluviales cluster:regards complexite:avancee type:installation securite:biologique relation:vrd relation:plomberie`

## Historique
| Version | Date | Auteur | Validateur | Motif |
|---|---|---|---|---|
| v0.1 | 2026-08-05 | IA | ⟦—⟧ | proposition initiale (Brouillon) |
