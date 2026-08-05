# Sécurité — biocides, occupants & zoonoses (nuisibles)

> **Brouillon (v0) — proposé par IA, en attente de validation métier** (Loi 7/18). Modèle : [../../cards/CARD_TEMPLATE.md](../../cards/CARD_TEMPLATE.md).
> Niveaux de confiance : A normes/fabricant · B technique · C terrain validé · D hypothèse.

## Métadonnées
| Champ | Valeur |
|---|---|
| Identifiant | `securite-biocides-occupants-nuisibles` |
| Titre | Sécurité — biocides, occupants & zoonoses (nuisibles) |
| Profession | `metier:hygiene-nuisibles` |
| Famille | `famille:specialises` |
| Sous-famille | `sous-famille:securite` |
| Version | v0.1 |
| Auteur | IA (proposition) |
| Validateur | ⟦à valider métier⟧ |
| Statut | Brouillon |
| Indice de confiance | **B** |

## Points à vérifier
- [ ] **Biocides** : produits dangereux ; application = **qualifié** (Certibiocide/AMM) ; **présentation seule** ici. `[A]`
- [ ] **Protection des occupants et animaux** ; **appâts sécurisés** ; aération. `[A]`
- [ ] **Risques sanitaires** : zoonoses (rongeurs), allergies (blattes), **piqûres** (guêpes/frelons). `[A]`
- [ ] **Guêpes/frelons** en hauteur / **punaises** : intervention **spécialisée**. `[A]`
- [ ] **Hygiène** et **exclusion** prioritaires (lutte intégrée). `[C]`
- [ ] **Amiante** (locaux anciens) : diagnostic ; retrait = **certifié** (jamais ici). `[A]`

## Cadre
- **Normes** : accès des nuisibles par les réseaux (siphons / clapets anti-rongeurs, **interface** plomberie) **DTU 60.1** ; **ventilation** contre l'humidité favorisant les nuisibles (**interface**) **DTU 68.3** ; services de lutte antiparasitaire **NF EN 16636** (certification CEPA), **Règlement Sanitaire Départemental**, **Règlement Biocides UE 528/2012 / Certibiocide** et **HACCP** (locaux alimentaires) ⟦en prose, à confirmer⟧ `[B]` ⟦référence exacte à confirmer⟧. `respecte-norme`
- **Relations** : `cite-procedure` → [inspection-securite-orientation-avant-traitement-3d](../../procedures/hygiene-nuisibles/inspection-securite-orientation-avant-traitement-3d.md).
- **Tags** : `metier:hygiene-nuisibles famille:specialises sous-famille:securite type:checklist cluster:prevention securite:biocides securite:amiante`

## Historique
| Version | Date | Auteur | Validateur | Motif |
|---|---|---|---|---|
| v0.1 | 2026-08-05 | IA | ⟦—⟧ | proposition initiale (Brouillon) |
