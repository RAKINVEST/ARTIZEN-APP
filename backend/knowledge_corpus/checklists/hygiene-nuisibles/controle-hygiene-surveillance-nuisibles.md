# Contrôle / hygiène / surveillance nuisibles

> **Brouillon (v0) — proposé par IA, en attente de validation métier** (Loi 7/18). Modèle : [../../cards/CARD_TEMPLATE.md](../../cards/CARD_TEMPLATE.md).
> Niveaux de confiance : A normes/fabricant · B technique · C terrain validé · D hypothèse.

## Métadonnées
| Champ | Valeur |
|---|---|
| Identifiant | `controle-hygiene-surveillance-nuisibles` |
| Titre | Contrôle / hygiène / surveillance nuisibles |
| Profession | `metier:hygiene-nuisibles` |
| Famille | `famille:specialises` |
| Sous-famille | `sous-famille:hygiene-nuisibles` |
| Version | v0.1 |
| Auteur | IA (proposition) |
| Validateur | ⟦à valider métier⟧ |
| Statut | Brouillon |
| Indice de confiance | **C** |

## Points à vérifier
- [ ] **Hygiène** : denrées protégées, déchets maîtrisés, propreté. `[A]`
- [ ] **Exclusion** : passages obturés, clapets/grilles, points d'entrée (toiture/réseaux). `[C]`
- [ ] **Humidité / ventilation** maîtrisées (blattes/moisissures). `[C]`
- [ ] **Surveillance** : pièges de monitoring relevés ; évolution. `[C]`
- [ ] **Appâts sécurisés** (boîtes verrouillées) ; protection occupants/animaux. `[A]`
- [ ] **Documentation** (registre, plan, HACCP/RSD) ; amiante vérifié. `[A]`

## Cadre
- **Normes** : accès des nuisibles par les réseaux (siphons / clapets anti-rongeurs, **interface** plomberie) **DTU 60.1** ; **ventilation** contre l'humidité favorisant les nuisibles (**interface**) **DTU 68.3** ; services de lutte antiparasitaire **NF EN 16636** (certification CEPA), **Règlement Sanitaire Départemental**, **Règlement Biocides UE 528/2012 / Certibiocide** et **HACCP** (locaux alimentaires) ⟦en prose, à confirmer⟧ `[B]` ⟦référence exacte à confirmer⟧. `respecte-norme`
- **Relations** : `verifie` → [inspecter-diagnostiquer-infestation](../../professions/hygiene-nuisibles/cards/inspecter-diagnostiquer-infestation.md).
- **Tags** : `metier:hygiene-nuisibles famille:specialises sous-famille:hygiene-nuisibles type:checklist cluster:surveillance cluster:documentation securite:biocides`

## Historique
| Version | Date | Auteur | Validateur | Motif |
|---|---|---|---|---|
| v0.1 | 2026-08-05 | IA | ⟦—⟧ | proposition initiale (Brouillon) |
