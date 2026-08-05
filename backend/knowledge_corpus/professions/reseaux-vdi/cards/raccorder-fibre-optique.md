# Raccorder la fibre optique

> **Brouillon (v0) — proposé par IA, en attente de validation métier** (Loi 7/18). Modèle : [../../../cards/CARD_TEMPLATE.md](../../../cards/CARD_TEMPLATE.md).
> Niveaux de confiance : A normes/fabricant · B technique · C terrain validé · D hypothèse. Rien n'est publié comme certitude.

## Métadonnées
| Champ | Valeur |
|---|---|
| Identifiant | `raccorder-fibre-optique` |
| Titre | Raccorder la fibre optique |
| Profession | `metier:reseaux-vdi` |
| Famille | `famille:electricite` |
| Sous-famille | `sous-famille:reseaux-vdi` |
| Version | v0.1 |
| Auteur | IA (proposition) |
| Validateur | ⟦à valider métier⟧ |
| Statut | Brouillon |
| Indice de confiance | **C** |

## Cadrage
- **Objectif** : raccorder/tirer de la fibre optique (soudure ou connectique) en respectant la sécurité laser. `[C]`
- **Résumé** : tirer la fibre (rayon de courbure **strict**), réaliser les raccordements par **soudure** (soudeuse) ou **connectique**, nettoyer les connecteurs, mesurer l'**affaiblissement** (photomètre/réflectomètre) ; **ne jamais regarder** dans une fibre sous tension optique (**laser** — lésion oculaire). `[C]` ⟦type de fibre/connectique selon réseau à confirmer⟧

## Réalisation
- **Étapes** :
  1. Tirer la fibre (**rayon de courbure** strict). `[C]`
  2. Raccorder par **soudure**/connectique ; nettoyer les connecteurs. `[C]`
  3. **Sécurité laser** : jamais regarder dans une fibre active ; capuchons. `[A]`
  4. Mesurer l'**affaiblissement** (photomètre/OTDR). `[C]` → [defaut-affaiblissement-fibre](../../../diagnostics/reseaux-vdi/defaut-affaiblissement-fibre.md)
- **Points critiques** : rayon de courbure ; **propreté des connecteurs** ; mesure d'affaiblissement ; **sécurité laser** (yeux).
- **Sécurité** : **laser fibre** (yeux) ; ESD ; éclats de fibre (manipulation). **Coexistence courants forts / courants faibles** : respecter les **distances/séparations** (NF C 15-100) — ne jamais faire cheminer VDI et puissance sans séparation (induction/contact). **Consignation avant intervention** : dès qu'on approche des **courants forts** (goulottes, coffrets), consignation par une personne **habilitée** (NF C 18-510) — **réservé habilité**. **Travail sur équipements alimentés** : à éviter (hors tension). **Protection ESD** des équipements électroniques (bracelet antistatique). **Laser fibre optique** : **ne jamais regarder** dans une fibre/un connecteur sous tension optique (lésion oculaire) — capuchons, mesureur adapté. **Conformité** de l'installation (grade/certification). **Arrêt immédiat en cas de danger.** Les opérations touchant aux **courants forts** sont réservées aux **professionnels habilités**.** `[A]`

## Cadre & suites
- **Normes** : installation électrique et **coffret de communication** résidentiel **NF C 15-100** ; opérations / consignation à proximité des courants forts **NF C 18-510** ; câblage résidentiel VDI (**UTE C 90-483**), systèmes de câblage (**NF EN 50173** / **ISO-IEC 11801**), sécurité laser fibre (**NF EN 60825**) ⟦en prose, à confirmer⟧ `[B]` ⟦références/versions exactes à confirmer par le validateur⟧. `respecte-norme`
- **Diagnostic fibre** : `traite-diagnostic` → [defaut-affaiblissement-fibre](../../../diagnostics/reseaux-vdi/defaut-affaiblissement-fibre.md)

## Relations & tags
- **Tags** : `metier:reseaux-vdi famille:electricite sous-famille:reseaux-vdi intervention:poser cluster:fibre-optique complexite:avancee type:installation securite:laser`

## Historique
| Version | Date | Auteur | Validateur | Motif |
|---|---|---|---|---|
| v0.1 | 2026-08-05 | IA | ⟦—⟧ | proposition initiale (Brouillon) |
