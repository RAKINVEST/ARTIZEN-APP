# Inspection, hygiène & orientation avant traitement 3D (décision)

> **Brouillon (v0) — proposé par IA, en attente de validation métier** (Loi 7/18). Modèle : [../../cards/CARD_TEMPLATE.md](../../cards/CARD_TEMPLATE.md).
> Niveaux de confiance : A normes/fabricant · B technique · C terrain validé · D hypothèse.

## Métadonnées
| Champ | Valeur |
|---|---|
| Identifiant | `inspection-securite-orientation-avant-traitement-3d` |
| Titre | Inspection, hygiène & orientation avant traitement 3D (décision) |
| Profession | `metier:hygiene-nuisibles` |
| Famille | `famille:specialises` |
| Sous-famille | `sous-famille:securite` |
| Version | v0.1 |
| Auteur | IA (proposition) |
| Validateur | ⟦à valider métier⟧ |
| Statut | Brouillon |
| Indice de confiance | **B** |

## But
- Cadrer le diagnostic, l'hygiène, la sécurité (biocides/occupants) et l'orientation — **décision/organisation**, sans protocole 3D. `[A]`

## Étapes (organisation / décision — aucun protocole de dératisation/désinsectisation/désinfection)
1. **Inspecter / identifier** l'espèce, l'ampleur, les points d'entrée. `[A]` → [inspecter-diagnostiquer-infestation](../../professions/hygiene-nuisibles/cards/inspecter-diagnostiquer-infestation.md)
2. **Prévention prioritaire** : hygiène + exclusion (Plomberie/Ventilation/Couverture). `[A]` → [prevenir-hygiene-lutte-integree](../../professions/hygiene-nuisibles/cards/prevenir-hygiene-lutte-integree.md)
3. **Biocides** : application **réglementée** (Certibiocide, appâts sécurisés, EPI, **protection des occupants/animaux**) = **applicateur qualifié**. `[A]`
4. **Guêpes/frelons** en hauteur / **punaises** : intervention **spécialisée**. `[A]`
5. **Amiante** (locaux anciens) → **arrêt / orientation** (Désamiantage). `[A]` → [arreter-signaler-en-cas-de-doute](../../professions/desamiantage/cards/arreter-signaler-en-cas-de-doute.md)
6. **Documenter** (registre, HACCP, RSD). `[C]` `relation:diagnostic`

## Cadre
- **Normes** : accès des nuisibles par les réseaux (siphons / clapets anti-rongeurs, **interface** plomberie) **DTU 60.1** ; **ventilation** contre l'humidité favorisant les nuisibles (**interface**) **DTU 68.3** ; services de lutte antiparasitaire **NF EN 16636** (certification CEPA), **Règlement Sanitaire Départemental**, **Règlement Biocides UE 528/2012 / Certibiocide** et **HACCP** (locaux alimentaires) ⟦en prose, à confirmer⟧ `[B]` ⟦référence exacte à confirmer⟧. `respecte-norme`
- **Relations** : `cite-carte` → [comprendre-traitements-documenter](../../professions/hygiene-nuisibles/cards/comprendre-traitements-documenter.md).
- **Tags** : `metier:hygiene-nuisibles famille:specialises sous-famille:securite intervention:securiser cluster:inspection cluster:reglementation type:procedure securite:biocides securite:amiante relation:desamiantage relation:diagnostic`

## Historique
| Version | Date | Auteur | Validateur | Motif |
|---|---|---|---|---|
| v0.1 | 2026-08-05 | IA | ⟦—⟧ | proposition initiale (Brouillon) |
